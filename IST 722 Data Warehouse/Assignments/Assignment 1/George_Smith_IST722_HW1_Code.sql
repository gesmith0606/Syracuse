--part 2 

Select * from employees

select distinct LastName, FirstName from employees 

-- part 3 
-- Question 1 
Select distinct Title from employees; 
--Question 2 
select t.TerritoryDescription, count(*) as EmployeeCount 
from Territories t 
	join EmployeeTerritories et on t.TerritoryID = et.TerritoryID
group by t.TerritoryDescription
order by EmployeeCount desc 


-- Question 1 
SELECT CompanyName, 
ContactName, 
ContactTitle
FROM Customers 
ORDER BY CompanyName

-- Question 2 
select 
ProductID,
sum(unitprice * (1-discount)*Quantity) as TotalAmount
FROM [Order Details]
GROUP BY ProductID

-- Question 3 
SELECT c.CategoryName,
count(p.CategoryID) as ProductCount
FROM Categories c 
join products p on c.CategoryID=p.CategoryID
GROUP BY c.CategoryName

-- Question 4 
select o.OrderID,
sum(ord.UnitPrice*ord.Quantity*(1-ord.Discount)) as TotalAmount 
FROM Orders o 
Join [Order Details] ord on o.OrderID=ord.OrderID
WHERE o.CustomerID = 'COMMI'
GROUP BY o.OrderID

--Question 5 
SELECT o.OrderID, 
o.Shipvia,
s.CompanyName,
DATEDIFF(D,o.OrderDate,o.ShippedDate) as TotalDaysElasped 
FROM orders o
join Shippers s on o.ShipVia = s.ShipperID
WHERE o.EmployeeID = '4' 

