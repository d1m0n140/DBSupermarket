CREATE PROCEDURE HBDiscountProc
AS
BEGIN


DECLARE @custId INT;
DECLARE custCursor CURSOR FORWARD_ONLY FOR
    SELECT CustomID FROM Customers
	WHERE DATEPART(MONTH, Birthday) = DATEPART(MONTH, GETDATE()) AND
	DATEPART(DAY, Birthday) = DATEPART(DAY, GETDATE());
OPEN custCursor;

FETCH NEXT FROM custCursor INTO @custId;
WHILE @@FETCH_STATUS = 0 BEGIN
	

	DECLARE @LastDiscID INT;
	DECLARE @DiscountSumma DECIMAL(10,2);

	SET @LastDiscID = (SELECT MAX(DiscID) FROM Discount
	WHERE CustomID = @custId);

	SET @DiscountSumma = (SELECT DiscSumma FROM Discount
	WHERE DiscID = @LastDiscID);

	IF (SELECT BeginDate FROM Customers
	WHERE CustomID = @custId) < '2020-06-20T00:00:00'
	SET @DiscountSumma = @DiscountSumma + 1000
	ELSE
	SET @DiscountSumma = @DiscountSumma + 500;

	UPDATE Discount
	SET DiscSumma = @DiscountSumma
	WHERE DiscID = @LastDiscID;

    FETCH NEXT FROM custCursor INTO @custId;
END;
CLOSE custCursor;
DEALLOCATE custCursor;

END