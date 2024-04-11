-- UC1-> created database for payroll services
CREATE DATABASE payroll_services;
USE payroll_services;
SHOW DATABASES;

-- UC2-> Employee payroll table created
CREATE TABLE employee_payroll (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    salary DOUBLE NOT NULL,
    startDate DATE NOT NULL
);

-- UC3-> created employee payroll data in the payroll service database
INSERT INTO employee_payroll (name, salary, startDate)
VALUES
    ("sujit", 26000, '2024-03-05'),
    ("mane", 27000, '2024-03-05'),
    ("vedant", 28000, '2024-03-04'),    
    ("ram", 29000, '2024-02-05');
    
    -- UC4-> Retrieving all the data from the employee payroll table
SELECT * FROM employee_payroll;

-- UC5-> Retrieving particular data from the employee name and joining dates
SELECT salary FROM employee_payroll WHERE name = "mane";
DELETE FROM employee_payroll WHERE name = "mane";
SET SQL_SAFE_UPDATES = 0;
INSERT INTO employee_payroll (name, salary, startDate) VALUES ("mane", 27500, '2024-03-05');

SELECT * FROM employee_payroll WHERE startDate BETWEEN CAST('2024-03-05' AS DATE) AND DATE(NOW());

-- UC6-> added gender to employee payroll and updated the
ALTER TABLE employee_payroll 
ADD COLUMN gender CHAR(1) AFTER name;

UPDATE employee_payroll SET gender = 'M' WHERE name IN ('sujit', 'mane', 'vedant', 'ram');

SELECT * FROM employee_payroll;

-- UC7-> use the avg, min, max functions
SELECT gender, SUM(salary) FROM employee_payroll GROUP BY gender; 
SELECT gender, AVG(salary) FROM employee_payroll GROUP BY gender; 
SELECT gender, MAX(salary) FROM employee_payroll GROUP BY gender; 
SELECT gender, MIN(salary) FROM employee_payroll GROUP BY gender; 
SELECT gender, COUNT(salary) FROM employee_payroll GROUP BY gender; 

-- UC8-> extending the employee payroll table
ALTER TABLE employee_payroll 
ADD COLUMN phone_number VARCHAR(20) AFTER name,
ADD COLUMN address VARCHAR(250) DEFAULT 'Govandi',
ADD COLUMN department VARCHAR(50) DEFAULT 'IT' NOT NULL;

SELECT * FROM employee_payroll;

-- UC9-> extending the employee payroll table to add taxes pay
ALTER TABLE employee_payroll
ADD COLUMN basicpay INT, 
ADD COLUMN TaxablePay INT, 
ADD COLUMN Incometax INT,
ADD COLUMN deduction INT,
ADD COLUMN NetPay INT;
SELECT * FROM employee_payroll;

-- UC10-> sujit as part of sales and marketing department.
UPDATE employee_payroll
SET phone_number = '1234', department = 'CS', basicpay = 5000, deduction = 500, TaxablePay = 500, Incometax = 200, NetPay = 5000
WHERE name = 'sujit';

UPDATE employee_payroll
SET phone_number = '1122', department = 'CS', basicpay = 10000, deduction = 100, TaxablePay = 1100, Incometax = 1200, NetPay = 1000
WHERE name = 'vedant';

UPDATE employee_payroll
SET phone_number = '2345', department = 'IT', basicpay = 6000, deduction = 700, TaxablePay = 700, Incometax = 400, NetPay = 6000
WHERE name = 'ram';

UPDATE employee_payroll
SET phone_number = '3456', department = 'IT', basicpay = 16000, deduction = 1700, TaxablePay = 1700, Incometax = 1400, NetPay = 16000
WHERE name = 'mane';

SET SQL_SAFE_UPDATES = 0;
INSERT INTO employee_payroll (name, gender, salary, startDate, department, basicpay, TaxablePay, Incometax, deduction, NetPay) 
VALUES ("sujit", 'M', 26000, '2024-04-10', "Marketting", 30000, 20000, 10000, 10000, 50000);

SELECT * FROM employee_payroll;

-- UC11-> Implement the ER Diagram into Payroll Service DB

CREATE TABLE EmployeeDept (
    EmployeeID INT UNSIGNED,
    DepartmentID INT UNSIGNED,
    FOREIGN KEY (EmployeeID) REFERENCES employee_payroll(id),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Department (
    DepartmentID INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50)
);
INSERT INTO Department (Name) VALUES
    ('IT'),
    ('Sales and Marketing');

INSERT INTO EmployeeDept (EmployeeID, DepartmentID) VALUES
    (1, 1),
    (2, 2),
    (3, 1),
    (4, 1);

SELECT * FROM EmployeeDept;

-- UC12 
SELECT * FROM employee_payroll;
SELECT SUM(basicpay) FROM employee_payroll; 
SELECT avg(basicpay) FROM employee_payroll; 
SELECT min(basicpay) FROM employee_payroll; 
SELECT max(basicpay) FROM employee_payroll; 
SELECT count(basicpay) FROM employee_payroll; 
