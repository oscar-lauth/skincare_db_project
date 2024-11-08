USE P3;

-- CREATE TABLE Users (
--     userID INT IDENTITY(1,1) PRIMARY KEY,
--     email VARCHAR(255) UNIQUE NOT NULL,
--     username VARCHAR(100) UNIQUE NOT NULL,
--     skinType VARCHAR(11) NOT NULL CHECK (skinType IN ('normal','oily','dry','combination','sensitive'))
-- );

-- Note: this should ideally be stored in an environment variable
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'g@6LeH8hxdYS*uiISkXd';

CREATE CERTIFICATE UserCert
WITH SUBJECT = 'Certificate for User Email Encryption';

CREATE SYMMETRIC KEY UserKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE UserCert;

ALTER TABLE Users
ADD encryptedEmail VARBINARY(384);
GO

OPEN SYMMETRIC KEY UserKey
DECRYPTION BY CERTIFICATE UserCert;
SELECT name FROM sys.symmetric_keys

UPDATE Users
SET encryptedEmail = EncryptByKey(Key_GUID('UserKey'), email);

SELECT 
    userID, 
    username,
    skinType,
    CONVERT(VARCHAR(255), DecryptByKey(encryptedEmail)) AS email
FROM Users;

SELECT
    encryptedEmail
FROM Users;

ALTER TABLE Users
DROP COLUMN email;

CLOSE SYMMETRIC KEY UserKey;