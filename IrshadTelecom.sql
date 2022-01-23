create database IrshadTelecom

use IrshadTelecom

create Table Brands 
(
 Id int primary key identity,
 Name nvarchar(30)
)
--1
create Table Notebooks 
(
 Id int primary key identity,
 Name nvarchar(30),
 Price Money,
 BrandId int references Brands(Id)
)
--2
create Table Phones 
(
 Id int primary key identity,
 Name nvarchar(30),
 Price Money,
 BrandId int references Brands(Id)
)

--3
Select (Brands.Name + ' ' +Notebooks.Name) as [Brand Name], Notebooks.Price from Notebooks
Inner Join Brands
on Notebooks.BrandId=Brands.Id

--4
Select (Brands.Name + ' ' +Phones.Name) as [Brand Name], Phones.Price from Phones
Inner Join  Brands
on Phones.BrandID=Brands.Id
--5
Select Notebooks.Name from Notebooks
Inner Join Brands
on Notebooks.BrandId=Brands.Id
 Where Brands.Name Like '%s%' 

--6
Select * From Notebooks where Notebooks.Price between 2000 and 5000 or Notebooks.Price>5000
--7
Select * From Phones Where Phones.Price between 1500 and 2000 or Phones.Price>1500

--8
Select Brands.Name, COUNT(Brands.Name) from Brands
Inner Join Notebooks
on Notebooks.BrandId=Brands.Id
Group By Brands.Name 

--9
Select Brands.Name, COUNT(Brands.Name) from Brands
Inner Join Phones
on Phones.BrandId=Brands.Id
Group By Brands.Name

--10
Select Phones.Name, Phones.BrandId from Phones
intersect 
Select Notebooks.Name, Notebooks.BrandId from Notebooks

--11
Select Phones.Id, Phones.Name, Phones.Price, Phones.BrandId from Phones
Union All
Select Notebooks.Id, Notebooks.Name, Notebooks.Price, Notebooks.BrandId from Notebooks

--12
Select Phones.Id, Phones.Name, Phones.Price, Phones.BrandId, Brands.Name 'Brand Name' from Phones
inner join Brands
on Phones.BrandId=Brands.Id
Union All
Select Notebooks.Id, Notebooks.Name, Notebooks.Price, Notebooks.BrandId, Brands.Name 'Brand Name' from Notebooks
inner join Brands
on Notebooks.BrandId=Brands.Id

--13
Select Phones.Id, Phones.Name, Phones.Price, Phones.BrandId, Brands.Name 'Brand Name' from Phones 
inner join Brands
on Phones.BrandId=Brands.Id
where Phones.Price>1000
Union All
Select Notebooks.Id, Notebooks.Name, Notebooks.Price, Notebooks.BrandId, Brands.Name 'Brand Name' from Notebooks 
inner join Brands
on Notebooks.BrandId=Brands.Id
where Notebooks.Price>1000

--14
Create view usv_GetAllPhones
As
Select Brands.Name 'Brand Name', COUNT(Brands.Name) 'Product Count',SUM(Phones.Price) 'Total Price' from Brands
Inner Join Phones
on Phones.BrandId=Brands.Id
Group By Brands.Name

Select * from usv_GetAllPhones

--15
Create view usv_GetAllNotebooks
As
Select Brands.Name 'Brand Name', Count(Brands.Name) 'Product Count', SUM(Notebooks.Price) 'Total Price' from Brands
Inner join Notebooks
on Notebooks.BrandId=Brands.Id
Group By Brands.Name

Select * from usv_GetAllNotebooks