@ECHO OFF
REM *****************************************************************************************************
REM * Append data from Customer.dat, MovieRented.dat and RentalAgreement.dat to existing schema		*
REM * AUTHOR: Zhiyue Zhao				   					*
REM * DATE: February 1, 2016				   						*
REM *****************************************************************************************************

REM * connect and login to the database
REM * loads the three (3) control files to import data to tables
SQLLDR T207/880zZy131@DBMSDBII CONTROL=LoadCustomerTables.ctl&
SQLLDR T207/880zZy131@DBMSDBII CONTROL=LoadRentalAgreementTables.ctl&
SQLLDR T207/880zZy131@DBMSDBII CONTROL=LoadMovieRentedTables.ctl

REM * wait for user to press key
PAUSE