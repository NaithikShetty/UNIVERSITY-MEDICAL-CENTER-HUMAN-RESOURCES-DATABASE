-- View 1: Candidates with Applications Summary
-- This view provides a comprehensive overview of candidates and their application statuses.

CREATE VIEW CandidatesWithApplications AS
SELECT c.CandidateId, c.Name, c.Email, a.ApplicationId, a.Status
FROM Candidates c
JOIN Application a ON c.CandidateId = a.CandidateId;

-- View 2: Job Opening Details
-- This view combines job details with job opening information.

CREATE VIEW JobOpeningDetails AS
SELECT j.JobId, j.Title, j.Type, j.Medium, jo.NumberOfPositions
FROM Job j
JOIN JobOpenings jo ON j.JobId = jo.JobId;

-- View 3: Interview Schedule Summary
-- This view lists all interviews with associated job and candidate details.
CREATE VIEW InterviewSchedule AS
SELECT 
    i.InterviewId, 
    i.StartTime, 
    i.EndTime, 
    j.Title, 
    c.Name
FROM 
    Interviews i
INNER JOIN 
    Application a ON i.ApplicationId = a.ApplicationId
INNER JOIN 
    Candidates c ON a.CandidateId = c.CandidateId
INNER JOIN 
    Job j ON a.JobOpeningId = j.JobId;

-- View 4: Candidate Evaluation Results
-- Shows evaluations linked to each candidate and application

CREATE VIEW CandidateEvaluationResults AS
SELECT e.EvaluationId, c.Name, a.ApplicationId, e.EvaluationNotes, e.Result
FROM Evaluation e
JOIN Application a ON e.ApplicationId = a.ApplicationId
JOIN Candidates c ON a.CandidateId = c.CandidateId;

