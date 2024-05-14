-- INSERTING DATA INTO THE TABLES

USE HRUniversityMedicalCentre
GO

-- Inserting into Job
INSERT INTO Job (Position, Title, Type, Medium, NumberOfPositions)
VALUES 
('Physician', 'General Practitioner', 'Full-time', 'Onsite', 5),
('Nurse', 'Registered Nurse', 'Part-time', 'Onsite', 8),
('Admin', 'Administrative Assistant', 'Full-time', 'Online', 2),
('Tech', 'Radiology Technologist', 'Full-time', 'Onsite', 3),
('Billing', 'Medical Biller', 'Contract', 'Online', 4);

-- Inserting into JobOpenings
INSERT INTO JobOpenings (JobId, NumberOfPositions)
SELECT JobId, NumberOfPositions FROM Job;

-- Inserting into Candidates
INSERT INTO Candidates (Name, Email, Phone, ShortProfile)
VALUES 
('John Doe', 'johndoe@example.com', '555-1234', 'Experienced GP with 10 years in a clinical setting.'),
('Jane Smith', 'janesmith@example.com', '555-5678', 'Registered nurse specializing in pediatric care.'),
('Alice Johnson', 'alicej@example.com', '555-8765', 'Skilled in hospital administration and patient scheduling.'),
('Bob Brown', 'bobbrown@example.com', '555-4321', 'Expert in radiological technology with a focus on MRI procedures.'),
('Carol White', 'carolwhite@example.com', '555-6789', 'Dedicated medical biller with over 5 years of experience.');

-- Inserting into Documents
INSERT INTO Documents (CandidateId, CVs, ReferenceLetters, CoverLetter)
VALUES 
(1, 'cv_johndoe.pdf', 'ref_johndoe.pdf', 'cover_johndoe.pdf'),
(2, 'cv_janesmith.pdf', 'ref_janesmith.pdf', 'cover_janesmith.pdf'),
(3, 'cv_alicej.pdf', 'ref_alicej.pdf', 'cover_alicej.pdf'),
(4, 'cv_bobbrown.pdf', 'ref_bobbrown.pdf', 'cover_bobbrown.pdf'),
(5, 'cv_carolwhite.pdf', 'ref_carolwhite.pdf', 'cover_carolwhite.pdf');

-- Inserting into Application
INSERT INTO Application (CandidateId, JobOpeningId, Status)
VALUES 
(1, 1, 'Applied'),
(2, 2, 'Interviewing'),
(3, 3, 'Offer Extended'),
(4, 4, 'Waiting'),
(5, 5, 'Rejected');

-- Inserting into Interviewers
INSERT INTO Interviewers (Name, Department, Title)
VALUES
('Dr. Emily Stone', 'Medical', 'Senior Physician'),
('Mr. Mark Benson', 'Nursing', 'Nursing Supervisor'),
('Ms. Linda Woolf', 'Administration', 'HR Manager'),
('Mr. Alex Turner', 'Technical', 'Senior Radiologist'),
('Ms. Rachel Green', 'Finance', 'Billing Manager');

-- Inserting into Interviews
INSERT INTO Interviews (ApplicationId, InterviewType, StartTime, EndTime, InterviewerId)
VALUES
(1, 'Onsite', '2023-10-10 09:00:00', '2023-10-10 10:00:00', 1),
(2, 'Online', '2023-10-11 11:00:00', '2023-10-11 12:00:00', 2),
(3, 'Onsite', '2023-10-12 14:00:00', '2023-10-12 15:30:00', 3),
(4, 'Online', '2023-10-13 16:00:00', '2023-10-13 17:00:00', 4),
(5, 'Onsite', '2023-10-14 10:00:00', '2023-10-14 11:00:00', 5);

-- Inserting into Tests
INSERT INTO Tests (ApplicationId, TestType, StartTime, EndTime, Result)
VALUES
(1, 'Skills Assessment', '2023-10-10 11:00:00', '2023-10-10 12:00:00', 'Passed'),
(2, 'Personality Test', '2023-10-11 13:00:00', '2023-10-11 14:00:00', 'Failed'),
(3, 'Technical Evaluation', '2023-10-12 15:00:00', '2023-10-12 16:30:00', 'Passed'),
(4, 'Compliance Test', '2023-10-13 17:00:00', '2023-10-13 18:00:00', 'Failed'),
(5, 'Skills Assessment', '2023-10-14 12:00:00', '2023-10-14 13:00:00', 'Passed');

-- Inserting into BackgroundCheck
INSERT INTO BackgroundCheck (CandidateId, CriminalBackground, EmploymentHistory, Status, CheckDate)
VALUES
(1, 'None', '10 years at City Hospital', 'Cleared', '2023-10-05'),
(2, 'None', '5 years at County Health Clinic', 'Cleared', '2023-10-06'),
(3, 'None', '7 years at Downtown Medical', 'Pending', '2023-10-07'),
(4, 'Minor Traffic Violation', '8 years at Regional Healthcare', 'Cleared', '2023-10-08'),
(5, 'None', '6 years at General Hospital', 'Cleared', '2023-10-09');

-- Inserting into DrugTest
INSERT INTO DrugTest (CandidateId, TestType, TestDate, Results)
VALUES
(1, 'Urine Test', '2023-10-15', 'Negative'),
(2, 'Urine Test', '2023-10-16', 'Negative'),
(3, 'Blood Test', '2023-10-17', 'Positive'),
(4, 'Urine Test', '2023-10-18', 'Negative'),
(5, 'Blood Test', '2023-10-19', 'Negative');

-- Inserting into Evaluation
INSERT INTO Evaluation (ApplicationId, EvaluationNotes, Result)
VALUES
(1, 'Excellent fit for the role, highly experienced.', 'Passed'),
(2, 'Lacks required certifications.', 'Failed'),
(3, 'Great organizational skills, needs more technical training.', 'Passed'),
(4, 'Outstanding technical skills, but poor teamwork.', 'Failed'),
(5, 'Meets all qualifications and has good references.', 'Passed');

-- Inserting into Reimbursement
INSERT INTO Reimbursement (ApplicationId, RequestAmount, ProcessedAmount, Status)
VALUES
(1, 200.00, 200.00, 'Processed'),
(2, 150.00, 150.00, 'Processed'),
(3, 180.00, 0.00, 'Pending'),
(4, 300.00, 300.00, 'Processed'),
(5, 250.00, 250.00, 'Processed');

-- Inserting into Onboarding
INSERT INTO Onboarding (CandidateId, JobId, StartDate, Status)
VALUES
(1, 1, '2023-11-01', 'Completed'),
(2, 2, '2023-11-02', 'Failed'),
(3, 3, '2023-11-03', 'In Process'),
(4, 4, '2023-11-04', 'Completed'),
(5, 5, '2023-11-05', 'Completed');

-- Inserting into ApplicationStatusLog
INSERT INTO ApplicationStatusLog (ApplicationId, OldStatus, NewStatus, ChangeDate)
VALUES
(1, 'Interviewing', 'Offer Extended', GETDATE()),
(2, 'Interviewing', 'Rejected', GETDATE()),
(3, 'Interviewing', 'Offer Extended', GETDATE()),
(4, 'Interviewing', 'Hired', GETDATE()),
(5, 'Interviewing', 'Waiting', GETDATE());


