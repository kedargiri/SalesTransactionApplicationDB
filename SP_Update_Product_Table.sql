  
Create Procedure SP_Update_Product_Table(@Json nvarchar(max))  
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