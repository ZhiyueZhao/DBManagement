/******************************************************************************
* Format Data in SQLPlus to be displayed as a report
* Author: Zhiyue Zhao
* Date: February 4, 2016
*******************************************************************************/

--Connect to database
CONN T207/880zZy131@DBMSDBII

--Disable displaying commands and other messages
SET ECHO OFF
SET FEEDBACK OFF
SET VERIFY OFF

--Set page formatting
SET PAGESIZE 30
SET LINESIZE 120

--Prompt user for customer ID
ACCEPT CustID NUMBER FORMAT '999' PROMPT 'Customer ID: '

--Clear formatting
CLEAR COLUMN
CLEAR BREAK

--Format columns
COLUMN AgreementID HEADING 'Agreement'
COLUMN FName FORMAT A15 HEADING 'First Name'
COLUMN LName FORMAT A15 HEADING 'Last Name'
COLUMN AgreementDate FORMAT A12 HEADING 'Date'
COLUMN Name FORMAT A55 HEADING 'Movie Name'
COLUMN RentalAmount FORMAT $990.00 HEADING 'Paid'

--Breaks
BREAK ON AgreementID ON FName ON LName ON REPORT SKIP 1

--Set top and bottom headings of report
TTITLE CENTER 'Movie Rental Details for Client ' &CustID -
	RIGHT 'Page: ' FORMAT 9 SQL.PNO SKIP 2
	
BTITLE LEFT 'Run by:' SQL.USER -
	CENTER 'End of Report'
	
--Computations
COMPUTE SUM LABEL 'Total' OF RentalAmount ON REPORT

--Spool to specified file
SPOOL 'C:\DBMSDBII\Reports\Zhao_Z.txt'

--Select data to be displayed in the report
SELECT 	 AgreementID, 
		 SUBSTR(FName, 1, 15) FName, 
		 SUBSTR(LName, 1, 15) LName, 
		 AgreementDate, 
		 SUBSTR(Name, 1, 55) Name, 
		 MR.RentalAmount
FROM   	 Customer JOIN RentalAgreement
USING 	(CustID) 	JOIN MovieRented MR
USING 	(AgreementID) JOIN Movie
USING 	(MovieID)
WHERE 	 CustID = &CustID
ORDER BY AgreementID;

--Turn off spooling and exit
SPOOL OFF
EXIT