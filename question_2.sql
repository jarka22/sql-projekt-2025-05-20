SELECT
	food_name,
	food_year,
	round(avg(wage_value)::NUMERIC / avg(food_value):: NUMERIC, 0)
FROM t_jarmila_sustkova_project_SQL_primary_final
WHERE food_category IN (111301, 114201) AND food_year IN (2006, 2018)
GROUP BY food_year, food_name;