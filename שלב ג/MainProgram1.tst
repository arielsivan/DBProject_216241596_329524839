PL/SQL Developer Test script 3.0
41
DECLARE
  v_units SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(1, 2, 3); -- מערך מזהי יחידות לדוגמה
  v_soldiersCount SYS.ODCINUMBERLIST;
  v_missionDate DATE := SYSDATE; -- תאריך המשימה
  v_totalSoldiers NUMBER := 0;
  v_maxSoldiersUnit NUMBER := 0;
  v_maxSoldiersCount NUMBER := 0;
BEGIN
  -- יצירת משימה חדשה עם היחידות הנתונות
  CreateNewMissionWithUnits(v_units, v_missionDate);
  
  -- קבלת מספר החיילים בכל יחידה
  v_soldiersCount := CountSoldiersInUnits(v_units);
  
  -- חישובים והצגת מספר החיילים בכל יחידה
  FOR i IN 1..v_soldiersCount.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Unit ' ||
        v_units(i) ||
        ' has ' ||
        v_soldiersCount(i) ||
        ' soldiers.');
    v_totalSoldiers := 
        v_totalSoldiers + v_soldiersCount(i);
    
    IF v_soldiersCount(i) > v_maxSoldiersCount THEN
      v_maxSoldiersCount := v_soldiersCount(i);
      v_maxSoldiersUnit := v_units(i);
    END IF;
  END LOOP;
  
  -- הצגת סך כל החיילים
  DBMS_OUTPUT.PUT_LINE('Total soldiers in mission: ' ||
    v_totalSoldiers);
  
  -- הצגת היחידה עם מספר החיילים הגבוה ביותר
  DBMS_OUTPUT.PUT_LINE('Unit with most soldiers: ' ||
    v_maxSoldiersUnit || 
    ' (' || 
    v_maxSoldiersCount || 
    ' soldiers)');
END;
0
0
