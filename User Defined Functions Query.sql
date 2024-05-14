-- USER DEFINED FUNCTIONS

-- Function 1: Calculate Years Of Experience
-- This function calculates the years of experience based on the given start date of the employment. It's useful for evaluating candidate qualifications.

CREATE FUNCTION CalculateYearsOfExperience (@StartDate DATE)
RETURNS INT
AS
BEGIN
    DECLARE @YearsOfExperience INT;
    SET @YearsOfExperience = DATEDIFF(YEAR, @StartDate, GETDATE());
    RETURN @YearsOfExperience;
END;

-- Function 2: Get Job Opening Status 
-- This function checks the number of positions left for a job and returns 'Open' if there are positions available or 'Closed' if there are none.

IF OBJECT_ID('dbo.GetJobOpeningStatus', 'FN') IS NOT NULL
    DROP FUNCTION dbo.GetJobOpeningStatus;
GO

CREATE FUNCTION dbo.GetJobOpeningStatus (@JobId INT)
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @Positions INT;
    DECLARE @Status VARCHAR(10);

    -- Retrieve the number of positions, ensuring no NULLs are processed
    SELECT @Positions = ISNULL((SELECT NumberOfPositions FROM JobOpenings WHERE OpeningId = @JobId), 0);

    -- Decide the return based on the number of positions
    IF @Positions > 0
        SET @Status = 'Open';
    ELSE
        SET @Status = 'Closed';

    RETURN @Status;
END;
GO

-- Function 3: Get Candidate Email
-- This function retrieves the email address of a candidate given their Candidate ID. It's useful for contact management systems within the HR module

CREATE FUNCTION GetCandidateEmail (@CandidateId INT)
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @Email VARCHAR(255);
    SELECT @Email = Email FROM Candidates WHERE CandidateId = @CandidateId;
    RETURN @Email;
END;

-- Function 4: Check Reimbursement Eligibility
-- This function determines whether a candidate is eligible for reimbursement based on the costs they have submitted and a predefined threshold.

CREATE FUNCTION CheckReimbursementEligibility (@ApplicationId INT, @Threshold DECIMAL(10,2))
RETURNS VARCHAR(15)
AS
BEGIN
    DECLARE @RequestedAmount DECIMAL(10,2);

    -- Initialize @RequestedAmount to avoid uninitialized variable use
    SELECT @RequestedAmount = ISNULL(RequestAmount, 0) FROM Reimbursement WHERE ApplicationId = @ApplicationId;

    IF @RequestedAmount > @Threshold
        RETURN 'Eligible'
    ELSE
        RETURN 'Not Eligible'

    -- Fail-safe return in case none of the above conditions are met (should not be necessary but included for completeness)
    RETURN 'Not Eligible'
END;

