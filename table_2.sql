SELECT *
FROM economies e
LEFT JOIN countries c
	ON c.country = e.country
	WHERE e.year >= 2006 AND e.year <= 2018
ORDER BY c.country, e.YEAR;
