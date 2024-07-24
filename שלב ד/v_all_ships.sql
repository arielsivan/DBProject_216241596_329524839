-- יצירת נוף של כל הספינות עם פרטים על מיקום הבסיס וסוג הספינה
CREATE VIEW V_ALL_SHIPS AS
SELECT 
    sv.sea_id,
    sv.nickname,
    sv.capacity,
    b.location AS base_location,
    CASE 
        WHEN d.sea_id IS NOT NULL THEN 'Destroyer'
        WHEN ms.sea_id IS NOT NULL THEN 'Missile Ship'
        WHEN sub.sea_id IS NOT NULL THEN 'Submarine'
        ELSE 'Sea Vessel'
    END AS ship_type
FROM SEA_VESSEL sv
LEFT JOIN BASE b ON sv.base_id = b.base_id
LEFT JOIN WARSHIP ws ON sv.sea_id = ws.sea_id
LEFT JOIN DESTROYER d ON ws.sea_id = d.sea_id
LEFT JOIN MISSILE_SHIP ms ON ws.sea_id = ms.sea_id
LEFT JOIN SUBMARINE sub ON sv.sea_id = sub.sea_id;

-- ספירת מספר הספינות לפי סוג הספינה
SELECT ship_type, COUNT(*) AS count
FROM V_ALL_SHIPS
GROUP BY ship_type;

-- ספירת מספר המשחתות לפי מיקום הבסיס
SELECT COUNT(sea_id), base_location
FROM V_ALL_SHIPS
WHERE ship_type = 'Destroyer'
GROUP BY base_location;
