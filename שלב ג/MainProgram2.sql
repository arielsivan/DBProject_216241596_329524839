DECLARE
  v_cID NUMBER := 123; -- תעודת זהות של חייל לדוגמה
  v_tID NUMBER := 1; -- מזהה טנק לדוגמה
  v_unID NUMBER := 2; -- מזהה יחידה חדשה לדוגמה
  v_tankInfo SYS_REFCURSOR; -- משתנה להחזקת המידע על הטנק
  v_result VARCHAR2(50); -- משתנה להחזקת תוצאת הפונקציה IsCommanderOf
  v_fullName VARCHAR2(50); -- משתנה להחזקת שם מלא של החייל
  v_tankRow TANK%ROWTYPE; -- משתנה להחזקת רשומת טנק
  v_tankCount NUMBER := 0;
  v_unitCount NUMBER := 0;
BEGIN
  -- IsCommanderOf  קריאה לפונקציה 
  v_result := IsCommanderOf(v_cID);
  DBMS_OUTPUT.PUT_LINE('Commander status: ' || v_result);
  
  -- GetSoldierName קריאה לפונקציה 
  v_fullName := GetSoldierName(v_cID);
  DBMS_OUTPUT.PUT_LINE('Soldier name: ' || v_fullName);
  
  -- והצגת מידע על הטנק שעודכן  AssignTankToUnit קריאה לפרוצדורה 
  AssignTankToUnit(v_tID, v_unID, v_tankInfo);
  
  LOOP
    FETCH v_tankInfo INTO v_tankRow;
    EXIT WHEN v_tankInfo%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Tank ID: ' || 
        v_tankRow.tID || 
        ', Unit ID: ' || 
        v_tankRow.unID || 
        ', Commander ID: ' || 
        v_tankRow.cID);
    v_tankCount := v_tankCount + 1;
  END LOOP;
  
  CLOSE v_tankInfo;
  
  -- הצגת מספר הטנקים של המפקד
  DBMS_OUTPUT.PUT_LINE('Total tanks commanded by ' ||
    v_fullName || ': ' || v_tankCount);
  
  -- הצגת מספר היחידות של המפקד
  BEGIN
    SELECT COUNT(*)
    INTO v_unitCount
    FROM UNIT
    WHERE cID = v_cID;
    
    DBMS_OUTPUT.PUT_LINE('Total units commanded by ' || 
        v_fullName || ': ' || v_unitCount);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error in counting units: ' || SQLERRM);
  END;
  
  -- בדיקת אם המפקד לא מפקד על טנקים או יחידות
  IF v_tankCount = 0 AND v_unitCount = 0 THEN
    DBMS_OUTPUT.PUT_LINE(v_fullName ||
        ' is not a commander of any tanks or units.');
  END IF;
END;
/

