CREATE TABLE t_jarmila_sustkova_project_SQL_primary_final AS
SELECT
	cp.value AS food_value,
	cp.category_code AS food_category,
	cpc.name AS food_name,
	date_part('year', cp.date_from):: int AS food_year,
	cpay.value AS wage_value,
	cpay.industry_branch_code,
	cpib.name AS industry_branch_name,
	cpay.payroll_year AS wage_year	
FROM czechia_price cp 
JOIN czechia_payroll cpay
	ON date_part('year', cp.date_from)::int = cpay.payroll_year
JOIN czechia_payroll_industry_branch cpib 
	ON cpay.industry_branch_code = cpib.code
JOIN czechia_price_category cpc
	ON cp.category_code = cpc.code
WHERE cpay.payroll_year >= 2006 AND cpay.payroll_year <= 2018 AND cpay.industry_branch_code IS NOT NULL AND cpay.value_type_code = 5958;