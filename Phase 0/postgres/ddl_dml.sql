------------------------------------
-- DATA DEFINITION LANGUAGE (DDL) --
------------------------------------

-- CREATE SERVER --
-------------------
	-- Servers [right click] -> Register -> Server... [click]
	-- General {Name: <server_name>}
	-- Connection {Host name: localhost, Username: <user_name or postgres (super user)>, Password :<password_user>}
	-- Save

-- CREATE DATABASE --
---------------------
CREATE DATABASE DBTRY; 		-- Will return lowercased
CREATE DATABASE "DBtry";	-- Will return as it is
CREATE DATABASE "DBTRY"; 	-- Will return as it is

-- DELETE DATABASE --
---------------------
DROP DATABASE dbtry;
DROP DATABASE "DBtry";
DROP DATABASE "DBTRY";

-- CHANGE CONNECTION --
-----------------------
	-- Connection Bar
	-- <database name>/<user name>@<server name>
	-- Click on drop down -> <New Connection...> [click]
	-- Add New Connection:
		-- Server
		-- Database
		-- User

-- CREATE TABLE --
-------------------
	-- Check connection first
	-- Create table that doesn't have foreign key first
	-- column_name data_type constrain
		-- Constrain (PRIMARY KEY, FOREIGN KEY/REFERENCES, NOT NULL, UNIQUE)
		-- Data Type:
			 -- String:
			 	-- Text		: bebas berap karakter
				 	-- TEXT = "Michael Wilbert Puradisastra"
				-- Char		: jumlah karakter harus sekian	
					-- CHAR(10) = "Michael Wi"
					-- CHAR(20) = "Michael Wilbert     "
				-- Varchar	: maksimal jumlah karakter harus sekian
					-- VARCHAR(10) = "Michael Wi"
					-- VARCHAR(20) = "Michael Wilbert"
			-- Number:
				-- INT		: bilangan bulat
				-- BIGNINT	: bilangan bulat tapi angka yang disimpan lebih banyak
				-- FLOAT	: bilangan desimal
				-- DOUBLE	: bilangan desimal tapi angka yang disimpan lebih banyak
			-- Date:
				-- DATE			: satuan terkecilnya tanggal (10/8/2024)
				-- TIMESTAMP	: satuan terkecilnya minimal jam (10/8/2024 10:23:39)

-- Create campus table
CREATE TABLE campus (
    id INT PRIMARY KEY,
    campus_name VARCHAR(50),
    batch VARCHAR(10),
    start_date DATE
);

-- Create students table
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INTEGER,
    campus_id INTEGER REFERENCES campus(id),
    total_grade FLOAT
);

-- DELETE TABLE --
------------------
	-- Delete table that have foreign key first
DROP TABLE students;
DROP TABLE campus;

-- ALTER --
----------
	-- Used to change something
ALTER TABLE students
	RENAME COLUMN total_grade
	TO grade;
	
-- TRUNCATE --
--------------
	-- Delete all data but entity and it's relation
TRUNCATE TABLE campus, students;

--------------------------------------
-- DATA MANIPULATION LANGUAGE (DML) --
--------------------------------------

-- INSERT --
------------
	-- Same as creating table
	-- Insert data table without FK first

-- Insert data into the campus table
INSERT INTO campus (id, campus_name, batch, start_date)
VALUES
    (1, 'Remote', 'RMT-1', '2023-01-01'),
    (2, 'Jakarta', 'HCK-2', '2023-02-01'),
    (3, 'BSD', 'BSD-4', '2023-03-01'),
    (4, 'Surabaya', 'SUB-1', '2023-04-01'),
    (5, 'Singapore', 'SIN-1', '2023-05-01');
	
-- Insert data into the students table
INSERT INTO students (id, name, age, campus_id, grade)
VALUES
    (1, 'Rafif Iman', 20, 1, 85.5),
    (2, 'Hana Arisona', 21, 2, 90.2),
    (3, 'Raka Purnomo', 19, 1, 78.9),
    (4, 'Danu Irfansyah', 20, 3, 92.7),
    (5, 'Rachman Ardhi', 22, 2, 88.1);

-- UPDATE --
------------
	-- Update age
UPDATE students 
	SET age = 23
	WHERE name = 'Rafif Iman';
	-- Update grade
UPDATE  students
	SET grade = 70.0
	WHERE id = 5;

-- DELETE --
------------

	-- Delete students data
DELETE 	FROM students
	WHERE name = 'Raka Purnomo';

	--Delete all students data
DELETE FROM students;
DELETE FROM campus;

-- EXPLAIN --
-------------
	-- Explain give information cost about query/syntax
EXPLAIN SELECT * FROM campus;
	-- Explain Analyze add time to the report
EXPLAIN ANALYZE SELECT * FROM students;