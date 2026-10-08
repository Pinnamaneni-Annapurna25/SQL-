use bank_churn;  
select * from bank_churn;
SELECT CustomerId,CreditScore,
CASE
 -- "WHEN" acts as if condition,"THEN" acts as  
           WHEN CreditScore >= 750 THEN 'Low Risk'
 
           WHEN CreditScore >= 650 THEN 'Medium Risk'
           ELSE 'High Risk'
 
       END AS RiskCategory FROM bank_churn;
       -- -- IF AGE < 30 CLAASIFY AS YOUNG, 30-50 AS MIDDLE AGE, ABOVE > 50 AS SENIOR AGE. 
       select CustomerId,Age,
       case 
       when age<30 then 'young'
       when age between 30 and 50 then 'Middle Age'
      else 'senior age' 
      end as Agecategory from bank_churn;
      -- A bank wants to identify customers who are likely to leave (churn) based on their age, account balance, and number of products they use.
select CustomerId,Age,Balance,NumOfProducts,
case
	when Age > 50 and Balance > 100000 and NumOfProducts = 1 then 'High Churn Risk'
    when Age > 40 and Balance > 50000 then 'Middle Churn Risk'
    else 'Low Churn Risk'
    end as ChurnRiskCategory from bank_churn;
--  A bank wants to analyze customer churn and understand how many customers have left the bank versus how many are still active.   
select CustomerId,
case
	when  Exited = 1 then 'Churned'
    when  Exited = 0 then 'Retained'
    end as Churnstat  count(*) TotalCustomers  from bank_churn group by ;
 select CustomerId,Surname from bank_churn order by balance desc limit 10;
-- CTE(Common Table Expressions)
WITH CustomerBalance AS
(
 select CustomerId, Surname,Balance
FROM bank_churn 
 )
 select * from CustomerBalance where Balance<10000
 