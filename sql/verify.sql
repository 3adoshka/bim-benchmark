SELECT * FROM dim_project;
SELECT element_type, SUM(quantity) AS total FROM fact_element_qty GROUP BY element_type ORDER BY total DESC;
