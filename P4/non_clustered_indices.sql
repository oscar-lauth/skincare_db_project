USE P3;
GO
-- #1. Non clustered index on routineID column in Reviews table
-- this will be useful as Reviews is often queried by routineID (in functions,procedures,etc)
CREATE NONCLUSTERED INDEX IDX_Reviews_RoutineID
ON Reviews (routineID);

-- #2. Non clustered index on productID column in Includes table (ingredients included in products)
-- this will be useful as we often want to query the Includes table by productID to get what ingredients are in a product
CREATE NONCLUSTERED INDEX IDX_Includes_ProductID
ON Includes (productID);

-- #3. Non clustered index on productType column in Product table
-- this will be useful as we likley will frequently want to filter the products by their different sub-types
CREATE NONCLUSTERED INDEX IDX_Product_ProductType
ON Product (productType);