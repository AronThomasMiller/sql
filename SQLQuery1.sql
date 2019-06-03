CREATE DATABASE HotelTask
ON
(
  NAME='HotelTask',
  FILENAME = 'C:\HotelTask.mdf',
  SIZE=200MB,
  MAXSIZE=2000MB,
  FILEGROWTH=10MB
)
LOG ON
(
  NAME = 'LogHotelTask',
  FILENAME = 'C:\HotelTask.ldf',
  SIZE=100MB,
  MAXSIZE=1000MB,
  FILEGROWTH=10MB
)
COLLATE Cyrillic_General_CI_AS

EXECUTE sp_helpdb HotelTask;

USE HotelTask
GO

CREATE TABLE Hotels 
(
  HotelId int NOT NULL PRIMARY KEY IDENTITY,
  HotelName varchar (100) NOT NULL,
  CreationYear int NOT NULL,
  HotelAddress varchar (100) NOT NULL,
  IsActive varchar (100) NOT NULL,
);
SELECT *FROM Hotels;

CREATE TABLE HotelRooms 
(
  id int NOT NULL PRIMARY KEY IDENTITY,
  HotelId int NOT NULL FOREIGN KEY REFERENCES dbo.Hotels(HotelId),
  RoomNumber int NOT NULL,
  Price int NOT NULL,
  ComfortLvl int NOT NULL,
  Capability int NOT NULL,
);
SELECT *FROM HotelRooms;

CREATE TABLE InfoClients 
(
  Id int NOT NULL PRIMARY KEY IDENTITY,
  ClientName varchar (100) NOT NULL,
  Email varchar (100) NOT NULL,
);
SELECT *FROM InfoClients;

CREATE TABLE Booking 
(
  BookId int NOT NULL PRIMARY KEY IDENTITY,
  ClientId int NOT NULL FOREIGN KEY REFERENCES InfoClients(Id),
  HotelRoomId int NOT NULL FOREIGN KEY REFERENCES HotelRooms(id),
  BookingStartDay date,
  BookingEndDay date,
);
SELECT *FROM Booking;

INSERT INTO Hotels (HotelName, CreationYear, HotelAddress, IsActive) VALUES 
('Star' , '1999' , 'Poletaeva 4' , 'True'),
('Moon' , '2004' , 'Nebesna-Sotnya 5a' , 'False'),
('Edelweiss' , '2009' , 'Golovna 7b' , 'True')

SELECT *FROM Hotels

UPDATE Hotels 
SET CreationYear='1937'
WHERE HotelId='1'

DELETE FROM Hotels 
WHERE HotelId='2'

INSERT INTO InfoClients(ClientName,Email) VALUES
('Andrew', 'Andrew@gmail.com'),
('Anton', 'Anton@gmail.com'),
('Alex', 'Alex@gmail.com'),
('Anton', 'Anton1@gmail.com'),
('Andrew', 'Andrew1@gmail.com'),
('Nazar', 'Nazar@gmail.com'),
('Ira', 'Ira@gmail.com'),
('Boris', 'Boris@gmail.com'),
('Max', 'Max@gmail.com'),
('Michael', 'Michael@gmail.com')

SELECT *FROM InfoClients
WHERE ClientName like 'A%'

SELECT *FROM HotelRooms
INSERT INTO HotelRooms (HotelId, RoomNumber, Price, ComfortLvl, Capability) VALUES
('1', '101', '2100' , '3' , '4'),
('1', '102', '2200' , '2' , '4'),
('1', '103', '2300' , '1' , '4'),
('1', '104', '2400' , '3' , '4'),
('1', '105', '2500' , '2' , '4'),
('1', '106', '2100' , '1' , '4'),
('1', '107', '2700' , '3' , '4'),
('3', '101', '2400' , '2' , '4'),
('3', '102', '2900' , '1' , '4'),
('3', '301', '2000' , '1' , '4')

SELECT Price FROM HotelRooms
ORDER BY Price

SELECT * FROM HotelRooms
WHERE HotelId='3'
ORDER BY Price

SELECT * FROM HotelRooms
WHERE ComfortLvl='3'

SELECT*
FROM Hotels
INNER JOIN HotelRooms ON Hotels.HotelId = HotelRooms.HotelId
WHERE ComfortLvl='3'

SELECT Hotels.HotelName, HotelRooms.RoomNumber , HotelRooms.ComfortLvl
FROM Hotels
INNER JOIN HotelRooms ON Hotels.HotelId = HotelRooms.HotelId
WHERE ComfortLvl='1'

SELECT  Hotels.HotelName, COUNT(HotelRooms.RoomNumber) AS RoomCount
FROM Hotels
INNER JOIN HotelRooms ON Hotels.HotelId = HotelRooms.HotelId
GROUP BY Hotels.HotelName

SELECT * FROM Booking
INSERT INTO Booking (ClientId, HotelRoomId, BookingStartDay, BookingEndDay) VALUES
('1', '1' , '2019-05-01' , '2019-05-04'),
('2', '3' , '2019-05-02' , '2019-05-05'),
('3', '3' , '2019-05-03' , '2019-05-06'),
('4', '1' , '2019-05-04' , '2019-05-07'),
('5', '3' , '2019-05-05' , '2019-05-08'),
('6', '1' , '2019-05-06' , '2019-05-09'),
('7', '3' , '2019-05-07' , '2019-05-10'),
('8', '1' , '2019-05-08' , '2019-05-11'),
('9', '3' , '2019-05-09' , '2019-05-12'),
('10', '3' , '2019-05-10' , '2019-05-13')

SELECT InfoClients.ClientName, HotelRooms.RoomNumber, Booking.BookingStartDay, Booking.BookingEndDay
FROM Booking
INNER JOIN InfoClients ON Booking.ClientId = InfoClients.Id
INNER JOIN HotelRooms ON HotelRooms.id = Booking.HotelRoomId

USE HotelTask
SELECT ClientName, RoomNumber, BookingStartDay, BookingEndDay
FROM InfoClients
INNER JOIN Booking ON InfoClients.Id = Booking.ClientId 
INNER JOIN HotelRooms ON Booking.HotelRoomId = HotelRooms.id