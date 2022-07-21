-- DELIVERABLE 1: The Number of Retiring Employees by Title:

--STEP 1: Create retirement table that holds all titles of employees born 
--between Jan 1,1952-Dec 31, 1955

SELECT e.emp_no, 
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e 
INNER JOIN titles AS t 
	ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Note: INNER JOIN was able to be used for title table because did not 
-- effect any columns in employees table because 
--employees table did not have from/to date columns


-- STEP 2:Create table containing most recent title of each current employee 
-- Use DISTINCT with ORDER BY to remove duplicate rows
SELECT DISTINCT ON (emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE rt.to_date = '9999-01-01'
ORDER BY emp_no, emp_no ASC;

-- STEP 3:retrieve # of employees by most recent job title 
-- who are about to retire 
SELECT COUNT(ut.title),
	ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

-- DELIVERABLE 2: The Employees Eligible for the Mentorship Program:

-- Create mentorship-eligibility table that holds current employees 
-- born between Jan 1, 1965 - Dec 31, 1965

-- STEP 1: Create table with employees eligible to participate in program
-- STEP 2: Perform 3 JOINs using tables(employees,dept_emp,titles) 
-- STEP 3: Filter data for employees currently still employed & birth dates
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de 
	ON (e.emp_no = de.emp_no)
LEFT JOIN titles AS t 
	ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01') 
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC;

-- LEFT JOIN used for title table as to not mess up from/to date in dept_emp table
-- title from/to date refers to how long employee has been in position
-- title from/to date does not mean how long employee has worked at Pewlett Hackard