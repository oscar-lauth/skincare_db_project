USE P3

CREATE TABLE Cleanser (
	productID INT PRIMARY KEY,
	cleanserForm VARCHAR(20) CHECK (cleanserForm IN ('oil-based', 'cream', 'balm', 'oil', 'water-based', 'foam', 'gel', 'wipes', 'clay', 'micellar', 'powder')),
	removesMakeup BIT,
	fragrance VARCHAR(50)
	FOREIGN KEY (productID) REFERENCES Product(productID)
);

INSERT INTO Cleanser
    (productID, cleanserForm, removesMakeup, fragrance)
VALUES
    (1, 'gel', 0, 'fragrance-free'),  
    (2, 'cream', 0, 'fragrance-`free'),  
    (3, 'water-based', 0, 'fragrance-free'),  
    (4, 'cream', 0, 'fragrance-free'),  
    (5, 'water-based', 0, 'fragrance-free'),  
    (6, 'cream', 1, 'light fragrance'),  
    (7, 'gel', 1, 'fragrance-free'),  
    (8, 'balm', 1, 'fragrance-free'),  
    (9, 'foam', 1, 'light fragrance'),  
    (10, 'micellar', 1, 'fragrance-free'),  
    (11, 'water-based', 0, 'fragrance-free'),  
    (12, 'gel', 1, 'light fragrance'),  
    (13, 'jelly', 1, 'fragrance-free'),  
    (14, 'micellar', 1, 'light fragrance'),  
    (15, 'gel', 1, 'light fragrance'),  
    (16, 'foam', 0, 'light fragrance'),  
    (17, 'gel', 1, 'light fragrance'),  
    (18, 'water-based', 0, 'fragrance-free'),  
    (19, 'cream', 0, 'light fragrance'),  
    (20, 'gel', 1, 'fragrance-free');