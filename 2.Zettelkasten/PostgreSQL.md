[[Database]]
## Connection

- `psql -U username -d database_name`: Connect to a database as a specific user
- `psql -h hostname -U username -d database_name`: Connect to a database on a specific host as a specific user

## Database Operations

- `CREATE DATABASE db_name;`: Create a new database
- `DROP DATABASE db_name;`: Delete a database
- `\l`: List all databases
- `\c db_name`: Connect to a specific database

## Table Operations

- `CREATE TABLE table_name (column1 datatype, column2 datatype, ...);`: Create a new table
- `DROP TABLE table_name;`: Delete a table
- `ALTER TABLE table_name ADD COLUMN new_column datatype;`: Add a new column to a table
- `ALTER TABLE table_name DROP COLUMN column_name;`: Remove a column from a table
- `ALTER TABLE table_name ALTER COLUMN column_name TYPE new_datatype;`: Change the data type of a column
- `\d`: List all tables in the current database
- `\d table_name`: Describe a specific table

## Data Manipulation

- `INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);`: Insert new data into a table
- `UPDATE table_name SET column1 = value1 WHERE condition;`: Update existing data in a table
- `DELETE FROM table_name WHERE condition;`: Delete data from a table

## Querying Data

- `SELECT * FROM table_name;`: Select all columns from a table
- `SELECT column1, column2 FROM table_name WHERE condition;`: Select specific columns with a condition
- `SELECT DISTINCT column FROM table_name;`: Select unique values from a column
- `SELECT column FROM table_name ORDER BY column ASC/DESC;`: Select data with sorting
- `SELECT column FROM table_name LIMIT n;`: Select a limited number of rows

## Joins

- `SELECT * FROM table1 INNER JOIN table2 ON table1.column = table2.column;`: Inner join
- `SELECT * FROM table1 LEFT JOIN table2 ON table1.column = table2.column;`: Left join
- `SELECT * FROM table1 RIGHT JOIN table2 ON table1.column = table2.column;`: Right join
- `SELECT * FROM table1 FULL OUTER JOIN table2 ON table1.column = table2.column;`: Full outer join

## Aggregation

- `SELECT COUNT(*) FROM table_name;`: Count rows
- `SELECT AVG(column) FROM table_name;`: Calculate average
- `SELECT SUM(column) FROM table_name;`: Calculate sum
- `SELECT MIN(column) FROM table_name;`: Find minimum value
- `SELECT MAX(column) FROM table_name;`: Find maximum value
- `SELECT column, COUNT(*) FROM table_name GROUP BY column;`: Group by with count
- `SELECT column, COUNT(*) FROM table_name GROUP BY column HAVING count(*) > value;`: Group by with having clause

## Indexing

- `CREATE INDEX index_name ON table_name (column);`: Create an index
- `DROP INDEX index_name;`: Delete an index

## Views

- `CREATE VIEW view_name AS SELECT column1, column2 FROM table_name WHERE condition;`: Create a view
- `DROP VIEW view_name;`: Delete a view

## Users and Permissions

- `CREATE USER username WITH PASSWORD 'password';`: Create a new user
- `ALTER USER username WITH PASSWORD 'new_password';`: Change user's password
- `GRANT ALL PRIVILEGES ON DATABASE db_name TO username;`: Grant all privileges on a database to a user
- `REVOKE ALL PRIVILEGES ON DATABASE db_name FROM username;`: Revoke all privileges on a database from a user
- `\du`: List all roles/users

## Backup and Restore

- `pg_dump db_name > backup_file.sql`: Backup a database
- `psql db_name < backup_file.sql`: Restore a database

## Transactions

- `BEGIN;`: Start a transaction
- `COMMIT;`: Commit a transaction
- `ROLLBACK;`: Rollback a transaction




