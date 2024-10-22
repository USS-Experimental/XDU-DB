INSERT INTO `BRANCH547` (branch_name, branch_city, assets) VALUES
('Downtown', 'New York', 1000000.00),
('Perryridge', 'Brooklyn', 1200000.00),
('Brighton', 'Boston', 1500000.00),
('Mianus', 'Stamford', 900000.00),
('Redwood', 'Palo Alto', 1700000.00),
('Round Hill', 'Princeton', 1100000.00);

INSERT INTO `CUSTOMER547` (customer_name, customer_street, customer_city) VALUES
('Adams', 'Spring', 'Pittsfield'),
('Brooks', 'Senator', 'Brooklyn'),
('Curry', 'North', 'Rye'),
('Glenn', 'Sand Hill', 'Woodside'),
('Green', 'Walnut', 'Stamford'),
('Hayes', 'Main', 'Harrison'),
('Johnson', 'Alma', 'Palo Alto'),
('Jones', 'Main', 'Harrison'),
('Lindsay', 'Park', 'Pittsfield'),
('Smith', 'North', 'Rye'),
('Turner', 'Putnam', 'Stamford'),
('Williams', 'Nassau', 'Princeton'),
('Jackson', 'Elm Street', 'Harrison');

INSERT INTO `ACCOUNT547` (account_number, branch_name, balance) VALUES
('A-101', 'Downtown', 500.00),
('A-102', 'Perryridge', 400.00),
('A-201', 'Brighton', 900.00),
('A-215', 'Mianus', 700.00),
('A-217', 'Brighton', 750.00),
('A-222', 'Redwood', 700.00),
('A-305', 'Round Hill', 350.00);

INSERT INTO `DEPOSITOR547` (customer_name, account_number) VALUES
('Hayes', 'A-102'),
('Johnson', 'A-101'),
('Johnson', 'A-201'),
('Jones', 'A-217'),
('Lindsay', 'A-222'),
('Smith', 'A-215'),
('Turner', 'A-305');

INSERT INTO `LOAN547` (loan_number, branch_name, amount) VALUES
('L-11', 'Round Hill', 900.00),
('L-14', 'Downtown', 1500.00),
('L-15', 'Perryridge', 1500.00),
('L-16', 'Perryridge', 1300.00),
('L-17', 'Downtown', 1000.00),
('L-23', 'Redwood', 2000.00),
('L-93', 'Mianus', 500.00);

INSERT INTO `BORROWER547` (customer_name, loan_number) VALUES
('Adams', 'L-16'),
('Curry', 'L-93'),
('Hayes', 'L-15'),
('Jackson', 'L-14'),
('Jones', 'L-17'),
('Smith', 'L-11'),
('Smith', 'L-23'),
('Williams', 'L-17');
