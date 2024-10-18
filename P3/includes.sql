USE P3
GO

CREATE TABLE Includes (
    productID INT NOT NULL REFERENCES Product(productID),
    ingredientID INT NOT NULL REFERENCES Ingredient(ingredientID),
    PRIMARY KEY (productID, ingredientID)
);

INSERT INTO Contains (productID, ingredientID) VALUES

