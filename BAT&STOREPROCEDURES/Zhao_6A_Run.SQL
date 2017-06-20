/****************************************************************************************
 * invoke Stord PROCEDURE
 * AUTHOR: Zhiyue Zhao				   				*
 * DATE: March 21, 2016				   				*
 ****************************************************************************************/

--connection to the database with username and password
CONN T207/880zZy131@DBMSDBII
--Disable displaying commands and other messages
SET ECHO OFF
SET FEEDBACK OFF
SET VERIFY OFF

--indicates that the output be listed on a single file
SET PAGESIZE 0

--Spool to a file named "Create_Tables_Zhao.SQL"
SPOOL Create_Tables_Zhao.SQL

-- set wrapped
SET SERVEROUTPUT ON FORMAT WRAPPED
SET SERVEROUTPUT ON SIZE 10000
EXEC Extract_Tables;

--Turn off spooling
SPOOL OFF

--terminates SQLPlus
EXIT