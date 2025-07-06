# SQL PROJEKT

Tento projekt je mým finálním výstupem Datové akademie u Engeta.

**Struktura projektu:**

t_jarmila_sustkova_project_sql_primary_final - sql dotaz pro vytvoření tabulky: table1.sql

t_jarmila_sustkova_project_sql_secondary_final - sql dotaz pro vytvoření tabulky: table2.sql

question_1.sql

question_2.sql

question_3.sql

question_4.sql

question_5.sql

**Tabulky:**

**Table 1** - data mezd a cen potravin v ČR za období 2006 až 2018
- Pro analýzu dat se vychází z období 2006 až 2018, ve kterém jsou dostupná data jak pro mzdy, tak pro ceny potravin. Tyto dvě hlavní tabulky spolu s dvěma pomocnými tak byly spojeny do jedné s názvem t_jarmila_sustkova_project_sql_primary_final.
- V tabulce cen ve sloupcích date_from a date_to, nedochází ve sledovaném období k tomu, že by kdy interval začínal na konci roku a končil na začátku roku následujícího. Z tohoto důvodu není relevantní, s jakým sloupcem se pracuje dále. Pro účely tohoto projektu byl vybrán sloupec date_from.
- Do výsledného výběru byla zahrnuta data jak pro jednotlivé kraje, tak pro celou ČR (region_code = NULL). 
- V tabulce mezd byly vyřazeny záznamy, kde se v kódu odvětví nachází NULL hodnoty (344 záznamů) a byly vybrány záznamy pouze pro průměrnou hrubou mzdu na zaměstnance (kód 5958).

**Table 2** - dodatečná data o dalších evropských státech a údaje o HDP za období 2006 až 2018
- Byly spojeny dvě tabulky, a to economies a countries, v jednu výslednou tabulku t_jarmila_sustkova_project_sql_secondary_final. 
- Vyřazeny byly velké územní celky jako například Europian Union či Africa Western and Southern. Ve výsledné tabulce také byly zachovány NULL hodnoty.
- Jelikož jde o spojení dvou různých tabulek, liší se u nich údaje o množství obyvatel. Pro účely tohoto projektu se s počtem obyvatel nepracuje.


**Otázka 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**
Mzdy ve všech odvětvích ve sledovaném období většinou rostly, u některých odvětví však došlo v určitých letech k poklesu mezd. Níže jsou uvedeny všechny roky a odvětví, kdy k poklesu mezd došlo. Nejpatrnější je to v roce 2013, kdy probíhala v ČR ekonomická recese.

2009	Těžba a dobývání
	Ubytování, stravování a pohostinství
	Zemědělství, lesnictví, rybářství
2010	Profesní, vědecké a technické činnosti
	Veřejná správa a obrana; povinné sociální zabezpečení
	Vzdělávání
2011	Kulturní, zábavní a rekreační činnosti
	Ubytování, stravování a pohostinství
	Veřejná správa a obrana; povinné sociální zabezpečení
2013	Administrativní a podpůrné činnosti
	Činnosti v oblasti nemovitostí
	Informační a komunikační činnosti
	Kulturní, zábavní a rekreační činnosti
	Peněžnictví a pojišťovnictví
	Profesní, vědecké a technické činnosti
	Stavebnictví
	Těžba a dobývání
	Velkoobchod a maloobchod; opravy a údržba motorových vozidel
	Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu
	Zásobování vodou; činnosti související s odpady a sanacemi
2014	Těžba a dobývání
2015	Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu
2016	Těžba a dobývání

V těchto odvětvích naopak docházelo ke každoročnímu nárůstu mezd:
- Doprava a skladování
- Ostatní činnosti
- Zdravotní a sociální péče
- Zpracovatelský průmysl

**Otázka 2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**
U obou kategorií platí, že v roce 2018 je možné koupit si větší množství chleba a také mléka.

**Otázka 3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší procentuální meziroční nárůst)?**
V letech 2006 až 2018 meziročně rostly nejpomaleji ceny těchto potravin:
	I. Cukr krystalový
	II. Rajská jablka červená kulatá
	III. Banány žluté

**Otázka 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (vetší než 10 %)?**
Ano, ne však pro všechny kategorie potravin. Výsledný SQL dotaz vygeneruje seznam kategorií potravin spolu s roky, kdy došlo k meziročnímu růstu cen potravin o více než 10 % oproti růstu mezd. 

**Otázka 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**
V roce 2009 a 2012 došlo k poklesu HDP, v roce 2013 ke stagnaci HDP.
Pro dané období platí, že se vzrůstem HDP rostly také mzdy. Mzdy klesly pouze v roce 2013 během ekonomické recese.
U cen potravin záleží na kategorii potravin, zde je to více specifické. V roce 2009 například docházelo k poklesu cen u většiny kategorií potravin, ne však u všech. Ceny potravin ovlivňují také vnější vlivy, dále úroda/neúroda, zvířecí nemoci, ceny pohonných hmot atd.