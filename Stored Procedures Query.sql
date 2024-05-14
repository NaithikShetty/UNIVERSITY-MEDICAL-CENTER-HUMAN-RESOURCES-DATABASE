-- STORED PROCEDURES
-- Stored Procedure 1: Insert New Candidate


CREATE PROCEDURE sp_InsertNewCandidate
    @Name VARCHAR(255),
    @Email VARCHAR(255),
    @Phone VARCHAR(50),
    @ShortProfile TEXT
AS
BEGIN
    INSERT INTO Candidates (Name, Email, Phone, ShortProfile)
    VALUES (@Name, @Email, @Phone, @ShortProfile);
END;
GO


EXEC sp_InsertNewCandidate 
    @Name = 'Mihika Gavali', 
    @Email = 'mihika@gmail.com', 
    @Phone = '123-456-7890', 
    @ShortProfile = 'Experienced project manager';


Select * From Candidates;

-- Stored Procedure 2: Apply for Job 
-- SQL stored procedure that enables candidates to apply for job openings at your company by inserting new entries into the Application table. This procedure will also check if there are open positions available in the JobOpenings table before proceeding with the application. If a position is available, it will update the number of open positions.

CREATE PROCEDURE ApplyForJob
    @CandidateId INT,
    @JobOpeningId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if there are open positions available for the job opening
    DECLARE @OpenPositions INT;
    SELECT @OpenPositions = NumberOfPositions FROM JobOpenings WHERE OpeningId = @JobOpeningId;

    IF @OpenPositions > 0
    BEGIN
        -- Insert application record
        INSERT INTO Application (CandidateId, JobOpeningId, Status)
        VALUES (@CandidateId, @JobOpeningId, 'Applied');

        -- Update the number of open positions
        UPDATE JobOpenings
        SET NumberOfPositions = NumberOfPositions - 1
        WHERE OpeningId = @JobOpeningId;

        -- Confirm application
        SELECT 'Application successful.' AS Message;
    END
    ELSE
    BEGIN
        -- Inform the user that there are no open positions
        SELECT 'No open positions available for this job opening.' AS Message;
    END
END;
GO

-- Stored Procedure 3: Update Application Status
-- Updates the status of an application.

CREATE PROCEDURE UpdateApplicationStatus
    @ApplicationId INT,
    @NewStatus VARCHAR(50)
AS
BEGIN
    UPDATE Application
    SET Status = @NewStatus
    WHERE ApplicationId = @ApplicationId;
END;
GO

EXEC UpdateApplicationStatus 1, 'Interviewed';

-- Stored Procedure 4: Schedule Interview
-- Schedules an interview for a candidate.

CREATE PROCEDURE ScheduleInterview
    @ApplicationId INT,
    @InterviewType VARCHAR(50),
    @StartTime DATETIME,
    @EndTime DATETIME,
    @InterviewerId INT
AS
BEGIN
    INSERT INTO Interviews (ApplicationId, InterviewType, StartTime, EndTime, InterviewerId)
    VALUES (@ApplicationId, @InterviewType, @StartTime, @EndTime, @InterviewerId);
END;
GO

EXEC ScheduleInterview 5, 'Onsite', '2023-12-01 10:00:00', '2023-12-01 11:00:00', 1;
Select * From Interviews

-- Stored Procedure 5: Complete Onboarding
-- Completes the onboarding process for a new hire

CREATE PROCEDURE CompleteOnboarding
    @CandidateId INT,
    @JobId INT,
    @StartDate DATE,
    @Status VARCHAR(50)
AS
BEGIN
    INSERT INTO Onboarding (CandidateId, JobId, StartDate, Status)
    VALUES (@CandidateId, @JobId, @StartDate, @Status);
END;
GO

EXEC CompleteOnboarding 3, 3, '2024-01-10', 'Completed';

