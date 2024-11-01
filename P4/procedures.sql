USE P3
GO

-- Useful for retrieving all conflicts associated with a specific ingredient
CREATE PROCEDURE GetConflictsForIngredient
  @ingredientID INT
AS
BEGIN
  SELECT ingredientID1, ingredientID2
  FROM ConflictsWith
  WHERE ingredientID1 = @ingredientID
     OR ingredientID2 = @ingredientID;
END;
GO