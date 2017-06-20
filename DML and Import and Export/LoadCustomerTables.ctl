LOAD DATA
INFILE customer.dat
APPEND INTO TABLE Customer
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
(CustID, FName, LName, StreetNo, Street, City, Province, PCode, PrimaryCustID)
