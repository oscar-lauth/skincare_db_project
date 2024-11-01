USE P3
GO

-- Useful for adding reviews to routines
CREATE PROCEDURE AddRoutineReview
    @RoutineID INT,
    @UserID INT,
    @ReviewText VARCHAR(255),
    @Rating INT
AS
BEGIN
    INSERT INTO Reviews (routineID, userID, reviewText, publishDate, rating)
    VALUES (@RoutineID, @UserID, @ReviewText, GETDATE(), @Rating);
END;





EXEC AddRoutineReview 
    @routineID = 16, 
    @userID = 5,
    @reviewText = 'Great product for daily use!', 
    @rating = 5;

SELECT * FROM Reviews
ORDER BY publishDate DESC
