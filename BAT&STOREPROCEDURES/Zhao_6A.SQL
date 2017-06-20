--create a store procedure that require the table name and go through all the Column Names in the table
CREATE OR REPLACE PROCEDURE Extract_Columns
(
	iTableName IN VARCHAR2
)
AS
	--make the cursor to go through the User_Tab_Columns table
	CURSOR ColumnNameCursor IS
	SELECT Column_Name, Column_ID
		FROM User_Tab_Columns
		WHERE Table_Name = iTableName
		ORDER BY Column_ID;
	
	CurrentRow ColumnNameCursor%ROWTYPE;
BEGIN
	--loop the result and print
	FOR CurrentRow IN ColumnNameCursor 
	LOOP
		IF(CurrentRow.Column_ID = 1) THEN
			DBMS_OUTPUT.PUT_LINE('   ' || CurrentRow.Column_Name);
		ELSE
			DBMS_OUTPUT.PUT_LINE(' , ' || CurrentRow.Column_Name);
		END IF;
	END LOOP;
END; 
/

--create a store procedure go through all the tables and invoke Extract_Columns
CREATE OR REPLACE PROCEDURE Extract_Tables
AS
	--make the cursor to go through the User_Tables table
	CURSOR TableNameCursor IS
	SELECT Table_Name 
		FROM User_Tables
		ORDER BY Table_Name;

	CurrentRow TableNameCursor%ROWTYPE;
BEGIN
	--print the title
	DBMS_OUTPUT.PUT_LINE('---- Oracle Catalog Extract Utility V1.0 ----');
	DBMS_OUTPUT.PUT_LINE('----');
	DBMS_OUTPUT.PUT_LINE('---- Run on ' || TO_CHAR(SYSDATE,'MON DD, YYYY') || ' at '
	 || TO_CHAR(SYSTIMESTAMP,'HH24:MI'));
	DBMS_OUTPUT.PUT_LINE('----');
	--loop the result and print
	FOR CurrentRow IN TableNameCursor 
	LOOP
		DBMS_OUTPUT.PUT_LINE('--   Start extracting table ' || CurrentRow.Table_Name);
		DBMS_OUTPUT.PUT_LINE('CREATE TABLE ' || CurrentRow.Table_Name || ' (');
		Extract_Columns(CurrentRow.Table_Name);
		DBMS_OUTPUT.PUT_LINE(RPAD(' ',LENGTH(' CREATE TABLE ') + LENGTH(CurrentRow.Table_Name),' ') || 
			'); -- END of Table '  || CurrentRow.Table_Name ||  ' creation');
		DBMS_OUTPUT.PUT_LINE('--');
		DBMS_OUTPUT.PUT_LINE('--');
	END LOOP;
	--print the footer
	DBMS_OUTPUT.PUT_LINE('---- Oracle Catalog Extract Utility V1.0 ----');
	DBMS_OUTPUT.PUT_LINE('---- Run Completed on ' || TO_CHAR(SYSDATE,'MON DD, YYYY') || ' at '
	 || TO_CHAR(SYSTIMESTAMP,'HH24:MI'));
END; 
/