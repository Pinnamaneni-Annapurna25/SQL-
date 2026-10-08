use Employee_1
-- SELECT Clause (From)
select  * from Employee_1;
select distinct dept_name from employee_1;
select concat(name, ' - ', dept_name) as fullname from employee_1;
select name as employee_name from employee_1;
select sum(salary) as total_salary from employee_1;
-- WHERE Clause
select * from employee_1 where dept_name = 'hr';
select * from employee_1 where salary > 50000;
select * from employee_1 where dept_name = 'hr' and salary > 50000;
select * from employee_1 where dept_name = 'hr' or dept_name = 'it';
select * from employee_1 where not dept_name = 'hr';
select * from employee_1 where salary > 1000;
-- ORDER BY Clause
select * from employee_1 order by salary asc;
select * from employee_1 order by salary desc;
select * from employee_1 order by salary desc limit 3;
select * from employee_1 order by dept_name asc, salary desc;
-- GROUP BY CLAUSE
select dept_name, count(*) as total_employees from employee_1 group by dept_name;
select dept_name, count(*) as employee_count, sum(salary) as total_salary, avg(salary) as average_salary, max(salary) as highest_salary, min(salary) as lowest_salary 
from employee_1 group by dept_name;
select dept_name, avg(salary) as average_salary from employee_1 group by dept_name;
-- HAVING CLAUSE
select dept_name, count(*) as total_employees from employee_1 group by dept_name having count(*) > 5;
select dept_name, count(*) as employee_count from employee_1 group by dept_name having count(*) >= 2;
select dept_name, avg(salary) as average_salary from employee_1 group by dept_name having avg(salary) > 50000;
select dept_name, sum(salary) as total_salary from employee_1 group by dept_name having sum(salary) > 500000;



