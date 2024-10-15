Use P3
GO

CREATE TABLE Product (
productID INT IDENTITY(1,1) PRIMARY KEY,
productName VARCHAR(255) UNIQUE NOT NULL, 
manufacturer VARCHAR(255) NOT NULL, 
skinType VARCHAR(11) NOT NULL CHECK (skinType IN('normal','oily','dry','combination','sensitive')),
price SMALLMONEY NOT NULL CHECK (price>=0)
);

INSERT INTO Product
    (productName, manufacturer, skinType, price)
VALUES
    ('Differin 10% Benzoyl Peroxide Acne Spot Treatment', 'Differin', 'normal', 9.99);