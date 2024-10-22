# 上机1

## 上机题目

### 任务1

本次上机的第一部分任务为教材Banking数据库的建库、数据更新及查询，创建数据库的语句如下：

```sql
mysql> create database BANK547;
Query OK, 1 row affected (0.02 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| BANK547            |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)
```

完成`BANK547`数据库的创建后，切换到该数据库，查询其中的表，由于尚未创建表，此处返回为空。

```sql
mysql> use BANK547;
Database changed
mysql> show tables;
Empty set (0.00 sec)
```

为了便于操作，我将创建表格的SQL语句放在了单独的文本文件中并调用运行，文件为`proj/proj1/task1/create.sql`，调用运行后查询当前数据库内表格，结果如下：

```sql
mysql> source ~/cs/database/proj/proj1/task1/create.sql
Query OK, 0 rows affected (0.06 sec)

Query OK, 0 rows affected (0.07 sec)

Query OK, 0 rows affected (0.05 sec)

Query OK, 0 rows affected (0.06 sec)

Query OK, 0 rows affected (0.05 sec)

Query OK, 0 rows affected (0.05 sec)

mysql> show tables;
+-------------------+
| Tables_in_BANK547 |
+-------------------+
| ACCOUNT547        |
| BORROWER547       |
| BRANCH547         |
| CUSTOMER547       |
| DEPOSITOR547      |
| LOAN547           |
+-------------------+
6 rows in set (0.00 sec)

mysql> desc CUSTOMER547;
+-----------------+--------------+------+-----+---------+-------+
| Field           | Type         | Null | Key | Default | Extra |
+-----------------+--------------+------+-----+---------+-------+
| customer_name   | varchar(100) | NO   | PRI | NULL    |       |
| customer_street | varchar(100) | YES  |     | NULL    |       |
| customer_city   | varchar(50)  | YES  |     | NULL    |       |
+-----------------+--------------+------+-----+---------+-------+
3 rows in set (0.01 sec)
```

完成表格的创建后，向其中插入要求的数据，语句同样保存在对应的文本文件当中，文件为`proj/proj1/task1/insert.sql`。

这里需要注意，在表2.7中，出现了在先前的表2.4中未出现过的`Jackson`，由于`BORROWER547`表中的`customer_name`为外键，因此需要在`CUSTOMER547`表中插入对应数据，否则会报错。

完成插入操作后，查询`ACCOUNT547`表中内容，结果如下：

```sql
mysql> source ~/cs/database/proj/proj1/insert.sql
Query OK, 6 rows affected (0.01 sec)
Records: 6  Duplicates: 0  Warnings: 0

Query OK, 13 rows affected (0.01 sec)
Records: 13  Duplicates: 0  Warnings: 0

Query OK, 7 rows affected (0.00 sec)
Records: 7  Duplicates: 0  Warnings: 0

Query OK, 7 rows affected (0.01 sec)
Records: 7  Duplicates: 0  Warnings: 0

Query OK, 7 rows affected (0.00 sec)
Records: 7  Duplicates: 0  Warnings: 0

Query OK, 8 rows affected (0.01 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> select * FROM ACCOUNT547;
+----------------+-------------+---------+
| account_number | branch_name | balance |
+----------------+-------------+---------+
| A-101          | Downtown    |  500.00 |
| A-102          | Perryridge  |  400.00 |
| A-201          | Brighton    |  900.00 |
| A-215          | Mianus      |  700.00 |
| A-217          | Brighton    |  750.00 |
| A-222          | Redwood     |  700.00 |
| A-305          | Round Hill  |  350.00 |
+----------------+-------------+---------+
7 rows in set (0.00 sec)
```

### 任务2

任务2为创建书中课后习题中的数据库并练习相关操作，数据库如下(加粗为主键)：

> employee (**employee_name**, street, city)  
> works (**employee_name**, company_name, salary)  
> company (**company_name**, city)  
> manages (**employee_name**, manager_name)

可见，需要创建四个表，并向其中插入数据，和任务1类似，不再赘述，创建和插入的语句分别在`proj/proj1/task2/create.sql`和`proj/proj1/task2/insert.sql`中，插入的数据由ChatGPT生成。

```sql
mysql> create database EMPLOYEE547;
Query OK, 1 row affected (0.01 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| BANK547            |
| EMPLOYEE547        |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
6 rows in set (0.01 sec)

mysql> use EMPLOYEE547;
Database changed
mysql> show tables;
Empty set (0.00 sec)

mysql> source ~/cs/database/proj/proj1/task2/create.sql
Query OK, 0 rows affected (0.04 sec)

Query OK, 0 rows affected (0.03 sec)

Query OK, 0 rows affected (0.04 sec)

Query OK, 0 rows affected (0.04 sec)

mysql> show tables;
+-----------------------+
| Tables_in_EMPLOYEE547 |
+-----------------------+
| COMPANY547            |
| EMPLOYEE547           |
| MANAGES547            |
| WORKS547              |
+-----------------------+
4 rows in set (0.00 sec)
```

接下来需要使用SQL语句完成教材课后题3.9和3.10

#### 3.9

##### a
> Find the names and cities of residence of all employees who work for “First Bank Corporation”.

想找出所有为“First Bank Corporation”工作的员工的姓名和所在城市，需要将`employee`和`works`两个表自然连接，然后查询即可，查询语句如下：

```sql
SELECT ee.employee_name, ee.city
FROM EMPLOYEE547 AS ee
NATURAL JOIN WORKS547 AS w
WHERE w.company_name = 'First Bank Corporation';
```

##### b
> Find the names, street addresses, and cities of residence of all employees who work for “First Bank Corporation” and earn more than $10,000.

想找出所有为“First Bank Corporation”工作的收入在$10000以上员工的姓名，街道地址和城市，只需在上一题的筛选条件中加入收入在$10000以上即可，语句如下：

```sql
SELECT ee.employee_name, ee.street, ee.city
FROM EMPLOYEE547 AS ee
NATURAL JOIN WORKS547 AS w
WHERE w.company_name = 'First Bank Corporation';
    AND w.salary > 10000;
```

##### c

> Find all employees in the database who do not work for “First Bank Corporation”.

要找出所有不为“First Bank Corporation”工作的员工，只需将a题中的`=`改为`!=`即可，语句如下：

```sql
SELECT ee.employee_name
FROM EMPLOYEE547 AS ee
NATURAL JOIN WORKS547 AS w
WHERE w.company_name != 'First Bank Corporation';
```

##### d

> Find all employees in the database who earn more than each employee of “Small Bank Corporation”. 

要找到数据库中比“Small Bank Corporation”中所有员工的工资都高的员工，可以使用嵌套的SQL语句，内层的SQL语句找到所有为“Small Bank Corporation”工作的员工，并使用`MAX()`函数找到薪资的最大值。  
外层筛选所有工资大于内层语句查询到的薪资，语句如下：

```sql
SELECT ee.employee_name
FROM EMPLOYEE547 AS ee
NATURAL JOIN WORKS547 AS w
WHERE w.salary > (
    SELECT MAX(w2.salary)
    FROM WORKS547 AS w2
    WHERE w2.company_name = 'Small Bank Corporation'
);
```

##### e

> Assumethat the companies may be located in several cities. Find all companies located in every city in which “Small Bank Corporation” is located.

要查找所有的公司，这些公司都在“Small Bank Corporation”公司所在的城市。想要完成这个任务同样需要使用嵌套的查询语句。

内层查询查找c2为'Small Bank Corporation'且c2和c1城市相同且c1不为'Small Bank Corporation'的情况，当查询到时，返回1。

外层检测到子查询返回1时，`WHERE EXISTS`将会返回TRUE，这时会将当前的`c1.company_name`包含在结果当中，最后使用`SELECT DISTINCT`确保结果不重复。

语句如下：

```sql
SELECT DISTINCT c1.company_name
FROM COMPANY547 AS c1
WHERE EXISTS (
    SELECT 1
    FROM COMPANY547 AS c2
    WHERE c2.company_name = 'Small Bank Corporation'
    AND c2.city = c1.city
    AND c1.company_name != 'Small Bank Corporation'
);
```

##### f
> Find the company that has the most employees.

要找到拥有最多雇员的公司，可以使用排序，先将`WORKS547`表按照公司名称进行分组，接下来使用`ORDER BY DESC`进行降序排列，最终输出排序最靠上的公司名称，语句如下：

```sql
SELECT w.company_name
FROM WORKS547 AS w
GROUP BY w.company_name
ORDER BY COUNT(w.employee_name) DESC
LIMIT 1
```
##### g

> Find those companies whose employees earn a higher salary, on average, than the average salary at “First Bank Corporation”.

要找到平均工资高于“First Bank Corporation”的平均工资的公司，同样可以使用嵌套的SQL语句。

内层查询得到“First Bank Corporation”的平均工资，外层在`WORKS547`表中按照公司名进行分组，并使用`HAVING`进行过滤，筛选平均工资大于内层查询的返回值，语句如下：

```sql
SELECT w.company_name
FROM WORKS547 AS w
GROUP BY w.company_name
HAVING AVG(w.salary) > (
    SELECT AVG(w2.salary)
    FROM WORKS547 AS w2
    WHERE w2.company_name = 'First Bank Corporation'
);
```

#### 3.10

##### a

> Modify the database so that “Jones” now lives in “Newtown”.

要修改数据，使得“Jones”的住址变为“Newtown”，只需使用`UPDATE`语句，语句如下：

```sql
UPDATE EMPLOYEE547
SET city = 'Newtown'
WHERE employee_name = 'Jones';
```

##### b

> Give all managers of “First Bank Corporation” a 10% raise unless the salary becomes greater than $100,000; in such cases, give only a 3% raise.

分析题目，要给所有“First Bank Corporation”的经理加薪，其中薪水在涨薪后，依然在$100,000以下的涨薪10%，以上的涨薪3%。

使用嵌套的SQL语句完成查询，由于是否是经理并没有在`EMPLOYEE547`表中记录，因此需要使用嵌套查询，外层说明在`MANAGES547`表中查询，返回名字，这样只会修改经理而非所有员工的薪资。内层查询公司名称为“First Bank Corporation”的员工，保证修改的是“First Bank Corporation”的员工的数据。

为了完成待条件的修改，使用`WHEN`和`ELSE`语句进行筛选，如果涨薪10%，依然小于100000，则涨薪10%，否则涨薪3%，语句如下：

```sql
UPDATE EMPLOYEE547 AS w
SET salary = CASE
    WHEN salary * 1.10 <= 100000 THEN salary * 1.10
    ELSE salary * 1.03
END
WHERE w.employee_name IN (
    SELECT m.employee_name
    FROM MANAGES547 AS m
    WHERE m.employee_name IN (
        SELECT w2.employee_name
        FROM EMPLOYEE547 AS w2
        WHERE w2.company_name = 'First Bank Corporation'
    )
);
```