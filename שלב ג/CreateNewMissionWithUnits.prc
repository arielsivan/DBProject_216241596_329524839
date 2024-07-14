create or replace procedure CreateNewMissionWithUnits(p_units IN SYS.ODCINUMBERLIST,
  p_mDate IN DATE) is v_mID NUMBER;
begin
  -- יצירת מזהה חדש למשימה
  SELECT NVL(MAX(mID), 0) + 1 INTO v_mID FROM MISSION;

  -- הוספת המשימה החדשה לטבלת המשימות
  INSERT INTO MISSION (mdate, mID)
  VALUES (p_mDate, v_mID);

  -- הוספת היחידות המשתתפות
  FOR i IN 1..p_units.COUNT LOOP
    INSERT INTO participates (mID, unID)
    VALUES (v_mID, p_units(i));
  END LOOP;

  COMMIT;

  -- הצגת הודעה על יצירת משימה חדשה
  DBMS_OUTPUT.PUT_LINE('New mission created with ID: ' || v_mID);
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
end CreateNewMissionWithUnits;
/
