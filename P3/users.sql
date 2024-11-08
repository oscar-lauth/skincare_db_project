USE P3
GO
-- needed auto-inc pk bc email and username could be modified later and thus not good pks

CREATE TABLE Users (
    userID INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(255),
    username VARCHAR(100) UNIQUE NOT NULL,
    skinType VARCHAR(11) NOT NULL CHECK (skinType IN ('normal','oily','dry','combination','sensitive'))
);

INSERT INTO Users 
    (email, username, skinType)
VALUES
('christianpulisic10@gmail.com', 'pulipulisicsic', 'normal'),
('megan.lopez@yahoo.com', 'meggielopez', 'sensitive'),
('sarahking23@outlook.com', 'sarahking', 'dry'),
('john.wick@gmail.com', 'baba_yaga', 'oily'),
('samuelgarcia@outlook.com', 'samg_theman', 'combination'),
('emilybrown99@gmail.com', 'emilybee', 'normal'),
('lukewilson55@outlook.com', 'luke_the_wolf', 'oily'),
('janet.davis@hotmail.com', 'davis_janet', 'sensitive'),
('michael.jackson@outlook.com', 'moonwalker', 'dry'),
('davidgreen@hotmail.com', 'greendave', 'combination'),
('matthewsanders@gmail.com', 'sandersmatt', 'oily'),
('lisa.jones@outlook.com', 'lisaj', 'dry'),
('robert.smith@yahoo.com', 'robthesmith', 'normal'),
('danielp@outlook.com', 'danswift', 'combination'),
('sophiacollins@gmail.com', 'sophiec', 'sensitive'),
('james.taylor@yahoo.com', 'jammiet', 'oily'),
('madisonbaker@yahoo.com', 'madi_bakes', 'dry'),
('brandonking12@gmail.com', 'b_king', 'normal'),
('lindseywells@outlook.com', 'wellslin', 'combination'),
('charles.rivers@gmail.com', 'crivers', 'oily'),
('nathan.roberts@outlook.com', 'nathanthegreat', 'sensitive'),
('juliacarter@hotmail.com', 'julz', 'dry'),
('jacksonbrown@gmail.com', 'jbrown22', 'combination'),
('sophiadavis@gmail.com', 'davissoph', 'normal'),
('connorlee23@outlook.com', 'connorlion', 'oily'),
('elizabeth.richards@yahoo.com', 'bethy', 'dry'),
('andrew.james@gmail.com', 'aj_coder', 'combination'),
('danielgreen@gmail.com', 'greendan', 'normal'),
('hannah.rose@outlook.com', 'rosehanna', 'sensitive'),
('jacob.wilson@gmail.com', 'jw88', 'oily'),
('natalie.smith@yahoo.com', 'nsmithy', 'combination'),
('alexandermartin@outlook.com', 'alexm', 'dry'),
('victoria.adams@gmail.com', 'vicky', 'sensitive'),
('peter.clark@yahoo.com', 'peteyclark', 'normal'),
('melanie_bell@hotmail.com', 'melbells', 'combination'),
('josephwilliams@gmail.com', 'joewill', 'dry'),
('isabellamiller@outlook.com', 'bella', 'oily'),
('mark.hamilton@hotmail.com', 'hamilton_m', 'sensitive'),
('kyle.johnson@gmail.com', 'johnsonator', 'combination'),
('alyssajones@yahoo.com', 'alyjo', 'dry'),
('ethan.wood@gmail.com', 'ethanwood', 'normal'),
('caroline.morris@outlook.com', 'caromorris', 'oily'),
('dylan.white@gmail.com', 'dylan_thegreat', 'sensitive'),
('rachel.smith@hotmail.com', 'rsmooth', 'dry'),
('ryan.roberts@gmail.com', 'ry_rob', 'combination'),
('rebeccakim@outlook.com', 'kimrebecca', 'normal'),
('steven.brown@gmail.com', 'stevenator', 'oily'),
('julieburns@yahoo.com', 'julieburn', 'sensitive'),
('anthonyjones@gmail.com', 'aj_tony', 'combination'),
('emmawatson@hotmail.com', 'emma_luv', 'normal');
