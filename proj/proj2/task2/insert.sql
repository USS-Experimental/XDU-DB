SET @counter = 10000;

INSERT INTO ACCOUNT547 (account_number, branch_name, balance)
SELECT 
    CONCAT('A-', LPAD(@counter := @counter + 1, 5, '0')) AS account_number,
    CASE FLOOR(RAND() * 5)
        WHEN 0 THEN 'Downtown'
        WHEN 1 THEN 'Perryridge'
        WHEN 2 THEN 'Brighton'
        WHEN 3 THEN 'Mianus'
        WHEN 4 THEN 'Redwood'
        ELSE 'Round Hill'
    END AS branch_name,
    ROUND(RAND() * 1000, 2) AS balance
FROM information_schema.tables AS a
CROSS JOIN information_schema.tables AS b
CROSS JOIN information_schema.tables AS c
LIMIT 10000;