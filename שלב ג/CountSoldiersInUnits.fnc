create or replace function CountSoldiersInUnits(p_units SYS.ODCINUMBERLIST) return SYS.ODCINUMBERLIST is
    -- הכרזת משתנה לאחסון התוצאה הסופית: מערך של מספרי החיילים בכל יחידה
  v_soldiersCount SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST();

  v_count NUMBER; -- משתנה לאחסון מספר החיילים הזמני
  v_index NUMBER := 1; -- אינדקס עבור הלולאות
  
  -- Cursor מפורש לבחירת מספר החיילים בכל יחידה לפי מזהה יחידה
  CURSOR soldiers_cur IS
    SELECT COUNT(*) AS soldier_count
    FROM SOLDIERS s
    JOIN CREWMATE cr ON s.sID = cr.crID
    JOIN UNIT u ON cr.cID = u.cID
    WHERE u.unID = p_units(v_index);
begin
    -- (Implicit Cursor) לא מפורש Cursor שימוש ב 
  FOR i IN 1..p_units.COUNT LOOP
    
    SELECT COUNT(*) * 4 -- בכל טנק יש 4 חיילים
    INTO v_count
    FROM Tank t
    WHERE t.unID = p_units(i);
  
    -- הוספת מספר החיילים למערך התוצאה
    v_soldiersCount.EXTEND;
    v_soldiersCount(i) := v_count;
  END LOOP;

  return v_soldiersCount;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    return v_soldiersCount; -- במקרה של שגיאה, מחזירה רשימה ריקה
end CountSoldiersInUnits;
/
