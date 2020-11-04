create procedure SP_Customer_Table (@Json nvarchar(max))  
as  
begin  
  
Insert into Customer_Table(Customer_FirstName,  
   Customer_LastName,  
   Customer_PhoneNumber,  
   Customer_Email,  
   Customer_Address)  
  
select * from OpenJson(@Json)  
with (Customer_FirstName nvarchar(500),  
  Customer_LastName nvarchar(500),  
  Customer_PhoneNumber Decimal(15,0),  
  Customer_Email nvarchar(500),  
  Customer_Address nvarchar(max))  
end


