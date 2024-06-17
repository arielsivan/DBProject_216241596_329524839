--- Select Queries

-- Select Query 1 : Calculates the average service duration (in days) for commanders and non-commanders (soldiers who are not commanders).
-- Subquery for Commanders
SELECT 'Commander' AS role, 
    AVG(s.releaseDate - s.draftDate) AS avgServiceDuration
FROM SOLDIERS s
JOIN COMMANDER c ON s.sID = c.cID

UNION ALL

-- Subquery for Non-Commanders
SELECT 'Non-Commander' AS role, 
    AVG(s.releaseDate - s.draftDate) AS avgServiceDuration
FROM SOLDIERS s
LEFT JOIN COMMANDER c ON s.sID = c.cID
WHERE c.cID IS NULL;

-- Select Query 2 : Retrieves units with a mission count above the average mission count across all units.
SELECT u.unID, u.uName, COUNT(p.mID) AS missionCount
FROM UNIT u
JOIN participates p ON u.unID = p.unID
GROUP BY u.unID, u.uName
HAVING COUNT(p.mID) > (
    SELECT AVG(missionCount)
    FROM (
        SELECT COUNT(p.mID) AS missionCount
        FROM participates p
        GROUP BY p.unID

    ) subquery
)
ORDER BY missionCount DESC;

-- Select Query 3 : Retrieves units and the number of tanks each unit has.
SELECT u.uName AS unitName, COUNT(t.tID) AS numberOfTanks
FROM UNIT u
LEFT JOIN TANK t ON u.unID = t.unID
GROUP BY u.uName
ORDER BY numberOfTanks DESC;

-- Select Query 4 : Retrieves crewmates who were drafted between March and April.
SELECT * FROM CREWMATE
WHERE crID IN (
  SELECT sID
  FROM SOLDIERS
  WHERE EXTRACT(MONTH FROM draftDate) BETWEEN 3 AND 4
);


--- Delete Queries

-- Delete Query 1 : Deletes participation records (participates table) associated with unit ID 101.
DELETE FROM participates AS p 
WHERE p.UNID = 101;

-- Delete Query 2 : Deletes crewmates who are associated with tanks assigned to unit ID 186.
DELETE FROM CREWMATE cr
WHERE cr.crID IN (
  SELECT cr.crID
  FROM CREWMATE cr
  JOIN TANK t ON t.cID = cr.cID
  JOIN UNIT u ON u.unID = t.unID
  WHERE u.unID = 186
);



--- Update Queries

-- Update Query 1 : Updates the uName (unit name) to 'Inactive Unit' for units  that have not participated in any missions  within the last 12 months .
UPDATE UNIT u
SET u.uName = 'Inactive Unit'
WHERE u.unID NOT IN (
  SELECT p.unID
  FROM participates p
  WHERE p.mID IN (
    SELECT m.mID
    FROM MISSION m
    WHERE m.mdate >= ADD_MONTHS(SYSDATE, -12)
  )
);

-- Update Query 2 : Updates the firstName and lastName of the commander (COMMANDER table) assigned to unit ID 10.
UPDATE COMMANDER
SET firstName = 'Ano',
    lastName = 'Nimi'
WHERE cID = (
    SELECT u.cID
    FROM UNIT u
    WHERE u.unID = 101
);
