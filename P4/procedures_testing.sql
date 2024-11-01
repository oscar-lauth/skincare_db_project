EXEC AddRoutineReview 
    @routineID = 4, 
    @userID = 25,
    @reviewText = 'Decent routine', 
    @rating = 3;

SELECT * FROM Reviews
ORDER BY routineID ASC


EXEC AddRoutineToFavorites
    @userID = 21,
    @routineID = 6;

SELECT * FROM Favorites
ORDER BY userID ASC


EXEC GetProductIngredients
    @ProductID = 10

SELECT * FROM Includes
ORDER BY ProductID ASC
