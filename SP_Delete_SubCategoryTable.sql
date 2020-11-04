  CREATE Procedure SP_Delete_SubCategoryTable(@Json nvarchar(Max))    
  as    
  begin    
    
  Delete SubCategory_Table  
  from OpenJson(@Json)  
  with (SubCategory_Id int) as JS  
  where SubCategory_Table.SubCategory_Id in (JS.SubCategory_Id)  
    
  end