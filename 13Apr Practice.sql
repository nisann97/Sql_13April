create database Company

use Company

create table Employees
(
    [Id] int primary key identity(1,1),
    [Name] NVARCHAR(50),
    [Surname] NVARCHAR(50),
    [Email] NVARCHAR(100) unique not null
)

insert into Employees
    ( [Name], [Surname], [Email])
values
    ('Nisa', 'Narimanova', 'nisann@gmail.com')

insert into Employees
    ([Name], [Surname], [Email])
values
    ('Matanat', 'Memmedova', 'matanat@gmail.com')

alter table Employees
add  [Age] int

select *
from Employees


select substring([Email], 1, charindex('@', email)-1) as username
from Employees

select substring([Email], charindex('@', email)+1, len(email)-CHARINDEX('@', email)) as domain
from Employees

create table City
(
    [Id] int primary key identity(1,1),
    [Name] NVARCHAR(50)
)

alter table Employees
add [CityId] int foreign key references City(Id)

insert into City([Name])
values('Baku'),
    ('Sumqayit'),
    ('Qubadli'),
    ('Naxchivan'),
    ('Yardimli')


create view vw_ShowEmployeesByAge
as 
select * from Employees where [Age]>25


select * from vw_ShowEmployeesByAge

create view vw_joinEmployeeDatas
as 
select emp.Name as 'Employee Name', emp.Surname as 'Employee Surname',  ct.Name as 'City' from Employees Emp
inner join City ct
on emp.CityId = ct.Id

select * from vw_joinEmployeeDatas

create function dbo.showWord()
returns NVARCHAR(50)
as
begin 
return 'P418'
end

select dbo.showWord()


declare @result NVARCHAR(50) = (select dbo.showWord())

print @result



create function dbo.showWordWithParameter1(@text nvarchar(50))
returns nvarchar(50)
AS
BEGIN
return @text
END

select dbo.showWordwithParameter1('Aqshin bey')
select dbo.showWordwithParameter1('Semed bey')
select dbo.showWordwithParameter1('Oruc bey')



create function dbo.getEmployeesAvgAge()
returns INT
AS
BEGIN
declare @avgAge int = (select Avg(Age) from Employees)
return @avgAge
END


select dbo.getEmployeesAvgAge()

select * from Employees
 
create function dbo.getEmployeesAvgAgeById(@id int)
returns INT
AS
BEGIN
declare @avgAge int = (select AVG(Age) from Employees where [Id]> @id)
return @avgAge
end

select dbo.getEmployeesAvgAgeById(3)



create function dbo.getEmployeesByCondition(@avgAge int)
returns table 
as
return (select * from Employees where [Age]> @avgAge)

declare @avgAge int = (select dbo.getEmployeesAvgAgeById(3))
select * from  getEmployeesByCondition(@avgAge)

create procedure usp_showText
AS
print 'salam'

exec usp_showText

usp_showText

create PROCEDURE usp_showTextWithParameter
@text NVARCHAR(50)
AS
print @text

exec usp_showTextWithParameter 'Azerbaycan'

select * from Employees


create procedure usp_deleteEmployeeById
@id INT
AS
delete from Employees where [Id] = @id


 usp_deleteEmployeeById 6


-- create procedure usp_createEmployee
-- @name NVARCHAR(50),
-- @surname NVARCHAR(50),
-- @email NVARCHAR(100),
-- @age INT,
-- @cityId INT
-- AS
-- begin 
-- insert into Employees ([Name], [Surname], [Email], [Age], [CityId])
-- values(@name, @surname, @email, @age, @cityId)
-- END


exec usp_createEmployee 'Tofiq', 'Nasibli', 'tofig@gmail.com', 29, 1


select * from Employees


create function dbo.getEmployeesAvgAge2()
returns INT
AS
BEGIN
return (SELECT Avg(Age) from Employees)
end


select dbo.getEmployeesAvgAge2()


create procedure usp_deleteEmployeesByAge
as
begin
declare @avgAge INT =  (select dbo.getEmployeesAvgAge2())
delete from Employees where [Age]> @avgAge
END

 usp_deleteEmployeesByAge

 select *from Employees
 