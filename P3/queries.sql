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
