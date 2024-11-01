USE P3
GO

-- Useful for adding reviews to routines while ensuring no user can review a routine twice
CREATE PROCEDURE AddRoutineReview
    @RoutineID INT,
    @UserID INT,
    @ReviewText VARCHAR(255),
    @Rating INT
AS
BEGIN
	SET NOCOUNT ON
	IF NOT EXISTS (
        SELECT 1
        FROM Reviews
        WHERE userID = @UserID AND routineID = @RoutineID
    )
	BEGIN
		INSERT INTO Reviews (routineID, userID, reviewText, publishDate, rating)
		VALUES (@RoutineID, @UserID, @ReviewText, GETDATE(), @Rating);
	END
	ELSE -- If review already exists, update it
	BEGIN
        UPDATE Reviews
        SET reviewText = @ReviewText,
            publishDate = GETDATE(),
            rating = @Rating
        WHERE userID = @UserID AND routineID = @RoutineID;
	END
END;
GO

-- Useful for adding a routine to favorites while ensuring no user can favorite a routine twice
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

-- Useful for getting the ingredients in a product
CREATE PROCEDURE GetProductIngredients
    @ProductID INT
AS
BEGIN
	SET NOCOUNT ON
    SELECT i.ingredientID, i.ingredientName, i.ingredientUse
    FROM Includes inc
    INNER JOIN Ingredient i ON inc.ingredientID = i.ingredientID
    WHERE inc.productID = @ProductID;
END;
GO
