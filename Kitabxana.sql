CREATE DATABASE Kitabxana

USE Kitabxana

Create Table Books
(
 Id int primary key identity,
 Name nvarchar(30)  Check(LEN(Name) between 2 and 100),
 PageCount int Check(PageCount>=10),
 AuthorID int references Authors(Id)
)

Create Table Authors
(
 Id int primary key identity,
 Name nvarchar(30),
 Surname nvarchar(40)
)

Create view usv_GetAllInformation
As
Select Books.Id, Books.Name, Books.PageCount, (Authors.Name+ ' '+Authors.Surname) 'AuthorFullName' from Books
inner join  Authors
on Books.AuthorID=Authors.Id

Select *from usv_GetAllInformation

Create procedure usp_SerachBooksBySTR 
(@BookSTR nvarchar(30))
As
Begin
Select books.Id,books.Name,books.PageCount,(Authors.Name+' '+Authors.Surname ) 'AuthorFullName' from Books
Join Authors
on Books.AuthorID=Authors.Id
Where Books.Name like '%'+@BookSTR+'%' or Authors.Name like '%'+@BookSTR+'%' or Authors.Surname like '%'+@BookSTR+'%'
End

exec usp_SerachBooksBySTR 'Believe'

Create procedure usp_Insertdata
(@Name nvarchar(30),
@SurName nvarchar(30))
As
Begin
Insert into Authors
Values(@Name,@SurName)
Select * from Authors 
End

exec usp_Insertdata 'Stiven', 'King'

Create procedure usp_Updatedata
(@Id int, @Name nvarchar(30),
@SurName nvarchar(30))
As
Begin
Update Authors
set Authors.Name=@Name, Authors.Surname=@SurName where Authors.Id=@Id
Select * from Authors
End

exec usp_Updatedata 1,'Joanne','Rowling'

Create procedure usp_DeleteData
(@Id int)
As
Begin
Delete From Authors where Authors.Id=@Id
Select *from Authors
End

exec usp_DeleteData  6


Create view usv_AuthorInfo
As
Select Authors.Id 'ID', Authors.Name + ' ' + Authors.Surname 'Fullname', COUNT(Books.Name) 'BooksCount', MAX(Books.PageCount) 'MaxPageCount' from Authors
inner join Books
on Books.AuthorID=Authors.Id
group by Authors.Id,Authors.Name,Authors.Surname
