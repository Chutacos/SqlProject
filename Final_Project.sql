DROP DATABASE IF EXISTS Final_Project;
CREATE DATABASE Final_project;
USE Final_Project

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer
    ( CustomerID INT NOT NULL IDENTITY(1,1),
      FirstName  VARCHAR(25) NOT NULL,
      LastName VARCHAR(25) NOT NULL,
      StreetAddress VARCHAR(255) NOT NULL,
      State VARCHAR(2) NOT NULL,
      City VARCHAR(25) NOT NULL,
      ZipCode VARCHAR(10) NOT NULL,
      CONSTRAINT PK_Customer_CustomerID PRIMARY KEY ( CustomerID )
);

DROP TABLE IF EXISTS Store;
CREATE TABLE Store
    ( StoreID INT NOT NULL IDENTITY (1,1),
      StreetAddress VARCHAR(255) NOT NULL,
      City VARCHAR(25) NOT NULL,
      ZipCode VARCHAR(10) NOT NULL,
      CONSTRAINT PK_Store_StoreID PRIMARY KEY (StoreID)
);

DROP TABLE IF EXISTS Vendor;
CREATE TABLE Vendor
    ( VendorID INT NOT NULL,
      VendorName VARCHAR(25) NOT NULL,
      ProductType VARCHAR(25) NOT NULL,
      StreetAddress VARCHAR(255) NOT NULL,
      City VARCHAR(35) NOT NULL,
      ZipCode VARCHAR(10) NOT NULL,
      CONSTRAINT PK_Vendor_VendorID PRIMARY KEY ( VendorID )
);

DROP TABLE IF EXISTS Products;
CREATE TABLE Products
    ( ProductID INT NOT NULL,
      ProductName VARCHAR(35) NOT NULL,
      ProductType VARCHAR(35) NOT NULL,
      VendorID INT NOT NULL,
      CONSTRAINT PK_Products_ProductID PRIMARY KEY ( ProductID ),
      CONSTRAINT FK_Products_VendorID FOREIGN KEY ( VendorID ) REFERENCES Vendor ( VendorID )
);

DROP TABLE IF EXISTS Inventory;
CREATE TABLE Inventory
    ( InventoryID INT NOT NULL,
      ProductID INT NOT NULL,
      VendorID INT NOT NULL,
      StoreID INT NOT NULL,
      DateOfShipment DATE NOT NULL,
      Quantity INT NOT NULL,
      Cost DECIMAL(8,2) NOT NULL
      CONSTRAINT PK_Inventory_InventoryID PRIMARY KEY ( InventoryID ),
      CONSTRAINT FK_Inventory_ProductID FOREIGN KEY ( ProductID ) REFERENCES Products ( ProductID),
      CONSTRAINT FK_Inventory_VendorID FOREIGN KEY ( VendorID ) REFERENCES Vendor ( VendorID ),
      CONSTRAINT FK_Inventory_StoreID FOREIGN KEY ( StoreID ) REFERENCES Store ( StoreID )
);

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee
    (EmployeeID INT NOT NULL IDENTITY(1,1),
     FirstName VARCHAR(25) NOT NULL,
     LastName VARCHAR(25),
     BaseCompensation INT NOT NULL,
     StoreID INT NOT NULL,
     DateOfEmployement DATE NOT NULL,
     TotalComp DECIMAL(8,2) NOT NULL,
     Position VARCHAR(25) NOT NULL,
     CONSTRAINT PK_Employee_EmployeeID PRIMARY KEY ( EmployeeID ),
     CONSTRAINT FK_Store_StoreID FOREIGN KEY (StoreID ) REFERENCES Store ( StoreID )
);

DROP TABLE IF EXISTS SalesPerson;
CREATE TABLE SalesPerson
    ( EmployeeID INT NOT NULL,
      CommissionEarned INT NOT NULL,
      HourlyWageCommission INT NOT NULL,
      CONSTRAINT FK_SalesPerson_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employee ( EmployeeID )
);

DROP TABLE IF EXISTS Tailor;
CREATE TABLE Tailor
    ( EmployeeID INT NOT NULL,
      HourlyWage DECIMAL(8,2) NOT NULL,
      YearsOfExperience SMALLINT NULL
      CONSTRAINT FK_Tailor_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employee ( EmployeeID )
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders
    ( OrderID INT NOT NULL IDENTITY(1,1),
      EmployeeID INT NOT NULL,
      CustomerID INT NOT NULL,
      StoreID INT NOT NULL,
      DateOfPurchase DATE NOT NULL,
      TotalPrice DECIMAL(8,2) NOT NULL,
      TypeOfOrder VARCHAR(25) NOT NULL,
      CONSTRAINT PK_Order_OrderID PRIMARY KEY ( OrderID ),
      CONSTRAINT FK_Orders_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employee ( EmployeeID ),
      CONSTRAINT FK_Orders_CustomerID FOREIGN KEY ( CustomerID )  REFERENCES Customer ( CustomerID ),
      CONSTRAINT FK_Orders_StoreID FOREIGN KEY ( StoreID ) REFERENCES Store ( StoreID )
);

DROP TABLE IF EXISTS OnlineOrder;
CREATE TABLE OnlineOrder
    ( OnlineID INT NOT NULL IDENTITY (1,1),
      OrderID INT NOT NULL,
      ProductID INT NOT NULL,
      Quantity INT NOT NULL,
      Price DECIMAL(8,2) NOT NULL,
      TrackingID INT NOT NULL,
      CONSTRAINT PK_OnlineOrder_OnlineID PRIMARY KEY ( OnlineID ),
      CONSTRAINT FK_OnlineOrder_OrderID FOREIGN KEY ( OrderID ) REFERENCES Orders ( OrderID ),
      CONSTRAINT FK_OnlineOrder_ProductID FOREIGN KEY ( ProductID ) REFERENCES Products ( ProductID )
);

DROP TABLE IF EXISTS InStore;
CREATE TABLE InStore
    ( InStoreID INT NOT NULL IDENTITY(1,1),
      OrderID INT NOT NULL,
      ProductID INT NOT NULL,
      Quantity SMALLINT NOT NULL,
      Price DECIMAL(8,2) NOT NULL,
      CONSTRAINT PK_InStore_InStoreID PRIMARY KEY ( InStoreID ), 
      CONSTRAINT FK_InStore_OrderID FOREIGN KEY ( OrderID ) REFERENCES Orders ( OrderID ),
      CONSTRAINT FK_Instore_ProductID FOREIGN KEY ( ProductID ) REFERENCES Products ( ProductID ),
);

DROP TABLE IF EXISTS ReadyToWear;
CREATE TABLE ReadyToWear
    ( ProductID INT NOT NULL,
      Color VARCHAR(35) NOT NULL,
      Size VARCHAR(25) DEFAULT NULL,
      PantSize VARCHAR(25) DEFAULT NULL,
      CONSTRAINT FK_RedayToWear_ProductID FOREIGN KEY ( ProductID ) REFERENCES Products ( ProductID )
);

DROP TABLE IF EXISTS CustomSuit;
CREATE TABLE CustomSuit
      ( ProductID INT NOT NULL,
        SuitID INT NOT NULL IDENTITY(1,1),
        CustomHeight VARCHAR(25) NOT NULL,
        Color VARCHAR(25) NOT NULL,
        CustomPants VARCHAR(25) NOT NULL,
        TypeOfMaterial VARCHAR(35) NOT NULL,
        CONSTRAINT FK_CustomSuit_ProductID FOREIGN KEY ( ProductID ) REFERENCES Products ( ProductID )
);