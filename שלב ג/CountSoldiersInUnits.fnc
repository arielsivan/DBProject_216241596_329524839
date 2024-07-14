create or replace function CountSoldiersInUnits(p_units SYS.ODCINUMBERLIST) return SYS.ODCINUMBERLIST is
    -- ����� ����� ������ ������ ������: ���� �� ����� ������� ��� �����
  v_soldiersCount SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST();

  v_count NUMBER; -- ����� ������ ���� ������� �����
  v_index NUMBER := 1; -- ������ ���� �������
  
  -- Cursor ����� ������ ���� ������� ��� ����� ��� ���� �����
  CURSOR soldiers_cur IS
    SELECT COUNT(*) AS soldier_count
    FROM SOLDIERS s
    JOIN CREWMATE cr ON s.sID = cr.crID
    JOIN UNIT u ON cr.cID = u.cID
    WHERE u.unID = p_units(v_index);
begin
    -- (Implicit Cursor) �� ����� Cursor ����� � 
  FOR i IN 1..p_units.COUNT LOOP
    
    SELECT COUNT(*) * 4 -- ��� ��� �� 4 ������
    INTO v_count
    FROM Tank t
    WHERE t.unID = p_units(i);
  
    -- ����� ���� ������� ����� ������
    v_soldiersCount.EXTEND;
    v_soldiersCount(i) := v_count;
  END LOOP;

  return v_soldiersCount;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    return v_soldiersCount; -- ����� �� �����, ������ ����� ����
end CountSoldiersInUnits;
/
