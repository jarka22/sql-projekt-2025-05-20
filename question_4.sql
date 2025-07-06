WITH prices_wages_differences AS(
SELECT
	food_name,
	food_year,
	(avg(food_value)):: NUMERIC AS avg_food_value,
	(avg(food_value) - LAG(avg(food_value), 1) OVER (PARTITION BY food_name ORDER BY food_year)):: NUMERIC AS value_diff,
	(((AVG(food_value) - LAG(AVG(food_value), 1) OVER (PARTITION BY food_name ORDER BY food_year)) 
     / LAG(AVG(food_value), 1) OVER (PARTITION BY food_name ORDER BY food_year)) * 100)::NUMERIC AS percentage_diff_prices,
     avg(wage_value):: NUMERIC AS avg_wage,
     avg(wage_value) - LAG(avg(wage_value), 1) OVER (PARTITION BY food_name ORDER BY food_year) AS wage_diff,
     (((AVG(wage_value) - LAG(AVG(wage_value), 1) OVER (PARTITION BY food_name ORDER BY food_year)) 
     / LAG(AVG(wage_value), 1) OVER (PARTITION BY food_name ORDER BY food_year)) * 100)::NUMERIC AS percentage_diff_wages
FROM t_jarmila_sustkova_project_sql_primary_final tjspspf
GROUP BY food_year, food_name
)
SELECT
	food_name,
	food_year AS year,
	round(percentage_diff_prices,1) AS annual_food_prices_percentage,
	round(percentage_diff_wages,1) AS annual_wages_percentage,
	CASE WHEN
	 percentage_diff_prices - percentage_diff_wages >= 10 THEN 'more than 10 %'
	 ELSE 'less than 10 %'
	END AS diff_between_food_wages
FROM prices_wages_differences
WHERE percentage_diff_prices IS NOT NULL
ORDER BY diff_between_food_wages DESC, food_year;