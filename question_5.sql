WITH prices_wages_differences AS(
SELECT
	t1.food_name,
	t1.food_year,
	(avg(t1.food_value)):: NUMERIC AS avg_food_value,
	(avg(t1.food_value) - LAG(avg(t1.food_value), 1) OVER (PARTITION BY t1.food_name ORDER BY t1.food_year)):: NUMERIC AS value_diff,
	(((AVG(t1.food_value) - LAG(AVG(t1.food_value), 1) OVER (PARTITION BY t1.food_name ORDER BY t1.food_year)) 
     / LAG(AVG(t1.food_value), 1) OVER (PARTITION BY t1.food_name ORDER BY t1.food_year)) * 100):: NUMERIC AS percentage_diff_prices,
     avg(t1.wage_value):: NUMERIC AS avg_wage,
     avg(t1.wage_value) - LAG(avg(t1.wage_value), 1) OVER (PARTITION BY t1.food_name ORDER BY t1.food_year) AS wage_diff,
     (((AVG(t1.wage_value) - LAG(AVG(t1.wage_value), 1) OVER (PARTITION BY t1.food_name ORDER BY t1.food_year)) 
     / LAG(AVG(t1.wage_value), 1) OVER (PARTITION BY t1.food_name ORDER BY t1.food_year)) * 100)::NUMERIC AS percentage_diff_wages,
     t2.gdp,
     (t2.gdp - LAG(t2.gdp,1) OVER (PARTITION BY t1.food_name ORDER BY t1.food_year)):: NUMERIC AS gdp_diff,
     ((t2.gdp - LAG(t2.gdp, 1) OVER (PARTITION BY t1.food_name ORDER BY t1.food_year)) 
     / LAG(t2.gdp) OVER (PARTITION BY food_name ORDER BY food_year) * 100):: NUMERIC AS percentage_gdp
FROM t_jarmila_sustkova_project_sql_primary_final t1
LEFT JOIN t_jarmila_sustkova_project_sql_secondary_final t2
	ON t1.food_year = t2.year
WHERE lower(t2.country) LIKE '%cze%' 
GROUP BY t1.food_year, t1.food_name, t2.gdp
)
SELECT
	food_name,
	food_year AS year,
	round(percentage_diff_prices, 1) AS perc_food,  ---vzrůst je kladný, pokles záporný
	round(percentage_diff_wages, 1) AS perc_wages,  ---vzrůst je kladný, pokles záporný
	round(percentage_gdp, 1) AS perc_gdp            ---vzrůst je kladný, pokles záporný
FROM prices_wages_differences
WHERE percentage_diff_prices IS NOT NULL
GROUP BY food_year, food_name, perc_food, perc_wages, perc_gdp;

