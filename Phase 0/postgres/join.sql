-- Create the students table
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INTEGER,
    campus_id INTEGER,
    total_grade FLOAT
);

-- Insert data into the students table
INSERT INTO students (name, age, campus_id, total_grade)
VALUES
    ('Rafif Iman', 20, 1, 85.5),
    ('Hana Arisona', 21, 2, 90.2),
    ('Raka Purnomo', 19, 1, 78.9),
    ('Danu Irfansyah', 20, 3, 92.7),
    ('Rachman Ardhi', 22, 2, 88.1);

-- Create the campus table
CREATE TABLE campus (
    id SERIAL PRIMARY KEY,
    campus_name VARCHAR(50),
    batch VARCHAR(10),
    start_date DATE
);

-- Insert data into the campus table
INSERT INTO campus (campus_name, batch, start_date)
VALUES
    ('Remote', 'RMT-1', '2023-01-01'),
    ('Jakarta', 'HCK-2', '2023-02-01'),
    ('BSD', 'BSD-4', '2023-03-01'),
    ('Surabaya', 'SUB-1', '2023-04-01'),
    ('Singapore', 'SIN-1', '2023-05-01');
-- Insert new data into the students table
INSERT INTO students (name, age, campus_id, total_grade)
VALUES
    ('Amir Nasution', 20, 1, 97.5),
    ('David Hartono', 21, 2, 83.2),
    ('Putri Ineke', 18, 2, 86.3),
    ('Tiara NIngrum', 17, 3, 84.4),
    ('Bayu Setiawan', 20, 2, 70.8);

SELECT * FROM students;


-- BASIC QUERY --
-----------------

SELECT * FROM students;

-- Mengambil columnname dan age --
SELECT name, age FROM students;

-- Mengambil semua data dari table students dengan alias --
SELECT * FROM students AS stu;

SELECT *FROM students stu;

-- Menampilkan column name dengan alias --
SELECT name AS full_name
FROM students;

-- Mengurutkan students dari usia termuda hingga tertua --
SELECT * FROM students
	ORDER BY age;

-- Mengurutkan students dari usia tertua hingga termuda --
SELECT * FROM students
	ORDER BY age DESC;

-- Mengurutkan students dari usia termuda hingga tertua kemudian id kecil ke besar --
SELECT * FROM students
	ORDER BY age ASC, id ASC;

-- Mencari daftar usia unik (tidak duplikat) --
SELECT DISTINCT age
	FROM students
		ORDER BY age ASC;

-- Mencari student unik berdasarkan age & campus_id --
SELECT DISTINCT age, campus_id
	FROM students
		ORDER BY age;

-- Mencari nama students yang berusia 20 --
SELECT name, age
	FROM students
		WHERE age = 20;

-- Mencari nama students yang bukan berusia 20 --
SELECT name, age
	FROM students
		WHERE age <> 20;

atau

SELECT name, age
	FROM students
		WHERE age != 20;

-- Mencari nama students yang memiliki total_grade lebih besar dari 80 --
SELECT name, total_grade
	FROM students
		WHERE total_grade > 80;
		
-- Mencari nama students yang bukan berusia 20 dan memiliki total_grade lebih besar sama dengan dari 80 --
SELECT name, age, total_grade
	FROM students
		WHERE age <>20 AND total_grade >= 80;
		
-- Mencari nama students yang memiliki campus_id = 1 ATAU memiliki total_grade lebih besar dari 90 --
SELECT name, campus_id, total_grade
	FROM students
		WHERE campus_id=1 OR total_grade>90;

-- Mencari nama student dengan karakter 'ar' pada nama nya --
SELECT * FROM students
	WHERE name ILIKE '%ar%';

-- Mencari banyaknya data di data table students --
SELECT COUNT (*) AS jumlah_data
	FROM students;

-- Mencari rata-rata dari total_grade pada table students --
SELECT AVG(total_grade)
	FROM students;

-- Mencari rata-rata total_grade per masing-masing campus_id --
SELECT campus_id, AVG(total_grade)
	FROM students
		GROUP BY campus_id
			ORDER BY campus_id ASC;

-- Mencari campus_id yang nilai rata-rata total_gradenya diatas 85 --
SELECT campus_id, AVG(total_grade)
	FROM students
		GROUP BY campus_id
			HAVING AVG (total_grade)>85
				ORDER BY campus_id ASC;

-- Mengambil 4 data students --
SELECT * FROM students 
	LIMIT 4;

-- Menghitung jumlah students per campus_id --
SELECT campus_id, COUNT(name) as jumlah_students
	FROM students
		GROUP BY campus_id;

-- Join table antara table students dengan table campus --
SELECT * FROM students 
	INNER JOIN campus ON students.campus_id = campus.id;

-- Menampilkan name, campus_name dari hasil join table --

SELECT students.name, campus.campus_name
	FROM students
		INNER JOIN campus ON students.campus_id = campus.id;
	

-- Create the students table
CREATE TABLE assignment_scores (
    id SERIAL PRIMARY KEY,
    students_id INTEGER,
    assignment_id INTEGER,
    score FLOAT
);

-- Insert data into the students table
INSERT INTO assignment_scores (students_id, assignment_id, score)
VALUES
    (1, 1, 90.0),
    (1, 2, 85.0),
    (2, 1, 92.5),
    (2, 2, 88.5),
    (3, 1, 80.0),
    (4, 2, 79.5),
    (4, 1, 95.0),
    (4, 2, 90.5),
    (5, 1, 88.0),
    (5, 2, 86.0),
    (6, 2, 86.0);

-- Join 3 table --
SELECT * FROM students
	INNER JOIN assignment_scores ON students.id = assignment_scores.students_id
		INNER JOIN campus ON students.campus_id = campus.id