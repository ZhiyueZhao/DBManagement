--Name: Zhiyue Zhao, Student Number: 0262458
--Course: DBMS-2004 Section2
--Date: 3/09/2016
--Assignment #4


--Part A
--Question 1
ALTER TABLE CUSTOMER 
	ADD CreditCardNumber NUMERIC(12) DEFAULT NULL;

--Question 2
ALTER TABLE RentalAgreement 
	MODIFY AgreementDate DEFAULT CURRENT_DATE;

--Question 3
ALTER TABLE Customer RENAME TO Client;

--Question 4
ALTER TABLE Client 
	RENAME COLUMN PCode TO PostalCode;

--Question 5
PURGE Recyclebin;

--Question 6
CREATE INDEX FullName
	ON Client(FName, LName)
ONLINE;

--Question 7
EXEC DBMS_STATS.GATHER_TABLE_STATS(ownname=>'T207', tabname=>'Client', cascade=>TRUE);


--Question 8
CREATE UNIQUE INDEX ClientCreditCard
	ON Client(CreditCardNumber)
COMPUTE STATISTICS;


--Part B
--Question 9
CREATE SEQUENCE RA_Sequence
	START WITH 1000
	INCREMENT BY 3
	MINVALUE 1
	MAXVALUE 10000 
	CYCLE
	CACHE 5;

--Question 10
INSERT INTO RentalAgreement (AgreementID, CustID, AgreementDate, MovieCount, DurationID)
	VALUES  (RA_Sequence.NEXTVAL, 23, CURRENT_DATE, 1, 1);

--Question 11
INSERT INTO MovieRented (MovieID, AgreementID, RentalAmount, PercentReductionApplied)
	VALUES  (6, RA_Sequence.CURRVAL, 3.76, 0);

--Question 12
CREATE PUBLIC SYNONYM Movies_T207
FOR Movie;

GRANT SELECT ON Movie TO DJONES, TBROWN;

--Question 13
ANALYZE INDEX SamplePK 
	VALIDATE STRUCTURE;

--Part C
--Question 14
SELECT Name, Height, Blocks, BR_Blks, BR_Rows, LF_Blks, LF_Rows 
	FROM Index_Stats
	WHERE NAME = 'SAMPLEPK'; 

a.	How many levels are in the tree?			2
b.	How many blocks are in the index?			16
c.	How many of those blocks are branch blocks?	1
d.	How many of those blocks are leaf blocks?	5
e.	How many branch rows are there?				4
f.	How many leaf rows are there?				2100

--Question 15
SELECT ROUND(Del_LF_Rows_len/LF_Rows_Len * 100) Balance_Ratio
	FROM Index_Stats
	WHERE NAME = 'SAMPLEPK';


The balance ratio returned is 0, is less than 20%, so it does not need to be rebuilt. 