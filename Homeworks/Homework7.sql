CREATE DATABASE hw7;
GO
USE hw7;
GO

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(10),
    category_id INT,
    price DECIMAL(6, 2),
);
INSERT INTO Product (product_id,product_name, category_id, price)
VALUES
   (1,'product a', 1, 10.00),
   (2,'product b', 2, 20.00),
   (3,'product c', 2, 15.00);
CREATE TABLE Category (
    category_name VARCHAR(10),
    category_id INT PRIMARY KEY,
);
INSERT INTO Category (category_name,category_id)
VALUES
   ('category a',1),
   ('category b',2),
   ('category c',3);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1, 1),
    product_id INT FOREIGN KEY REFERENCES Product(product_id),
    order_date DATETIME DEFAULT GETDATE(),
    quantity INT
);
INSERT INTO Orders (product_id, quantity)
VALUES
   (1, 5),
   (1, 2),
   (2, 3),
   (2, 1),
   (2, 2);

GO
-- Q1. Create a view that lists the total sales (price times quantity) for each product
CREATE VIEW ProductSales AS
SELECT 
    p.product_id,
    p.product_name,
    SUM(p.price * o.quantity) AS total_sales
FROM 
    Product p
INNER JOIN 
    Orders o ON p.product_id = o.product_id
GROUP BY 
    p.product_id, p.product_name;
GO

SELECT * FROM ProductSales;
GO

-- Q2. Create a view that shows the total number of products sold per category
CREATE VIEW SalesPerCategory AS
SELECT c.category_id, c.category_name, SUM(o.quantity) AS Sales
FROM
    Category c
INNER JOIN
    Product p on p.category_id = c.category_id
INNER JOIN
    Orders o on o.product_id = p.product_id
GROUP BY
    c.category_id,c.category_name;
GO
SELECT * FROM SalesPerCategory;
GO
CREATE TABLE PriceHistory (
   history_id INT PRIMARY KEY IDENTITY(1, 1),
   product_id INT FOREIGN KEY REFERENCES Product(product_id),
   old_price DECIMAL(4, 2),
   new_price DECIMAL(4, 2),
   change_date DATETIME DEFAULT GetDate(),
);
GO
-- Q3. Create a Trigger to automatically update a PriceHistory table whenever a product in the Products table gets a new price.
CREATE TRIGGER trg_UpdatePriceHistory
ON Product
AFTER UPDATE
AS
BEGIN
    IF UPDATE(price)
    BEGIN
        INSERT INTO PriceHistory (product_id, old_price, new_price, change_date)
        SELECT 
            d.product_id,
            d.price AS old_price,
            i.price AS new_price,
            GETDATE() AS change_date
        FROM 
            Inserted i
        JOIN 
            Deleted d ON i.product_id = d.product_id
    END;
END;
GO
UPDATE Product SET price=13.00 WHERE product_id <> 2;
SELECT * FROM PriceHistory;
GO
-- Q4. Write a query to list the total number of products sold and total revenue for each
-- product, grouped by product name and ordered by total revenue in descending order. Provide the
-- estimation plan for this query
SELECT 
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold,
    SUM(o.quantity * p.price) AS total_revenue
FROM 
    Product p
JOIN 
    Orders o ON p.product_id = o.product_id
GROUP BY 
    p.product_name
ORDER BY 
    total_revenue DESC;
