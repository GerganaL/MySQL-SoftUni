# 1. Employee Address
SELECT 	e.employee_id, e.job_title, e.address_id, a.address_text
FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
ORDER BY e.address_id LIMIT 5;

# 2. Addresses with Towns
SELECT e.first_name, e.last_name, t.name, a.address_text
FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
JOIN towns AS t
ON a.town_id = t.town_id
ORDER BY e.first_name ASC,  e.last_name ASC LIMIT 5;

# 3. Sales Employee
SELECT e.employee_id, e.first_name, e.last_name, d.name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.name = 'Sales'
ORDER BY e.employee_id DESC	;

# 4. Employee Departments
SELECT e.employee_id, e.first_name, e.salary, d.name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE salary > 15000
ORDER BY d.department_id DESC LIMIT 5;

# 5. Employees without project
SELECT e.employee_id, e.first_name
FROM employees AS e
LEFT JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

# 6. Employees hired after
SELECT e.first_name, e.last_name, e.hire_date, d.name AS 'dept_name'
FROM employees AS e
JOIN departments as d
ON e.department_id = d.department_id
WHERE e.hire_date > 1999-1-1 AND d.name IN('Sales', 'Finance')
ORDER BY e.hire_date ASC;

# 7. Employees with Project
SELECT	e.employee_id, e.first_name, p.name AS 'project_name'
FROM employees AS e
JOIN employees_projects AS ep ON ep.employee_id = e.employee_id
JOIN projects AS p ON ep.project_id = p.project_id
WHERE DATE(p.start_date)> 2002-08-13 AND p.end_date IS NULL
ORDER BY e.first_name, p.name
LIMIT 5;

# 8. Employee 24

SELECT e.employee_id, e.first_name, IF(YEAR(p.start_date) >= 2005, NULL, p.name) AS 'project_name'
FROM employees AS e
JOIN employees_projects AS ep ON ep.employee_id = e.employee_id
JOIN projects AS p ON ep.project_id = p.project_id
WHERE e.employee_id = 24 
ORDER BY p.name;

# 9. Employee Manager
SELECT e.employee_id, e.first_name, e.manager_id, m.first_name
FROM employees AS e
JOIN employees AS m ON e.manager_id = m.employee_id
WHERE e.manager_id IN (3, 7)
ORDER BY e.first_name;

# 10. Employee Summary
SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS 'employee_name', CONCAT(m.first_name, ' ', m.last_name) AS 'manager_name', d.name
FROM employees AS e
JOIN employees AS m ON e.manager_id = m.employee_id
JOIN departments AS d ON e.department_id = d.department_id
ORDER BY e.employee_id;

# 11. Min Average Salary
SELECT AVG(e.salary) as 'min_average_salary'
FROM employees AS e
GROUP BY e.department_id
ORDER BY `min_average_salary` LIMIT 1;

# 12. Highest Peaks in Bulgaria
SELECT mc.country_code, m.mountain_range, p.peak_name, p.elevation
FROM mountains_countries AS mc
JOIN mountains AS m ON mc.mountain_id = m.id
JOIN peaks AS p ON p.mountain_id = m.id
WHERE mc.country_code = 'BG' AND p.elevation > 2835
ORDER BY p.elevation DESC;

#13 Count Mountain Ranges
SELECT mc.country_code, COUNT(m.mountain_range)
FROM mountains_countries AS mc
JOIN mountains AS m ON  mc.mountain_id = m.id
WHERE mc.country_code IN ('BG', 'US', 'RU')
GROUP BY mc.country_code
ORDER BY COUNT(m.mountain_range) DESC;

# 14. Countries with Rivers
SELECT c.country_name, r.river_name
FROM countries AS c
LEFT JOIN countries_rivers as cs ON cs.country_code = c.country_code
LEFT JOIN rivers as r ON r.id = cs.river_id
JOIN continents as cn ON cn.continent_code = c.continent_code
WHERE cn.continent_name = 'Africa'
ORDER BY c.country_name
LIMIT 5;

# 15. Continents and Currencies
SELECT c.continent_code, c.currency_code, COUNT(*) AS 'currency_usage'
FROM countries AS c
GROUP BY c.continent_code, c.currency_code
HAVING `currency_usage` > 1 AND `currency_usage` = (
	SELECT COUNT(*) AS cn FROM countries AS c2
    WHERE c2.continent_code = c.continent_code
    GROUP BY c2.currency_code
    ORDER BY cn DESC LIMIT 1
    )
ORDER BY c.continent_code;

# 16. Countries without any Mountains
SELECT COUNT(*) as 'country_count'
FROM
    (SELECT mc.country_code AS 'mc_country_code'
    FROM `mountains_countries` AS mc
    GROUP BY mc.country_code) AS d
RIGHT JOIN `countries` AS c ON c.country_code = d.mc_country_code
WHERE d.mc_country_code IS NULL;

# 17. Highest Peak and Longest River by Country
SELECT c.country_name, MAX(p.elevation) AS 'highest_peak_elevation', MAX(r.length) AS 'longest_river_length'
FROM `countries` AS c LEFT JOIN `mountains_countries` AS mc ON c.country_code = mc.country_code
LEFT JOIN `peaks` AS p ON mc.mountain_id = p.mountain_id
LEFT JOIN `countries_rivers` AS cr ON c.country_code = cr.country_code
LEFT JOIN `rivers` AS r ON cr.river_id = r.id
GROUP BY c.country_name
ORDER BY `highest_peak_elevation` DESC , `longest_river_length` DESC , c.country_name
LIMIT 5;
