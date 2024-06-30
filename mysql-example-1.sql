CREATE DATABASE ORG;

SHOW DATABASES;
USE ORG;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	FIRST_NAME CHAR(20), 
	LAST_NAME CHAR(20),
    SALARY INT,
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(20)
);

INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES 
    (001, "Abhishek", "Singh", 10000, "14-02-20 09.00.00", "HR"),
    (002, "Ayush", "Singh", 20000, "14-06-20 09.00.00", "ADMIN"),
    (003, "Sumit", "Singh", 42000, "14-07-11 09.00.00", "HR"),
    (004, "Ashish", "Singh", 50000, "14-01-10 09.00.00", "HR"),
    (005, "Shiva", "Singh", 153000, "14-08-21 09.00.00", "ADMIN"),
    (006, "Narendar", "Shai", 110000, "14-01-12 09.00.00", "HR"),
    (007, "Satish", "Kumar", 530000, "14-02-20 09.00.00", "HR"),
    (008, "Arpita", "Chauhan", 800000, "14-04-12 09.00.00", "ADMIN");

SELECT * FROM Worker;

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
    BONUS_AMOUNT INT,
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
		ON DELETE CASCADE
);

INSERT INTO Bonus
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, "16-02-20"),
        (002, 3000, "16-08-11"),
        (003, 4000, "16-01-20"),
        (001, 1555, "16-02-20"),
        (002, 3500, "16-06-11");

SELECT * FROM Bonus;

CREATE TABLE Title (
	WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES 
		(001, "Manager", "2016-02-20 00:00:00"),
        (002, "Executive", "2016-01-12 00:00:00"),
        (003, "Executive", "2016-06-13 00:00:00"),
        (008, "Manager", "2016-01-29 00:00:00"),
        (007, "Asst. Manager", "2016-06-21 00:00:00"),
        (006, "Lead", "2016-03-11 00:00:00");

SELECT * FROM Title;

-- [DRL] DATA RERIEVAL LANGUAGE QUERIES

SELECT * FROM Worker;
SELECT FIRST_NAME, SALARY FROM Worker;

SELECT now();
SELECT ucase("abhiSingh");
SELECT lcase("ABHISHEK_SINGH");

SELECT * FROM worker WHERE salary > 10000;

SELECT * FROM worker WHERE DEPARTMENT = 'HR';

SELECT * FROM worker WHERE salary BETWEEN 10000 AND 200000;

SELECT * FROM worker WHERE first_name LIKE '%i_';

-- [sorting in sql using order by]
SELECT * FROM worker ORDER BY salary;
SELECT * FROM worker ORDER BY salary DESC;

-- DISTINCT
SELECT DISTINCT department FROM worker;

-- GROUP BY
SELECT department FROM worker GROUP BY department;

-- AVG
-- Q: Find avg. salary per department.
SELECT department, AVG(salary) FROM worker GROUP BY department;

-- COUNT
-- Q: Find total employees working in different departments.
SELECT department, COUNT(department) FROM worker GROUP BY department;

-- SUM
-- Q: Find the total sum of salary is given in per department.
SELECT department, SUM(salary) FROM worker GROUP BY department;

-- MIN
-- Q: Find the minimum salary is given in every department.
SELECT department, MIN(salary) FROM worker GROUP BY department;

-- MAX
-- Q: Find the maximum salary is given in every department.
SELECT department, MAX(salary) FROM worker GROUP BY department;


-- GROUP BY HAVING
-- Q: Find all the departments where more than 2 employees work.
SELECT department, COUNT(department) FROM worker GROUP BY department HAVING COUNT(department) > 3;




-- DDL (DATA DEFINATION LANGUAGE)

CREATE DATABASE DDL;

USE DDL;

-- PRIMARY KEY
CREATE TABLE customer(
	id INT PRIMARY KEY,
    first_name CHAR(20),
    last_name CHAR(20),
    address VARCHAR(100)
);

-- FOREIGN KEY
CREATE TABLE order_details(
	order_id INT PRIMARY KEY,
    product_name CHAR(50),
    product_category CHAR(50),
    amount INT,
    cust_id INT,
    FOREIGN KEY(cust_id) REFERENCES customer(id)
);

-- CONSTRAINTS AND DEFAULT 
CREATE TABLE user_details(
	id INT PRIMARY KEY,
    username CHAR(10) DEFAULT 'DON_',
    first_name CHAR(10),
    last_name CHAR(10),
	balance INT,
    CONSTRAINT acc_balance_check CHECK(balance > 100)
);

INSERT INTO user_details(id, first_name, last_name, balance) VALUES(1, 'a', 'b', 101);

SELECT * FROM user_details;
DESC user_details;

-- ADD - New column
ALTER TABLE user_details ADD interest FLOAT NOT NULL DEFAULT 6;

-- MODIFY - Change the datatype of a column
ALTER TABLE user_details MODIFY interest DOUBLE NOT NULL DEFAULT 0;

-- CHANGE COLUMN - Rename the column name
ALTER TABLE user_details CHANGE COLUMN interest saving_interest FLOAT NOT NULL DEFAULT 2;

-- DROP COLUMN - Delete a column
ALTER TABLE user_details DROP COLUMN saving_interest;

-- RENAME TABLE NAME
ALTER TABLE user_details RENAME TO user_information;