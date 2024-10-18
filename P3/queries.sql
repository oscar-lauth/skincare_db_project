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

-- find all products that are part of a routine along with the routine’s details
SELECT p.productName, r.summary, r.timeOfDay
FROM Product p
JOIN Has h ON p.productID = h.productID
JOIN Routine r ON h.routineID = r.routineID;

-- list all users who have reviewed a product and the details of the routine they reviewed
SELECT u.username, r.reviewText, rt.summary, rt.timeOfDay
FROM Reviews r
JOIN Users u ON r.userID = u.userID
JOIN Routine rt ON r.routineID = rt.routineID;
