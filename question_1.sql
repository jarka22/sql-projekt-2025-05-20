WITH avg_industry_branch AS (
SELECT
	round(avg(wage_value):: NUMERIC, 0) AS avg_wage,
	industry_branch_name,
	wage_year
FROM t_jarmila_sustkova_project_sql_primary_final tjspspf
GROUP BY industry_branch_name, wage_year
)
SELECT 
	aib.*,
	aib.avg_wage - LAG(aib.avg_wage, 1) OVER (PARTITION BY aib.industry_branch_name ORDER BY aib.wage_year) AS value_diff
FROM avg_industry_branch aib;