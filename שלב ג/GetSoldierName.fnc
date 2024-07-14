create or replace function GetSoldierName(p_cID NUMBER) return varchar2 is
  v_fullName VARCHAR2(50);
    -- ����� ������ ������ ���� ����� ������� �� �����
  v_firstName SOLDIERS.firstName%TYPE;
  v_lastName SOLDIERS.lastName%TYPE;
begin
    -- ����� ����� ����� ������� �� ����� ���� ����� ��� ����� ����� �� �����
  SELECT s.firstName, s.lastName
  INTO v_firstName, v_lastName
  FROM SOLDIERS s
  WHERE s.sID = p_cID;

  -- ����� ��� ����� ��� ������ ��� ���
  v_fullName := v_firstName || ' ' || v_lastName;

  -- ����� ��� ����
  return v_fullName;
EXCEPTION
  -- ����� ����� ��� ���� ���� �� ����� �����
  WHEN NO_DATA_FOUND THEN
    RETURN 'Soldier not found';
  -- ����� ��� ����� ����
  WHEN OTHERS THEN
    return 'Error: ' || SQLERRM;
end GetSoldierName;
/
