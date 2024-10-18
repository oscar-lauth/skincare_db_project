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

-- find the total number of users with each skin type
SELECT skinType, COUNT(userID) AS totalUsers
FROM Users
GROUP BY skinType;

-- find all products that are part of a user’s routine along with the routine’s details
SELECT p.productName, r.summary, r.timeOfDay
FROM Product p
JOIN Has h ON p.productID = h.productID
JOIN Routine r ON h.routineID = r.routineID;

-- list all cleansers and their details that are included in user routines
SELECT p.productName, c.cleanserForm, c.removesMakeup, r.summary
FROM Cleanser c
JOIN Product p ON c.productID = p.productID
JOIN Has h ON p.productID = h.productID
JOIN Routine r ON h.routineID = r.routineID;
