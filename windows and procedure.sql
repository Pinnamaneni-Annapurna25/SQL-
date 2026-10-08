use bank_churn

select *from bank_churn1 where geography="spain"
delimiter //
create procedure spain_customers()
begin
   select *from bank_churn1 where geography="spain";
end // 
delimiter;



call spain_customers();
delimiter //

create procedure francemale_customers()
begin
select *from bank_churn1  where geography="france" and gender="male";
end //
delimiter;

call francemale_customers();

create table employee9(emp_id int primary key,emp_name  varchar(100) not null,
emp_salary decimal(10,2));

DELIMITER //
CREATE PROCEDURE add_employee91(
    IN emp_id INT,
    IN emp_name VARCHAR(100),
    IN emp_salary DECIMAL(10,2)
)
BEGIN
    INSERT INTO Employee9(emp_id, emp_name, emp_salary)
  VALUES (emp_id, emp_name, emp_salary);
END //
 
DELIMITER ;

call add_employee91(1,'a',10000)
select *from employee9
select *from bank_churn1

select avg(EstimatedSalary) as averagesalary from bank_churn1

SELECT CustomerId,
       Geography,
       Balance,
       AVG(Balance) OVER(PARTITION BY Geography) AS Avg_Balance
FROM bank_churn1;

SELECT CustomerId,
       Geography,
       Balance,
       SUM(Balance) OVER(PARTITION BY Geography) AS sum_balance
FROM bank_churn1;

SELECT CustomerId,
       Geography,
       Balance,
       SUM(Balance) OVER(ORDER BY CustomerId) AS sum_balance
FROM bank_churn1;

select geography,sum(balance) as totalbalance from bank_churn1 group by Geography

SELECT CustomerId,
       Geography,
       Balance,
       SUM(Balance) OVER(order by customerid) AS sum_balance
FROM bank_churn1;

SELECT CustomerId,
       balance,
       RANK() OVER(ORDER BY balance asc) AS Salary_Rank
FROM  bank_churn1 ;

SELECT CustomerId,
       balance,
       dense_rank() OVER(ORDER BY balance DESC) AS Salary_Rank
FROM  bank_churn1 ;
