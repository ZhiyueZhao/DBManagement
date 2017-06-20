/****************************************************************************************
 * Export data from RentalAgreement, MovieRented and Movie table to DataExport.dat   	*
 * AUTHOR: Zhiyue Zhao				   				*
 * DATE: February 1, 2016				   				*
 ****************************************************************************************/

--connection to the database with username and password
CONN T207/880zZy131@DBMSDBII

--prevents commands being run in the script from being printed
SET ECHO OFF;

--indicates that the output be listed on a single file
SET PAGESIZE 0

--set length of a line
SET LINESIZE 135

--removes number of record returned by query execution
SET FEEDBACK OFF

--Spool to a file named "DataExport.dat"
SPOOL DataExport.dat

--Run the SELECT seperating selected columns with concatenated commas

SELECT 	TRIM(CustID) || ',' || 
	TRIM(AgreementDate) || ',' || 
	TRIM(RentalAmount) || ',' || 
	TRIM(NVL(PercentReductionApplied,'0')) || ',' || 
	TRIM(M.MovieID) || ',' || TRIM(M.Name) || ',' || 
	TRIM(NVL(TO_CHAR(M.Released),'Unknown'))
FROM 	RentalAgreement NATURAL JOIN MovieRented MR JOIN Movie M ON (MR.MovieID = M.MovieID)
WHERE 	AgreementDate + 30 >= ( SELECT MAX(AgreementDate) 
					FROM RentalAgreement );

--Turn off spooling
SPOOL OFF

--terminates SQLPlus
EXIT

