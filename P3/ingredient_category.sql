USE P3
GO
    
CREATE TABLE IngredientCategory (
    ingredientID INT NOT NULL FOREIGN KEY REFERENCES Ingredient(ingredientID),
    categoryID INT NOT NULL
    PRIMARY KEY (ingredientID, categoryID)
);

INSERT INTO IngredientCategory (ingredientID, categoryID) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 2),
(6, 3),
(6, 4),
(7, 5),
(8, 1),
(8, 2),
(9, 1),
(9, 2),
(10, 2),
(10, 5),
(11, 2),
(12, 2),
(13, 1),
(13, 5),
(14, 2),
(15, 6),
(16, 3),
(17, 2),
(18, 1),
(19, 2),
(20, 4),
(21, 1),
(21, 3);
