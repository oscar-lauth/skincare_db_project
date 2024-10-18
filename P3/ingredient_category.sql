USE P3
GO
    
CREATE TABLE IngredientCategory (
    ingredientID INT NOT NULL FOREIGN KEY REFERENCES Ingredient(ingredientID),
    category VARCHAR(16) NOT NULL CHECK (category IN ('exfoliant','antioxidant','humectant','texture enhancer','emollient','antibacterial')),
    PRIMARY KEY (ingredientID, category)
);
INSERT INTO IngredientCategory (ingredientID, category) VALUES
(1, 'exfoliant'),
(2, 'exfoliant'),
(3, 'exfoliant'),
(4, 'antioxidant'),
(5, 'antioxidant'),
(6, 'antioxidant'),
(6, 'humectant'),
(6, 'texture enhancer'),
(7, 'emollient'),
(8, 'exfoliant'),
(8, 'antioxidant'),
(9, 'exfoliant'),
(9, 'antioxidant'),
(10, 'antioxidant'),
(10, 'emollient'),
(11, 'antioxidant'),
(12, 'antioxidant'),
(13, 'exfoliant'),
(13, 'emollient'),
(14, 'antioxidant'),
(15, 'antibacterial'),
(16, 'humectant'),
(17, 'antioxidant'),
(18, 'exfoliant'),
(19, 'antioxidant'),
(20, 'texture enhancer'),
(21, 'exfoliant'),
(21, 'humectant');
