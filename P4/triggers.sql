-- Don't allow insertion of cleanser if sunscreen/moisturizer already exist

CREATE TABLE ProductErrors (
    ErrorID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    ErrorMessage VARCHAR(255),
    ErrorDate DATETIME DEFAULT GETDATE()
);
GO

CREATE TRIGGER trg_InsteadOfInsertCleanser
ON [Cleanser]
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @productID INT;

    SELECT @productID = productID
    FROM inserted;
    
    IF NOT EXISTS (
        SELECT 1 FROM Product WHERE ProductID = @ProductID
    )
        BEGIN
            INSERT INTO ProductErrors (ProductID, ErrorMessage)
            VALUES (@ProductID, 'Invalid ProductID for Cleanser: Product does not exist.');
        END
    ELSE
    BEGIN
        INSERT INTO [Cleanser] (productID, cleanserForm, removesMakeup, fragrance)
        SELECT productID, cleanserForm, removesMakeup, fragrance
        FROM inserted;
    END
END;
GO

CREATE TRIGGER trg_InsteadOfInsertSunscreen
ON [Sunscreen]
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @productID INT;

    SELECT @productID = productID
    FROM inserted;
    
    IF NOT EXISTS (
        SELECT 1 FROM Product WHERE ProductID = @ProductID
    )
        BEGIN
            INSERT INTO ProductErrors (ProductID, ErrorMessage)
            VALUES (@ProductID, 'Invalid ProductID for Sunscreen: Product does not exist.');
        END
    ELSE
    BEGIN
        INSERT INTO [Sunscreen] (productID, spf, waterResistant, allergyFriendly)
        SELECT productID, spf, waterResistant, allergyFriendly
        FROM inserted;
    END
END;
GO

CREATE TRIGGER trg_InsteadOfInsertMoisturizer
ON [Moisturizer]
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @productID INT;

    SELECT @productID = productID
    FROM inserted;
    
    IF NOT EXISTS (
        SELECT 1 FROM Product WHERE ProductID = @ProductID
    )
        BEGIN
        -- Log the error into the OrderErrors table
            INSERT INTO ProductErrors (ProductID, ErrorMessage)
            VALUES (@ProductID, 'Invalid ProductID for Moisturizer: Product does not exist.');
        END
    ELSE
    BEGIN
        INSERT INTO [Moisturizer] (productID, applicationType)
        SELECT productID, applicationType
        FROM inserted;
    END
END;

-- Testing
INSERT INTO Cleanser
    (productID, cleanserForm, removesMakeup, fragrance)
VALUES
    (5000, 'test', 0, 'test');

INSERT INTO Sunscreen
    (productID, spf, waterResistant, allergyFriendly)
VALUES
    (5000, 30, 1, 1);

INSERT INTO Moisturizer
    (productID, applicationType)
VALUES
    (5000, 'test');

INSERT INTO Sunscreen
    (productID, spf, waterResistant, allergyFriendly)
VALUES
    (50, 30, 1, 1);  

SELECT *
FROM ProductErrors;