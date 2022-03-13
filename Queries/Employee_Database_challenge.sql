-- Deliverable 1 Weekly Challenge
-- Create Retirement_titles table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees e
LEFT JOIN titles t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows and create a unique titles table
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title

INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Query to return and create table with counts by job title
SELECT COUNT(emp_no),
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(*) DESC

-- Deliveralbe 2
-- Query to create table of elgible membership candidates with titles
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	d.from_date,
	d.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees e
JOIN dept_emp d
ON e.emp_no = d.emp_no
JOIN titles t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
AND d.to_date = '9999-01-01'
ORDER BY e.emp_no, t.to_date DESC -- Delevirable 2, step 9 has a typo, it should include order by t.to_date DESC to return the last held title of the employee

-- Extra Useful queries
-- Total count of current employees
-- Returns value of 240,124
SELECT COUNT(*) 
FROM employees e
JOIN dept_emp d
ON e.emp_no = d.emp_no
WHERE d.to_date = '9999-01-01'

-- Count of retiring employees
-- Returns 72,458
SELECT COUNT(emp_no)
FROM unique_titles

-- Count of Mentors
-- Returns 1,549
SELECT DISTINCT COUNT(e.emp_no)
FROM employees e
JOIN dept_emp d
ON e.emp_no = d.emp_no
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
AND d.to_date = '9999-01-01'

-- For Screen shots
SELECT * FROM retirement_titles LIMIT 10
SELECT * FROM unique_titles LIMIT 10
SELECT * FROM retiring_titles LIMIT 10
SELECT * FROM mentorship_eligibilty LIMIT 10