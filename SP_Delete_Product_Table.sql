CREATE Procedure SP_Delete_Product_Table(@Json nvarchar(max))  
as  
begin  
  
Delete Product_Table   
from OPenJson(@Json)  
with(Product_Id int) as js  
where Product_Table.Product_Id = js.Product_Id  
  
end  