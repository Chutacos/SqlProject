-- Querey 1; What Type of Products do we sell?
SELECT
ProductID,
ProductType
FROM Products;

-- Querey 2: Who are our Vendors and what do they supply us with?
SELECT
	VendorName,
	ProductType
FROM Vendor;

-- Query 3: What our Employees names and their positions?
SELECT 
	Concat(FirstName,' ', LastName) AS EmployeeName,
	Position
FROM Employee;

--Query 4: What types of orders were made, at what store, and their total price?
SELECT
	StoreID,
	TypeOfOrder,
	TotalPrice
FROM Orders;

--Query 5: How much did the salespeople earn in commission?
SELECT 
	EmployeeID,
	CommissionEarned
FROM SalesPerson;


--Query 6: Who supplies our products, what types of products, and inventory available?
SELECT 
	p.ProductID,
	p.ProductType,
	p.VendorID,
	i.Quantity	
FROM Products AS p
JOIN Inventory AS i ON p.VendorID = i.VendorID;

--Query 7: What Employee works at what store alongside the store address?
SELECT
	e.EmployeeID,
	CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
	s.StoreID,
	s.StreetAddress
FROM Employee AS e
INNER JOIN Store as s ON e.StoreID = s.StoreID;

--Query 8: What type of orders were fullfiiled online?
SELECT 
	o.OrderID,
	o.ProductID,
	p.ProductName,
	p.ProductType
FROM OnlineOrder AS o
INNER JOIN Products as p ON o.ProductID = p.ProductID;

---View 1
--Query 9: Who are our employees?
CREATE VIEW [Our Employees] AS
	SELECT FirstName,
		   LastName,
	       EmployeeID
FROM Employee;
SELECT* FROM [Our Employees];
---View 2
--Query 10: Who are our top salespeople?
CREATE VIEW [Top Sellers] AS
	SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
		   e.EmployeeID,
		   s.CommissionEarned
FROM Employee AS e
INNER JOIN SalesPerson AS s ON e.EmployeeID = s.EmployeeID
WHERE [CommissionEarned] < 50000;
SELECT * FROM [Top Sellers];
