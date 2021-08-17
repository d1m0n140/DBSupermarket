CREATE FUNCTION DiscountDateFunc
(@CustomerID INT)
RETURNS SMALLDATETIME
BEGIN
	DECLARE @DiscountDate SMALLDATETIME; 
    SET @DiscountDate = (SELECT BeginDate FROM Customers
	WHERE CustomID = @CustomerID);
	DECLARE @Period INT;
	SET @Period = DATEDIFF(DAY, @DiscountDate, GETDATE()); 
	SET @DiscountDate = DATEADD(DAY, 1 + @Period, @DiscountDate);
    RETURN @DiscountDate
END