PL/SQL Developer Test script 3.0
61
DECLARE
  v_cID NUMBER := 123; -- ����� ���� �� ���� ������
  v_tID NUMBER := 1; -- ���� ��� ������
  v_unID NUMBER := 2; -- ���� ����� ���� ������
  v_tankInfo SYS_REFCURSOR; -- ����� ������ ����� �� ����
  v_result VARCHAR2(50); -- ����� ������ ����� �������� IsCommanderOf
  v_fullName VARCHAR2(50); -- ����� ������ �� ��� �� �����
  v_tankRow TANK%ROWTYPE; -- ����� ������ ����� ���
  v_tankCount NUMBER := 0;
  v_unitCount NUMBER := 0;
BEGIN
  -- IsCommanderOf  ����� �������� 
  v_result := IsCommanderOf(v_cID);
  DBMS_OUTPUT.PUT_LINE('Commander status: ' || v_result);
  
  -- GetSoldierName ����� �������� 
  v_fullName := GetSoldierName(v_cID);
  DBMS_OUTPUT.PUT_LINE('Soldier name: ' || v_fullName);
  
  -- ����� ���� �� ���� ������  AssignTankToUnit ����� ��������� 
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
  
  -- ���� ���� ������ �� �����
  DBMS_OUTPUT.PUT_LINE('Total tanks commanded by ' ||
    v_fullName || ': ' || v_tankCount);
  
  -- ���� ���� ������� �� �����
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
  
  -- ����� �� ����� �� ���� �� ����� �� ������
  IF v_tankCount = 0 AND v_unitCount = 0 THEN
    DBMS_OUTPUT.PUT_LINE(v_fullName ||
        ' is not a commander of any tanks or units.');
  END IF;
END;
/
0
0
