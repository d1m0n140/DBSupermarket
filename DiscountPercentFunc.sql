CREATE FUNCTION DiscountPercentFunc
(@CustomerID INT)
RETURNS INT
BEGIN
	 DECLARE @DiscountDate SMALLDATETIME;
	 DECLARE @Percent INT;
	 DECLARE @BeginDate SMALLDATETIME;
	 SET @BeginDate = (SELECT BeginDate FROM Customers
	 WHERE CustomID = @CustomerID);
	 SET @DiscountDate = dbo.DiscountDateFunc(@CustomerID);
	 IF DATEDIFF(MONTH, @BeginDate, @DiscountDate) < 3
		SET @Percent = 5;

	 IF DATEDIFF(MONTH, @BeginDate, @DiscountDate) >= 3 AND DATEDIFF(MONTH, @BeginDate, @DiscountDate) < 6
		SET @Percent = 10;

     IF DATEDIFF(MONTH, @BeginDate, @DiscountDate) BETWEEN 6 AND 9
		SET @Percent = 15;

	 IF DATEDIFF(MONTH, @BeginDate, @DiscountDate) > 9
		SET @Percent = 20;

	 RETURN @Percent 
END