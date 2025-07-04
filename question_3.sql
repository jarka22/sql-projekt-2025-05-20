-- porovnání roku 2018 s rokem 2006:

SELECT
	food_name,
	food_year,
	avg(food_value) AS avg_food_value,
	avg(food_value) - LAG(avg(food_value), 1) OVER (PARTITION BY food_name ORDER BY food_year) AS value_diff,
	round(
	(((AVG(food_value) - LAG(AVG(food_value)) OVER (PARTITION BY food_name ORDER BY food_year)) 
     / LAG(AVG(food_value)) OVER (PARTITION BY food_name ORDER BY food_year)) * 100)::NUMERIC,0
     ) AS percentage_difference
FROM t_jarmila_sustkova_project_sql_primary_final tjspspf
WHERE food_year IN (2006, 2018)
GROUP BY food_year, food_name
ORDER BY food_name;

-- porovnání všech po sobě jdoucích let od roku 2006 do roku 2018, kdy dochází vždy k porovnání roku s rokem předešlým
SELECT
	food_name,
	food_year,
	avg(food_value) AS avg_food_value,
	avg(food_value) - LAG(avg(food_value), 1) OVER (PARTITION BY food_name ORDER BY food_year) AS value_diff,
	round(
	(((AVG(food_value) - LAG(AVG(food_value)) OVER (PARTITION BY food_name ORDER BY food_year)) 
     / LAG(AVG(food_value)) OVER (PARTITION BY food_name ORDER BY food_year)) * 100)::NUMERIC,0
     ) AS percentage_difference
FROM t_jarmila_sustkova_project_sql_primary_final tjspspf
GROUP BY food_year, food_name;