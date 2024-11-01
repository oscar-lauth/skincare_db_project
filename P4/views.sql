CREATE VIEW UserInfoView AS
SELECT 
    userID,
    email,
    username,
    skinType
FROM 
    Users;
GO

CREATE VIEW ProductInfoView AS
SELECT 
    productID,
    productName,
    manufacturer,
    productType,
    skinType,
    price
FROM 
    Product;
GO

CREATE VIEW RoutineInfoView AS
SELECT 
    routineID,
    userID,
    timeOfDay,
    summary
FROM 
    Routine;
GO
