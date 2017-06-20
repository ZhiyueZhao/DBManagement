/****************************************************************
* Set up SQLPlus to data is extracted as a CSV
* Assignment 2 part 2
* Author: Zhiyue Zhao
* Date: February 01, 2016
****************************************************************/
--connection to the database with username and password
CONN T207/880zZy131@DBMSDBII
--Not show the log
--prevents commands being run in the script from being printed
SET ECHO OFF
--removes number of record returned by query execution
SET FEEDBACK OFF
--indicates that the output be listed on a single file
SET PAGESIZE 0
--set the line size according to the output length
SET LINESIZE 153
--spool to a file named “DataExport.dat”
SPOOL DataExport.dat
--Run the Select separating selected columns with concatemated commas
SELECT CustID || ',' || AgreementDate || ',' || RentalAmount || ',' || NVL(PercentReductionApplied, 0) || ',' || MovieID || ',' || TRIM(Name) || ',' || NVL(TO_CHAR(Released), 'Unknown')
FROM RentalAgreement NATURAL JOIN MovieRented JOIN Movie USING(MovieID)
WHERE AgreementDate + 30 >= (SELECT MAX(AgreementDate) FROM RentalAgreement);
--turn off spooling
SPOOL OFF
EXIT
