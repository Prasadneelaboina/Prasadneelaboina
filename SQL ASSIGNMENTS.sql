-- assignment 1 a
select distinct(employeeNumber),firstname,lastname from employees where jobtitle = "sales rep" and reportsto = 1102;


-- 1 b
select distinct(productline) from products where productline like "%cars";


-- assignment 2 
select customernumber,customername,
case when country in ("usa","canada") then "North America"
when country in ("uk","france","germany") then "Europe"
else "others"
end as CountrySegment
from customers;
                 


-- assignment 3 a 
select productcode,sum(quantityordered) as total_ordered from orderdetails group by productCode order by total_ordered desc limit 10;


-- 3 b
select monthname(paymentdate) as payment_month,count(paymentdate) as num_payments from payments group by payment_month having num_payments > 20 order by num_payments desc;



-- assignment 4 a
create database Customers_orders;
create table Customers(customer_id int primary key auto_increment,first_name varchar(50) not null,last_name varchar(50) not null,email varchar(255) unique,phone_number varchar(20));


-- 4 b
create table orders(order_id int primary key auto_increment,customer_id int,foreign key(customer_id) references customers(customer_id),order_date date,total_amount decimal(10,2) check(total_amount>0));



-- assignment 5 
select country,count(ordernumber) as order_count from customers natural join orders group by country order by order_count desc limit 5;



-- assignment 6
create table project(EmployeeID int primary key auto_increment,FullName varchar(50) not null,Gender varchar(6) check(Gender in('male','female')),ManagerID int);
insert into project (fullname,gender,managerid) values("Pranaya","Male",3),("Priyanka","Female",1),("Preeti","Female",null),("Anurag","Male",1),("Sambit","Male",1),("Rajesh","Male",3),("Hina","Female",3);
select M.fullname as manager_name,E.fullname as emp_name from project M inner join project E on M.employeeid = E.ManagerID;
  


  -- assignment 7
   create table facility(Facility_ID int, name varchar(100), State varchar(100),Country varchar(100));
   alter table facility modify facility_id int not null auto_increment primary key;
   alter table facility add city varchar(100) not null after name; 



-- assignment 8
create view product_category_sales as
select
     pl.productline,
     sum(od.quantityOrdered * od.priceEach) as total_sales,
     count(distinct o.orderNumber) as number_of_orders
from
    productlines pl
join 
    products p on pl.productLine = p.productLine
join 
    orderdetails od on p.productcode = od.productCode
join
    orders o on od.orderNumber = o.orderNumber
group by
	pl.productLine;
    


-- assignment 9
call get_country_payments(2003, 'france');



-- assignment 10 a
SELECT 
    c.customerName,
    COUNT(o.orderNumber) AS order_count,
    DENSE_RANK() OVER (ORDER BY COUNT(o.orderNumber) DESC) AS order_frequency_rnk
FROM 
    customers c
LEFT JOIN 
    orders o ON c.customerNumber = o.customerNumber
GROUP BY 
    c.customerName
ORDER BY 
    order_frequency_rnk;


-- 10 b

with x as (
select
     year(orderDATE) as year,
     monthname (orderDATE) as month,
     count(orderDATE) as total_orders
     from
        orders
        group by
        year , month
)
select
     year ,
     month,
     total_orders as 'Total_orders'
	 ,(concat(
		round(
		   100* (
           (Total_orders - lag(Total_orders) over (order by year)) / lag(Total_orders) over (order by year)
           ),
           0)
		),
		'%'
	 )as "% yoy change"
from 
	x;
    
    

-- assignment 11
select productline,count(*) as total from products where buyprice > (select avg(buyPrice) from products) group by productline order by total desc;



-- assignment 12

create table Emp_EH(empid int primary key,empname varchar(100),emailaddress varchar(100));
call insertEMP(1,'prasad','prasad.n@gmail.com');



-- assaignment 13

create table emp_BIT(name varchar(50),occupation varchar(50),workingdate date,workinghours int);
-- created before insert trigger
INSERT INTO Emp_BIT (Name, Occupation, WorkingDate, WorkingHours) VALUES
('Robin', 'Scientist', '2020-10-04', 12),
('Wamer', 'Engineer', '2020-10-04', 10),
('Peter', 'Actor', '2020-10-04', 13),
('Marco', 'Doctor', '2020-10-04', 14),
('Brayden', 'Teacher', '2020-10-04', 12),
('Antonio','Buissnes', '2020-10-04', 11);
insert into emp_bit values('prasad', 'data analyst', '2024-10-20', -10);




-- ASSIGNMENTS COMPLETED --