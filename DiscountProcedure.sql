CREATE PROCEDURE AddDiscount @CustomerID INT, @InvoiceID INT
AS
BEGIN

	DECLARE @DiscountDate SMALLDATETIME;
	SET @DiscountDate = dbo.DiscountDateFunc(@CustomerID);
	DECLARE @DiscountPercent INT;
	SET @DiscountPercent = dbo.DiscountPercentFunc(@CustomerID);
	DECLARE @DiscountKey INT;
	SET @DiscountKey = (SELECT MAX(DiscID) FROM Discount) + 1;
	INSERT INTO Discount (DiscID, CustomID, DiscDate, DiscPercent, InvID) VALUES 
		(@DiscountKey, @CustomerID, @DiscountDate, @DiscountPercent, @InvoiceID);
	IF dbo.CheckCustomerFunc(@CustomerID) = 1
	BEGIN
		DECLARE @DiscountSumma DECIMAL(10,2);
		SET @DiscountSumma = (SELECT sum_wt FROM Invoice
		WHERE InvID = @InvoiceID) * (@DiscountPercent / 100);
		UPDATE Discount
		SET DiscSumma = @DiscountSumma
		WHERE DiscID = @DiscountKey; 
	END
END