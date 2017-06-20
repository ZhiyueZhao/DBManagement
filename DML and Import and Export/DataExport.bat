@ECHO OFF
REM *****************************************************************************************************
REM * Run the DataExport.sql to export data from RentalAgreement, MovieRented and Movie table to a file
REM * Author: Zhiyue Zhao
REM * Date: February 1, 2016
REM *****************************************************************************************************
REM * Sign on to SQLPlus and invoke the DataExport.sql script
SQLPLUS /nolog @DataExport.sql
PAUSE