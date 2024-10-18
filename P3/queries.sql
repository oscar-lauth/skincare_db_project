USE P3
GO

-- count the total number of products by type
SELECT productType, COUNT(productID) AS totalProducts
FROM Product
GROUP BY productType;

-- find the average price of all products for each skin type
SELECT skinType, AVG(price) AS averagePrice
FROM Product
GROUP BY skinType;

-- get the minimum, maximum, and average SPF values for all sunscreens
SELECT MIN(spf) AS minSPF, MAX(spf) AS maxSPF, AVG(spf) AS avgSPF
FROM Sunscreen;

-- find all products that contain BHA as well as their product type
SELECT p.productName, p.productType
FROM Product p
JOIN Includes c ON p.productID = c.productID
JOIN Ingredient i ON c.ingredientID = i.ingredientID
WHERE i.ingredientName = 'BHA (salicylic acid)';

-- list the product details and application type of all moisturizers
SELECT p.productName, p.manufacturer, p.skinType, p.price, m.applicationType
FROM Moisturizer m
JOIN Product p ON m.productID = p.productID;

-- list all users who have reviewed a product and the details of the routine they reviewed
SELECT u.username, r.reviewText, rt.summary, rt.timeOfDay
FROM Reviews r
JOIN Users u ON r.userID = u.userID
JOIN Routine rt ON r.routineID = rt.routineID;

-- find all moisturizers with an above average price
SELECT p.productName, p.price
FROM Product p
WHERE p.price > (
    SELECT AVG(price)
    FROM Product
    WHERE productType = 'Moisturizer'
);

-- find the most expensive product(s) for each skin type
SELECT productName, price, skinType
FROM Product p
WHERE price = (
    SELECT MAX(price)
    FROM Product
    WHERE skinType = p.skinType
);

-- list the users who have reviewed more than one routine and how many reviews they have submitted
SELECT u.username, 
       (SELECT COUNT(r.routineID) 
        FROM Reviews r 
        WHERE r.userID = u.userID) AS reviewCount
FROM Users u
WHERE (SELECT COUNT(r.routineID) 
       FROM Reviews r 
       WHERE r.userID = u.userID) > 1;

-- find all products that are marked as water-resistant sunscreens and the summary of routines that contain them
SELECT p.productName, r.summary
FROM Routine r
JOIN Has h ON r.routineID = h.routineID
JOIN Product p ON h.productID = p.productID
JOIN Sunscreen s ON p.productID = s.productID
WHERE s.waterResistant = 1;
