-- Creating Database

CREATE DATABASE UniversityMedicalCentreHR

-- CREATING TABLES

USE HRUniversityMedicalCentre;
GO

-- Job table
CREATE TABLE Job (
    JobId INT IDENTITY(1,1) PRIMARY KEY,
    Position VARCHAR(255),
    Title VARCHAR(255),
    Type VARCHAR(50),
    Medium VARCHAR(50),
    NumberOfPositions INT
);

-- Job Openings table
CREATE TABLE JobOpenings (
    OpeningId INT IDENTITY(1,1) PRIMARY KEY,
    JobId INT,
    NumberOfPositions INT,
    FOREIGN KEY (JobId) REFERENCES Job(JobId)
);

-- Candidates table
CREATE TABLE Candidates (
    CandidateId INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(50),
    ShortProfile TEXT
);

-- Documents table
CREATE TABLE Documents (
    DocumentId INT IDENTITY(1,1) PRIMARY KEY,
    CandidateId INT,
    CVs VARCHAR(255),
    ReferenceLetters VARCHAR(255),
    CoverLetter VARCHAR(255),
    FOREIGN KEY (CandidateId) REFERENCES Candidates(CandidateId)
);

-- Application table
CREATE TABLE Application (
    ApplicationId INT IDENTITY(1,1) PRIMARY KEY,
    CandidateId INT,
    JobOpeningId INT,
    Status VARCHAR(50),
    FOREIGN KEY (CandidateId) REFERENCES Candidates(CandidateId),
    FOREIGN KEY (JobOpeningId) REFERENCES JobOpenings(OpeningId)
);

-- Interviewers table
CREATE TABLE Interviewers (
    InterviewerId INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(255),
    Department VARCHAR(100),
    Title VARCHAR(100)
);

-- Interviews table
CREATE TABLE Interviews (
    InterviewId INT IDENTITY(1,1) PRIMARY KEY,
    ApplicationId INT,
    InterviewType VARCHAR(50),
    StartTime DATETIME,
    EndTime DATETIME,
    InterviewerId INT,
    FOREIGN KEY (ApplicationId) REFERENCES Application(ApplicationId),
    FOREIGN KEY (InterviewerId) REFERENCES Interviewers(InterviewerId)
);

-- Tests table
CREATE TABLE Tests (
    TestId INT IDENTITY(1,1) PRIMARY KEY,
    ApplicationId INT,
    TestType VARCHAR(50),
    StartTime DATETIME,
    EndTime DATETIME,
    Result VARCHAR(10),
    FOREIGN KEY (ApplicationId) REFERENCES Application(ApplicationId)
);

-- Background Check table
CREATE TABLE BackgroundCheck (
    BackgroundCheckId INT IDENTITY(1,1) PRIMARY KEY,
    CandidateId INT,
    CriminalBackground VARCHAR(255),
    EmploymentHistory TEXT,
    Status VARCHAR(50),
    CheckDate DATE,
    FOREIGN KEY (CandidateId) REFERENCES Candidates(CandidateId)
);

-- Drug Test table
CREATE TABLE DrugTest (
    DrugTestId INT IDENTITY(1,1) PRIMARY KEY,
    CandidateId INT,
    TestType VARCHAR(50),
    TestDate DATE,
    Results VARCHAR(50),
    FOREIGN KEY (CandidateId) REFERENCES Candidates(CandidateId)
);

-- Evaluation table
CREATE TABLE Evaluation (
    EvaluationId INT IDENTITY(1,1) PRIMARY KEY,
    ApplicationId INT,
    EvaluationNotes TEXT,
    Result VARCHAR(50),
    FOREIGN KEY (ApplicationId) REFERENCES Application(ApplicationId)
);

-- Reimbursement table
CREATE TABLE Reimbursement (
    ReimbursementId INT IDENTITY(1,1) PRIMARY KEY,
    ApplicationId INT,
    RequestAmount DECIMAL(10, 2),
    ProcessedAmount DECIMAL(10, 2),
    Status VARCHAR(50),
    FOREIGN KEY (ApplicationId) REFERENCES Application(ApplicationId)
);

-- Onboarding table
CREATE TABLE Onboarding (
    OnboardingId INT IDENTITY(1,1) PRIMARY KEY,
    CandidateId INT,
    JobId INT,
    StartDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (CandidateId) REFERENCES Candidates(CandidateId),
    FOREIGN KEY (JobId) REFERENCES Job(JobId)
);

-- Application Status Log table
CREATE TABLE ApplicationStatusLog (
    LogId INT IDENTITY(1,1) PRIMARY KEY,
    ApplicationId INT NOT NULL,
    OldStatus VARCHAR(255) NOT NULL,
    NewStatus VARCHAR(255) NOT NULL,
    ChangeDate DATETIME NOT NULL,
    FOREIGN KEY (ApplicationId) REFERENCES Application(ApplicationId)
);