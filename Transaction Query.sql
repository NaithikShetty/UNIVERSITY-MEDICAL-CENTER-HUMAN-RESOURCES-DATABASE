-- Transaction 1: Process Candidate Reimbursement
-- Process a reimbursement request for a candidate after verifying expense claims.

BEGIN TRANSACTION;

-- Verify the total requested amount is within the allowed limit
DECLARE @RequestedAmount DECIMAL(10,2);
SELECT @RequestedAmount = RequestAmount FROM Reimbursement WHERE ReimbursementId = 7;

IF @RequestedAmount <= 500.00 -- Assuming $500 is the limit
BEGIN
    -- Update reimbursement to 'Processed'
    UPDATE Reimbursement
    SET Status = 'Processed', ProcessedAmount = @RequestedAmount
    WHERE ReimbursementId = 7;

    COMMIT TRANSACTION;
END
ELSE
BEGIN
    RAISERROR ('Requested amount exceeds the allowable limit.', 16, 1);
    ROLLBACK TRANSACTION;
END

--Transaction 2: Updating Candidate Status After Interview
--This transaction updates a candidate’s application status after an interview and logs the change for auditing purposes.


BEGIN TRANSACTION

-- Update application status
UPDATE Application
SET Status = 'Offer Extended'
WHERE ApplicationId = 1;

-- Log status change
INSERT INTO ApplicationStatusLog (ApplicationId, OldStatus, NewStatus, ChangeDate)
VALUES (1, 'Interviewing', 'Offer Extended', GETDATE());

COMMIT TRANSACTION;

-- Transaction 3: Candidate Rejection and Feedback Entry
-- Reject a candidate after an interview and record feedback from the interviewer.

BEGIN TRANSACTION;

-- Update candidate's status to 'Rejected'
UPDATE Application
SET Status = 'Rejected'
WHERE ApplicationId = @ApplicationId;

-- Insert interview feedback
INSERT INTO Evaluation (ApplicationId, EvaluationNotes, Result)
VALUES (@ApplicationId, @Feedback, 'Rejected');

COMMIT TRANSACTION;

Select * From Application where ApplicationId = 10;
Select * From Evaluation;

-- Transaction 4: Hiring a Candidate
-- Successfully move a candidate from the interviewing phase to hired status and update the number of job openings

DECLARE @ApplicationId INT = 11;  -- Example application ID
DECLARE @JobId INT;  -- To store Job ID associated with the application

BEGIN TRANSACTION;

-- Retrieve Job ID for the application
SELECT @JobId = JobOpeningId FROM Application WHERE ApplicationId = @ApplicationId;

-- Update the candidate's status to 'Hired'
UPDATE Application
SET Status = 'Hired'
WHERE ApplicationId = @ApplicationId AND Status = 'Interviewed';

-- Check if the status update was successful
IF @@ROWCOUNT = 0
BEGIN
    RAISERROR ('Update failed, either no such application or status is not "Interviewed"', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
END

-- Decrease the number of positions available for the job
UPDATE JobOpenings
SET NumberOfPositions = NumberOfPositions - 1
WHERE JobId = @JobId AND NumberOfPositions > 0;

-- Check if update was successful
IF @@ROWCOUNT = 0
BEGIN
    RAISERROR ('No open positions available or Job ID not found', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
END

COMMIT TRANSACTION;



