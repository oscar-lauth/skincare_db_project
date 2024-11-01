EXEC AddRoutineReview 
    @routineID = 4, 
    @userID = 26,
    @reviewText = 'Garbage', 
    @rating = 1;

SELECT * FROM Reviews
ORDER BY publishDate DESC


EXEC AddRoutineToFavorites
    @userID = 21,
    @routineID = 6;

SELECT * FROM Favorites
ORDER BY userID ASC