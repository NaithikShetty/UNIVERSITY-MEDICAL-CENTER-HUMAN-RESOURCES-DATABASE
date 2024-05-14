# UNIVERSITY-MEDICAL-CENTER-HUMAN-RESOURCES-DATABASE

## Introduction

This project aims to develop a comprehensive Human Resources (HR) database for the University Medical Center, designed to manage and streamline the recruitment and HR processes within a medical university setting. The database handles various HR activities, such as job postings, candidate applications, interviews, background checks, onboarding, and more, while ensuring data integrity and compliance with institutional policies.

 ## System Requirements
-- Software Requirements
- SQL Server: Microsoft SQL Server 2019 or later
- Operating System: Windows 10 or later, or a compatible Linux distribution
- Development Tools: SQL Server Management Studio (SSMS) or any SQL IDE that supports T-SQL
-- Hardware Requirements
- Processor: Minimum 1 GHz or faster processor
- RAM: 4 GB or more
- Hard Disk: Minimum 20 GB of available space
-- User Requirements
- Permissions: Appropriate user permissions for database creation and manipulation.
- Knowledge: Basic understanding of SQL and database management.
  ## Database Setup:
   - Open SQL Server Management Studio.
   - Connect to your SQL Server instance.
   - Execute the SQL scripts provided in the directory to create the database and its objects.
## Methodology:
Database Design
- The database is normalized to reduce redundancy and improve data integrity.
- Tables are structured to support all key HR functions from job posting to candidate onboarding.


Development Approach
- Incremental Development: The database was developed incrementally, starting from basic schema setup to more complex features like triggers and stored procedures.
- Testing: Each component was thoroughly tested for functionality and performance.
-- Security
- Implemented role-based security to ensure that access to sensitive data is properly controlled.
-- Features
- Automated Workflows: Triggers and stored procedures automate common tasks like updating job openings and logging application status changes.
- Comprehensive Reporting: Stored procedures for generating detailed reports to aid in decision-making.
- Data Integrity: Use of transactions to ensure data consistency during updates.
-- Usage
- Running Queries:
  Execute SQL queries using SSMS or your preferred SQL IDE to interact with the database.
- Generating Reports:
  Execute stored procedures to generate recruitment and performance reports. 
-- Contributing
Contributors are welcome to further enhance the HR database system. Please fork the repository and submit pull requests for review.

