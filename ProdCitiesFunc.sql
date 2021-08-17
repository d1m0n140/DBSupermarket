CREATE FUNCTION ProdCitiesFunc (@ProductName VARCHAR(300))
RETURNS TABLE
AS
RETURN
(
    SELECT Town FROM Customers
	INNER JOIN Invoice ON Customers.CustomID = Invoice.CustomID
	INNER JOIN InvoiceDetail ON Invoice.InvID = InvoiceDetail.InvID
	INNER JOIN Products ON InvoiceDetail.ProdID = Products.ProdID
    WHERE ProdName = @ProductName
);