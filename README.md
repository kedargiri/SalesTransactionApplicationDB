# SalesTransactionDB

# Project Report of Sales Transaction Application

# Create at least following tables:
1.	Product
2.	Customer 
3.	Sales Transaction
4.	Invoice
Note: Each table must have primary key, Unique key and should have foreign key constraints (can have check constraints)

 SUBCategory_Table:-
	Create Table SubCategoryTable
	(
	SubCategory_Id int identity(100,1) primary key,
	SubCategoryName nvarchar(500) NOT NULL,
	[Description] nvarchar(max) NOT NULL
	)

 Product_Table:-

	Create table Product_Table
	(
	Product_Id int identity (100,1) primary key,
	Product_Name nvarchar(max),
	SubCategory_Name int,
	Product_Stock_Qty int,
	Product_Rate  money,
	Mfg_Date date,
	Exp_Date date NULL,
	constraint FK_ProductTable_SubCategoryName foreign key (SubCategory_Name) references SubCategory_Table(SubCategory_Id)
	)
 
	Create table Customer_Table
	(
	Customer_Id int identity(100,1) primary key,
	Customer_FirstName nvarchar(500),
	Customer_LastName nvarchar(500),
	Customer_PhoneNumber Decimal(15,0),
	Customer_Email nvarchar(500),
	Customer_Address nvarchar(max),
	)


	CREATE TABLE Sales_Transaction(
	SalesTransactionId int IDENTITY(100,1) NOT NULL,
	CustomerId int foreign key CustomerId references Customer_Table(Customer_Id),
	ProductId int foreign key ProductId references Product_Table(Product_Id),
	Quantity int,
	Rate money,
	Amount money,
	Discount money,
	SalesDate date,
	InvoiceId int 
 	)
	

	CREATE TABLE Invoice_Table
	(
	InvoiceId int IDENTITY Primary Key(100,1),
	InvoiceDate date Default NULL,
	CustomerId int foreign key CustomerId references Customer_Table(Customer_Id) ,
	GrandTotal money,
	Discount money,
	NetTotal  AS (GrandTotal-Discount
	);



# 1. Store Procedures:
# 1.	Insert Product, Update Product, Select Product (Json as parameter for all SP preferred) 
# 2.	Insert Customer, Update Customer, Select Customer
# 3.	Insert Sales Transaction, Update Sales Transaction, Select Sales Transaction
# 4.	Create Invoice with following conditions:
# •	It should generate invoice and insert into Invoice table and each invoice generated should be tagged back to the related transaction.
# •	Number of invoices inserted should create only one invoice per customer. (a customer may buy 5 items but it should only generate one invoice (bill))
# •	Should calculate discount of 5% for items whose total amount is less than or equal 500 and 10% if total amount is greater than 500.

# Stored Procedure of SubCategory_Table:-
# Insert Stored Procedure
	Create procedure [dbo].[SP_Insert_SubCategoryTable](@JSon nvarchar(max))  
	as  
	begin  
  
	Insert into SubCategory_Table 
	(SubCategory_Name,
	[Description]
	)  
	select * from openJson(@Json)  
	with 
	(SubCategory_Name nvarchar(500),
	 [Description] nvarchar(max))  
	end  

# Update Stored Procedure


 	 CREATE procedure [dbo].[SP_Update_SubCategoryTable]
	(@Json nvarchar(max)
	)  
 	 as  
 	 begin  
 	 Update SubCategory_Table  
 	 set SubCategory_Name=js.SubCategory_Name,  
 	 [Description]=js.[Description]  
 	 from openjson(@Json)  
  	with (SubCategory_Id int 'strict $.SubCategory_Id',  
  	  SubCategory_Name nvarchar(500),  
   	 [Description] nvarchar(max)) As js  
   	 where SubCategory_Table.SubCategory_Id=js.SubCategory_Id;  
 	 end  

# Delete Stored Procedure
 	 CREATE Procedure [dbo].[SP_Delete_SubCategoryTable](
	@Json nvarchar(Max)
	)    
	  as    
	  begin        
 	 Delete SubCategory_Table  
 	 from OpenJson(@Json)  
 	 with (SubCategory_Id int) as JS  
 	 where SubCategory_Table.SubCategory_Id in (JS.SubCategory_Id)  
    
 	 end   

# Stored Procedure of Product_Table
# Insert stored Procedure

	CREATE Procedure [dbo].[SP_Insert_Product_Table](@Json nvarchar(max))  
	as  
	begin  
  
	Insert into Product_Table
	(Product_Name,
	SubCategory_Name,
	Product_Stock_Qty,
	Product_Rate,
	Mfg_Date,
	Exp_Date)  

	select * from openJson(@Json)  
	with (Product_Name nvarchar(500),
	SubCategory_Name int,
	Product_Stock_Qty int,
	Product_Rate money,
	Mfg_Date date,
	Exp_Date date)  
   
	End

 
# Update Stored Procedure
	Create Procedure [dbo].[SP_Update_Product_Table](@Json nvarchar(max))  
	as  
	begin  
  
	Update Product_Table set  
	Product_Name = js.Product_Name,  
	SubCategory_Name = js.SubCategory_Name,  
	Product_Stock_Qty= js.Product_Stock_Qty,  
	Product_Rate= js.Product_Rate,  
	Mfg_Date = js.Mfg_Date,  
	Exp_Date = js.Mfg_Date  
  
	from openJson(@Json)  
	with (  Product_Id int 'strict $.Product_Id',  
   	Product_Name nvarchar(500),   
   	SubCategory_Name int,  
   	Product_Stock_Qty int,  
   	Product_Rate money,  
  	 Mfg_Date date,  
  	 Exp_Date date)  as js  
  	 where Product_Table.Product_Id=js.Product_Id  
  
	end  
# Delete Stored Procedure
	CREATE Procedure [dbo].[SP_Delete_Product_Table](@Json nvarchar(max))  
	as  
	begin  
  
	Delete Product_Table   
	from OPenJson(@Json)  
		with(Product_Id int) as js  
	where Product_Table.Product_Id = js.Product_Id  
  
	end  

Stored Procedure of Customer_Table
Insert Stored Procudure
	create procedure SP_Customer_Table (@Json nvarchar(max))  
	as  
	begin  
  
	Insert into Customer_Table
 	 (Customer_FirstName,  
  	 Customer_LastName,  
  	 Customer_PhoneNumber,  
  	 Customer_Email,  
  	 Customer_Address)  
  
	select * from OpenJson(@Json)  
	with (Customer_FirstName nvarchar(500),  
	  Customer_LastName nvarchar(500),  
	  Customer_PhoneNumber Decimal(15,0),  
	  Customer_Email nvarchar(500),  
	  Customer_Address nvarchar(max))  
	End
# Update Stored Procedure
	CREATE procedure SP_Update_Customer_Table(@Json nvarchar(max))  
	 as  
	 begin  
  
 	 Update Customer_Table   
	 set Customer_FirstName= js.Customer_FirstName,  
	  Customer_LastName= js.Customer_LastName,  
	  Customer_PhoneNumber= js.Customer_PhoneNumber,  
	  Customer_Email=js.Customer_Email,  
	  Customer_Address=js.Customer_Address  
  
 	 from OpenJson(@Json)  
 	 with(Customer_Id int 'strict $.Customer_Id',  
 	 Customer_FirstName nvarchar(500),  
 		 Customer_LastName nvarchar(500),  
 	 Customer_PhoneNumber decimal(15,0),  
 	 Customer_Email nvarchar(500),  
 	 Customer_Address nvarchar(max)) as js  
  
	  where Customer_Table.Customer_Id= js.Customer_Id  
	 end
# Delete Stored Procedure
	CREATE Procedure SP_Delete_Customer_Table(@Json nvarchar(max))  
	as  
	begin  
  
	Delete Customer_Table  
	from OpenJson(@Json)  
	with (Customer_Id int 'strict $.Customer_Id') as js  
	where Customer_Table.Customer_Id in (js.Customer_Id)  
  
	end  
	
# Stored Procedure of Sales_Transaction
# Insert Stored Procedure

	Create Procedure [dbo].[SP_Insert_SalesTransaction] 
	(@Json nvarchar(max))
	as
	begin
	Insert into Sales_Transaction
	(
	CustomerId,
 	ProductId,
	Quantity,
	Rate,
	Amount,
	Discount
	)

	Select 	st.CustomerId,
		st.ProductId,
		st.Quantity,
		st.Rate,
		st.Rate * st.Quantity,
		case when (st.Rate * st.Quantity) < 500 then 0.05*(st.Rate * st.Quantity) 
		else 0.1*(st.Rate * st.Quantity) end
		
	from 
		openJson(@Json)
		with
		(
		 CustomerId int,
		ProductId int,
		Quantity int,
		Rate money
		) as st
	end
  
# Update Stored Procedure
	CREATE procedure SP_Update_SalesTransaction (@Json nvarchar(max))  
	as  
	begin  
  
	Update st set st.CustomerId= jj.CustomerId, st.ProductId=jj.ProductId,  
	st.Quantity=jj.Quantity, st.Rate=jj.Rate  
	from  
	 openJson(@Json)  
	  with  
 	  (  
	   SalesTransactionId int 'strict $.SalesTransactionId',  
	   CustomerId int,  
	   ProductId int,  
	   Quantity int,  
	   Rate money  
	   ) as jj  
 	  inner join Sales_Transaction as st  
 	  on st.SalesTransactionId=jj.SalesTransactionId  
 	  where   
 		  st.SalesTransactionId=jj.SalesTransactionId  


# Stored Procedure of Invoice_Table
  #   Insert Stored Procedure
		CREATE Procedure SP_Invoice(@Json nvarchar(max))  
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


# Script to insert 50 random information in all tables. Should use the insert SP.

	Create procedure SPSubCategoryRandomInsert  
	AS  
	BEGIN   
	SET NOCOUNT ON  
	DECLARE @Json VARCHAR(max)  
	DECLARE @Loop INT=0  
	Declare @Phone INT  
	Declare @Length INT  
	DECLARE @Address VARCHAR(20);  
	Declare @Customer_FirstName varchar(255)  
	Declare @Customer_LastName varchar(255)  
  
	CREATE TABLE #temp  
	(  
	Customer_FirstName varchar(255),  
	Customer_LastName varchar(255),  
	Customer_PhoneNumber varchar(255),  
	Customer_Address varchar(255)  
	)  
  
	WHILE @Loop < 50  
	BEGIN  
  
	SET @Phone = ROUND(RAND() * 10000, 0)  
	SET @Customer_FirstName = ''  
	set @Customer_LastName= ''  
	set @Address = 'Address'  
	SET @Length = CAST(RAND() * 20 AS INT)  
  
	WHILE @Length <> 0  
	BEGIN  
	SET @Customer_FirstName = @Customer_FirstName + CHAR(CAST(RAND() * 26 + 42 AS INT))  
	SET @Customer_LastName = @Customer_LastName + CHAR(CAST(RAND() * 20 + 40 AS INT))  
	SET @Length = @Length - 1  
  
	END  
 
 	INSERT INTO #temp  
	(  
   	Customer_FirstName,  
 	Customer_LastName,  
	 Customer_PhoneNumber,  
	 Customer_Address  
	)  
	SELECT @Customer_FirstName,  
	  @Customer_LastName,  
	       @Phone, (@Address + cast(@Loop as varchar(20)))  
  
	SET @Loop = @Loop + 1  
  
	END

	SELECT @Json=(  
	select * from #temp for json AUTO)  
  
	exec [dbo].[SP_Insert_Customer_Table] @json=@json  
	 drop table #temp  
	END  
# 3. The primary key in all tables should start from 100
All the Table have Primary table start from 100
# 4. Query to return following: 
1.	Whose name start with the letter "A" or ends with the letter "S" but should have the letter "K".

		Select * from Customer_Table where Customer_FirstName like '%A%K%S'


# 2.	Do not have any invoice yet.

	Select c.Customer_Id,
	c.Customer_FirstName,
	c.Customer_LastName,
	c.Customer_Email,
	c.Customer_Address from 
	Customer_Table as c 
	left Join Invoice_Table
	as i on i.CustomerId=c.Customer_Id where i.CustomerId is Null

# 3.	Average number of products bought on current date.

	select
	Avg(SalesTransactionId) as 'Average Number of Product' 
	from Sales_Transaction where SalesDate=GETDATE()

# 4.	The customer who has spent highest amount in specific date rage.

	Select distinct s.SalesDate,
	c.Customer_FirstName,
	sum(s.Amount) as highestPaid 
	from 
	Customer_Table as c 
	right join
	Sales_Transaction as s
	on c.Customer_Id=s.CustomerId 
	group by c.Customer_FirstName,
	s.SalesDate   
	having
	s.SalesDate='2020-08-16' 
	order by highestPaid desc




# Random Stored Procedure for auto Deducting Stock from Product_Table

   
	CREATE Procedure SP_ProductSalesTransaction  
	@Customer_Id int,  
	@Customer_FirstName nvarchar(350),  
	@Customer_LastName nvarchar(350),  
	@ProductId int,  
	@QuantityToSell int,  
	@Invoice int  
  
	as  
	begin  
  
----check stock availablity in Product_table  
	Declare @StockAvailable int  
	Declare @Rate money  
	select   @StockAvailable=Product_Stock_Qty, @Rate=Product_Rate from Product_Table where Product_Id=@ProductId  
  
---throw an error if there is not enough stock available  
 	if(@StockAvailable < @QuantityToSell)  
 	begin  
 	Raiserror('There is not enough stock available',16,1);  
	 Print ('Total number of stock is ' + Cast(@StockAvailable as nvarchar(max)) )  
	 end  
  
 	else  
 ---if enough stock is available then  
		 begin  
		 begin try  
	 begin transaction  
  
	 update Product_Table set Product_Stock_Qty = (Product_Stock_Qty - @QuantityToSell)   
	 where Product_Id =@ProductId  
  
	 Declare @MaxProductSalesId int  
     	  select @MaxProductSalesId = case when  
                 Max(SalesTransaction_Id) is Null   
                 then 0 else MAX(SalesTransaction_Id) end   
                 from Sales_Transaction  
          set @MaxProductSalesId = @MaxProductSalesId + 1  
            
  ----Calculate rate and total  
    
    	 Declare @Total money  
     	select @Total= (@QuantityToSell * @Rate)  from Product_Table where Product_Id=@ProductId  
  
  ------ insert into SalesTransaction  
 	 Insert into Sales_Transaction values(@MaxProductSalesId,@Customer_Id,,@ProductId,@QuantityToSell,@Rate,@Total,@Invoice,GETDATE())  
 	 commit transaction   
 	 end try  
 	 begin catch  
 	  Rollback transaction  
 	  Print 'Transaction Rolled back'  
  	  select ERROR_NUMBER() as ErrorNumber,  
  	   ERROR_LINE() as ErrorLine,  
  	   ERROR_MESSAGE() as ErrorMessage,  
   	  ERROR_PROCEDURE() as ErrorProcedure,  
   	  ERROR_SEVERITY() as ErrorServerity,  
   	  ERROR_STATE() as ErrorState  
 	 end catch  
	end  
	end




