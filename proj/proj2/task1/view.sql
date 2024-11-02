CREATE VIEW branch_detail AS
SELECT 
    b.branch_name,
    COUNT(DISTINCT a.account_number) AS deposit_customer_count,
    COALESCE(SUM(a.balance), 0) AS total_deposits,
    COUNT(DISTINCT br.customer_name) AS loan_customer_count,
    COALESCE(SUM(l.amount), 0) AS total_loans
FROM 
    BRANCH547 AS b
    LEFT JOIN ACCOUNT547 AS a ON b.branch_name = a.branch_name
    LEFT JOIN LOAN547 AS l ON b.branch_name = l.branch_name
    LEFT JOIN BORROWER547 AS br ON l.loan_number = br.loan_number
GROUP BY 
    b.branch_name;