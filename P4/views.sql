CREATE VIEW UserInfoView AS
SELECT 
    userID,
    email,
    username,
    skinType
FROM 
    Users;
GO

CREATE VIEW DayRoutineView AS
SELECT 
    routineID,
    userID,
    timeOfDay,
    summary
FROM 
    Routine
WHERE
    timeOfDay = 'day';
GO

CREATE VIEW NightRoutineView AS
SELECT 
    routineID,
    userID,
    timeOfDay,
    summary
FROM 
    Routine
WHERE
    timeOfDay = 'night';
GO
