--ensure draftDate is before releaseDate in the SOLDIERS table:
ALTER TABLE SOLDIERS
ADD CONSTRAINT chk_draft_release_dates CHECK (draftDate < releaseDate);

-- ensure each unit has a unique name
ALTER TABLE UNIT
ADD CONSTRAINT uk_unit_name UNIQUE (uName);

--This ensures that every crew member (CREWMATE) must have a specified type.
ALTER TABLE CREWMATE
MODIFY (type VARCHAR(20) NOT NULL);
