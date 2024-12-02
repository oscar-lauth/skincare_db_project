USE P3
GO

CREATE TABLE Moisturizer (
	productID INT PRIMARY KEY,
    applicationType VARCHAR(10) NOT NULL CHECK (applicationType IN ('ointment', 'cream', 'lotion', 'gel')),
	FOREIGN KEY (productID) REFERENCES Product(productID) ON DELETE CASCADE
);

INSERT INTO Moisturizer
    (productID, applicationType)
VALUES
    (51, 'cream'),  
    (52, 'gel'),  
    (53, 'cream'),  
    (54, 'lotion'),  
    (55, 'cream'),  
    (56, 'gel'),  
    (57, 'cream'),  
    (58, 'cream'),  
    (59, 'gel'),  
    (60, 'cream'),  
    (61, 'cream'),  
    (62, 'lotion'),  
    (63, 'lotion'),  
    (64, 'cream'),  
    (65, 'lotion'),  
    (66, 'cream'),  
    (67, 'cream'),  
    (68, 'lotion'),  
    (69, 'lotion'),  
    (70, 'ointment'),  
    (71, 'gel'),  
    (72, 'cream'),  
    (73, 'cream'),  
    (74, 'cream'),  
    (75, 'cream'),  
    (76, 'cream'),  
    (77, 'lotion'),  
    (78, 'gel'),  
    (79, 'cream'),  
    (80, 'cream'),  
    (81, 'cream'),  
    (82, 'gel'),  
    (83, 'lotion'),  
    (84, 'cream'),  
    (85, 'gel'),  
    (86, 'cream'),  
    (87, 'gel'),  
    (88, 'cream'),  
    (89, 'gel'),  
    (90, 'cream'),  
    (91, 'lotion'),  
    (92, 'cream'),  
    (93, 'lotion'),  
    (94, 'lotion'),  
    (95, 'lotion'),  
    (96, 'cream'),  
    (97, 'cream'),  
    (98, 'ointment'),  
    (99, 'lotion'),  
    (100, 'cream');