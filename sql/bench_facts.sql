ATTACH 'duplex.duckdb' AS src (READ_ONLY);
INSERT INTO fact_element_qty
SELECT 'duplex-01', 'IfcWallStandardCase', 'Wall', COUNT(*), 'count', NULL FROM src.IfcWallStandardCase
UNION ALL SELECT 'duplex-01', 'IfcWall', 'Wall', COUNT(*), 'count', NULL FROM src.IfcWall
UNION ALL SELECT 'duplex-01', 'IfcSlab', 'Slab', COUNT(*), 'count', NULL FROM src.IfcSlab
UNION ALL SELECT 'duplex-01', 'IfcDoor', 'Door', COUNT(*), 'count', NULL FROM src.IfcDoor
UNION ALL SELECT 'duplex-01', 'IfcWindow', 'Window', COUNT(*), 'count', NULL FROM src.IfcWindow
UNION ALL SELECT 'duplex-01', 'IfcSpace', 'Space', COUNT(*), 'count', NULL FROM src.IfcSpace
UNION ALL SELECT 'duplex-01', 'IfcCovering', 'Covering', COUNT(*), 'count', NULL FROM src.IfcCovering
UNION ALL SELECT 'duplex-01', 'IfcStair', 'Stair', COUNT(*), 'count', NULL FROM src.IfcStair
UNION ALL SELECT 'duplex-01', 'IfcRoof', 'Roof', COUNT(*), 'count', NULL FROM src.IfcRoof;
