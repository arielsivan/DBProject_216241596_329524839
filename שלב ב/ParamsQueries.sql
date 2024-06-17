-- Query 1 : Retrieves all columns from the TANK table for units with specific names.
SELECT t.* FROM TANK t
JOIN UNIT u ON t.unID = u.unID
WHERE u.uName Like &<name="names" list=" ' Utzvat HaPlada', ' Bnei Or', ' Sinai', ' Star of light', ' Yiftach' " >

-- Query 2 : Retrieves mission ID, mission date, and the count of participating units for missions with more than a specified number of participating units.
SELECT m.mID AS missionID,
SELECT m.mID AS missionID,
       m.mdate AS missionDate,
       COUNT(p.unID) AS numberOfParticipatingUnits
FROM MISSION m
JOIN participates p ON m.mID = p.mID
GROUP BY m.mID, m.mdate 
HAVING COUNT(p.unID) > &<name = "number of units" hint="number of units can be from 1 to 5" type="integer">
ORDER BY numberOfParticipatingUnits DESC;

-- Query 3 : Updates the releaseDate of soldiers based on the inputted first name.
UPDATE SOLDIERS s
SET releaseDate = TO_DATE(&<name="new release date" type="date">, 'YYYY-MM-DD')
WHERE s.firstName = &<name = "first name">;

-- Query 4 : Deletes records from participates table where the mission ID matches the inputted mission ID.
DELETE FROM participates
WHERE mID = &<name="mission id" type="integer" hint="mission id is between 0 and 2000">;
