CREATE FUNCTION CheckCustomerFunc
(@CustomerID INT)
RETURNS BIT
BEGIN
DECLARE @Result BIT;
IF 
(SELECT COUNT(CustomID) FROM Customers
WHERE CustomID = @CustomerID AND (BeginDate IS NULL OR Town IS NULL OR CustomName IS NULL OR CustomSurname IS NULL OR CustomMiddle IS NULL OR
CustomMail IS NULL OR CustomPhone IS NULL OR Birthday IS NULL) ) > 0 SET @Result = 0
ELSE SET @Result = 1;
RETURN @Result;
END