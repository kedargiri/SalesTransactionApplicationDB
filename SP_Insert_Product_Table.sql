CREATE Procedure SP_Insert_Product_Table(@Json nvarchar(max))  
as  
begin  
  
Insert into Product_Table (Product_Name,SubCategory_Name,Product_Stock_Qty,Product_Rate,Mfg_Date,Exp_Date)  
select * from openJson(@Json)  
with (Product_Name nvarchar(500),
	SubCategory_Name int,
	Product_Stock_Qty int,  
	Product_Rate money,
	Mfg_Date date,
	Exp_Date date
)  
  
end