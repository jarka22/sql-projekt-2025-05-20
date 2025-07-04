CREATE TABLE t_jarmila_sustkova_project_sql_secondary_final AS
SELECT 
	c.*,
	e.country AS economies_country,
	e.YEAR,
	e.gdp,
	e.population AS economies_population,
	e.gini,
	e.taxes,
	e.fertility,
	e.mortaliy_under5
FROM economies e
LEFT JOIN countries c
	ON c.country = e.country
WHERE e.year >= 2006 AND e.year <= 2018 AND c.country=e.country
ORDER BY c.country, e.YEAR;