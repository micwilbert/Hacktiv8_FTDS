----------------------------------
-- TRANSACTION CONTROL LANGUAGE --
----------------------------------

-- ALTER TABLE (ADD COLUMN) --
------------------------------
	-- Add Column
ALTER TABLE students
	ADD COLUMN amount INT;
	-- Add Value
UPDATE students SET amount = 50;

-- BEGIN, ROLLBACK, & COMMIT --
------------------------------
	-- Hana amount		-30
	-- Rachman amount	+30
	
-- Untuk memulai blok transaksi
BEGIN;

-- Amount Hana berkurang 30
UPDATE students
	SET amount = amount - 30
	WHERE name = 'Hana Arisona';

-- Untuk meletakkan savepoint/checkpoint
SAVEPOINT hana_berkurang;

-- Amount Rachman bertambah 30
UPDATE students
	SET amount = amount + 30
	WHERE name = 'Rachman Ardhi';

-- Untuk mengembalikan ke keadaan sebelum BEGIN
ROLLBACK;

-- Untuk mengembalikan ke keadaan sebelum savepoint yang diminta
ROLLBACK TO SAVEPOINT hana_berkurang;

-- Untuk COMMIT perubahan ke dalam database
COMMIT;


---------------------------
-- DATA CONTROL LANGUAGE --
---------------------------

-- CREATE USER --
-----------------
CREATE USER user_admin WITH PASSWORD '123456';
CREATE USER user_cashier WITH PASSWORD '1234';
	-- Try to create server with each user

-- SEE USER LIST --
-------------------
SELECT * FROM pg_user;

-- SWITCH USER --
-----------------
	-- Could try to switch user with it's own server
SET ROLE user_admin;	-- Ganti ke admin
SET ROLE user_cashier;	-- Ganti ke kasir
SET ROLE postgres;		-- Ganti ke super user

-- CHECK CURRENT USER --
------------------------
SELECT current_user;

-- GRANT --
-----------
	-- Memberi hak kepada user dalam suatu table
GRANT SELECT, INSERT, UPDATE, DELETE	-- Cara 1
	ON students, campus	-- Ke table mana
	TO user_admin;		-- Untuk user mana
GRANT ALL PRIVILEGES					-- Cara 2
	ON students, campus					-- Bukan berarti setara dengan super user (postgres)
	TO user_admin;
GRANT SELECT, INSERT
	ON students
	TO user_cashier;

	-- Update Amount --
UPDATE students SET amount = amount + 10;

-- REVOKE --
------------
REVOKE INSERT, SELECT
	ON 	students
	FROM user_cashier;
REVOKE ALL PRIVILEGES
	ON students, campus
	FROM user_admin;
	
-- DELETE USER --
-----------------
	-- Can't delete user that still have privilege
DROP USER user_cashier;
DROP USER user_admin;

SELECT * FROM students;
--------------
-- EXERCISE --
--------------
	-- Create user that could UPDATE & SELECT
	-- Switch to new_user
	-- Update amount - 25
	-- Update grade to 88.8 for Raka
BEGIN;

CREATE USER new_user WITH PASSWORD '123';

GRANT UPDATE, SELECT
	ON students
	TO new_user;

SET ROLE new_user;

SAVEPOINT new_user_point;

UPDATE students SET amount = amount - 25;

SAVEPOINT subs_amount_point;

UPDATE students SET grade = 88.8 WHERE name = 'Raka Purnomo';

ROLLBACK;

-- ROLLBACK TO SAVEPOINT new_user_point;
-- ROLLBACK TO SAVEPOINT subs_amount_point;

COMMIT;

--------------------------
-- INSERT DATA FROM CSV --
--------------------------

-- Create Tables --
BEGIN;

SET ROLE postgres;

CREATE TABLE players (
    full_school_name VARCHAR(255),
    school_name VARCHAR(255),
    player_name VARCHAR(255),
    position VARCHAR(255),
    height FLOAT,
    weight FLOAT,
    year VARCHAR(255),
    hometown VARCHAR(255),
    state VARCHAR(255),
    id INT PRIMARY KEY
);

CREATE TABLE teams (
    division VARCHAR(100),
    conference VARCHAR(100),
    school_name VARCHAR(100),
    roster_url VARCHAR(200),
    id INT PRIMARY KEY
);

COMMIT;

-- Delete Data --
TRUNCATE TABLE teams, players;

-- Check Values --
SELECT * FROM teams;
SELECT * FROM players;

-- INSERT DATA FROM CSV --
--------------------------
	-- Import/ Export
		-- On table name [right click] -> Import/Export Data...
		-- General
			-- Import
			-- Filename sesuaikan dengan lokasi data
			-- Format csv
			-- Encoding UTF8
		-- Options
			-- Header ON kalo baris atas merupakan nama kolom
			-- Header OFF kalo baris atas file csv bukan/tidak ada nama kolom
			-- Delimiter ,
		-- OK

	-- Syntax COPY
		-- Masukkan file csv ke folder private/var/temp/
COPY teams(division, conference, school_name, roster_url, id)
FROM 'C:\Users\MSI\AppData\Local\Temp\teams.csv'
DELIMITER ','
CSV HEADER;

COPY players(full_school_name, school_name, player_name, position, height, weight, year, hometown, state, id)
FROM 'C:\Users\MSI\AppData\Local\Temp\players.csv'
DELIMITER ','
CSV HEADER;