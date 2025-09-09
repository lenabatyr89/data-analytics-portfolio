use AdventureWorks2017;

--Q1
SELECT t1.ProductID,
       t1.[Name],
       t1.Color,
       t1.ListPrice,
       t1.Size
FROM Production.[Product] AS t1
LEFT JOIN ( SELECT *
			FROM Sales.SalesOrderDetail) AS t2
ON t1.ProductID = t2.ProductID
WHERE t2.ProductID IS NULL;

--Q2
 update sales.customer set personid=customerid  
where customerid <=290 
update sales.customer set personid=customerid+1700  
where customerid >= 300 and customerid<=350 
update sales.customer set personid=customerid+1700  
where customerid >= 352 and customerid<=701 

SELECT  T1.CustomerID,
    CASE 
        WHEN T2.LastName IS NULL THEN 'Unknown'
        ELSE T2.LastName
    END AS LastName,
    CASE 
        WHEN T2.FirstName IS NULL THEN 'Unknown'
        ELSE T2.FirstName
    END AS FirstName
FROM  Sales.Customer AS T1
LEFT JOIN 
    (SELECT * FROM Person.Person) AS T2
    ON T1.PersonID = T2.BusinessEntityID
LEFT JOIN 
    (SELECT * FROM Sales.SalesOrderHeader) AS T3
    ON T1.CustomerID = T3.CustomerID
WHERE T3.CustomerID IS NULL
ORDER BY T1.CustomerID ASC;


--Q3
SELECT  TOP 10 CustomerID,
		T2.FirstName,
		T2.LastName,
		COUNT( CUSTOMERID) AS CountOfOrder
FROM ( SELECT *
		FROM Sales. SalesOrderHeader) AS T1
LEFT JOIN (SELECT *
			FROM  Person. Person) AS T2
ON T1.CustomerID= T2.BusinessEntityID
GROUP BY T1.CustomerID, t2. FirstName, T2. LastName
ORDER BY COUNT( CUSTOMERID) DESC;

--Q4
SELECT T2. FirstName,
		T2.LastName,
		T1.JobTitle,
		T1.HireDate,
		COUNT ( T1.BusinessEntityID) OVER(PARTITION BY T1.JobTitle) AS CountOfTitle
FROM HumanResources. Employee AS T1
 LEFT JOIN  ( SELECT *
			  FROM Person.Person) AS T2
ON T1.BusinessEntityID=T2.BusinessEntityID
ORDER BY T1. JobTitle;

--Q5
SELECT
	MAX(CASE WHEN OrderRank = 1 THEN SalesOrderID END) AS SalesOrderID,
    CustomerID,
	LastName,
	FirstName,
    MAX(CASE WHEN OrderRank = 1 THEN OrderDate END) AS LastOrderDate,
   MAX(CASE WHEN OrderRank = 2 THEN OrderDate END) AS SecondLastOrderDate

from (select T1.SalesOrderID,
    T1.CustomerID,
    T3.LastName,
    T3.FirstName,
    T1.OrderDate,
    ROW_NUMBER () OVER (PARTITION BY T1.CustomerID ORDER BY T1.OrderDate DESC) AS OrderRank
	
FROM Sales.SalesOrderHeader AS T1
LEFT JOIN ( select *
			from Sales.Customer )AS T2 
 ON T1.CustomerID = T2.CustomerID
LEFT JOIN ( select *
			from Person.Person) AS T3 
 ON T2.PersonID = T3.BusinessEntityID) as t4
GROUP BY CustomerID, LastName,FirstName
order by CustomerID  ;

--Q6

SELECT OrderYear,
		SalesOrderID,
		LastName,
		FirstName,
		Total
FROM(SELECT  YEAR(T1.OrderDate) AS OrderYear,
		T1.SalesOrderID,
		T3.LastName,
		T3.FirstName,
		MAX(T1.SubTotal) OVER (PARTITION BY YEAR(T1.OrderDate) ORDER BY T1.SubTotal DESC) AS Total,
		ROW_NUMBER() OVER (PARTITION BY YEAR(T1.OrderDate) ORDER BY T1.TotalDue DESC) AS RankNum
FROM Sales.SalesOrderHeader AS T1
LEFT JOIN  (SELECT *
			FROM Sales.Customer) AS T2
ON T1.CustomerID=T2.CustomerID
LEFT JOIN (  SELECT *
			 FROM Person.Person) AS T3
 ON T2.PersonID=T3.BusinessEntityID) as t4
 WHERE RankNum=1;

 --Q7
--Q7a

SELECT 
    MONTH(OrderDate) AS OrderMonth,
    SUM(CASE WHEN YEAR(OrderDate) = 2011 THEN 1 ELSE 0 END) AS [2011],
    SUM(CASE WHEN YEAR(OrderDate) = 2012 THEN 1 ELSE 0 END) AS [2012],
    SUM(CASE WHEN YEAR(OrderDate) = 2013 THEN 1 ELSE 0 END) AS [2013],
    SUM(CASE WHEN YEAR(OrderDate) = 2014 THEN 1 ELSE 0 END) AS [2014]
FROM Sales.SalesOrderHeader
GROUP BY MONTH(OrderDate)
ORDER BY OrderMonth;

;
--Q7b
SELECT *
FROM (
    SELECT 
        YEAR(OrderDate) AS OrderYear, 
        MONTH(OrderDate) AS OrderMonth, 
        SalesOrderID
    FROM Sales.SalesOrderHeader
) AS SourceTable
PIVOT (
    COUNT(SalesOrderID) 
    FOR OrderYear IN ([2011], [2012], [2013], [2014])
) AS PivotTable
ORDER BY OrderMonth;

 --Q8
SELECT 
    [Year],
    [Month],
    Sum_Price,
    Money
FROM (
    SELECT 
        CAST(YEAR(OrderDate) AS VARCHAR) AS [Year],
        CAST(MONTH(OrderDate) AS VARCHAR) AS [Month],
        SUM(TotalDue) AS Sum_Price,
        SUM(SUM(TotalDue)) OVER (
            PARTITION BY YEAR(OrderDate)
            ORDER BY MONTH(OrderDate)
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS Money,
        MIN(MONTH(OrderDate)) AS MonthOrder
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)

    UNION ALL

    SELECT 
        CAST(YEAR(OrderDate) AS VARCHAR) AS [Year],
        'grand_total' AS [Month],
        NULL AS Sum_Price,
        SUM(TotalDue) AS Money,
        13 AS MonthOrder
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate)
) AS Result
ORDER BY 
    [Year],
    MonthOrder;


 --Q9
SELECT 
    t3.DepartmentName,
    t3.BusinessEntityID AS [Employee'sId],
    CONCAT(t3.FirstName, ' ', t3.LastName) AS [Employee'sFullName],
    t3.StartDate AS HireDate,
    DATEDIFF(month, t3.StartDate, GETDATE()) AS Seniority,
    CONCAT(t4.FirstName, ' ', t4.LastName) AS PreviuseEmpName,
    t4.StartDate AS PreviuseEmpHDate,
    CASE 
        WHEN t4.StartDate IS NULL THEN NULL
        WHEN t4.StartDate <= t3.StartDate THEN DATEDIFF(DAY, t4.StartDate, t3.StartDate)
        ELSE DATEDIFF(DAY, t3.StartDate, t4.StartDate)
    END AS DiffDays
FROM (
    SELECT 
        t1.BusinessEntityID,
        t1.StartDate,
        t1.DepartmentID,
        t3.[Name] AS DepartmentName,
        t2.FirstName,
        t2.LastName,
        ROW_NUMBER() OVER (PARTITION BY t1.DepartmentID ORDER BY t1.StartDate DESC) AS RowNum
    FROM HumanResources.EmployeeDepartmentHistory AS t1
    INNER JOIN Person.Person AS t2
	ON t1.BusinessEntityID = t2.BusinessEntityID
    INNER JOIN HumanResources.Department AS t3 
	ON t1.DepartmentID = t3.DepartmentID
    WHERE t1.EndDate IS NULL
) AS t3
LEFT JOIN (
    SELECT 
        t1.BusinessEntityID,
        t1.StartDate,
        t1.DepartmentID,
        t3.Name AS DepartmentName,
        t2.FirstName,
        t2.LastName,
        ROW_NUMBER() OVER (PARTITION BY t1.DepartmentID ORDER BY t1.StartDate DESC) AS RowNum
    FROM HumanResources.EmployeeDepartmentHistory AS t1
    INNER JOIN Person.Person AS t2 ON t1.BusinessEntityID = t2.BusinessEntityID
    INNER JOIN HumanResources.Department AS t3 ON t1.DepartmentID = t3.DepartmentID
    WHERE t1.EndDate IS NULL
) AS t4
ON t3.DepartmentID = t4.DepartmentID
AND t3.RowNum = t4.RowNum - 1
ORDER BY 
    t3.DepartmentName,
    t3.StartDate DESC;

 --Q10a

SELECT 
    t1.StartDate AS hiredate,
    t1.DepartmentID,
    STUFF((
        SELECT ', ' + CONCAT(CAST(t3.BusinessEntityID AS VARCHAR), ' ', t4.LastName, ' ', t4.FirstName)
        FROM (SELECT * 
              FROM HumanResources.EmployeeDepartmentHistory
              WHERE EndDate IS NULL) AS t3
        LEFT JOIN Person.Person AS t4
            ON t3.BusinessEntityID = t4.BusinessEntityID
        WHERE 
            t3.StartDate = t1.StartDate
            AND t3.DepartmentID = t1.DepartmentID
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS a
FROM (SELECT * 
      FROM HumanResources.EmployeeDepartmentHistory
      WHERE EndDate IS NULL) AS t1
LEFT JOIN Person.Person AS t2
    ON t1.BusinessEntityID = t2.BusinessEntityID
GROUP BY 
    t1.StartDate,
    t1.DepartmentID
ORDER BY 
    t1.StartDate,
    t1.DepartmentID;

--Q10b
SELECT 
    t1.StartDate AS hiredate,
    t1.DepartmentID,
    STRING_AGG(CAST(t1.BusinessEntityID AS VARCHAR) + ' ' + t2.LastName + ' ' + t2.FirstName, ', ') WITHIN GROUP (ORDER BY t1.BusinessEntityID) AS Employees
FROM HumanResources.EmployeeDepartmentHistory AS t1
INNER JOIN Person.Person AS t2
    ON t1.BusinessEntityID = t2.BusinessEntityID
WHERE t1.EndDate IS NULL
GROUP BY 
    t1.StartDate,
    t1.DepartmentID
ORDER BY 
    t1.StartDate,
    t1.DepartmentID;