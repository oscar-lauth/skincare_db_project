USE P3;
GO
-- Product with id 4 contains ingredient AHA which conflicts with ingredient Vitamin A which is in product id 25
-- so should return 1 (yes conflicting)
SELECT dbo.ProductsHaveConflictingIngredients(4,25) AS ProductsHaveConflictingIngredients;

-- routine with id 21 has ratings 5,5,5,5,4 --> avg rating of 4.8
SELECT dbo.GetAverageRoutineRating(21) AS AverageRoutineRating;

-- returns all 3 routines user with id 17 has favorited
SELECT * FROM dbo.GetUserFavoriteRoutines(17);


