-- Report 1: Candidate Pipeline Report
-- Provides a detailed report of the candidate pipeline stages.

CREATE PROCEDURE sp_GetCandidatePipeline
AS
BEGIN
    SELECT 
        Status,
        COUNT(*) AS NumberOfCandidates
    FROM 
        Application
    GROUP BY 
        Status;
END;

EXEC sp_GetCandidatePipeline;

-- Report 2: Interviewer Performance Analysis
-- Analyzes the outcome of interviews conducted by each interviewer, including pass/fail rates and average interview duration.

CREATE PROCEDURE Report_InterviewerPerformance
AS
BEGIN
    SELECT 
        i.Name AS Interviewer,
        COUNT(t.TestId) AS TotalInterviews,
        AVG(DATEDIFF(minute, iv.StartTime, iv.EndTime)) AS AverageDuration,
        SUM(CASE WHEN t.Result = 'Passed' THEN 1 ELSE 0 END) * 100.0 / COUNT(t.TestId) AS PassRate
    FROM 
        Interviewers i
        JOIN Interviews iv ON i.InterviewerId = iv.InterviewerId
        JOIN Tests t ON iv.ApplicationId = t.ApplicationId
    GROUP BY 
        i.Name;
END;

EXEC Report_InterviewerPerformance;

-- Report 3: Offers vs. Acceptances Report
-- Compares the number of offers made to the number of acceptances to measure the success rate of job offers.

CREATE PROCEDURE Report_OffersVsAcceptances
AS
BEGIN
    SELECT 
        YEAR(a.ApplicationDate) AS Year,
        COUNT(DISTINCT CASE WHEN a.Status = 'Offer Extended' THEN a.ApplicationId END) AS OffersMade,
        COUNT(DISTINCT CASE WHEN a.Status = 'Accepted' THEN a.ApplicationId END) AS OffersAccepted
    FROM 
        Application a
    GROUP BY 
        YEAR(a.ApplicationDate)
    ORDER BY 
        Year;
END;

EXEC Report_OffersVsAcceptances;

-- Report 4: Yearly Recruitment Comparison Report 
-- This report shows the number of candidates applied, interviewed, and hired each year, giving insights into the efficiency and changes in the recruitment process.

CREATE PROCEDURE ReportYearlyRecruitmentComparison
AS
BEGIN
    WITH YearlyData AS (
        SELECT 
            YEAR(a.ApplicationDate) AS Year,
            a.Status,
            COUNT(*) AS Total
        FROM 
            Application a
        GROUP BY 
            YEAR(a.ApplicationDate),
            a.Status
    )
    SELECT 
        Year,
        SUM(CASE WHEN Status = 'Applied' THEN Total ELSE 0 END) AS Applied,
        SUM(CASE WHEN Status LIKE '%interviewed%' THEN Total ELSE 0 END) AS Interviewed,
        SUM(CASE WHEN Status = 'Accepted' THEN Total ELSE 0 END) AS Hired,
		SUM(CASE WHEN Status = 'Offer Extended' THEN Total Else 0 End) As Offered
    FROM 
        YearlyData
    GROUP BY 
        Year
    ORDER BY 
        Year;
END;

EXEC ReportYearlyRecruitmentComparison;