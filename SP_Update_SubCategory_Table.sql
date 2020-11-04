  CREATE procedure SP_Update_SubCategoryTable(@Json nvarchar(max))  
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