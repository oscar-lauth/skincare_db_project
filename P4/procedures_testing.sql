EXEC AddRoutineReview 
    @routineID = 16, 
    @userID = 5,
    @reviewText = 'Great product for daily use!', 
    @rating = 5;

SELECT * FROM Reviews
ORDER BY publishDate DESC
