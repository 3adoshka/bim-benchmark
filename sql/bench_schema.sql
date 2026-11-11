CREATE TABLE IF NOT EXISTS dim_project (
    project_id VARCHAR PRIMARY KEY,
    name VARCHAR,
    ifc_schema VARCHAR,
    typology VARCHAR,
    gfa_m2 DOUBLE,
    location VARCHAR,
    year INTEGER
);
CREATE TABLE IF NOT EXISTS fact_element_qty (
    project_id VARCHAR,
    ifc_class VARCHAR,
    element_type VARCHAR,
    quantity BIGINT,
    unit VARCHAR,
    storey VARCHAR
);
INSERT OR REPLACE INTO dim_project VALUES
    ('duplex-01', 'Duplex Apartment', 'IFC2X3', 'Residential', NULL, NULL, NULL);
