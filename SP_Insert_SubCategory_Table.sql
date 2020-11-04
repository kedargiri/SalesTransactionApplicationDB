  
Create procedure SP_SubCategory_Table(@JSon nvarchar(max))  
as  
begin  
  
Insert into SubCategory_Table (SubCategory_Name,[Description])  
select * from openJson(@Json)  
with (SubCategory_Name nvarchar(500), [Description] nvarchar(max))  
end  