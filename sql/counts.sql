SELECT 'IfcWall' AS ifc_class, COUNT(*) AS n FROM IfcWall
UNION ALL SELECT 'IfcWallStandardCase', COUNT(*) FROM IfcWallStandardCase
UNION ALL SELECT 'IfcSlab', COUNT(*) FROM IfcSlab
UNION ALL SELECT 'IfcDoor', COUNT(*) FROM IfcDoor
UNION ALL SELECT 'IfcWindow', COUNT(*) FROM IfcWindow
UNION ALL SELECT 'IfcSpace', COUNT(*) FROM IfcSpace
UNION ALL SELECT 'IfcCovering', COUNT(*) FROM IfcCovering
UNION ALL SELECT 'IfcStair', COUNT(*) FROM IfcStair
UNION ALL SELECT 'IfcRoof', COUNT(*) FROM IfcRoof
ORDER BY n DESC;
