-- Trigger 1: Auto Update Job Openings On Hire

CREATE TRIGGER AutoUpdateJobOpeningsOnHire
ON Application
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted i WHERE i.Status = 'Hired')
    BEGIN
        UPDATE JobOpenings
        SET NumberOfPositions = NumberOfPositions - 1
        WHERE JobId IN (SELECT JobId FROM inserted WHERE Status = 'Hired');
    END
END;

-- Trigger 2: Auto Update Job Openings On Rejection

CREATE TRIGGER AutoUpdateJobOpeningsOnRejection
ON Application
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted i WHERE i.Status = 'Declined')
    BEGIN
        UPDATE JobOpenings
        SET NumberOfPositions = NumberOfPositions + 1
        WHERE JobId IN (SELECT JobId FROM inserted WHERE Status = 'Declined');
    END
END;

-- Trigger 3: Log Status Change 

CREATE TRIGGER LogStatusChange
ON Application
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Status)
    BEGIN
        INSERT INTO ApplicationStatusLog (ApplicationId, OldStatus, NewStatus, ChangeDate)
        SELECT i.ApplicationId, d.Status, i.Status, GETDATE()
        FROM inserted i
        JOIN deleted d ON i.ApplicationId = d.ApplicationId;
    END
END;

-- Trigger 4: Check Candidate Age

CREATE TRIGGER CheckCandidateAge
ON Candidates
INSTEAD OF INSERT, UPDATE
AS
BEGIN
-- Check if any inserted/updated birthdates result in an age less than 18
    IF EXISTS (
        SELECT 1 FROM inserted
        WHERE DATEDIFF(year, BirthDate, GETDATE()) < 18
    )
    BEGIN
        RAISERROR('Candidates must be at least 18 years old.', 16, 1);
    END
    ELSE
    BEGIN
-- If all candidates are 18 or older, proceed with the insert or update
-- For INSERT
        INSERT INTO Candidates (Name, Email, Phone, ShortProfile, BirthDate)
        SELECT Name, Email, Phone, ShortProfile, BirthDate
        FROM inserted
        WHERE NOT EXISTS (SELECT 1 FROM deleted);

        -- For UPDATE
        UPDATE C
        SET 
            C.Name = I.Name,
            C.Email = I.Email,
            C.Phone = I.Phone,
            C.ShortProfile = I.ShortProfile,
            C.BirthDate = I.BirthDate
        FROM Candidates C
        JOIN inserted I ON C.CandidateId = I.CandidateId
        WHERE EXISTS (SELECT 1 FROM deleted);
    END
END;



