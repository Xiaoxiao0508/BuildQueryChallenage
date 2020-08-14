-- name Xiaoxiao Cao
-- Id:103043833
-- -------------------task1--------------------------------------
-- Tour (TourName,Description) 
-- PRIMARY KEY (TourName) 


-- Client (ClientID,Surname,GivienName,Gender) 
-- PRIMARY KEY (ClientID) 

-- Event(TourName,EventYear,EventMonth,EventDay,Fee) 
-- PRIMARY KEY (TourName,EventYear,EventMonth,EventDay) 
-- FOREIGN KEY(TourName) REFERENCES Tour 

-- Booking(ClientID ,TourName,EventYear,EventMonth,EventDay,Fee,DateBooked,Payment) 
-- PRIMARY KEY (ClientID ,TourName,EventYear,EventMonth,EventDay) 
-- FOREIGN KEY(ClientID ,) REFERENCES Client
-- FOREIGN KEY(TourName,EventYear,EventMonth,EventDay REFERENCES Event

use TEST
-- SELECT table_catalog[database],table_schema [schema],table_name name,table_type type
-- FROM INFORMATION_SCHEMA.TABLES

-- -----------------------------------------task2----------------------
IF OBJECT_ID('Booking') IS NOT NULL 
DROP TABLE Booking
IF OBJECT_ID('Event') IS NOT NULL 
DROP TABLE Event
IF OBJECT_ID('Tour') IS NOT NULL 
DROP TABLE Tour
IF OBJECT_ID('Client') IS NOT NULL 
DROP TABLE Client
GO


CREATE TABLE Tour(
    TourName NVARCHAR(100),
    [Description]  NVARCHAR(500),
    PRIMARY KEY(TourName)
)

CREATE TABLE Client (
    ClientID INT,
    Surname NVARCHAR(100) NOT NULL,
    GivienName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(1) CHECK(Gender IN ('M','F','I'))
    PRIMARY KEY (ClientID) 
) 
CREATE TABLE Event(
TourName NVARCHAR(100),
EventYear INT CHECK (LEN(EventYear)=4),
EventMonth  NVARCHAR(3) CHECK(EventMonth IN ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')),
EventDay INT CHECK(EventDay>=1 AND EventDay<=31),
Fee Money NOT NULL CHECK(Fee>0),
 PRIMARY KEY (TourName,EventYear,EventMonth,EventDay),
 FOREIGN KEY(TourName) REFERENCES Tour 
)

CREATE TABLE Booking(
    ClientID INT,
    TourName NVARCHAR(100),
    EventYear INT CHECK (LEN(EventYear)=4),
    EventMonth NVARCHAR(3) CHECK(EventMonth IN ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')),
    EventDay INT CHECK((EventDAY>=1) AND (EventDay<=31)),
    DateBooked date not null,
    Payment MONEY CHECK(Payment>0), 
 PRIMARY KEY (ClientID ,TourName,EventYear,EventMonth,EventDay) ,
 FOREIGN KEY(ClientID) REFERENCES Client,
FOREIGN KEY(TourName,EventYear,EventMonth,EventDay) REFERENCES Event
    
)
SELECT table_catalog[database],table_schema [schema],table_name name,table_type type
FROM INFORMATION_SCHEMA.TABLES

-- --------------------------task 3-----------------------------------
INSERT INTO Tour(TourName,Description) VALUES
('North','Tour of wineries and outlets of the Bedigo and Castlemaine region'),
('South','Tour of wineries and outlets of Mornington Penisula'),
('West','Tour of wineries and outlets of the Geelong and Otways region');

INSERT INTO Client(ClientID,Surname,GivienName,Gender) VALUES
(1,'Price','Taylor','M'),
(2,'Gamble','Ellyse','F'),
(3,'Tan','Tilly','F'),
(4,'Cao','Xiaoxiao','F');


INSERT INTO Event(TourName,EventYear,EventMonth,EventDay,Fee) VALUES
('North',2016,'Jan',9,200),
('North',2016,'Feb',13,225),
('South',2016,'Jan',9,200),
('South',2016,'Jan',16,200),
('West',2016,'Jan',29,225);

INSERT INTO Booking(ClientID ,TourName,EventYear,EventMonth,EventDay,DateBooked,Payment) VALUES
(1,'North',2016,'Jan',9,'2015-12-10',200),
(2,'North',2016,'Jan',9,'2015-12-16',200),
(1,'North',2016,'Feb',13,'2016-01-08',225),
(2,'North',2016,'Feb',13,'2016-01-14',125),
(3,'North',2016,'Feb',13,'2016-02-03',225),
(1,'South',2016,'Jan',9,'2015-12-10',200),
(2,'South',2016,'Jan',16,'2015-12-18',200),
(3,'South',2016,'Jan',16,'2016-01-09',200),
(2,'West',2016,'Jan',29,'2015-12-17',225),
(3,'West',2016,'Jan',29,'2015-12-18',200),
(4,'West',2016,'Jan',29,'2015-12-18',200);

-- -----------------------task4----------------------------------------

SELECT C.GivienName,C.Surname,T.TourName,T.Description,E.EventYear,E.EventMonth,E.EventDay,E.Fee, B.DateBooked,B.Payment 
FROM Client C
INNER JOIN Booking B
ON C.ClientID=B.ClientID
INNER JOIN Event E
ON B.EventYear=E.EventYear AND B.TourName=E.TourName AND B.EventMonth=E.EventMonth AND B.EventDay=E.EventDay
INNER JOIN Tour T
ON E.TourName=T.TourName


SELECT EventMonth, TourName, COUNT(*) AS 'Num Booking'
FROM Event 
Group by EventMonth,TourName

 SELECT *
FROM Booking
WHERE Payment>(
    SELECT AVG(Payment)
    FROM Booking
);


-- -----------------------task5---------------------------------------
GO
IF OBJECT_ID('Myview') IS NOT NULL
DROP VIEW Myview;
GO
CREATE VIEW Myview AS
SELECT C.GivienName,C.Surname,T.TourName,T.Description,E.EventYear,E.EventMonth,E.EventDay,E.Fee, B.DateBooked,B.Payment 
FROM Client C
INNER JOIN Booking B
ON C.ClientID=B.ClientID
INNER JOIN Event E
ON B.EventYear=E.EventYear
INNER JOIN Tour T
ON E.TourName=T.TourName
 GO

SELECT * 
FROM Myview

--------------------------task6--------------------------------------
SELECT  *
FROM Client
--  By listing all the client details to check whether all the information are list in the 
-- query result
SELECT * 
FROM Booking
-- -  By listing all the 10 bookings to check whether all the information are list in 
-- the query result, the query result shows the total booking is 10, so this is correct.

 SELECT AVG(Payment) as averagepayment
    FROM Booking
-- By listing the average payments to check whether the query result is right, 
-- the average is 200, so the result is correct.
