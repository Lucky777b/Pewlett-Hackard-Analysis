# Pewlett Hackard Analysis

## Purpose 

The purpose of this project was to use SQL (Structured Query Language) to create a new employee database, in which new data tables can be created and used to determine relationships between different data tables using relational databases. This kind of task might not be as easily conducted using programs, such as excel or VBA, because those systems cannot easily merge and filter multiple datasets, or may possibly crash, especially when the datasets are extremely large. SQL uses a database system, known as Postgres (or PostgreSQL), that is used to load massive/multiple datasets into. Using the interface specifically built for Postgres, known as pgAdmin, can not only talk to postgres, but allows an analyst to use SQL statements, in pgAdmin, to perform advanced data analysis. 

Database keys, such as primary or foreign keys, are important to understand when using SQL, because such keys can help identify records/values from tables and help to establish a relationship between various tables. A primary key is a unique identifier, and a foreign key is used to reference another dataset's primary key. Primary keys are necessary to be able to link different tables/datasets together, for example, one table might contain information that another table might not, but as long as a primary key is found within both tables, those tables can be combined, or what is known as a 'join' in SQL.

Before creating a query in SQL, it can be useful to create an ERD (Entity Relationship Diagram), which is what I used to understand how the 6 csv files could be relationally tied together. ERD's are basically flow charts that provide a visual representation of the tables created in an ERD diagram, and can provide a roadmap for how you might want to connect or create new databases. 

## Overview 

 PH (Pewlett Hackard) is a company that has been around for a long time, and because of that they are going to be offering retirement packages for those who meet a certain criteria, as well as looking at how many positions will need to be filled in the near future following the retirement of the baby-boomers. Once the baby boomers start retiring, there will be thousands of job openings, which could effect the company negatively if they did not prepare for what they are calling the "silver tsunami". 

With the "silver tsunami" in mind, PH wanted to know how many people will be retiring in the next couple of years and how many positions will they need to fill, which is why they need a generated list of all the employees that are eligible for the retirement package. Due to the fact that PH was mainly using excel and VBA to collect and store their employee data, they could only provide the various employee data within 6 csv files. This is why the use of SQL was important for this task, because SQL can compile all of the data within the 6 csv files into a new employee database. 

## Resources 

* PostgreSQL 13
* pgAdmin 4 v6.11

## The Data 

Using my ERD (Entity Relationship Diagram) as a guide (Fig. A), I was able to create my tables in pgAdmin. An ERD was helpful for setting up the new employee database because of that fact that ERD's capture important information from each csv file used, such as primary and foreign keys, and the datatypes for each column. 

Fig. A)
(ERD diagram)

I prepared the employee database by creating six different tables (Fig. B), known as entities, as well as specifying the datatypes, known as attributes, using the appropriate SQL syntax. In order to establish a relationship between each table, I had to specify a primary key. For example, 'emp_no' was considered a primary key because the employee numbers were unique and only referenced one employee per employee number. I clarified foreign keys within a couple of the tables I was creating, so that I could link the tables together and set up a join between them. 

I also used a UNIQUE constraint (Fig. B) to the 'dept_name' column inside of my 'departments' table, which is useful to prevent data from being duplicated. Setting up this constraint prevents data from becoming flawed or misrepresented, in the event that the 'departments' table, for example, were ever updated in the future, and the same department names were used on similar datasets.

Fig. B)
(create tables ph employees)

Now, that the tables have been created in my schema, and the csv files were properly imported, I used another query to confirm that the tables were created, known as a SELECT statement. It does not do anything with the data but answer questions about the data itself, for instance, 'how many columns are in the table?' , or, 'what is the order of those columns?', 'was I successful in creating my tables?'. This is essentially what is meant when someone says they are "querying the database", a question is asked and an answer is provided but there are no changes actually made to the data itself when using a SELECT statement. As shown in Fig. C, a SELECT statement is used and the questions mentioned above are answered in the 'Data Output' tab. 

Fig. C)
(fig _ c select statement pic)

Next, I had to decide how I wanted to use the data to provide the information regarding retirement eligibility. First, I needed to retrieve information from the employees table using the emp_no (primary key), first_name, and last_name. I also needed to retrieve information from the titles table, which was title, from_date, and to_date. 

By setting up a WHERE statement to filter out the employees that were born between certain dates, for example, those who had a 'birth_date' between Jan 1, 1952 - Dec 31, 1955. I used an INNER JOIN statement to combine the tables using a primary key (emp_no), which was specified with an ON statement inside of the join statement. I used an INTO statement to create a new table, 'retirement titles' (Fig. D), to hold the information I needed from both tables, along with the applied filters, for those employees born, within a certain birth date.

Fig. D)
(pic of retirement titles code)


Using the 'retirement titles' table, I had to create a new table, 'unique titles' (Fig. E), in which I used DISTINCT ON so that I could remove duplicate rows produced in the 'retirement titles' table. This was necessary because some employees may have received a promotion, which would have led to duplicate employee number entries because they were listed in the database under two different titles. I only wanted to keep the employee records of those who were currently still working at PH, as well as, removing the record of their previous job title, which is why I had to set up a filter on the 'to_date' column. I also used an ORDER BY statement to group the employee numbers in ascending order.

Fig. E)
(pic of fig E) 

 I used the COUNT function to display how many employees who were about to retire, and grouping by their job titles. I did not have to recreate the filters for birth_date, or worry about duplicate records, as they were already used to create the 'retiring_titles' table, which is why I used that table to pull information from and create a new 'retiring_titles' table, (Fig. F).

Fig. F)
(pic of fig f)

A final table was created, that would provide information for current employees eligible to participate, in the mentorship program. The criteria for my WHERE clause would now include 2 filters, for example,  birth_date would now apply to those born between Jan 1, 1965 - Dec 31, 1965, and using the 'to_date' from my departments table to be set to the current employee date, '9999-01-01'. 

For the 'mentorship_eligibility' table (Fig. G), I had to write a query that would perform 3 JOINs using tables, 'employees', 'dept_emp', and 'titles'. I used INNER JOIN to combine the employees table to the department employees table, because it would match the emp_no records from both tables, as well as, adding the additional information from the dept_emp table, which was 'from_date' and 'to_date'. 

I used LEFT JOIN to combine the employees table with the titles table, because I wanted to match the employee numbers from both tables together and bring over their associated job titles. I didn't want to carry over the 'from_date' and 'to_date' from the titles table to mess with the 'from_date' and 'to_date' that was already being joined from the 'dept_emp' table. The reason for this was because the from and to dates from the 'dept_emp' table specified when an employee started working at PH, while the from and to dates from the 'titles' table provided dates specific to when that employee started in a certain position, not when they started employment at PH. 

Fig. G)
(mentorship eligibility table)



## Results

By looking at the counts of how many employees by their most recent job title will be retiring soon (Fig H), it can be concluded that: 

* Senior Engineer and Senior Staff employees make up the majority of the number of employees that will be retiring soon
* The Senior positions should be prioritized for setting up the mentorship program to combat the positions that will need to be filled following the "silver tsunami"

Other notable result evaluations include: 

* There is a 72-fold difference between the amount of roles needing to be filled vs. the amount of employees eligible to fill those roles
* When 'joining' multiple tables, one must be cautious as to how they join the tables together, because an improper join could leave values in certain columns empty or not pull over all the needed employee records to provide a proper employee count for employees retiring, or for mentorship eligible employee counts. This was also discussed when reviewing how to join the tables for Fig. G.

## Summary 

* How many roles will need to be filled as the "silver tsunami" begins to make an impact?

Upon creation of the retiring_titles table, it can be concluded that 72,458 roles will need to be filled after the so-called "silver tsunami", which would make a huge impact on PH. This is a substantial amount of roles to fill, which could have extreme effects on the companies success and overall production if they did not take the time to look into how many employees were close to retirement. If the company had tried to calculate this number using the csv files alone, it is possible that they may have come up with a much higher number of roles to fill, due to duplicated employee records, or possibly including records of employees that no longer worked at the company. This could have caused a huge problem down the line, because they would eventually realize that they may have hired, or promoted, more employees than they needed to, and that could cause financial strain on the company in the long run. 

* Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

The amount of employees that are eligible for the mentorship program only amounts to 1,549 employees, which is about 72x lower than the amount of employees they would need to fill all the roles that will be open following the "silver tsunami". This is no where near enough employees to offset the amount of employees that will be retiring.

* Additional queries or tables that may provide more insight into the upcoming "silver tsunami."

Another query could be made, where the amount of eligible employees for the mentorship program could be increased, if they increased the variability of birth dates from Jan 1, 1965 - Dec 31, 1965, to birth dates that span between Jan 1, 1965 - Dec 31, 1970. Then the eligible mentees could be grouped into tables based on the departments they work in, and another table that would provide a count of how many of those employees fall into each birth year. This could be helpful because the retiring employees count used a filter that counted all employees born between 1952-1955, and that doesn't mean that all 72,458 will retire in the same year. So if another query was created breaking down the birth date years into 3 different counts, the amount of employees retiring might show more retiring one year vs. the next year, and so on. Thus, by keeping track of how many employees will be retiring each year, can provide the company with a gauge on how many roles will need to be filled per year, instead of as a whole. 

By breaking up the retiring employee counts by year, the company can decide how many mentor eligible employees would need to be trained up each year. If they broke up those eligible by departments, they could allocate more mentees to one mentor, so more could be trained at once and for the positions that will be need to be filled sooner. This would also prevent certain employees being mentored and then just waiting for a year or two before that mentor retires, as well as, preventing possible roles just being left open because the lower priority mentor eligible employees were trained first over the ones that needed to be trained first. Another positive to breaking up the retiring employee counts by year will give the company an idea of how many external employees they might need to hire to be mentored before the retiring employees leave.
