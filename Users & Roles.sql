--Name: Zhiyue Zhao, Student Number: 0262458
--Course: DBMS-2004 Section2
--Date: 3/15/2016
--Assignment #5

--Question 1
CREATE USER T207_JGarnet
	IDENTIFIED BY sixcha;

CREATE USER T207_PBlat
	IDENTIFIED BY sixcha;

CREATE USER T207_RSeymore
	IDENTIFIED BY sixcha;

--Question 2
CREATE ROLE T207_Receptionist_Role;

GRANT SELECT
	ON Customer
	TO T207_Receptionist_Role;

GRANT SELECT
	ON RentalAgreement
	TO T207_Receptionist_Role;

GRANT SELECT
	ON MovieRented
	TO T207_Receptionist_Role;

GRANT SELECT
	ON Movie
	TO T207_Receptionist_Role;

--Question 3
GRANT CREATE SESSION 
	TO T207_Receptionist_Role;

--Question 4
GRANT T207_Receptionist_Role
	TO T207_JGarnet;

--Question 5
CREATE ROLE T207_Salesperson_Role;

GRANT T207_Receptionist_Role
	TO T207_Salesperson_Role;

GRANT INSERT
	ON RentalAgreement
	TO T207_Salesperson_Role;

GRANT INSERT
	ON MovieRented
	TO T207_Salesperson_Role;

--Question 6
GRANT T207_Salesperson_Role
	TO T207_PBlat;

--Question 7
CREATE ROLE T207_SaleManager_Role IDENTIFIED BY sixcha;

GRANT SELECT, INSERT, UPDATE, DELETE
	ON Customer
	TO T207_SaleManager_Role;

GRANT SELECT, INSERT, UPDATE, DELETE
	ON RentalAgreement
	TO T207_SaleManager_Role;

GRANT SELECT, INSERT, UPDATE, DELETE
	ON MovieRented
	TO T207_SaleManager_Role;

GRANT SELECT, INSERT, UPDATE, DELETE
	ON Movie
	TO T207_SaleManager_Role;

--Question 8
GRANT T207_Salesperson_Role, T207_SaleManager_Role
	TO T207_RSeymore;

ALTER USER T207_RSeymore DEFAULT ROLE T207_Salesperson_Role;

--Question 9
SET ROLE T207_SaleManager_Role IDENTIFIED BY sixcha;

--Question 10
SET ROLE T207_Salesperson_Role;