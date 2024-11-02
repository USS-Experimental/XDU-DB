# 上机1

## 上机题目

1. 基于第一次上机创建的银行数据库，创建一个视图`branch_detail`，能够显示所有支行的存款客户数量、存款总额、贷款客户数量、贷款总额。
2. 在`account`的`account_number`属性上建立索引，并在`account`表里插入大量元组，比较有无索引在查询速度上的区别。
3. 创建角色银行经理`branch_manager`，银行经理具有插入、删除和更新`branch`表的权限。
4. 自由练习第四章中级SQL的其他特性。

## 解答

### 1

创建视图使用`CREATE VIEW *** AS`语句，本题要求创建显示每一个支行的客户数量，存款总额，贷款客户的数量和总额，因此需要连接`account`，`depositor`，`loan`和`borrower`表，并筛选其中的账户数量总和，存款总和。

语句如下：

```sql
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
```

执行效果如下：

```sql
mysql> source ~/cs/database/proj/proj2/view.sql
Query OK, 0 rows affected (0.02 sec)

mysql> SELECT * FROM branch_detail;
+-------------+------------------------+----------------+---------------------+-------------+
| branch_name | deposit_customer_count | total_deposits | loan_customer_count | total_loans |
+-------------+------------------------+----------------+---------------------+-------------+
| Brighton    |                      2 |        1650.00 |                   0 |        0.00 |
| Downtown    |                      1 |        1500.00 |                   3 |     3500.00 |
| Mianus      |                      1 |         700.00 |                   1 |      500.00 |
| Perryridge  |                      1 |         800.00 |                   2 |     2800.00 |
| Redwood     |                      1 |         700.00 |                   1 |     2000.00 |
| Round Hill  |                      1 |         350.00 |                   1 |      900.00 |
+-------------+------------------------+----------------+---------------------+-------------+
6 rows in set (0.01 sec)
```

### 2

要在`account`的`account_number`属性上建立索引，并且比较有无索引在查询速度上的区别，首先需要在`account`表里插入大量元组。

使用如下的语句进行插入，随机生成account_number和balance，并在现有的六个branch_name中随机选择进行插入，共插入10000条元组，语句如下：

```sql
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
```

完成插入后，首先测量没有索引时的查询速度，查询语句如下：

```sql
SET @start_time_no_index = (SELECT MICROSECOND(NOW(4)));

SELECT * FROM ACCOUNT547 WHERE account_number = 'A-11451';

SET @end_time_no_index = (SELECT MICROSECOND(NOW(4)));

SELECT @end_time_no_index - @start_time_no_index AS no_index_query_duration_microseconds;
```

执行效果如下：

```sql
mysql> source ~/cs/database/proj/proj2/without_index.sql
Query OK, 0 rows affected (0.00 sec)

+----------------+-------------+---------+
| account_number | branch_name | balance |
+----------------+-------------+---------+
| A-11451        | Brighton    |  400.28 |
+----------------+-------------+---------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

+--------------------------------------+
| no_index_query_duration_microseconds |
+--------------------------------------+
|                                  600 |
+--------------------------------------+
1 row in set (0.00 sec)
```

可以发现，在没有索引时在10000条数据中查询，花费了600ms。

接下来需要创建索引可以使用`CREATE INDEX *** ON ***`语句，语句如下：

```sql
CREATE INDEX idx_account_number ON ACCOUNT547(account_number);
```
执行效果如下：

```sql
mysql> CREATE INDEX idx_account_number ON ACCOUNT547(account_number);
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0
```

完成创建后，继续进行查询，结果如下：

```sql
mysql> source ~/cs/database/proj/proj2/with_index.sql
Query OK, 0 rows affected (0.00 sec)

+----------------+-------------+---------+
| account_number | branch_name | balance |
+----------------+-------------+---------+
| A-11451        | Brighton    |  400.28 |
+----------------+-------------+---------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

+----------------------------------------+
| with_index_query_duration_microseconds |
+----------------------------------------+
|                                    500 |
+----------------------------------------+
1 row in set (0.00 sec)
```

可以发现，创建索引后减小了100ms的查询时间。

### 3

创建角色银行经理`branch_manager`，银行经理具有插入、删除和更新`branch`表的权限，可以使用`ROLL`相关的语句，语句如下：

```sql
CREATE ROLE branch_manager;

GRANT INSERT, DELETE, UPDATE ON BRANCH547 TO branch_manager;
```