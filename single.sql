-- name Xiaoxiao Cao
-- Id:103043833
-- -------------------task1--------------------
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

-- use TEST
-- SELECT table_catalog[database],table_schema [schema],table_name name,table_type type
-- FROM INFORMATION_SCHEMA.TABLES

CREATE TABLE Tour(
    TourName NVARCHAR(100),
    [Description]  NVARCHAR(50),
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
    Fee MONEY NOT NULL CHECK(Fee>0) ,
    DateBooked date not null,
    Payment MONEY CHECK(Payment>0), 
 PRIMARY KEY (ClientID ,TourName,EventYear,EventMonth,EventDay) ,
 FOREIGN KEY(ClientID) REFERENCES Client,
FOREIGN KEY(TourName,EventYear,EventMonth,EventDay) REFERENCES Event
    
)
SELECT table_catalog[database],table_schema [schema],table_name name,table_type type
FROM INFORMATION_SCHEMA.TABLES