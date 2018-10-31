CREATE OR REPLACE PROCEDURE BILL_GENERATION_PROCEDURE
(oid IN NUMBER)
AS
TBILL ORDERS.TOTAL%TYPE :=0;
SALES_TAX CONSTANT NUMBER(10,2) :=0.10;
BEGIN 

SELECT SUM(O.quantity * M.price) INTO TBILL
FROM ORDERITEMS O
JOIN 
MENU M ON M.ITEM_ID=O.ITEM_ID
WHERE O.ORDER_ID = oid;

UPDATE ORDERS SET SUBTOTAL=TBILL WHERE ORDER_ID=oid;

UPDATE ORDERS SET TOTAL=TBILL+(TBILL*SALES_TAX) WHERE ORDER_ID=oid;
COMMIT;
END; 