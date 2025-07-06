WITH prices_change_annualy AS (
SELECT
	food_name,
	food_year,
	avg(food_value):: NUMERIC AS avg_food_value,
	(avg(food_value) - LAG(avg(food_value), 1) OVER (PARTITION BY food_name ORDER BY food_year)):: NUMERIC AS value_difference,
	(((AVG(food_value) - LAG(AVG(food_value), 1) OVER (PARTITION BY food_name ORDER BY food_year)) 
     / LAG(AVG(food_value), 1) OVER (PARTITION BY food_name ORDER BY food_year)) * 100)::NUMERIC AS percentage_difference
FROM t_jarmila_sustkova_project_sql_primary_final tjspspf
GROUP BY food_year, food_name
)
SELECT
	food_name,
	round(avg(percentage_difference), 1) AS annual_change
FROM prices_change_annualy
GROUP BY food_name
ORDER BY annual_change;