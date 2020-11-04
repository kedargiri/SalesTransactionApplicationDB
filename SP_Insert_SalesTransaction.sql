CREATE Procedure [dbo].[SP_Insert_SalesTransaction] (@Json nvarchar(max))  
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
  
Select   
  st.CustomerId,  
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