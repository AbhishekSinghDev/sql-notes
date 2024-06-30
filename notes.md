# SQL

    Structured Query Language, is a way or language to communicate with RDBMS.

    * Sql is a language
    * Mysql is open-source RDBMS itself which uses Sql as a query language.

## SQL Datatypes

- CHAR => string with size (0, 255).
- VARCHAR => string (0, 255) range.
- TINYTEXT => string(0, 255) range.
- TEXT => string(0, 65535) range.
- MEDIUMTEXT => string(0, 16777215).
- LONGTEXT => string(0,4294967295).
- BLOB => string(0, 65535) used to store files (audio, video etc).
- MEDIUMBLOB => string(0, 16777215)
- LARGEBLOB => string(0, 4294967295)
- TINYINT
- SMALLINT
- MEDIUMIN
- INT
- BIGINT
- FLOAT => decimal with precision to 23 digits.
- DOUBLE => decimal with 24 to 53 digits.
- DECIMAL => double stored as string.
- DATE => YYYY-MM-DD
- DATETIME => YYYY-MM-DD HH:MM:SS
- TIMESTAMP => YYYYMMDDHHMMSS
- TIME => HH:MM:SS
- ENUM => one of the preset values.
- SET => one or many of the preset values.
- BOOLEAN => true or false
- BIT => stores values in bits.

### CHAR vs VARCHAR

    * char and varchar both store the same a string type but, the only difference in between them is of size.
    * char is a fixed size datatype.
    * varchar is variable size datatype.
    * eg: RAM
    char(250) => [R,A,M,_,_,_,_,_,_,_,_,_,...]
    varchar(250) => [R,A,M]

## Types of SQL commands

- DDL (data definition language)

  - used in defining relation schema
  - CREATE: create table, db, view
  - ALTER TABLE: modification in table structure. eg, change in column dtype or add/remove columns.
  - DROP: delete table, db, view.
  - TRUNCATE: remove all the tuples from the table.
  - RENAME: rename db name, table name, column name etc.

- DRL / DQL (data retrieval / data query language)

  - use to retrieve data from tables
  - SELECT

- DML (data modification language)

  - use to perform modifications in the DB
  - INSERT: insert data into a relation.
  - UPDATE: update relation data.
  - DELETE: delete row(s) from the relation.

- DCL (data control language)

  - use to grant or revote authorities from user.
  - GRANT: access privileges to the db.
  - REVOKE: revoke user access privileges.

- TCL (transaction control language)

  - use to manage transactions done in the db.
  - START TRANSACTION: begin a transaction.
  - COMMIT: apply all the changes and end transaction.
  - ROLLBACK: discard changes and end transaction.
  - SAVEPOINT: checkout within the group of transactions in which to rollback.

## SQL Commands (syntax)

### DRL (DATA RETRIEVAL LANGUAGE)

    1. SELECT <set of column names> FROM <table_name>;

    2. Order execution from RIGHT to LEFT.

    3. Q: Can we use SELECT keyword without using FROM clause ?
        1. Yes, using DUAL Tables;
        2. Dual tables are dummy tables created by MySql, help user
        to do certain obvious actions withot referring to user defined tables;
        3. eg: SELECT 55 + 11;
               SELECT now();
               SELECT ucase(); etc

    4. WHERE
        1. Reduce rows based on given conditions.
        2. Eg: SELECT * FROM user WHERE age > 18;
           Eg: SELECT * FROM worker WHERE department = 'HR';

    5. BETWEEN
        1. SELECT * FROM worker WHERE salary BETWEEN 80000 AND 100000;
        2. In the above Eg, the 80000 and 100000 are inclusive means
        the output will include these number also.

    6. IN
        1. Reduce OR conditions;
        2. Eg: SELECT * FROM worker WHERE department IN ('HR', 'ADMIN')
        3. Other way: using or
           SELECT * FROM worker WHERE department = 'HR' OR department = 'admin'

    7. AND / OR / NOT
        1. AND: WHERE condition_1 AND condition_2;
        2. OR: WHERE condition_1 OR condition_2;
        3. NOT: WHERE condtion_1 NOT IN ('HR', 'ADMIN');

    8. IS NULL
        1. SELECT * FROM worker WHERE pincode IS NULL

    9. PATTERN SEARCHING / WILD CARDS
        1. '%': Any number of charater from '0' to 'n'. Similar to '*' in regex.
        2. '_': Only one character;
        3. SELECT * FROM customer WHERE name LIKE '%p_';
           '%p_' means include those names whose second last word is p;

    10. SORTING
        1. ASC: SELECT * FROM customer ORDER BY salary;
           ASC: SELECT * FROM customer ORDER BY salary ASC;
           -> defualt asc order, we can also add ASC.
        2. DESC: SELECT * FROM customer ORDER BY salary DESC;

    11. DISTINCT
        1. SELECT DISTINCT department FROM worker;
           -> returns all the unique departments in worker table.

    12. GROUP BY
        1. -- GROUP BY
        SELECT department FROM worker GROUP BY department;
        Rule: the column name provided in between select and from that same column name or
        cloumn name list provided to group by also.

        Aggregate functions / methods provided by sql

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

    13. HAVING
        1. Used only with GROUP BY.
        2. Similar to WHERE but not equal to WHERE.
           WHERE filters on the rows of data directly.
           HAVING filters on the groups made by GROUP BY.
        3. Eg: Ques: Find all the departments where more than 2 employees work.
           - SELECT department, COUNT(department) FROM worker GROUP BY department HAVING COUNT(department) > 3;

### DDL (DATA DEFINATION LANGUAGE)

    1. Constraints

        1. Primary Key
            - unique
            - not null
            - only one in a table
            - good practice to have int as PK.
            - Eg: CREATE TABLE customer(
                    id INT PRIMARY KEY,
                    branch_id INT,
                    first_name char(20),
                    last_name char(20),
                    dob DATE,
                    gender char(6)
                );

        2. Foreign Key
            - FK refers to PK of other table.
            - Each relation can have any number of FK.
            - Eg: CREATE TABLE orders(
                    order_id INT PRIMARY KEY,
                    delivery_date DATE,
                    order_placed_date DATE,
                    cust_id INT,
                    FOREIGN KEY(cust_id) REFERENCES customer(id)
                );

        3. Unique
            - Can be null.
            - Table can have multiple unique attributes.
            - Eg: CREATE TABLE customer(
                    ...
                    email VARCHAR(100) UNIQUE,
                    ...
                );
        4. Check
            - Consistency constraint.
            - Eg: CREATE TABLE customer(
                    ...
                    age INT,
                    CONSTRAINT age_check CHECK (age > 12),
                    ...
                );
    2. ALTER

        1. ADD - New column
            ALTER TABLE user_details ADD interest FLOAT NOT NULL DEFAULT 6;

        2. MODIFY - Change the datatype of a column
            ALTER TABLE user_details MODIFY interest DOUBLE NOT NULL DEFAULT 0;

        3. CHANGE COLUMN - Rename the column name
            ALTER TABLE user_details CHANGE COLUMN interest saving_interest FLOAT NOT NULL DEFAULT 2;

        4. DROP COLUMN - Delete a column
            ALTER TABLE user_details DROP COLUMN saving_interest;

        5. RENAME TABLE NAME
            ALTER TABLE user_details RENAME TO user_information;
