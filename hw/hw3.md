# Homework3
## 3.2
### a
```sql
SELECT SUM(c.credits * gp.points) AS total_grade_points
FROM takes AS t
NATURAL JOIN course AS c
NATURAL JOIN grade_points AS gp
WHERE t.ID = '12345';
```
### b
```sql
SELECT SUM(c.credits * gp.points) / SUM(c.credits) AS GPA
FROM takes AS t
NATURAL JOIN course AS c
NATURAL JOIN grade_points AS gp
WHERE t.ID = '12345';
```
### c
```sql
SELECT t.ID, SUM(c.credits * gp.points) / SUM(c.credits) AS GPA
FROM takes AS t
NATURAL JOIN course AS c
NATURAL JOIN grade_points AS gp;
```

## 3.9
### a
```sql
SELECT ee.employee_name, ee.city
FROM employee AS ee
NATURAL JOIN works AS w
WHERE w.company_name = 'First Bank Corporation';
```
### b
```sql
SELECT ee.employee_name, ee.street, ee.city
FROM employee AS ee
NATURAL JOIN works AS w
WHERE w.company_name = 'First Bank Corporation' 
    AND w.salary > 10000;
```
### c
```sql
SELECT ee.employee_name
FROM employee AS ee
NATURAL JOIN works AS w
WHERE w.company_name != 'First Bank Corporation';
```
### d
```sql
SELECT ee.employee_name
FROM employee AS ee
NATURAL JOIN works AS w
WHERE w.salary > (
    SELECT MAX(w2.salary)
    FROM works AS w2
    WHERE w2.company_name = 'Small Bank Corporation'
);
```
### e
```sql
SELECT DISTINCT c1.company_name
FROM company AS c1
WHERE EXISTS (
    SELECT 1
    FROM company AS c2
    WHERE c2.company_name = 'Small Bank Corporation'
    AND c2.city = c1.city
    AND c1.company_name != 'Small Bank Corporation'
);
```
### f
```sql
SELECT w.company_name
FROM works AS w
GROUP BY w.company_name
ORDER BY COUNT(w.employee_name) DESC
LIMIT 1
```
### g
```sql
SELECT w.company_name
FROM works AS w
GROUP BY w.company_name
HAVING AVG(w.salary) > (
    SELECT AVG(w2.salary)
    FROM works w2
    WHERE w2.company_name = 'First Bank Corporation'
);
```
## 3.15
### a
```sql
SELECT DISTINCT c.customer_name
FROM customer AS c
WHERE NOT EXISTS (
    SELECT b.branch_name
    FROM branch AS b
    WHERE b.branch_city = 'Brooklyn'
    AND NOT EXISTS (
        SELECT d.account_number
        FROM depositor AS d, account AS a
        WHERE d.customer_name = c.customer_name
        AND d.account_number = a.account_number
        AND a.branch_name = b.branch_name
    )
);
```
### b
```sql
SELECT SUM(amount) AS total_loan_amount
FROM loan;
```
### c
```sql
SELECT b1.branch_name
FROM branch AS b1
WHERE b1.assets > (
    SELECT MAX(b2.assets)
    FROM branch AS b2
    WHERE b2.branch_city = 'Brooklyn'
);
```