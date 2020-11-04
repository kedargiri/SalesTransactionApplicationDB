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
    
end  