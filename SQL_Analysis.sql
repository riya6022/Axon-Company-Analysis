-- DATA ANALYSIS FOR AXON COMPANY USING SQL
select * from customers;
select * from offices;
select * from employees;
select * from orderdetails;
select * from orders;
select * from payments;
select * from products;
select * from productlines;

----------------------------------------------------------------------------------------
-- Retrieving customer numbers along with order and payment information by joining
-- the customers, orders, and payments tables in a database.

SELECT c.customerNumber, o.orderDate, o.shippedDate, p.amount
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN payments p ON c.customerNumber = p.customerNumber;

----------------------------------------------------------------------------------------
-- Retrieves employee information and corresponding office details, emphasizing the offices 
-- where employees are stationed, utilizing a right join between the 'employees' and 'offices' tables
-- based on matching office codes.

select e.employeeNumber , e.firstname , e.jobtitle , e.officeCode , o.city , o.phone from employees e
right join offices o ON e.officeCode = o.officeCode;

----------------------------------------------------------------------------------------
-- Query retrieves the total count of customers from each country who have placed orders
-- and made payments, presenting the results in descending order based on the total number of customers.

select country , count(c.customerNumber) as Total_Customer from customers c
join orders o on c.customerNumber = o.customerNumber
join payments p on c.customerNumber = p.customerNumber
group by 1
order by Total_Customer desc

----------------------------------------------------------------------------------------
-- Stored procedure named `GetCustomerDetail` retrieves distinct customer details, 
-- including contact information and payment amounts, based on a specified customer number parameter.

DELIMITER //
CREATE PROCEDURE GetCustomerDetail (IN customerNumberParam INT)
BEGIN
SELECT DISTINCT c.customerNumber, c.contactFirstName, c.phone, c.city, p.amount
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
WHERE c.customerNumber = customerNumberParam;
END //
DELIMITER ;

CALL GetCustomerDetail(103);

----------------------------------------------------------------------------------------
-- Created a view named 'ProductLineSales' that summarizes total sales for each productline 
-- by combining information from the 'productlines,' 'products,' and 'orderdetails' tables.

CREATE VIEW ProductLineSales AS
SELECT pl.productLine, pl.textDescription, SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM productlines pl
JOIN products p ON pl.productLine = p.productLine
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY pl.productLine, pl.textDescription;
    
SELECT * FROM ProductLineSales;

---------------------------------------------------------------------------------------
-- Retrieves the count of employees in each office, including offices with zero employees, and 
-- presents the results grouped by office code and city.

SELECT o.officeCode, o.city,COUNT(e.employeeNumber) AS numberOfEmployees
FROM offices o
LEFT JOIN employees e ON o.officeCode = e.officeCode
GROUP BY o.officeCode, o.city;
    
---------------------------------------------------------------------------------------





