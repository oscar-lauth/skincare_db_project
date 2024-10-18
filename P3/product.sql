CREATE DATABASE P3
GO
USE P3
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
    -- ('Differin 10% Benzoyl Peroxide Acne Spot Treatment', 'Differin', 'normal', 9.99),  
    ('CeraVe Hydrating Facial Cleanser', 'CeraVe', 'dry', 13.99),  
    ('Neutrogena Oil-Free Acne Wash', 'Neutrogena', 'oily', 8.49),  
    ('La Roche-Posay Toleriane Hydrating Cleanser', 'La Roche-Posay', 'sensitive', 14.99),
    ('Cetaphil Gentle Skin Cleanser', 'Cetaphil', 'combination', 10.49),  
    ('First Aid Beauty Pure Skin Face Cleanser', 'First Aid Beauty', 'sensitive', 12.00),
    ('Paula’s Choice Clear Pore Normalizing Cleanser', 'Paula’s Choice', 'normal', 14.00),  
    ('The Ordinary Squalane Cleanser', 'The Ordinary', 'dry', 7.90),  
    ('Kiehl’s Ultra Facial Cleanser', 'Kiehl’s', 'normal', 22.00),  
    ('Bioderma Sensibio H2O Micellar Water', 'Bioderma', 'sensitive', 11.99),  
    ('Vanicream Gentle Facial Cleanser', 'Vanicream', 'sensitive', 8.50),  
    ('Youth To The People Superfood Cleanser', 'Youth To The People', 'combination', 36.00),  
    ('Drunk Elephant Beste No.9 Jelly Cleanser', 'Drunk Elephant', 'oily', 32.00),  
    ('Garnier SkinActive Micellar Water', 'Garnier', 'normal', 8.99),  
    ('Tatcha The Deep Cleanse', 'Tatcha', 'combination', 38.00),  
    ('Origins Checks and Balances Frothy Face Wash', 'Origins', 'combination', 25.00),  
    ('Fresh Soy Face Cleanser', 'Fresh', 'normal', 38.00),  
    ('Clinique Liquid Facial Soap', 'Clinique', 'oily', 21.00),  
    ('Aveeno Calm + Restore Nourishing Oat Cleanser', 'Aveeno', 'sensitive', 9.99),  
    ('Eucerin Hydrating Cleansing Gel', 'Eucerin', 'dry', 10.50);