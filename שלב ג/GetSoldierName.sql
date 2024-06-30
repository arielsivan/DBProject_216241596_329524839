CREATE OR REPLACE FUNCTION GetSoldierName(p_cID NUMBER) RETURN VARCHAR2 IS
  -- הכרזת משתנים לאחסון שמות הפרטי והמשפחה של החייל
  v_firstName SOLDIERS.firstName%TYPE;
  v_lastName SOLDIERS.lastName%TYPE;
  v_fullName VARCHAR2(50);
BEGIN
  -- שליפת השמות הפרטי והמשפחה של החייל מתוך הטבלה לפי תעודת הזהות של החייל
  SELECT s.firstName, s.lastName
  INTO v_firstName, v_lastName
  FROM SOLDIERS s
  WHERE s.sID = p_cID;

  -- שילוב השם הפרטי ושם המשפחה לשם מלא
  v_fullName := v_firstName || ' ' || v_lastName;

  -- החזרת השם המלא
  RETURN v_fullName;
EXCEPTION
  -- טיפול במקרה שלא נמצא חייל עם המזהה הנתון
  WHEN NO_DATA_FOUND THEN
    RETURN 'Soldier not found';
  -- טיפול בכל שגיאה אחרת
  WHEN OTHERS THEN
    RETURN 'Error: ' || SQLERRM;
END GetSoldierName;
/

