USE P3
GO

CREATE TABLE ConflictsWith(
  ingredientID1 INT FOREIGN KEY REFERENCES IngredientCategory(categoryID)
  ingredientID2 INT FOREIGN KEY REFERENCES IngredientCategory(categoryID)
);


INSERT INTO ConflictsWith (ingredientID1, ingredientID2) VALUES
(1, 3),
(1, 5),
(1, 6),
(1, 13),
(1, 19),
(1, 21),
(2, 3),
(2, 5),
(2, 6),
(2, 13),
(2, 19),
(2, 21),
(3, 1),
(3, 2),
(3, 6),
(3, 13),
(3, 21),
(5, 1),
(5, 2),
(5, 6),
(5, 15),
(6, 1),
(6, 2),
(6, 3),
(6, 5),
(6, 12),
(6, 13),
(6, 19),
(9, 21),
(12, 6),
(13, 1),
(13, 2),
(13, 3),
(13, 6),
(13, 21),
(15, 19),
(19, 1),
(19, 2),
(19, 6),
(19, 15),
(21, 1),
(21, 2),
(21, 3),
(21, 9),
(21, 13);
