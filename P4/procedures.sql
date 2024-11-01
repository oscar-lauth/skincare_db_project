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
	SET NOCOUNT ON
    INSERT INTO Reviews (routineID, userID, reviewText, publishDate, rating)
    VALUES (@RoutineID, @UserID, @ReviewText, GETDATE(), @Rating);
END;
GO

-- Useful for adding a routine to favorites
CREATE PROCEDURE AddRoutineToFavorites
    @UserID INT,
    @RoutineID INT
AS
BEGIN
	SET NOCOUNT ON
    IF NOT EXISTS (
        SELECT 1
        FROM Favorites
        WHERE userID = @UserID AND routineID = @RoutineID
    )
	BEGIN
		INSERT INTO Favorites (userID, routineID)
		VALUES (@UserID, @RoutineID);
	END
END;
GO


