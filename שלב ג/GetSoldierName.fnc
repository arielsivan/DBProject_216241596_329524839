create or replace function GetSoldierName(p_cID NUMBER) return varchar2 is
  v_fullName VARCHAR2(50);
    -- הכרזת משתנים לאחסון שמות הפרטי והמשפחה של החייל
  v_firstName SOLDIERS.firstName%TYPE;
  v_lastName SOLDIERS.lastName%TYPE;
begin
    -- שליפת השמות הפרטי והמשפחה של החייל מתוך הטבלה לפי תעודת הזהות של החייל
  SELECT s.firstName, s.lastName
  INTO v_firstName, v_lastName
  FROM SOLDIERS s
  WHERE s.sID = p_cID;

  -- שילוב השם הפרטי ושם המשפחה לשם מלא
  v_fullName := v_firstName || ' ' || v_lastName;

  -- החזרת השם המלא
  return v_fullName;
EXCEPTION
  -- טיפול במקרה שלא נמצא חייל עם המזהה הנתון
  WHEN NO_DATA_FOUND THEN
    RETURN 'Soldier not found';
  -- טיפול בכל שגיאה אחרת
  WHEN OTHERS THEN
    return 'Error: ' || SQLERRM;
end GetSoldierName;
/
