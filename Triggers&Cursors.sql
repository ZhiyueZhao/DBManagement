--Zhiyue Zhao
--11/24/2015 

--Question 1
CREATE OR REPLACE PROCEDURE AddOrder
(
    iCust IN NUMBER,
    iMfr IN CHAR,
    iProduct IN CHAR,
    iQuantity IN NUMBER
)
AS
   wValueSold       NUMBER(9,2);
   wQtyOnHand       NUMBER(5);
BEGIN
    SELECT QtyOnHand INTO wQtyOnHand 
      FROM Products 
      WHERE Mfr = UPPER(iMfr)
      AND Product = UPPER(iProduct);
    IF wQtyOnHand < iQuantity THEN
      DBMS_OUTPUT.PUT_LINE('Quantity on hand is not enough!');
    ELSE
      SELECT Price * iQuantity INTO wValueSold
       FROM Products
       WHERE Mfr = UPPER(iMfr)
       AND Product = UPPER(iProduct);
      INSERT INTO Orders (OrderNum, OrderDate, Cust, Rep, Mfr, Product, Qty, Amount)
        VALUES ((SELECT MAX(OrderNum) + 1 FROM Orders), CURRENT_DATE, iCust, 
        (SELECT CustRep FROM Customers WHERE CustNum = iCust), UPPER(iMfr), 
        UPPER(iProduct), iQuantity, wValueSold);
     COMMIT; 
    END IF;
END;
/
SHOW ERRORS;

--Question 2
CREATE OR REPLACE TRIGGER ProductMaint
AFTER INSERT ON Orders
FOR EACH ROW 
BEGIN
   UPDATE Products
      SET QtyOnHand = QtyOnHand - :NEW.Qty
      WHERE Mfr = :NEW.Mfr 
      AND Product = :NEW.Product; 
END;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER SalesRepMaint
AFTER INSERT ON Orders
FOR EACH ROW 
WHEN (NEW.Rep IS NOT NULL)
BEGIN
   UPDATE Salesreps
      SET Sales = Sales + :NEW.Amount
      WHERE SalesRep = :NEW.Rep;
END;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER OfficesMaint
AFTER UPDATE ON Salesreps
FOR EACH ROW 
WHEN (NEW.RepOffice IS NOT NULL)
BEGIN
   UPDATE Offices
      SET Sales = Sales + :NEW.Sales - :OLD.Sales
      WHERE Office = :NEW.RepOffice;
END;
/
SHOW ERRORS;


--Question 3
CREATE OR REPLACE PROCEDURE CustomerOrders
(
    iCustomerNum IN NUMBER
)
AS
   
   CURSOR  OrderCursor IS
   SELECT Description, Amount
    FROM Orders, Products
    WHERE Products.Product = Orders.Product
    AND Products.Mfr = Orders.Mfr
    AND Cust = iCustomerNum;
   
   CurrentRow  OrderCursor%ROWTYPE;
   wDescription CHAR(20);
   wAmount NUMBER(9,2);
   wTotalOrders NUMBER(11,2);
   wCustomerName VARCHAR2(20);
   wCustomerCount NUMBER(1);
   wOrderCount NUMBER(1);
BEGIN
    SELECT COUNT(*) INTO wCustomerCount FROM Customers WHERE CustNum = iCustomerNum;
    IF(wCustomerCount != 0) THEN 
      SELECT Company INTO wCustomerName FROM Customers WHERE Custnum = iCustomerNum;
      SELECT COUNT(*) INTO wOrderCount FROM Orders WHERE Cust = iCustomerNum;
      IF(wOrderCount != 0) THEN 
        DBMS_OUTPUT.PUT_LINE('Orders for ' || iCustomerNum || ' ' || wCustomerName);
        DBMS_OUTPUT.PUT_LINE('DESCRIPTION                   AMOUNT');
        DBMS_OUTPUT.PUT_LINE('-------------------- ----------------');
        FOR CurrentRow IN OrderCursor 
        LOOP
          wDescription := CurrentRow.Description;
          wAmount := CurrentRow.Amount;
          DBMS_OUTPUT.PUT_LINE(wDescription || '   ' || TO_CHAR(wAmount,'$9,999,999.99'));
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('                     ----------------');
        SELECT SUM(Amount) INTO wTotalOrders
         FROM Orders
         WHERE Cust = iCustomerNum;
        DBMS_OUTPUT.PUT_LINE('Total Orders:' || '        ' || TO_CHAR(wTotalOrders,'$999,999,999.99'));
        DBMS_OUTPUT.PUT_LINE('                     ================');
      ELSE
        DBMS_OUTPUT.PUT_LINE('Customer ' || iCustomerNum || ' (' || wCustomerName || ') ' || 'does not have any orders.');
      END IF;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Customer ' || iCustomerNum || ' does not exist.');
    END IF;
END;
/
SHOW ERRORS;