create or replace function IsCommanderOf(p_cID NUMBER) return varchar2 is
   v_count_tanks NUMBER := 0;
  v_count_units NUMBER := 0;
  v_result VARCHAR2(50);
begin
-- בדיקת אם המפקד הוא מפקד של טנק
  SELECT COUNT(*)
  INTO v_count_tanks
  FROM TANK
  WHERE cID = p_cID;

  -- בדיקת אם המפקד הוא מפקד של יחידה
  SELECT COUNT(*)
  INTO v_count_units
  FROM UNIT
  WHERE cID = p_cID;

  -- הסתעפות על פי התוצאות
  IF v_count_tanks > 0 AND v_count_units > 0 THEN
    v_result := 'Commander of both tank and unit';
  ELSIF v_count_tanks > 0 THEN
    v_result := 'Commander of tank';
  ELSIF v_count_units > 0 THEN
    v_result := 'Commander of unit';
  ELSE
    v_result := 'Not a commander';
  END IF;

  RETURN v_result;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 'Error: ' || SQLERRM;
end IsCommanderOf;
/
