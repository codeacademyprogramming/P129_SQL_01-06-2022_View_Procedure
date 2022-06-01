--Database Yaradin Adi Ne Olursa Olsun

--Brands Adinda Table Yaradin 2 dene colum Id ve Name

--Notebooks Adinda Table Yaradin Id,Name, Price Columlari Olsun.

--Phones Adinda Table Yaradin Id, Name, Price Columlari Olsun.

Create Database Store

Use Store

Create Table Brands
(
	Id int primary key identity,
	Name nvarchar(50) Not Null Check(Len(Name) >= 2) Unique
)

INSERT INTO Brands
VALUES
('Apple'),
('Hp'),
('Samsung'),
('Xiaomi'),
('Huawei'),
('Asus'),
('Dell')

Create Table Phones
(
	Id int primary key identity,
	Name nvarchar(255) Not Null Check(Len(Name) >= 2) Unique,
	Price money Not Null Check(Price > 0)
)

Create Table Notebooks
(
	Id int primary key identity,
	Name nvarchar(255) Not Null Check(Len(Name) >= 2) Unique,
	Price money Not Null Check(Price > 0)
)

--1) Notebook ve Brand Arasinda Mentiqe Uygun Relation Qurun.
Alter Table Notebooks
Add BrandId int Not Null Foreign Key References Brands(Id)

INSERT INTO Notebooks(Name, Price, BrandId)
VALUES
('250 G5', 943, 2),
('250 G6', 1158, 2),
('250 G7', 1251, 2),
('Air', 2363, 1),
('Pro 13', 2975, 1),
('Pro 15', 3439, 1),
('ROG', 2928, 6),
('ROG PRO', 3968, 6),
('VIVOBOOK 15', 1536, 6),
('VIVOBOOK 14', 1325, 6),
('Mate X', 1600, 5),
('Mate X PRO', 1900, 5),
('Mate XL PRO', 1864, 5),
('Mate XXL PRO', 1253, 5),
('Mi Notebook Air', 1753, 4),
('Mi Notebook Pro', 2153, 4),
('Lustrous Grey', 4681, 4),
('Galaxy Book', 1874, 3),
('Galaxy Book PRO', 3274, 3),
('Galaxy Book AIR', 2574, 3),
('Galaxy Book AIR PRO', 3367, 3)

--2) Phones ve Brand Arasinda Mentiqe Uygun Relation Qurun.
Alter Table Phones
Add BrandId int Not Null Foreign Key References Brands(Id)

INSERT INTO Phones(Name, Price, BrandId)
VALUES
('13', 2463, 1),
('13 Pro', 3075, 1),
('13 Pro Max', 3339, 1),
('Mate Pad', 1600, 5),
('Mate Xs', 1900, 5),
('Nova 9 SE', 1864, 5),
('P50E', 1853, 5),	
('Poco 5', 1753, 4),
('Poco 4', 2153, 4),
('Poco 6', 4681, 4),
('A11', 275, 3),
('A21', 285, 3),
('A31', 374, 3),
('A41', 467, 3),
('A51', 567, 3),
('A61', 667, 3),
('A71', 767, 3),
('A81', 867, 3),
('A91', 967, 3)

--3) Notebooks Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.

Select n.Name, b.Name 'BrandName', n.Price From Notebooks n
Left Join Brands b
On n.BrandId=b.Id


--4) Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.

Select p.Name, b.Name 'BrandName',p.Price From Phones p
Left Join Brands b
On p.BrandId=b.Id

--5) Brand Adinin Terkibinde s Olan Butun Notebooklari Cixardan Query.

SELECT * FROM Notebooks WHERE EXISTs(SELECT * FROM Brands WHERE Brands.Name LIKE '%S%' AND Id=Notebooks.BrandId)

--6) Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Notebooklari Cixardan Query.

SELECT * FROM Notebooks WHERE price between 2000 and 5000 or Price>5000

--7) Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.

SELECT * FROM Phones WHERE price between 1000 and 1500 or Price>1500


--8) Her Branda Aid Nece dene Notebook Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
SELECT Brands.Name, Count(*) 'Count' FROM Brands 
Join Notebooks On Notebooks.BrandId = Brands.Id 
Group By Brands.Name
--9) Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
SELECT Brands.Name, Count(*) 'Count' FROM Brands 
Join Phones On Phones.BrandId = Brands.Id 
Group By Brands.Name
--10) Hem Phone Hem de Notebookda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.
SELECT Name, BrandId FROM Notebooks 
Union
SELECT Name, BrandId FROM Phones 
--11) Phone ve Notebook da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.
SELECT * FROM Notebooks 
Union All
SELECT * FROM Phones 
--12) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.
SELECT n.Id, n.Name, n.Price, b.Name [Brand Name] FROM Notebooks n
Join Brands b On n.BrandId = b.Id 
Union All
SELECT p.Id, p.Name, p.Price, b.Name [Brand Name] FROM Phones p
Join Brands b On p.BrandId = b.Id 

Select tbl.Id, tbl.Name, tbl.Price, Brands.Name [Brand Name] From 
(
	SELECT * FROM Notebooks
	Union All
	SELECT * FROM Phones p
) tbl
Join Brands On tbl.BrandId = Brands.Id
--13) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.
SELECT n.Id, n.Name, n.Price, b.Name [Brand Name] FROM Notebooks n 
Join Brands b On n.BrandId = b.Id 
Where n.Price > 1000
Union All
SELECT p.Id, p.Name, p.Price, b.Name [Brand Name] FROM Phones p
Join Brands b On p.BrandId = b.Id 
 Where p.Price > 1000

Select tbl.Id, tbl.Name, tbl.Price, Brands.Name [Brand Name] From 
(
	SELECT * FROM Notebooks
	Union All
	SELECT * FROM Phones p
) tbl
Join Brands On tbl.BrandId = Brands.Id
 Where tbl.Price > 1000
--14) Phones Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) ve Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olan Datalari Cixardan Query.Misal
--BrandName:        TotalPrice:        ProductCount:
--Apple                 6750                3
--Samsung				3500                4
--Redmi                 800                 1

Select b.Name 'Brand Name', SUM(p.Price) 'Total Price', COUNT(*) 'Product Count' From Brands b
Join Phones p On p.BrandId = b.Id
Group By b.Name

--15) Notebooks Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) , Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olacaq ve Sayi 3-ve 3-den Cox Olan Datalari Cixardan Query.Misal
--BrandName:        TotalPrice:        ProductCount:
--Apple                    6750                3
--Samsung              3500                4
Select b.Name 'Brand Name', SUM(p.Price) 'Total Price', COUNT(*) 'Product Count' From Brands b
Join Notebooks p On p.BrandId = b.Id
Group By b.Name Having COUNT(*) > 3

--View
--1. Create View
Create View usv_GetPhoneswithBrand
As
Select Phones.Name 'PhoneName', Phones.Price 'PhonePrice',Brands.Name 'BrandName' From Phones
Join Brands On Phones.BrandId = Brands.Id

Select PhoneName From usv_GetPhoneswithBrand Where PhonePrice > 1500

--2. Edit View
Alter View usv_GetPhoneswithBrand
As
Select Phones.Id 'PhoneId', Phones.Name 'PhoneName', Phones.Price 'PhonePrice',Brands.Name 'BrandName' From Phones
Join Brands On Phones.BrandId = Brands.Id

Create View usv_GetNotebookswithBrand
As
Select Notebooks.Id 'NotebookId', Notebooks.Name 'NotebookName', Notebooks.Price 'NotebookPrice',Brands.Name 'BrandName' From Notebooks
Join Brands On Notebooks.BrandId = Brands.Id


Create View usv_GetPhonesAndNotebooksWithBrand
As
Select PhoneId 'Id', PhoneName 'Name', PhonePrice 'Price', BrandName 
From usv_GetPhoneswithBrand
Union
Select NotebookId 'Id', NotebookName 'Name', NotebookPrice 'Price', BrandName 
From usv_GetNotebookswithBrand

Select * From usv_GetPhonesAndNotebooksWithBrand

Select tbl.Id, tbl.Name, tbl.Price, tbl.BrandName From usv_GetPhonesAndNotebooksWithBrand tbl
Where tbl.Price > 1000

Select tbl.Id, tbl.Name, tbl.Price, tbl.BrandName From usv_GetPhonesAndNotebooksWithBrand tbl
Where tbl.Price > 2000

Select tbl.Id, tbl.Name, tbl.Price, tbl.BrandName From usv_GetPhonesAndNotebooksWithBrand tbl
Where tbl.Name = 'S22'

--Procedure
--1. Create Procedure
Create Procedure usp_GetPhonesAndNotebooksWithBrandMoreThanPrice @price money
As
Begin
	Select * From usv_GetPhonesAndNotebooksWithBrand
	Where Price > @price
End

--2. Edit Procedure
Alter Procedure usp_GetPhonesAndNotebooksWithBrandMoreThanPrice @price money
As
Begin
	Select * From usv_GetPhonesAndNotebooksWithBrand
	Where Price < @price
End

exec usp_GetPhonesAndNotebooksWithBrandMoreThanPrice 2000

Alter Procedure usp_GetPhoneswithBrandByPriceAndBrandName 
@price money, 
@brandName nvarchar(255)
As
Begin
	Select * From usv_GetPhoneswithBrand 
	Where PhonePrice > @price And BrandName like '%'+@brandName+'%'
End

exec usp_GetPhoneswithBrandByPriceAndBrandName 1000,'a'