-- יצירת מבט של פרטי הטנקים
CREATE VIEW V_Tank_Details AS
SELECT t.tid AS tank_id, u.uname AS unit_name, (s.firstname || ' ' || s.lastname) AS commander_name
FROM TANK t
JOIN UNIT u ON t.unid = u.unid
JOIN SOLDIERS s ON t.cid = s.sid;

-- ספירת מספר הטנקים לפי שם היחידה
SELECT unit_name, COUNT(*) AS tank_count
FROM v_Tank_Details
GROUP BY unit_name;

-- עדכון שם חייל לפי מזהה טנק מסוים
UPDATE SOLDIERS
SET firstname = 'John', lastname = 'Doe'
WHERE sid = (
    SELECT t.cid
    FROM TANK t
    JOIN v_Tank_Details td ON t.tid = td.tank_id
    WHERE td.tank_id = 2
);
