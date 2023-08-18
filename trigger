create database promptpan1
use PromptPan1

create table admin(Adminid int identity,Adminname varchar(20),Gallo int,createdon datetime default getdate())
create table customer(Cid int identity,Cumstomer varchar(20),CreatedOn datetime default getdate())
create table ProductType(PTid int identity,PType varchar(20),CreatedOn datetime default getdate())
create table ProductName(PNid int identity,PName varchar(20),PTid int,PRS float,Stock int,CreatedOn datetime default getdate())
create table total(BillNo int identity,Cid int,PTid int,PNid int,Quantity int,CreatedOn datetime default getdate())
select * from customer
update ProductName set Stock=50 where PNid=5

insert into admin values('admin',50000,GETDATE())

insert into total values( 0,1,4,5)
declare @id as int 
select @id=PNid from total

--INSERT customer
EXEC managecustomer 0,'subramaniyam','i'
EXEC managecustomer 0,'dipu','i'
EXEC managecustomer 0,'fiddu','i'
EXEC managecustomer 0,'jadu','i'
--UPDATE customer
EXEC managecustomer 1,'bala','u'
--DELETE customer 
EXEC managecustomer 1,'d','d'
--select customer
EXEC managecustomer 0,'s','s'


--INSERT Productype
EXEC productTypepro 0,'masala','insert'
EXEC productTypepro 0,'pan masala','insert'
EXEC productTypepro 0,'cigrate','insert'
EXEC productTypepro 0,'chocolate','insert'
EXEC productTypepro 0,'drink','insert'
--select ProductType
EXEC  productTypepro 0,'s','s'
--DELETE ProductType 
EXEC productTypepro 6,'d','d'
EXEC productTypepro 7,'d','d'



--INSERT ProductName
EXEC productNamepro 0,'135 masala',1,20.00,50,'i'
EXEC productNamepro 0,'128 masala',1,15.00,50,'i'
EXEC productNamepro 0,'RMD',2,08.00,50,'i'
EXEC productNamepro 0,'Signature',2,05.00,50,'i'
EXEC productNamepro 0,'GFL',3,20.00,50,'i'
EXEC productNamepro 0,'ADVANCE',3,20.00,50,'i'
EXEC productNamepro 0,'Crush',3,10.00,50,'i'
EXEC productNamepro 0,'SHMBHAJI',3,2.00,50,'i'
EXEC productNamepro 0,'DairyMilk Silk',4,50.00,50,'i'
EXEC productNamepro 0,'Amul Dark Chocolate',4,150.00,50,'i'
EXEC productNamepro 0,'ThumbsUp',5,20.00,50,'i'
EXEC productNamepro 0,'MautainDue',5,20.00,50,'i'
EXEC productNamepro 0,'JIRA',5,12.00,50,'i'
--select ProductName
EXEC  productNamepro 0,'s',1,0.0,0,'s'
--DELETE ProductName 
EXEC productNamepro 6,'d','d'
EXEC productNamepro 7,'d','d'
--INSERT ProductName
EXEC productNamepro 0,1,4,9,'i'
EXEC productNamepro 0,1,3,5,'i'
--DELETE ProductName
EXEC productNamepro 30,'d',2,2,'d'
EXEC productNamepro 31,'d',2,2,'d'
EXEC productNamepro 32,'d',2,2,'d'
EXEC productNamepro 33,'d',2,2,'d'

--insert Bill
EXEC total1 0,2,4,5,4,'i'
EXEC total1 0,1,3,9,4,'i'
EXEC total1 0,3,4,10,4,'i'
--select Bill
EXEC  total1 0,1,1,0,19,'s'
--DELETE ProductName
EXEC  total1 0,2,1,0,'d'

select * from total
select * from ProductName
select * from admin

select total.BillNo,customer.Cid,customer.Cumstomer,ProductType.PType,ProductName.PName,ProductName.PRS from total 
inner join customer on customer.Cid=total.Cid
inner join ProductType on ProductType.PTid=total.PTid
inner join ProductName on ProductName.PNid=total.PNid


create trigger ForStockManage1
ON total after insert
AS
BEGIN
update ProductName set Stock=49 where PNid=5
END

insert into total values( 0,1,4,5)
declare @id as int 
select @id=PNid from total


alter trigger ForStockManage2
ON total
after insert
AS
BEGIN
declare @Quantity as int
select @Quantity=Quantity from total

declare @PNid as int
select @PNid=PNid from total

update ProductName set Stock=Stock-@Quantity 
from ProductName inner join total on total.PNid=ProductName.PNid
where @PNid=ProductName.PNid
END


alter trigger ForStockManage2
ON total
after insert
AS
BEGIN
declare @Quantity as int
select @Quantity=Quantity from total

declare @PNid as int
select @PNid=PNid from total


update ProductName set Stock=Stock-@Quantity 
from ProductName inner join total on total.PNid=ProductName.PNid
where @PNid=ProductName.PNid

update admin set Gallo=Gallo+Quantity*ProductName.PRS
from ProductName inner join total on total.PNid=ProductName.PNid
END

