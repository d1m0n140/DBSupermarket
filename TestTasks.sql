SELECT CustomName, CustomSurname, CustomMiddle, CustomMail, CustomPhone, Birthday FROM Customers
WHERE DATEPART(MONTH, Birthday) = 11 AND DATEPART(DAY, Birthday) = 1;

SELECT CustomName, CustomSurname, CustomMiddle, BeginDate, Town FROM Customers
WHERE DATEPART(YEAR, BeginDate) = 2020 AND DATEPART(MONTH, BeginDate) < 7;

SELECT ProdName, ProdDate, Country, Currency FROM Products
ORDER BY Country;

SELECT BeginDate, Town, CustomName, CustomSurname, CustomMiddle, CustomMail, CustomPhone, Birthday FROM Customers
WHERE BeginDate IS NULL OR Town IS NULL OR CustomName IS NULL OR CustomSurname IS NULL OR CustomMiddle IS NULL OR
CustomMail IS NULL OR CustomPhone IS NULL OR Birthday IS NULL
ORDER BY CustomName, CustomSurname, CustomMiddle;

SELECT CustomName, CustomSurname, CustomMiddle, InvDate, SUM(Sum_nt), SUM(Sum_wt) FROM Customers
INNER JOIN Invoice ON Customers.CustomID = Invoice.CustomID
WHERE DATEPART(YEAR, InvDate) = 2020 AND DATEPART(MONTH, InvDate) = 9
GROUP BY Customers.CustomID, CustomName, CustomSurname, CustomMiddle, InvDate
ORDER BY InvDate DESC;

SELECT CustomName, CustomSurname, CustomMiddle, SUM(Invoice.Sum_wt) FROM Customers
INNER JOIN Invoice ON Customers.CustomID = Invoice.CustomID
WHERE Customers.Town = 'Kyiv'
GROUP BY Customers.CustomID, CustomName, CustomSurname, CustomMiddle;

SELECT Town, COUNT(CustomID) FROM Customers
WHERE Town IS NOT NULL
GROUP BY Town;

SELECT ProdName, Article, ProdDate FROM Products
WHERE DATEPART(YEAR, ProdDate) = 2020 AND DATEPART(MONTH, ProdDate) = 7
ORDER BY Article, ProdDate, ProdName;

SELECT CustomName, CustomSurname, CustomMiddle FROM Customers
INNER JOIN Invoice ON Customers.CustomID = Invoice.CustomID
WHERE DATEPART(YEAR, InvDate) = 2020 AND DATEPART(MONTH, InvDate) = 7 AND DATEPART(DAY, InvDate) = 16;


UPDATE Products
SET ProdPrice = ProdPrice - ProdPrice * 0.02
WHERE ProdID IN (7, 13, 45, 10, 27, 33) AND DATEPART(YEAR, ProdDate) = 2020 AND DATEPART(MONTH, ProdDate) = 9 AND DATEPART(DAY, ProdDate) = 11;

UPDATE Products
SET Color = 'Green'
WHERE Article BETWEEN 'XX138000' AND 'XX150000';

INSERT INTO Products (ProdID, ProdName, Article, Color, ProdDate, Country, ProdPrice, Currency) VALUES (23, 'socks', 'XX100001', 'gray', '2020-01-06T00:00:00', 'Ukraine', 5, 'UAH');
INSERT INTO Products (ProdID, ProdName, Article, Color, ProdDate, Country, ProdPrice, Currency) VALUES (24, 'socks', 'XX100002', 'brown', '2020-01-06T00:00:00', 'Ukraine', 5, 'UAH');
INSERT INTO Products (ProdID, ProdName, Article, Color, ProdDate, Country, ProdPrice, Currency) VALUES (25, 'socks', 'XX100003', 'black', '2020-01-06T00:00:00', 'Ukraine', 5, 'UAH');
INSERT INTO Products (ProdID, ProdName, Article, Color, ProdDate, Country, ProdPrice, Currency) VALUES (26, 'socks', 'XX100004', 'red', '2020-01-06T00:00:00', 'Ukraine', 5, 'UAH');
INSERT INTO Products (ProdID, ProdName, Article, Color, ProdDate, Country, ProdPrice, Currency) VALUES (27, 'socks', 'XX100005', 'red', '2020-01-06T00:00:00', 'Ukraine', 5, 'UAH');

DELETE FROM Products
WHERE ProdID NOT IN (SELECT ProdID FROM InvoiceDetail) AND Color = 'red';

SELECT * FROM Customers
INNER JOIN Discount ON Customers.CustomID = Discount.CustomID
WHERE Town IN ('Dnipro', 'Zaporizha') AND DiscPercent = 20;

SELECT ProdName, Quant FROM Products
INNER JOIN InvoiceDetail ON Products.ProdID = InvoiceDetail.ProdID
INNER JOIN Invoice ON InvoiceDetail.InvID = Invoice.InvID
INNER JOIN Customers ON Invoice.CustomID = Customers.CustomID
WHERE Quant >
(SELECT AVG(Quant) FROM InvoiceDetail
INNER JOIN Invoice ON InvoiceDetail.InvID = Invoice.InvID
INNER JOIN Customers ON Invoice.CustomID = Customers.CustomID
WHERE Town = 'Zaporizha') AND Town = 'Zaporizha';

SELECT ProdName, Country, Currency, 'Dollar' FROM Products
WHERE Country != 'Ukraine' AND Currency = 'USD'
UNION
SELECT ProdName, Country, Currency, 'Euro' FROM Products
WHERE Country != 'Ukraine' AND Currency = 'EUR';

SELECT Sum_nt, Tax, Sum_wt, 'Winter' FROM Invoice
INNER JOIN InvoiceDetail ON Invoice.InvID = InvoiceDetail.InvID
WHERE DATEPART(YEAR, InvDate) = 2020 AND DATEPART(MONTH, InvDate) IN (1,2,12)
UNION
SELECT Sum_nt, Tax, Sum_wt, 'Spring' FROM Invoice
INNER JOIN InvoiceDetail ON Invoice.InvID = InvoiceDetail.InvID
WHERE DATEPART(YEAR, InvDate) = 2020 AND DATEPART(MONTH, InvDate) IN (3,4,5)
UNION
SELECT Sum_nt, Tax, Sum_wt, 'Summer' FROM Invoice
INNER JOIN InvoiceDetail ON Invoice.InvID = InvoiceDetail.InvID
WHERE DATEPART(YEAR, InvDate) = 2020 AND DATEPART(MONTH, InvDate) IN (6,7,8)
UNION
SELECT Sum_nt, Tax, Sum_wt, 'Autumn' FROM Invoice
INNER JOIN InvoiceDetail ON Invoice.InvID = InvoiceDetail.InvID
WHERE DATEPART(YEAR, InvDate) = 2020 AND DATEPART(MONTH, InvDate) IN (9,10,11);

DECLARE @Country VARCHAR(50) = 'Germany';
SELECT * FROM Products
WHERE Country = @Country;