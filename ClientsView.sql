CREATE VIEW Clients AS
SELECT CustomName, CustomSurname, CustomMiddle, BeginDate, DiscDate, DiscPercent, DiscSumma, ProdName, Quant FROM Customers
INNER JOIN Discount ON Customers.CustomID = Discount.CustomID
INNER JOIN Invoice ON Discount.InvID = Invoice.InvID
INNER JOIN InvoiceDetail ON Invoice.InvID = InvoiceDetail.InvID
INNER JOIN Products ON InvoiceDetail.ProdID = Products.ProdID; 