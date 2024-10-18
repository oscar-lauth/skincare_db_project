USE P3
GO

CREATE TABLE IngredientCategory (
    categoryID INT IDENTITY(1,1) PRIMARY KEY,
    categoryName VARCHAR(30) UNIQUE NOT NULL,
);

INSERT INTO IngredientCategory (categoryName) VALUES
('exfoliant'),
('antioxidant'),
('humectant'),
('texture enhancer'),
('emollient'),
('antibacterial');