USE P3
GO

CREATE TABLE Ingredient (
    ingredientID INT IDENTITY(1,1) PRIMARY KEY,
    ingredientName VARCHAR(30) UNIQUE NOT NULL,
    ingredientUse VARCHAR(50) NOT NULL, 
    category INT FOREIGN KEY REFERENCES IngredientCategory(categoryID)
);

INSERT INTO Ingredient
    (ingredientName, ingredientUse, category)
VALUES
('BHA (salicyclic acid)','anti-acne, blackhead reducing, soothing',1),
-- Exfoliants
('AHA (Glycolic acid)', 'exfoliation, skin brightening', 1),
('Lactic Acid', 'exfoliation, hydration', 1),
('Mandelic Acid', 'exfoliation, acne treatment, anti-aging', 1);

-- Antioxidants
INSERT INTO Ingredient (ingredientName, ingredientUse, category) VALUES
('Vitamin C (Ascorbic Acid)', 'brightening, anti-aging, antioxidant', 2),
('Vitamin E (Tocopherol)', 'moisturizing, antioxidant', 2),
('Green Tea Extract', 'soothing, anti-inflammatory, antioxidant', 2);

-- Humectants
INSERT INTO Ingredient (ingredientName, ingredientUse, category) VALUES
('Hyaluronic Acid', 'hydration, plumping, humectant', 3),
('Glycerin', 'hydration, moisture retention, humectant', 3),
('Sodium PCA', 'moisturizing, humectant', 3);

-- Texture Enhancers
INSERT INTO Ingredient (ingredientName, ingredientUse, category) VALUES
('Silicone (Dimethicone)', 'smoothing, texture enhancer, occlusive', 4),
('Silica', 'oil control, texture enhancement', 4),
('Microcrystalline Cellulose', 'thickening agent, texture enhancement', 4);

-- Emollients
INSERT INTO Ingredient (ingredientName, ingredientUse, category) VALUES
('Shea Butter', 'moisturizing, softening, emollient', 5),
('Coconut Oil', 'moisturizing, barrier repair, emollient', 5),
('Squalane', 'hydrating, smoothing, emollient', 5);

-- Antibacterials
INSERT INTO Ingredient (ingredientName, ingredientUse, category) VALUES
('Tea Tree Oil', 'antibacterial, anti-acne, anti-inflammatory', 6),
('Benzoyl Peroxide', 'acne treatment, antibacterial', 6),
('Niacinamide', 'anti-inflammatory, sebum control, antibacterial', 6);
