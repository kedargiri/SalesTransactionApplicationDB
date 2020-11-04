 CREATE procedure SP_Update_Customer_Table(@Json nvarchar(max))  
 as  
 begin  
  
 Update Customer_Table   
 set Customer_FirstName= js.Customer_FirstName,  
  Customer_LastName= js.Customer_LastName,  
  Customer_PhoneNumber= js.Customer_PhoneNumber,  
  Customer_Email=js.Customer_Email,  
  Customer_Address=js.Customer_Address  
  
  from OpenJson(@Json)  
  with(Customer_Id int 'strict $.Customer_Id',  
  Customer_FirstName nvarchar(500),  
  Customer_LastName nvarchar(500),  
  Customer_PhoneNumber decimal(15,0),  
  Customer_Email nvarchar(500),  
  Customer_Address nvarchar(max)) as js  
  
  where Customer_Table.Customer_Id= js.Customer_Id  
  
  
  
  
  
 end
