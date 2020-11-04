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
  Insert into Sales_Transaction values(@MaxProductSalesId,@Customer_Id,@Customer_FirstName,@Customer_LastName,@ProductId,@QuantityToSell,@Rate,@Total,@Invoice,GETDATE())  
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