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

-- find the names of products that contain an ingredient which has conflicts with another ingredient
SELECT p.productName
FROM Product p
WHERE p.productID IN (
    SELECT inc.productID
    FROM Includes inc
    WHERE inc.ingredientID IN (
        SELECT cw.ingredientID1
        FROM ConflictsWith cw
        UNION
        SELECT cw.ingredientID2
        FROM ConflictsWith cw
    )
);

-- find the most expensive product(s) for each skin type
SELECT productName, price, skinType
FROM Product p
WHERE price = (
    SELECT MAX(price)
    FROM Product
    WHERE skinType = p.skinType
);

-- list the users who have reviewed more than one routine
SELECT username
FROM Users u
WHERE (
    SELECT COUNT(routineID)
    FROM Reviews r
    WHERE r.userID = u.userID
) > 1;

-- find all products that are marked as water-resistant sunscreens and the summary of routines that contain them
SELECT p.productName, r.summary
FROM Routine r
JOIN Has h ON r.routineID = h.routineID
JOIN Product p ON h.productID = p.productID
JOIN Sunscreen s ON p.productID = s.productID
WHERE s.waterResistant = 1;
