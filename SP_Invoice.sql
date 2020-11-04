CREATE Procedure SP_Invoice (@Json nvarchar(max))  
as  
begin  
  
SELECT   
oj.SalesTransactionId,   
s.CustomerId  
INTO #temp  
FROM  
OPENJSON(@Json)  
WITH  
(  
SalesTransactionId INT  
) AS oj  
Inner join Sales_Transaction as s on s.SalesTransactionId=oj.SalesTransactionId  
  
  
insert into Invoice_Table  
(  
CustomerId,  
 GrandTotal,  
 Discount  
 )  
  
 SELECT t.CustomerId,SUM(s.Amount),Sum(s.Discount)  FROM  #temp AS t  
INNER JOIN dbo.Sales_Transaction AS s ON s.SalesTransactionId=t.SalesTransactionId  
 GROUP BY t.CustomerId  
  
DECLARE @InvoiceId INT;  
SET @InvoiceId =SCOPE_IDENTITY();  
  
UPDATE s SET s.InvoiceId=@InvoiceId FROM Sales_Transaction AS s  
INNER JOIN  #temp AS t ON t.CustomerId=s.CustomerId  
  
  
end  