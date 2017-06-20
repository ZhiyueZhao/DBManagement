--Name: Zhiyue Zhao, Student Number: 0262458
--Course: DBMS-2004 Section2
--Date: 1/18/2016
--Assignment #1

SET PAGESIZE 80
SET LINESIZE 900
--Question 1
SELECT UNIQUE Lname || ', ' || Fname || CHR(10) 
		|| StreetNo || ' ' || Street || CHR(10) 
		|| City || ', ' || Province || CHR(10) 
		|| PCode || CHR(10) AS "Address"
FROM   Customer JOIN RentalAgreement
Using (CustID)
WHERE EXTRACT(YEAR FROM AgreementDate) = 2015
ORDER BY "Address";

--Question 2
SELECT SUBSTR(Name,1,34) AS "Name", LPAD(TO_CHAR(Released, 'YYYY'), 39, ' ') AS "Released In", 
		TO_CHAR((RentalAmount - DistributionCost) / DistributionCost * 100, '99,999.999') AS "% Profit"
FROM Movie 
ORDER BY "% Profit" DESC;

--Question 3
SELECT Name AS "Movies Never Rented" 
FROM Movie
WHERE MovieID IN (SELECT MovieID FROM Movie MINUS SELECT MovieID FROM MovieRented);

--Question 4
SELECT Name AS "Movie Name", RatingType AS "Rating", TO_CHAR(RentalAmount, '$9.99') AS "Current", TO_CHAR(DECODE(RatingID, '14A', RentalAmount * 1.25,
                                                                                                  '18A', RentalAmount * 1.15,
                                                                                                  'A', RentalAmount * 1.10,
                                                                                                  RentalAmount * 1.05), '$9.99') AS "New Rent"
FROM Movie LEFT OUTER JOIN Rating
USING (RatingID)
ORDER BY "Rating", "Movie Name";

--optional
SELECT DISTINCT Name AS "Movie Name", RatingType AS "Rating", 
        LPAD(TO_CHAR(RentalAmount, '$9,999.99'), 20, ' ') AS "Current Rental Price",
        LPAD(TO_CHAR(DECODE(Movie.RatingID,
                        '14A', RentalAmount * 1.25,
                        '18A', RentalAmount * 1.15,
                        'A', RentalAmount * 1.1,
                        RentalAmount * 1.05
                      ), '$9,999.99'), 16, ' ') AS "New Rental Price"
FROM Movie LEFT OUTER JOIN Rating
ON Movie.RatingID = Rating.RatingID
ORDER BY "Movie Name" ASC;

--Question 5
/*SELECT Name, ROUND((RentalAmount - DistributionCost) / DistributionCost * 100, 1) AS "Profit %", "Rented"
FROM Movie NATURAL JOIN (SELECT MovieID, COUNT(*) AS "Rented" FROM MovieRented GROUP BY MovieID)
WHERE RentalAmount < 2 * DistributionCost;*/
SELECT Name, ROUND((RentalAmount - DistributionCost) / DistributionCost * 100, 1) AS "Profit %", NVL("Rented", 0)
FROM Movie LEFT OUTER JOIN (SELECT MovieID, COUNT(*) AS "Rented" FROM MovieRented GROUP BY MovieID) MR
ON Movie.MovieID = MR.MovieID
WHERE RentalAmount < 2 * DistributionCost;

--Question 6
SELECT Name, ROUND(MONTHS_BETWEEN(CURRENT_DATE, Released))
FROM Movie
ORDER BY Released;
--optional
SELECT Name, ROUND(MONTHS_BETWEEN(current_date, 
             Released))
             AS "Months since release"
FROM Movie
ORDER BY "Months since release" DESC;

--Question 7
SELECT Next_Day(SYSDATE, 'Tuesday') AS "Next Tuesday" FROM Dual;

--Question 8
SELECT MIN(LENGTH(Name)), MAX(LENGTH(Name)), AVG(LENGTH(Name))
FROM Movie;

--Question 9
SELECT TO_CHAR(AVG(SUM(RentalAmount)), '$999,999.99') AS Average 
FROM MovieRented 
GROUP BY AgreementID;

--Question 10
SELECT CONCAT(REPLACE(Name, ': ', CHR(10)), CHR(10)) AS "Movie"
FROM Movie
WHERE INSTR(Name, ': ') > 0;


--Question 11
SELECT CustID, FName, LName
FROM Customer
WHERE SOUNDEX(FName) = SOUNDEX('Allan')
ORDER BY CustID;

--Question 12
CREATE MATERIALIZED VIEW MovieGenreStars
REFRESH COMPLETE
START WITH CURRENT_DATE NEXT CURRENT_DATE + 7
AS SELECT SUBSTR(Name,1,45) AS "The Movie", SUBSTR(GenreType,1,22) AS "In this genre...", Stars AS "Has stars:"
	FROM Movie NATURAL JOIN MovieGenre
	JOIN (SELECT GenreID, GenreType, MAX(Stars) AS MaxStars 
		FROM Movie NATURAL JOIN MovieGenre NATURAL JOIN Genre
		GROUP BY GenreID, GenreType) GS 
	ON MovieGenre.GenreID = GS.GenreID AND Stars = MaxStars
	ORDER BY GenreType;