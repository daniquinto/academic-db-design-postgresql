-- Creating the database
-- Intended to be run with psql

-- Safety: drop only if it exists 
DROP DATABASE IF EXISTS academic_university_management;

CREATE DATABASE academic_university_management;

-- psql meta-command to connect to the created database
-- this keeps the remaining scripts clean and avoids manual reconnection steps
\connect academic_university_management;
