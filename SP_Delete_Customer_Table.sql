CREATE Procedure SP_Delete_Customer_Table(@Json nvarchar(max))  
as  
begin  
  
Delete Customer_Table  
from OpenJson(@Json)  
with (Customer_Id int 'strict $.Customer_Id') as js  
where Customer_Table.Customer_Id in (js.Customer_Id)  
  
end  