IF EXISTS (SELECT name FROM master.sys.databases WHERE name = N'DBSuperMarket')
DROP DATABASE DBSuperMarket;

USE master;
GO
CREATE DATABASE DBSuperMarket 
ON
( NAME = DBSuperMarket,
    FILENAME = 'C:\SQLData\DBSuperMarket.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON
( NAME = DBSuperMarket_log,
    FILENAME = 'C:\SQLData\DBSuperMarket_log.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
USE DBSuperMarket;

IF EXISTS (SELECT 1 FROM  sysobjects
WHERE  id = object_id('Customers')
AND   TYPE = 'U')
DROP TABLE Customers;

CREATE TABLE Customers (
   CustomID INT PRIMARY KEY NOT NULL,
   CustomName VARCHAR(50) NULL,
   CustomSurname VARCHAR(50) NULL,
   CustomMiddle VARCHAR(50) NULL,
   BeginDate SMALLDATETIME NULL,
   CustomMail VARCHAR(100) NULL,
   CustomPhone VARCHAR(20) NULL UNIQUE,
   Birthday SMALLDATETIME NULL,
   Town VARCHAR(50) NULL,
   CHECK(BeginDate >= '2020-01-01 00:00:00'),
   CHECK(CustomPhone LIKE '[+][0-9][0-9][(][0-9][0-9][0-9][)][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]')
);

IF EXISTS (SELECT 1 FROM  sysobjects
WHERE  id = object_id('Invoice')
AND   TYPE = 'U')
DROP TABLE Invoice;

CREATE TABLE Invoice (
   InvID INT PRIMARY KEY NOT NULL,
   InvNum VARCHAR(25) NULL,
   InvDate DATETIME NULL,
   Sum_nt DECIMAL(10,2) NULL,
   Tax AS Sum_nt * 0.2,
   Sum_wt AS Sum_nt + Sum_nt * 0.2,
   CustomID INT NULL,
   FOREIGN KEY (CustomID) REFERENCES Customers(CustomID)
);

IF EXISTS (SELECT 1 FROM  sysobjects
WHERE  id = object_id('Discount')
AND   TYPE = 'U')
DROP TABLE Discount;

CREATE TABLE Discount (
   DiscID INT PRIMARY KEY NOT NULL,
   CustomID INT NULL,
   DiscDate DATETIME NULL,
   DiscPercent INT NULL,
   DiscSumma DECIMAL(10,2) NULL,
   InvID INT NULL,
   FOREIGN KEY (CustomID) REFERENCES Customers(CustomID),
   FOREIGN KEY (InvID) REFERENCES Invoice(InvID)
);

IF EXISTS (SELECT 1 FROM  sysobjects
WHERE  id = object_id('Products')
AND   TYPE = 'U')
DROP TABLE Products;

CREATE TABLE Products (
   ProdID INT PRIMARY KEY NOT NULL,
   ProdName VARCHAR(300) NULL,
   Article CHAR(20) NULL UNIQUE,
   Color VARCHAR(25) NULL,
   ProdDate DATETIME NULL,
   Country VARCHAR(50) NULL,
   ProdPrice DECIMAL(10,2) NULL,
   Currency CHAR(3) NULL,
   CHECK(ProdDate >= '2020-01-01 00:00:00:000'),
   CHECK(Article LIKE '[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9]')
);

IF EXISTS (SELECT 1 FROM  sysobjects
WHERE  id = object_id('InvoiceDetail')
AND   TYPE = 'U')
DROP TABLE InvoiceDetail;

CREATE TABLE InvoiceDetail (
   InvDID INT PRIMARY KEY NOT NULL,
   InvID INT NULL,
   ProdID INT NULL,
   Quant DECIMAL(10,2) NULL,
   Price DECIMAL(10,2) NULL,
   Sum DECIMAL(10,2) NULL,
   FOREIGN KEY (InvID) REFERENCES Invoice(InvID),
   FOREIGN KEY (ProdID) REFERENCES Products(ProdID)
);

