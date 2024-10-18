USE P3
GO

CREATE TABLE Ingredient (
    ingredientID INT IDENTITY(1,1) PRIMARY KEY,
    ingredientName VARCHAR(30) UNIQUE NOT NULL,
    ingredientUse VARCHAR(100) NOT NULL, 
);

INSERT INTO Ingredient (ingredientName, ingredientUse) VALUES
    ('BHA (salicylic acid)', 'Anti-acne, blackhead reducing, soothing'),
    ('AHA', 'Anti-aging, dark spot fading, evens skin tone, hydration'),
    ('PHA', 'Anti-aging, evens skin tone, smooths bumpy skin'),
    ('Niacinamide (vitamin B3)', 'Anti-aging, pore minimizer, soothing'),
    ('Vitamin C', 'Anti-aging, evens skin tone, dark spot fading'),
    ('Vitamin A (retinol)', 'Anti-aging, anti-acne, pore minimizer'),
    ('Hyaluronic Acid', 'Anti-aging, hydration'),
    ('Ceramides', 'Anti-aging, hydration'),
    ('Azelaic Acid', 'Anti-acne, dark spot fading, smooths bumpy skin, pH stablizer'),
    ('Squalane', 'Anti-aging, hydration'),
    ('Snail Mucin', 'Anti-aging, hydration, collagen stimulator'),
    ('Licorice Extract', 'Dark spot fading, anti-aging, soothing'),
    ('Urea', 'Hydration, smooths bumpy skin, evens skin tone, pH stablizer'),
    ('Arbutin', 'Dark spot fading, soothing, anti-aging'),
    ('Benzoyl Peroxide', 'Anti-acne, smooths bumpy skin'),
    ('Aloe Vera', 'Hydration, soothing'),
    ('Kojic Acid', 'Dark spot fading, evens skin tone, anti-aging'),
    ('Sulfur', 'Anti-acne'),
    ('Tea Tree Oil', 'Anti-acne'),
    ('Clay (kaolin)', 'Absorbent, removes excess oil'),
    ('Allantoin', 'Soothing, moisturizing'),
    ('Colloidal Oatmeal', 'Soothing, anti-inflammatory'),
    ('Zinc Oxide', ''),
    ('Titanium Dioxide', ''),
    ('Avobenzone', ''),
    ('Homosalate', ''),
    ('Octocrylene', ''),
    ('Glycerin', ''),
    ('tocopheryl acetate', ''),
    ('Mineral Oil', ''),
    ('Micelles', '');
