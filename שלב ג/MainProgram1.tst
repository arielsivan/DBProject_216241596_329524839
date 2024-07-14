PL/SQL Developer Test script 3.0
41
DECLARE
  v_units SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(1, 2, 3); -- ���� ���� ������ ������
  v_soldiersCount SYS.ODCINUMBERLIST;
  v_missionDate DATE := SYSDATE; -- ����� ������
  v_totalSoldiers NUMBER := 0;
  v_maxSoldiersUnit NUMBER := 0;
  v_maxSoldiersCount NUMBER := 0;
BEGIN
  -- ����� ����� ���� �� ������� �������
  CreateNewMissionWithUnits(v_units, v_missionDate);
  
  -- ���� ���� ������� ��� �����
  v_soldiersCount := CountSoldiersInUnits(v_units);
  
  -- ������� ����� ���� ������� ��� �����
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
  
  -- ���� �� �� �������
  DBMS_OUTPUT.PUT_LINE('Total soldiers in mission: ' ||
    v_totalSoldiers);
  
  -- ���� ������ �� ���� ������� ����� �����
  DBMS_OUTPUT.PUT_LINE('Unit with most soldiers: ' ||
    v_maxSoldiersUnit || 
    ' (' || 
    v_maxSoldiersCount || 
    ' soldiers)');
END;
0
0
