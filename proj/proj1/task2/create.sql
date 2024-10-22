CREATE TABLE EMPLOYEE547 (
    employee_name VARCHAR(100) PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE COMPANY547 (
    company_name VARCHAR(100) PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE WORKS547 (
    employee_name VARCHAR(100) PRIMARY KEY,
    company_name VARCHAR(100),
    salary DECIMAL(15, 2) NOT NULL,

    FOREIGN KEY (employee_name) REFERENCES EMPLOYEE547(employee_name),
    FOREIGN KEY (company_name) REFERENCES COMPANY547(company_name)
);

CREATE TABLE MANAGES547 (
    employee_name VARCHAR(100) PRIMARY KEY,
    manager_name VARCHAR(100),

    FOREIGN KEY (employee_name) REFERENCES EMPLOYEE547(employee_name),
    FOREIGN KEY (manager_name) REFERENCES EMPLOYEE547(employee_name)
);
