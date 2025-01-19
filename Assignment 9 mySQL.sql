# Create the database

CREATE DATABASE WorkerDB;
USE WorkerDB;

# Create the Worker table

CREATE TABLE Worker (
    Worker_Id INT PRIMARY KEY,
    FirstName CHAR(25),
    LastName CHAR(25),
    Salary INT,
    JoiningDate DATETIME,
    Department CHAR(25)
    );
    
# Insert 5 rows into the Worker table

INSERT INTO Worker VALUES
(1, 'John', 'Doe', 50000, '2021-01-15', 'HR'),
(2, 'Jane', 'Smith', 60000, '2020-06-12', 'Finance'),
(3, 'Alice', 'Brown', 70000, '2019-09-01', 'IT'),
(4, 'Bob', 'White', 55000, '2022-03-20', 'Marketing'),
(5, 'Charlie', 'Black', 80000, '2021-11-11', 'IT');

SELECT *FROM Worker ;

#  create the stored procedures

# 1.Stored procedure to add a new record to the Worker table

DELIMITER //
CREATE PROCEDURE AddWorker (
    IN p_Worker_Id INT,
    IN p_FirstName CHAR(25),
    IN p_LastName CHAR(25),
    IN p_Salary INT,
    IN p_JoiningDate DATETIME,
    IN p_Department CHAR(25)
)
BEGIN
    INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
    VALUES (p_Worker_Id, p_FirstName, p_LastName, p_Salary, p_JoiningDate, p_Department);
END //
DELIMITER ;
;

# Procedure Call:

CALL AddWorker(6, 'John', 'Doe', 50000, '2025-01-16', 'HR');

# 2.Stored procedure to retrieve salary using WORKER_ID

DELIMITER //
CREATE PROCEDURE GetSalary (
    IN p_Worker_Id INT,
    OUT p_Salary INT
)
BEGIN
    SELECT Salary INTO p_Salary
    FROM Worker
    WHERE Worker_Id = p_Worker_Id;
END //
DELIMITER ;

# Procedure Call:
SET @salary = 0;
CALL GetSalary(1, @salary);
SELECT @salary AS Salary;


# 3. Stored procedure to update the department of a worker

DELIMITER //
CREATE PROCEDURE UpdateDepartment (
    IN p_Worker_Id INT,
    IN p_Department CHAR(25)
)
BEGIN
    UPDATE Worker
    SET Department = p_Department
    WHERE Worker_Id = p_Worker_Id;
END //
DELIMITER ;

#  Procedure Call:

CALL UpdateDepartment(4, 'Sales');

# 4. Stored procedure to retrieve the number of workers in a department

DELIMITER //
CREATE PROCEDURE CountWorkersInDepartment (
    IN p_Department CHAR(25),
    OUT p_WorkerCount INT
)
BEGIN
    SELECT COUNT(*) INTO p_WorkerCount
    FROM Worker
    WHERE Department = p_Department;
END //
DELIMITER ;

# procedure call
SET @workerCount = 0;
CALL CountWorkersInDepartment('HR', @workerCount);
SELECT @workerCount AS WorkerCount;

# 5. Stored procedure to retrieve the average salary of workers in a department

DELIMITER //
CREATE PROCEDURE AverageSalaryInDepartment (
    IN p_Department CHAR(25),
    OUT p_AvgSalary FLOAT
)
BEGIN
    SELECT AVG(Salary) INTO p_AvgSalary
    FROM Worker
    WHERE Department = p_Department;
END //
DELIMITER ;

#  procedure call
SET @workerCount = 0;
CALL AverageSalaryInDepartment('HR', @avgSalary);
SELECT @avgSalary;



