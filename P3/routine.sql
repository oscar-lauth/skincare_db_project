Use P3
GO

CREATE TABLE Routine (
routineID  INT IDENTITY(1,1) PRIMARY KEY,
memberID INT FOREIGN KEY REFERENCES Member(memberID),
timeOfDay VARCHAR(5) NOT NULL CHECK(timeOfDay IN('day','night')),
summary VARCHAR(255) NOT NULL,
);

INSERT INTO Routine (memberID, timeOfDay, summary)
VALUES (1,'night','this is a basic routine');