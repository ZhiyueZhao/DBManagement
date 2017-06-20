LOAD DATA
INFILE MovieRented.dat
APPEND INTO TABLE MovieRented
FIELDS TERMINATED BY ','
(MovieID, AgreementID, RentalAmount, PercentReductionApplied)