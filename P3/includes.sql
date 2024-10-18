USE P3
GO
-- product "includes" ingredients
CREATE TABLE Includes (
    productID INT NOT NULL REFERENCES Product(productID),
    ingredientID INT NOT NULL REFERENCES Ingredient(ingredientID),
    PRIMARY KEY (productID, ingredientID)
);

INSERT INTO Includes (productID, ingredientID) VALUES

