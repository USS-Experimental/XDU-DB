CREATE TABLE BRANCH547(
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50) NOT NULL,
    assets DECIMAL(15, 2) NOT NULL
);

CREATE TABLE ACCOUNT547(
    account_number CHAR(10) PRIMARY KEY,
    branch_name VARCHAR(50),
    balance DECIMAL(15, 2) NOT NULL,

    Foreign Key (branch_name) REFERENCES BRANCH547(branch_name)
);

CREATE TABLE CUSTOMER547(
    customer_name VARCHAR(100) PRIMARY KEY,
    customer_street VARCHAR(100),
    customer_city VARCHAR(50)
);

CREATE TABLE DEPOSITOR547 (
    customer_name VARCHAR(100),
    account_number CHAR(10),

    PRIMARY KEY (customer_name, account_number),
    FOREIGN KEY (customer_name) REFERENCES CUSTOMER547(customer_name),
    FOREIGN KEY (account_number) REFERENCES ACCOUNT547(account_number)
);

CREATE TABLE LOAN547 (
    loan_number CHAR(10) PRIMARY KEY,
    branch_name VARCHAR(50),
    amount DECIMAL(15, 2) NOT NULL,

    FOREIGN KEY (branch_name) REFERENCES BRANCH547(branch_name)
);

CREATE TABLE BORROWER547 (
    customer_name VARCHAR(100),
    loan_number CHAR(10),

    PRIMARY KEY (customer_name, loan_number),
    FOREIGN KEY (customer_name) REFERENCES CUSTOMER547(customer_name),
    FOREIGN KEY (loan_number) REFERENCES LOAN547(loan_number)
);
