INSERT INTO `EMPLOYEE547` (employee_name, street, city) VALUES
('Alice', 'Maple St', 'New York'),
('Bob', 'Oak St', 'Boston'),
('Charlie', 'Pine St', 'Chicago'),
('David', 'Elm St', 'San Francisco'),
('Eve', 'Cedar St', 'Seattle');

INSERT INTO `COMPANY547` (company_name, city) VALUES
('TechCorp', 'New York'),
('HealthInc', 'Boston'),
('EduWorld', 'Chicago'),
('FinancePro', 'San Francisco'),
('AutoWorks', 'Seattle');

INSERT INTO `WORKS547` (employee_name, company_name, salary) VALUES
('Alice', 'TechCorp', 90000.00),
('Bob', 'HealthInc', 75000.00),
('Charlie', 'EduWorld', 62000.00),
('David', 'FinancePro', 85000.00),
('Eve', 'AutoWorks', 67000.00);

INSERT INTO `MANAGES547` (employee_name, manager_name) VALUES
('Alice', 'David'),
('Bob', 'Alice'),
('Charlie', 'Bob'),
('Eve', 'Charlie');
