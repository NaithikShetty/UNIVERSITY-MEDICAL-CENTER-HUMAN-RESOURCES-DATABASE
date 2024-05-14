-- DatabaseAdmin User:

CREATE ROLE DatabaseAdmin1; 
GO 
GRANT CONTROL ON DATABASE::HRUniversityMedicalCentre TO DatabaseAdmin1; 
GO

CREATE LOGIN DatabaseAdminUser WITH PASSWORD = 'AdminPass123*'; 
GO 
USE HRUniversityMedicalCentre; 
GO 
CREATE USER DatabaseAdminUser FOR LOGIN DatabaseAdminUser; 
GO 
ALTER ROLE DatabaseAdmin1 ADD MEMBER DatabaseAdminUser;


-- ReadOnly User:

CREATE ROLE ReadOnly; 
GO 
GRANT SELECT ON SCHEMA::dbo TO ReadOnly; 
GO

CREATE LOGIN ReadOnlyUser WITH PASSWORD = 'ReadOnlyPass123*'; 
GO 
CREATE USER ReadOnlyUser FOR LOGIN ReadOnlyUser; 
GO 
EXEC sp_addrolemember 'db_datareader', 'ReadOnlyUser'; 
GO

-- DataEditor User:

USE HRUniversityMedicalCentre; 
GO 
CREATE ROLE DataEditor2; 
GO 
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO DataEditor2; 
GO

CREATE LOGIN DataEditorUser WITH PASSWORD = 'DataEditorPass123*'; 
GO 
USE HRUniversityMedicalCentre; 
GO 
CREATE USER DataEditorUser FOR LOGIN DataEditorUser; 
GO 
ALTER ROLE DataEditor2 ADD MEMBER DataEditorUser; 
GO

-- DataEntry User:

CREATE ROLE DataEntry; 
GO 
GRANT SELECT, INSERT, UPDATE ON SCHEMA::dbo TO DataEntry; 
GO

CREATE LOGIN DataEntryUser WITH PASSWORD = 'DataEntryPass123*'; 
GO 
USE HRUniversityMedicalCentre; 
GO 
CREATE USER DataEntryUser FOR LOGIN DataEntryUser; 
GO 
ALTER ROLE DataEntry ADD MEMBER DataEntryUser; 
GO

