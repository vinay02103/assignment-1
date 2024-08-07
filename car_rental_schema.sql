
CREATE DATABASE car_rental;
use car_rental;
-- Create the CAR table
CREATE TABLE CAR (
    VehicleID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each car
    Model VARCHAR(50) NOT NULL, -- Model of the car
    Year INT NOT NULL, -- Year of manufacture
    CarType ENUM('COMPACT', 'MEDIUM', 'LARGE', 'SUV', 'TRUCK', 'VAN') NOT NULL, -- Type of the car
    Category ENUM('Regular', 'Luxury') NOT NULL, -- Category of the car
    DailyRate DECIMAL(10, 2) NOT NULL, -- Daily rental rate
    WeeklyRate DECIMAL(10, 2) NOT NULL -- Weekly rental rate
);

-- Create the CUSTOMER table
CREATE TABLE CUSTOMER (
    IdNo INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each customer
    Name VARCHAR(50) NOT NULL, -- Customer's name
    Phone VARCHAR(12) NOT NULL, -- Customer's phone number
    CustomerType ENUM('Individual', 'Business') NOT NULL -- Type of customer
);

-- Create the OWNER table
CREATE TABLE OWNER (
    OwnerID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each owner
    OwnerType ENUM('Company', 'Bank', 'Individual') NOT NULL, -- Type of owner
    OwnerName VARCHAR(100) NOT NULL, -- Name of the owner
    OwnerAddress VARCHAR(255) NOT NULL -- Address of the owner
);

-- Create the CAR_OWNERSHIP table to link cars and owners
CREATE TABLE CAR_OWNERSHIP (
    VehicleID INT, -- Foreign key to CAR table
    OwnerID INT, -- Foreign key to OWNER table
    OwnershipStartDate DATE NOT NULL, -- Start date of ownership
    OwnershipEndDate DATE, -- End date of ownership (nullable)
    PRIMARY KEY (VehicleID, OwnerID), -- Composite primary key
    FOREIGN KEY (VehicleID) REFERENCES CAR(VehicleID), -- Foreign key constraint for VehicleID
    FOREIGN KEY (OwnerID) REFERENCES OWNER(OwnerID) -- Foreign key constraint for OwnerID
);

-- Create the RENTAL table to track rental transactions
CREATE TABLE RENTAL (
    RentalID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each rental
    VehicleID INT, -- Foreign key to CAR table
    IdNo INT, -- Foreign key to CUSTOMER table
    RentalType ENUM('DAILY', 'WEEKLY') NOT NULL, -- Type of rental
    StartDate DATE NOT NULL, -- Rental start date
    ReturnDate DATE NOT NULL, -- Rental return date
    NoOfDays INT, -- Number of days rented (nullable)
    NoOfWeeks INT, -- Number of weeks rented (nullable)
    AmountDue DECIMAL(10, 2) NOT NULL, -- Amount due for the rental
    FOREIGN KEY (VehicleID) REFERENCES CAR(VehicleID), -- Foreign key constraint for VehicleID
    FOREIGN KEY (IdNo) REFERENCES CUSTOMER(IdNo) -- Foreign key constraint for IdNo
);

-- Insert sample data into CUSTOMER table
INSERT INTO CUSTOMER (Name, Phone, CustomerType) VALUES 
('J.Smith', '817-272-3000', 'Individual'),
('R.Wong', '817-273-3000', 'Business'),
('A.Johnson', '817-274-3000', 'Individual'),
('B.Miller', '817-275-3000', 'Business'),
('C.Davis', '817-276-3000', 'Individual');

-- Insert sample data into CAR table
INSERT INTO CAR (Model, Year, CarType, Category, DailyRate, WeeklyRate) VALUES 
('Chevy Malibu', 2020, 'MEDIUM', 'Regular', 30.00, 180.00),
('Toyota Corolla', 2021, 'COMPACT', 'Luxury', 35.00, 210.00),
('Ford F-150', 2019, 'TRUCK', 'Regular', 40.00, 240.00),
('Honda CR-V', 2022, 'SUV', 'Luxury', 45.00, 270.00),
('Nissan Sentra', 2021, 'MEDIUM', 'Regular', 32.00, 192.00);

-- Insert sample data into OWNER table
INSERT INTO OWNER (OwnerType, OwnerName, OwnerAddress) VALUES 
('Company', 'Company XYZ', '123 Rental St, City, Country'),
('Bank', 'National Bank', '456 Bank Ave, City, Country'),
('Individual', 'John Doe', '789 Private Dr, City, Country');

-- Insert sample data into CAR_OWNERSHIP table
INSERT INTO CAR_OWNERSHIP (VehicleID, OwnerID, OwnershipStartDate, OwnershipEndDate) VALUES 
(1, 1, '2023-01-01', NULL), -- Chevy Malibu owned by Company XYZ
(2, 1, '2023-02-01', NULL), -- Toyota Corolla owned by Company XYZ
(3, 2, '2023-03-01', NULL), -- Ford F-150 owned by National Bank
(4, 2, '2023-04-01', NULL), -- Honda CR-V owned by National Bank
(5, 3, '2023-05-01', NULL); -- Nissan Sentra owned by John Doe

-- Insert sample data into RENTAL table
INSERT INTO RENTAL (VehicleID, IdNo, RentalType, StartDate, ReturnDate, NoOfDays, NoOfWeeks, AmountDue) VALUES 
(1, 1, 'DAILY', '2024-08-01', '2024-08-04', 3, NULL, 90.00), -- Rental of Chevy Malibu by J.Smith
(2, 2, 'WEEKLY', '2024-08-01', '2024-08-08', NULL, 1, 210.00), -- Rental of Toyota Corolla by R.Wong
(3, 3, 'DAILY', '2024-08-02', '2024-08-06', 4, NULL, 160.00), -- Rental of Ford F-150 by A.Johnson
(4, 4, 'WEEKLY', '2024-08-03', '2024-08-10', NULL, 1, 270.00), -- Rental of Honda CR-V by B.Miller
(5, 5, 'DAILY', '2024-08-04', '2024-08-07', 3, NULL, 96.00); -- Rental of Nissan Sentra by C.Davis
