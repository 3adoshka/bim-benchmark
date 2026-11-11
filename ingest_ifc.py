#!/usr/bin/env python3
"""Ingest an IFC file into the benchmark database.

Works for IFC2X3 and IFC4. Counts elements by normalised type
and appends to dim_project / fact_element_qty in benchmarks.duckdb.
"""
import sys
import ifcopenshell
import duckdb

# class names to check, grouped by normalised element_type
CLASS_MAP = {
    "Wall":     ["IfcWall", "IfcWallStandardCase"],
    "Slab":     ["IfcSlab"],
    "Door":     ["IfcDoor"],
    "Window":   ["IfcWindow"],
    "Space":    ["IfcSpace"],
    "Covering": ["IfcCovering"],
    "Stair":    ["IfcStair"],
    "Roof":     ["IfcRoof"],
    "Column":   ["IfcColumn"],
    "Beam":     ["IfcBeam"],
}

def main(ifc_path, project_id, project_name, db_path="benchmarks.duckdb"):
    model = ifcopenshell.open(ifc_path)
    schema = model.schema

    con = duckdb.connect(db_path)
    con.execute("""
        CREATE TABLE IF NOT EXISTS dim_project (
            project_id VARCHAR PRIMARY KEY, name VARCHAR, ifc_schema VARCHAR,
            typology VARCHAR, gfa_m2 DOUBLE, location VARCHAR, year INTEGER
        );
        CREATE TABLE IF NOT EXISTS fact_element_qty (
            project_id VARCHAR, ifc_class VARCHAR, element_type VARCHAR,
            quantity BIGINT, unit VARCHAR, storey VARCHAR
        );
    """)

    con.execute(
        "INSERT OR REPLACE INTO dim_project VALUES (?, ?, ?, NULL, NULL, NULL, NULL)",
        [project_id, project_name, schema],
    )

    rows = []
    for element_type, classes in CLASS_MAP.items():
        for cls in classes:
            try:
                n = len(model.by_type(cls))
            except RuntimeError:
                n = 0
            if n > 0:
                rows.append((project_id, cls, element_type, n, "count", None))

    con.executemany(
        "INSERT INTO fact_element_qty VALUES (?, ?, ?, ?, ?, ?)", rows
    )
    con.close()
    print(f"Ingested {ifc_path} -> {project_id} ({schema}), {len(rows)} rows")

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: ingest_ifc.py FILE.ifc PROJECT_ID PROJECT_NAME")
        sys.exit(1)
    main(sys.argv[1], sys.argv[2], sys.argv[3])
