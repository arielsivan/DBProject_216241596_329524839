CREATE OR REPLACE PROCEDURE AssignTankToUnit (
  p_tID NUMBER,
  p_unID NUMBER,
  p_tankInfo OUT SYS_REFCURSOR
) IS
BEGIN
  -- עדכון יחידת הטנק
  UPDATE TANK
  SET unID = p_unID
  WHERE tID = p_tID;

  --להחזרת מידע על הטנק שעודכן Ref Cursor פתיחת
  OPEN p_tankInfo FOR
    SELECT tID, unID, cID
    FROM TANK
    WHERE tID = p_tID;

  COMMIT;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Tank not found');
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END AssignTankToUnit;
/


