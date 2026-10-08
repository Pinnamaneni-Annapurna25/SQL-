-- AdventureWorks SQL Hands-on Business Analytics Project
-- Task 1: Database Investigation
-- • What tables are available?
-- customer,product,product category ,person,product subcategory,salesorderdetails,salesorderheader,sales teritory
-- • Which tables belong to Sales, Production and Person schemas?
-- customer, salesorderheader, salesorderdetail, salesterritory, and salesperson.
-- • Identify primary keys for Sales.SalesOrderHeader, Sales.SalesOrderDetail, Sales.Customer, Production.Product and Sales.SalesPerson.
-- salesorderid, salesorderdetailid, customerid, productid,businessentityid
-- • Identify important foreign-key relationships.
-- Foreign keys connect customers to orders, orders to order details, order details to products, and products to their categories.
-- • Determine how a customer connects to a sales order, how a sales order connects to a product, and how a product connects to a product category.
-- customerid,salesorderdetail,productsubcategory,
-- • Find the approximate number of records in each major table.
-- count(*)
-- Task 2: Create an Analysis Database
create database AdventureWorks_Training;
create database Analytics;
use AdventureWorks_Training;
describe CustomerAnalysis;

-- task 3: customer analysiscustomer

create table CustomerAnalysis (
    CustomerID int primary key,
    CustomerName varchar(100) not null,
    TerritoryID int,
    TotalOrders int,
    TotalRevenue decimal(10,6) not null,
    CustomerSegment varchar(50),
    CreatedDate datetime default current_timestamp
);
-- task 4: product performance
create table ProductPerformance (
    ProductID int primary key,
    ProductName varchar(50) not null,
    ProductCategory varchar(100),
    ProductSubcategory varchar(100),
    TotalQuantitySold int not null,
    TotalRevenue decimal(10,6) not null,
    AverageSellingPrice decimal,
    ProductRank int,
    PerformanceCategory varchar(50)
);
-- person table
create table Person (
    PersonID int primary key,
    FirstName varchar(50),
    LastName varchar(50)
);
-- sales territory table
create table SalesTerritory (
    TerritoryID int primary key,
    TerritoryName varchar(100),
    Country varchar(100)
);
-- sales person table
create table SalesPerson (
    SalesPersonID int primary key,
    PersonID int,
    TerritoryID int,

    foreign key (PersonID)
        references Person(PersonID),

    foreign key (TerritoryID)
        references SalesTerritory(TerritoryID)
);
-- customer table
create table Customer (
    CustomerID int primary key,
    PersonID int,
    TerritoryID int,

    foreign key (PersonID)
        references Person(PersonID),

    foreign key (TerritoryID)
        references SalesTerritory(TerritoryID)
);
-- product category
create table ProductCategory (
    CategoryID int primary key,
    CategoryName varchar(100)
);
-- product subcategory
create table ProductSubcategory (
    SubcategoryID int primary key,
    SubcategoryName varchar(100),
    CategoryID int,

    foreign key (CategoryID)
        references ProductCategory(CategoryID)
);
-- Product table
create table Product (
    ProductID int primary key,
    ProductName varchar(100),
    SubcategoryID int,
    UnitPrice decimal(10,2),
    foreign key (SubcategoryID)
        references ProductSubcategory(SubcategoryID)
);
-- SalesOrderHeader table
create table SalesOrderHeader (
    OrderID int primary key,
    CustomerID int,
    SalesPersonID int,
    TerritoryID int,
    OrderDate datetime,
    TotalAmount decimal(10,2),
    foreign key (CustomerID)
        references Customer(CustomerID),

    foreign key (SalesPersonID)
        references SalesPerson(SalesPersonID),

    foreign key (TerritoryID)
        references SalesTerritory(TerritoryID)
);
-- SalesOrderDetail
create table SalesOrderDetail (
    OrderDetailID int primary key,
    OrderID int,
    ProductID int,
    Quantity int,
    UnitPrice decimal(10,2),

    foreign key (OrderID)
        references SalesOrderHeader(OrderID),

    foreign key (ProductID)
        references Product(ProductID)
);


-- Task 5: ALTER TABLE Practice
-- adding a new column
     alter table productperformance add lastupdated datetime;
     -- changing the datatype
     alter table productperformance modify productname varchar(100);
     -- using default constraint
     alter table CustomerAnalysis modify TotalOrders int default 0;
     -- using check constraint
     alter table CustomerAnalysis  add constraint chk_totalorders
     check (totalorders <=3);  
     -- using unique constraint 
alter table CustomerAnalysis add constraint uq_TerritoryID unique (TerritoryID);
     -- Rename a column where supported
	alter table  CustomerAnalysis rename column CreatedDate to DateCreated;
    -- remove a constraint
    alter table CustomerAnalysis drop check chk_totalorders;
    -- remove a column
    alter table productperformance drop column lastupdated;
    alter table CustomerAnalysis modify    TotalRevenue decimal
    alter table customeranalysis
    drop index uq_TerritoryID;
-- Task 6: INSERT
-- inserting records
insert into CustomerAnalysis
(customerid, customername, territoryid, totalorders, totalrevenue,CustomerSegment, DateCreated)
values
(101, 'Ram', 1, 5, 12000.00, 'premium', '2026-08-19 10:00:00'),
(102, 'Bhoomi', 2, 8, 7500.00, 'gold', '2026-08-20 10:05:00'),
(103, 'Sai', 1, 3, 3000.00, 'silver', '2026-08-19 10:10:00'),
(104, 'Anu', 3, 2, 500.00, 'standard', '2026-08-09 10:15:00'),
(105, 'Divi', 2, 6, 15000.00, 'premium', '2026-08-19 10:20:00');
select * from CustomerAnalysis;

-- Task 7:updating customer segments based on revenue.
Update CustomerAnalysis
set CustomerSegment= case
	when TotalRevenue >= 10000 then 'Premium'
	when TotalRevenue between 5000 and 9999 then 'Gold'
	when TotalRevenue between 1000 and 4999 then 'Silver'
	else 'Standard' 
    end ;
-- Task 8:deleting nly the records inserted for practice.
    delete from CustomerAnalysis where CustomerID between 101 and 105;
    
-- Task 9: Sales Order Analysis

 use Analytics;
select * from customer;
 select * from product;
select * from person;
 select * from productcategory;
 select * from productsubcategory;
 select * from salesorderdetail;
 select * from salesorderheader;
select * from salesterritory;
-- Find total sales orders
SELECT COUNT(*) AS totalsalesorders from salesorderheader;
-- Find total sales amount.
SELECT SUM(TotalDue) AS totalsalesamount from salesorderheader;
--  Find average, minimum and maximum order value
SELECT AVG(TotalDue) as averageordervalue from salesorderheader;
SELECT min(TotalDue) as minimumordervalue from SalesOrderHeader;
SELECT max(TotalDue) as maximunordervalue from SalesOrderHeader;
--  the number of unique customers
select count(distinct CustomerID) as UniqueCustomers from SalesOrderHeader;
-- Find the number of unique products sold.
select count(distinct ProductID) as UniqueProductsSold from SalesOrderDetail;

-- Task 10: Customer Revenue
-- Calculate customer-level sales performance.
-- • Customer ID,Number of orders,Total revenue,Average order value
-- Challenge: Sort customers by revenue from highest to lowest.
select
    Customer.CustomerID,
    concat(Person.FirstName, ' ', Person.LastName) as customername,
    count(SalesOrderHeader.SalesOrderID) as numberoforders,
    sum(SalesOrderHeader.TotalDue) as totalrevenue,
    avg(SalesOrderHeader.TotalDue) as averageordervalue
from Customer
join Person
    on Customer.PersonID = Person.BusinessEntityID
join SalesOrderHeader
    on Customer.CustomerID = SalesOrderHeader.CustomerID
group by
    Customer.CustomerID,
    Person.FirstName,
    Person.LastName
order by total_revenue desc;

-- Task 11: Product Revenue: 
-- Find the top 20 products based on quantity sold.
-- Find the top 20 products based on revenue.
select
    product.productid,
    product.name as product_name,
    (
        select sum(salesorderdetail.orderqty)
        from salesorderdetail
        where salesorderdetail.productid = product.productid
    ) as totalquantitysold
from product
where product.productid in (
    select productid
    from salesorderdetail
)
order by totalquantitysold desc
limit 20;
select * from salesorderdetail;
select
    product.productid,
    product.name as productname,
    sum(salesorderdetail.orderqty) as totalquantitysold
from product
join salesorderdetail
    on product.productid = salesorderdetail.productid
group by
    product.productid,
    product.name
order by totalquantitysold desc
limit 20;
select product.productid,product.name as productname,
    sum(salesorderdetail.linetotal) as totalrevenue
from product
join salesorderdetail
    on product.productid = salesorderdetail.productid
group by
    product.productid,
    product.name
order by totalrevenue desc limit 20;
-- The analysis shows that the product sold in the highest quantity is not necessarily the product generating the highest revenue.
-- Mountain-200 Black, 38--total revenue is 4400592.800420056

-- Task 12: Territory Performance
-- Objective: Calculate territory-level performance.

select
    salesterritory.territoryid,
    salesterritory.name as territoryname,
    count(distinct customer.customerid) as numberofcustomers,
    count(distinct salesorderheader.salesorderid) as numberoforders,
    sum(salesorderheader.totaldue) as totalrevenue,
    avg(salesorderheader.totaldue) as averageordervalue
from salesterritory
join customer
    on salesterritory.territoryid = customer.territoryid
join salesorderheader
    on customer.customerid = salesorderheader.customerid
group by
    salesterritory.territoryid,
    salesterritory.name
order by totalrevenue desc;
 -- Identify the best-performing territory.:none
 
 -- Task 13: Customer Order Report
 -- Objective: Create a customer order report
 select
    concat(person.firstname, ' ', person.lastname) as customername,
    salesorderheader.salesordernumber as sales_order_number,
    salesorderheader.orderdate as order_date,
    salesterritory.name as territory,
    salesorderheader.totaldue as total_order_value
from customer
join person
    on customer.personid = person.businessentityid
join salesorderheader
    on customer.customerid = salesorderheader.customerid
join salesterritory
    on salesorderheader.territoryid = salesterritory.territoryid
order by salesorderheader.orderdate;

-- Task 14: Product Sales Report
-- Objective: Create a product sales report.
select
    product.name as productname,
    productcategory.name as productcategory,
    productsubcategory.name as productsubcategory,
    sum(salesorderdetail.orderqty) as quantitysold,
    sum(salesorderdetail.linetotal) as revenue
from product
join productsubcategory
    on product.productsubcategoryid = productsubcategory.productsubcategoryid
join productcategory
    on productsubcategory.productcategoryid = productcategory.productcategoryid
join salesorderdetail
    on product.productid = salesorderdetail.productid
group by
    product.productid,
    product.name,
    productcategory.name,
    productsubcategory.name
order by revenue desc;

 -- Task 15: Employee/Salesperson Performance
-- Objective: Analyze salesperson performance.

select
    concat(person.firstname, ' ', person.lastname) as salespersonname,
    salesterritory.name as territory,
    count(salesorderheader.salesorderid) as numberoforders,
    sum(salesorderheader.totaldue) as totalsales,
    avg(salesorderheader.totaldue) as averageordervalue
from salesperson
join person
    on salesperson.businessentityid = person.businessentityid
join salesorderheader
    on salesperson.businessentityid = salesorderheader.salespersonid
join salesterritory
    on salesperson.territoryid = salesterritory.territoryid
group by
    salesperson.businessentityid,
    person.firstname,
    person.lastname,
    salesterritory.name
order by totalsales desc;

-- Task 16: Customer Segmentation
-- Objective: Classify customers based on total revenue.
select
    customer.customerid,
    sum(salesorderheader.totaldue) as totalrevenue,
    case
        when sum(salesorderheader.totaldue) >= 1000 then 'premium'
        when sum(salesorderheader.totaldue) >= 500 then 'gold'
        when sum(salesorderheader.totaldue) >= 100 then 'silver'
        else 'standard'
    end as customersegment
from customer
join salesorderheader
    on customer.customerid = salesorderheader.customerid
group by customer.customerid
order by totalrevenue desc;

-- Task 17: Product Classification
-- Objective: Classify products according to revenue performance.
select
    product.productid,
    product.name as productname,
    sum(salesorderdetail.linetotal) as totalrevenue,
    case
        when sum(salesorderdetail.linetotal) >= 100000 then 'high performer'
        when sum(salesorderdetail.linetotal) >= 50000 then 'medium performer'
        else 'low performer'
    end as productclassification
from product
join salesorderdetail
    on product.productid = salesorderdetail.productid
group by
    product.productid,
    product.name
order by totalrevenue desc;

-- Task 18: Customer Revenue CTE
-- Objective: Use a CTE to calculate total revenue for each customer.
-- top 10 customers
with customerrevenue as (
    select
        customerid,
        sum(totaldue) as totalrevenue
    from salesorderheader
    group by customerid
)
select
    customerid,
    totalrevenue
from customerrevenue
order by totalrevenue desc limit 10;

-- Identify customers above average revenue.
with customerrevenue as (
    select
        customerid,
        sum(totaldue) as totalrevenue
    from salesorderheader
    group by customerid
)
select
    customerid,
    totalrevenue
from customerrevenue
where totalrevenue > (
    select avg(totalrevenue)
    from customerrevenue
)
order by totalrevenue desc;
-- identify customers below average revenue.
select customerid,totalrevenue from customerrevenue;

with customerrevenue as (
    select
        customerid,
        sum(totaldue) as totalrevenue
    from salesorderheader
    group by customerid
)

-- Task 19: Product Performance CTE
-- Create a CTE containing Product, Quantity Sold and Revenue.
with productperformance as (
    select
        productid,
        sum(orderqty) as quantitysold,
        sum(linetotal) as revenue
    from salesorderdetail
    group by productid
)
select
    productid,
    quantitysold,
    revenue
from productperformance order by revenue desc;
-- • Use the CTE to identify products contributing more than a specified percentage of total sales.
with productperformance as (
    select
        productid,
        sum(orderqty) as quantitysold,
        sum(linetotal) as revenue
    from salesorderdetail
    group by productid
)
select
    productid,
    quantitysold,
    revenue,
    (revenue / (
        select sum(revenue)
        from productperformance
    )) * 100 as percentageoftotalsales
from productperformance
where revenue > (
    select sum(revenue) * 0.05
    from productperformance
)
order by revenue desc;

-- Window Functions
-- Task 20: ROW_NUMBER()
with customerrevenue as (
    select customerid,sum(totaldue) as totalrevenue from salesorderheader
    group by customerid
)
select customerid,totalrevenue,row_number() over (order by totalrevenue desc) as revenuerank
 from customerrevenue;
 with customerrevenue as (
    select customerid,territoryid,sum(totaldue) as totalrevenue
    from salesorderheader
    group by customerid, territoryid
)
select customerid,territoryid,totalrevenue,row_number() over (partition by territoryid
order by totalrevenue desc) as territoryrank
from customerrevenue
order by territoryid, territoryrank;

-- Task 21: RANK()
with customerrevenue as (select customerid, territoryid, sum(totaldue) as totalrevenue from salesorderheader 
group by customerid, territoryid) 
select customerid, territoryid, totalrevenue, rank() 
over (partition by territoryid order by totalrevenue desc) as territoryrank 
from customerrevenue order by territoryid, territoryrank;


-- Task 22: DENSE_RANK()
with customerrevenue as (select customerid, territoryid, sum(totaldue) as totalrevenue from salesorderheader 
group by customerid, territoryid) 
select customerid, territoryid, totalrevenue, dense_rank()
 over (order by totalrevenue desc) as denserankvalue from customerrevenue 
 order by territoryid, totalrevenue desc;
 
 
-- Task 24: Running Total
select salesorderid, totaldue, sum(totaldue) over (order by salesorderid) as runningtotal
 from salesorderheader limit 5;
 
 
 -- Task 25 — lag()
 select salesorderid, totaldue, lag(totaldue) 
 over (order by salesorderid) as previousordervalue from salesorderheader limit 5;
 
 -- Task 27 — lead()
select salesorderid, totaldue, lead(totaldue) 
over (order by salesorderid) as nextordervalue from salesorderheader limit 10;

-- Task 28: Customer Purchase History
select customerid, orderdate, totaldue as orderamount, lag(totaldue) over (partition by customerid 
order by orderdate) as previousorderamount, totaldue - lag(totaldue) 
over (partition by customerid order by orderdate) as differencefrompreviousorder 
from salesorderheader order by customerid, orderdate;

-- task 29 — running revenue by customer
select customerid, totaldue as ordervalue, sum(totaldue)
 over (partition by customerid order by salesorderid)
 as runningrevenue from salesorderheader order by customerid, salesorderid;
    
 -- Task 30: NTILE()
with customerrevenue as (select customerid, sum(totaldue) as totalrevenue 
from salesorderheader group by customerid) 
Select customerid, totalrevenue, ntile(4) over (order by totalrevenue desc) as revenuegroup from customerrevenue 
order by revenuegroup, totalrevenue desc;



-- Advanced Business Problems
-- Task 1: Top 3 Products Per Category
with productrevenue as 
(select product.productid, product.name as productname, productcategory.name as categoryname, 
sum(salesorderdetail.linetotal) as revenue from product
 join salesorderdetail on product.productid = salesorderdetail.productid 
 join productsubcategory on product.productsubcategoryid = productsubcategory.productsubcategoryid 
 join productcategory on productsubcategory.productcategoryid = productcategory.productcategoryid 
 group by product.productid, product.name, productcategory.name), rankedproducts as (select productid, productname, categoryname, revenue, rank() 
 over (partition by categoryname order by revenue desc) as productrank from productrevenue) 
 select productid, productname, categoryname, revenue, productrank from rankedproducts where productrank <= 3 order by categoryname, productrank;
 
 
-- Task 2: Top Customer Per Territory
with customerrevenue as (select customerid, territoryid, sum(totaldue) as totalrevenue
 from salesorderheader group by customerid, territoryid), rankedcustomers as (select customerid, territoryid, totalrevenue, rank() 
 over (partition by territoryid order by totalrevenue desc) as customerrank from customerrevenue) 
 select customerid, territoryid, totalrevenue, customerrank from rankedcustomers 
 where customerrank = 1 order by territoryid;
 
-- Task 3: Second Highest Customer
with customerrevenue as (select customerid, sum(totaldue) as totalrevenue 
from salesorderheader group by customerid), rankedcustomers as (select customerid, totalrevenue, rank() over (order by totalrevenue desc) 
as customerrank from customerrevenue) select customerid, totalrevenue 
from rankedcustomers where customerrank = 2;

-- Task 4: Customers Above Territory Average
select customerid, territoryid, totalrevenue
from (select customerid, territoryid, sum(totaldue) as totalrevenue
    from salesorderheader
    group by customerid, territoryid


-- Task 5: Product Contribution
with productrevenue as (select productid, sum(linetotal) as revenue 



