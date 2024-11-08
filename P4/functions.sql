USE P3
GO

-- #1. Function to check if two skincare products conflict with each other (ie contain conflicting ingredients)
-- will be useful as one of apps core function is building skincare routines with skincare products that don't clash

CREATE FUNCTION dbo.ProductsHaveConflictingIngredients (
    @productID1 INT,
    @productID2 INT
) 
RETURNS BIT
AS
BEGIN
    DECLARE @conflict BIT = 0;

    IF EXISTS (
        SELECT 1
        FROM Includes AS inc1
        INNER JOIN Includes AS inc2
            ON inc1.productID = @productID1
            AND inc2.productID = @productID2
        INNER JOIN ConflictsWith AS cw
            ON (cw.ingredientID1 = inc1.ingredientID AND cw.ingredientID2 = inc2.ingredientID)
            OR (cw.ingredientID1 = inc2.ingredientID AND cw.ingredientID2 = inc1.ingredientID)
    )
    BEGIN
        SET @conflict = 1;
    END

    RETURN @conflict;
END;

GO
-- #2. Function to get average rating of reviews of a given skincare routine
-- will be useful in displaying to users how well liked/disliked a routine they're browsing is rated by other users

CREATE FUNCTION dbo.GetAverageRoutineRating (
    @routineID INT
)
RETURNS DECIMAL(4,2) AS 
BEGIN
    DECLARE @AverageRating DECIMAL(4,2);
        SELECT @AverageRating = AVG(CAST(rating AS DECIMAL(4,2)))
            FROM Reviews r
            WHERE r.routineID = @routineID;
    RETURN ISNULL(@AverageRating,0.00);
END
GO


-- #3. Function to get all routines favorited by a given user
-- will be useful in dynamically listing/displaying all the routines a user has favorited in the app
CREATE FUNCTION dbo.GetUserFavoriteRoutines (
    @userID INT
)
RETURNS TABLE
AS
RETURN (
    SELECT r.routineID, r.timeOfDay, r.summary
    FROM Routine r INNER JOIN Favorites f ON r.routineID = f.routineID
    WHERE f.userID = @userID
);
