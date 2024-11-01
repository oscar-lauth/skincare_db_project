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
