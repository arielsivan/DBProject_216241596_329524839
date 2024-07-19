prompt PL/SQL Developer Export Tables for user SYS
prompt Created by USER on Friday, July 19, 2024
set feedback off
set define off

prompt Creating SOLDIERS...
create table SOLDIERS
(
  sid         NUMBER(9) not null,
  firstname   VARCHAR2(20) not null,
  lastname    VARCHAR2(20) not null,
  draftdate   DATE not null,
  releasedate DATE not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SOLDIERS
  add primary key (SID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SOLDIERS
  add constraint CHK_DRAFT_RELEASE_DATES
  check (draftDate < releaseDate);

prompt Creating COMMANDER...
create table COMMANDER
(
  cid NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table COMMANDER
  add primary key (CID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table COMMANDER
  add foreign key (CID)
  references SOLDIERS (SID);

prompt Creating CREWMATE...
create table CREWMATE
(
  type VARCHAR2(20) not null,
  crid NUMBER(9) not null,
  cid  NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CREWMATE
  add primary key (CRID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CREWMATE
  add foreign key (CRID)
  references SOLDIERS (SID);
alter table CREWMATE
  add foreign key (CID)
  references COMMANDER (CID);

prompt Creating MISSION...
create table MISSION
(
  mdate DATE not null,
  mid   NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MISSION
  add primary key (MID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating UNIT...
create table UNIT
(
  unid  NUMBER(9) not null,
  uname VARCHAR2(20) not null,
  cid   NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table UNIT
  add primary key (UNID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table UNIT
  add constraint UK_UNIT_NAME unique (UNAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table UNIT
  add foreign key (CID)
  references COMMANDER (CID);

prompt Creating PARTICIPATES...
create table PARTICIPATES
(
  mid  NUMBER(9) not null,
  unid NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PARTICIPATES
  add primary key (MID, UNID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PARTICIPATES
  add foreign key (MID)
  references MISSION (MID);
alter table PARTICIPATES
  add foreign key (UNID)
  references UNIT (UNID);

prompt Creating TANK...
create table TANK
(
  tid  NUMBER(9) not null,
  unid NUMBER(9) not null,
  cid  NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TANK
  add primary key (TID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TANK
  add foreign key (UNID)
  references UNIT (UNID);
alter table TANK
  add foreign key (CID)
  references COMMANDER (CID);

prompt Disabling triggers for SOLDIERS...
alter table SOLDIERS disable all triggers;
prompt Disabling triggers for COMMANDER...
alter table COMMANDER disable all triggers;
prompt Disabling triggers for CREWMATE...
alter table CREWMATE disable all triggers;
prompt Disabling triggers for MISSION...
alter table MISSION disable all triggers;
prompt Disabling triggers for UNIT...
alter table UNIT disable all triggers;
prompt Disabling triggers for PARTICIPATES...
alter table PARTICIPATES disable all triggers;
prompt Disabling triggers for TANK...
alter table TANK disable all triggers;
prompt Disabling foreign key constraints for COMMANDER...
alter table COMMANDER disable constraint SYS_C008381;
prompt Disabling foreign key constraints for CREWMATE...
alter table CREWMATE disable constraint SYS_C008386;
alter table CREWMATE disable constraint SYS_C008387;
prompt Disabling foreign key constraints for UNIT...
alter table UNIT disable constraint SYS_C008392;
prompt Disabling foreign key constraints for PARTICIPATES...
alter table PARTICIPATES disable constraint SYS_C008407;
alter table PARTICIPATES disable constraint SYS_C008408;
prompt Disabling foreign key constraints for TANK...
alter table TANK disable constraint SYS_C008397;
alter table TANK disable constraint SYS_C008398;
prompt Deleting TANK...
delete from TANK;
commit;
prompt Deleting PARTICIPATES...
delete from PARTICIPATES;
commit;
prompt Deleting UNIT...
delete from UNIT;
commit;
prompt Deleting MISSION...
delete from MISSION;
commit;
prompt Deleting CREWMATE...
delete from CREWMATE;
commit;
prompt Deleting COMMANDER...
delete from COMMANDER;
commit;
prompt Deleting SOLDIERS...
delete from SOLDIERS;
commit;
prompt Loading SOLDIERS...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (426, 'Elizabeth', 'Wiest', to_date('04-01-2006', 'dd-mm-yyyy'), to_date('28-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (427, 'Robin', 'Penn', to_date('21-06-2006', 'dd-mm-yyyy'), to_date('27-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (428, 'Tobey', 'DeLuise', to_date('10-11-2006', 'dd-mm-yyyy'), to_date('25-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (429, 'Stellan', 'Hatfield', to_date('06-11-2006', 'dd-mm-yyyy'), to_date('12-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (430, 'Hex', 'Rio', to_date('25-03-2006', 'dd-mm-yyyy'), to_date('24-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (431, 'Leon', 'Blanchett', to_date('29-11-2006', 'dd-mm-yyyy'), to_date('06-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (432, 'Brad', 'Perez', to_date('23-02-2006', 'dd-mm-yyyy'), to_date('30-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (433, 'Sally', 'Fonda', to_date('21-02-2006', 'dd-mm-yyyy'), to_date('02-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (434, 'Dustin', 'Ripley', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('20-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (435, 'Gene', 'Keitel', to_date('13-02-2006', 'dd-mm-yyyy'), to_date('02-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (436, 'Wendy', 'Witherspoon', to_date('21-09-2006', 'dd-mm-yyyy'), to_date('12-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (437, 'Allison', 'Noseworthy', to_date('23-03-2006', 'dd-mm-yyyy'), to_date('16-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (438, 'Daniel', 'Glover', to_date('15-07-2006', 'dd-mm-yyyy'), to_date('10-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (439, 'Suzi', 'Quaid', to_date('10-08-2006', 'dd-mm-yyyy'), to_date('04-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (440, 'Jesus', 'Moore', to_date('11-09-2006', 'dd-mm-yyyy'), to_date('17-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (441, 'Freddie', 'Goodman', to_date('06-07-2006', 'dd-mm-yyyy'), to_date('03-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (442, 'Howie', 'Coltrane', to_date('05-10-2006', 'dd-mm-yyyy'), to_date('07-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (443, 'Emily', 'Bush', to_date('12-11-2006', 'dd-mm-yyyy'), to_date('10-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (444, 'Emilio', 'Sweet', to_date('04-12-2006', 'dd-mm-yyyy'), to_date('06-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (445, 'Joaquin', 'Place', to_date('25-03-2006', 'dd-mm-yyyy'), to_date('29-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (446, 'Art', 'Caine', to_date('30-10-2006', 'dd-mm-yyyy'), to_date('21-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (447, 'Aida', 'Crimson', to_date('08-01-2006', 'dd-mm-yyyy'), to_date('18-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (448, 'James', 'Rankin', to_date('19-09-2006', 'dd-mm-yyyy'), to_date('17-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (449, 'Edgar', 'Flatts', to_date('31-01-2006', 'dd-mm-yyyy'), to_date('22-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (450, 'Marty', 'Danes', to_date('24-11-2006', 'dd-mm-yyyy'), to_date('08-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (451, 'Debbie', 'Shand', to_date('14-07-2006', 'dd-mm-yyyy'), to_date('17-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (452, 'Candice', 'Roberts', to_date('04-07-2006', 'dd-mm-yyyy'), to_date('24-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (453, 'Rich', 'Woodard', to_date('16-12-2006', 'dd-mm-yyyy'), to_date('18-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (454, 'Vonda', 'McGovern', to_date('07-08-2006', 'dd-mm-yyyy'), to_date('27-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (455, 'Timothy', 'Ball', to_date('20-11-2006', 'dd-mm-yyyy'), to_date('05-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (456, 'Charlize', 'Carrey', to_date('17-07-2006', 'dd-mm-yyyy'), to_date('28-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (457, 'Kristin', 'Reiner', to_date('10-08-2006', 'dd-mm-yyyy'), to_date('19-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (458, 'Lily', 'Holm', to_date('21-09-2006', 'dd-mm-yyyy'), to_date('05-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (459, 'Chrissie', 'Barry', to_date('10-04-2006', 'dd-mm-yyyy'), to_date('31-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (460, 'Wesley', 'Klugh', to_date('30-07-2006', 'dd-mm-yyyy'), to_date('12-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (461, 'Lupe', 'Playboys', to_date('02-05-2006', 'dd-mm-yyyy'), to_date('01-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (462, 'Nanci', 'Sepulveda', to_date('29-11-2006', 'dd-mm-yyyy'), to_date('19-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (463, 'Chrissie', 'Burke', to_date('11-04-2006', 'dd-mm-yyyy'), to_date('09-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (464, 'Wesley', 'Torino', to_date('25-07-2006', 'dd-mm-yyyy'), to_date('06-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (465, 'Taylor', 'Armstrong', to_date('03-09-2006', 'dd-mm-yyyy'), to_date('13-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (466, 'Liam', 'Sherman', to_date('06-05-2006', 'dd-mm-yyyy'), to_date('29-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (467, 'Liquid', 'Lee', to_date('24-07-2006', 'dd-mm-yyyy'), to_date('03-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (468, 'Lonnie', 'Sweet', to_date('30-04-2006', 'dd-mm-yyyy'), to_date('01-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (469, 'Hilary', 'Sizemore', to_date('06-02-2006', 'dd-mm-yyyy'), to_date('23-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (470, 'Matt', 'Getty', to_date('03-06-2006', 'dd-mm-yyyy'), to_date('09-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (471, 'Merle', 'Landau', to_date('28-07-2006', 'dd-mm-yyyy'), to_date('27-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (472, 'Joseph', 'Craig', to_date('07-04-2006', 'dd-mm-yyyy'), to_date('21-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (473, 'Chad', 'Delta', to_date('09-09-2006', 'dd-mm-yyyy'), to_date('04-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (474, 'Mia', 'Anderson', to_date('14-06-2006', 'dd-mm-yyyy'), to_date('13-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (475, 'Hex', 'Cromwell', to_date('16-03-2006', 'dd-mm-yyyy'), to_date('14-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (476, 'Roddy', 'Stanley', to_date('11-01-2006', 'dd-mm-yyyy'), to_date('08-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (477, 'Meredith', 'Capshaw', to_date('30-10-2006', 'dd-mm-yyyy'), to_date('20-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (478, 'Trini', 'Deschanel', to_date('07-05-2006', 'dd-mm-yyyy'), to_date('27-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (479, 'Regina', 'Matthau', to_date('01-07-2006', 'dd-mm-yyyy'), to_date('20-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (480, 'Harris', 'Caan', to_date('16-03-2006', 'dd-mm-yyyy'), to_date('12-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (481, 'Todd', 'Domino', to_date('23-11-2006', 'dd-mm-yyyy'), to_date('25-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (482, 'Liev', 'Basinger', to_date('22-04-2006', 'dd-mm-yyyy'), to_date('22-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (483, 'Vince', 'Graham', to_date('02-05-2006', 'dd-mm-yyyy'), to_date('28-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (484, 'Rawlins', 'Finney', to_date('09-01-2006', 'dd-mm-yyyy'), to_date('13-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (485, 'Rhett', 'Biehn', to_date('06-12-2006', 'dd-mm-yyyy'), to_date('17-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (486, 'Josh', 'Branch', to_date('30-06-2006', 'dd-mm-yyyy'), to_date('05-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (487, 'Jane', 'Winslet', to_date('08-02-2006', 'dd-mm-yyyy'), to_date('31-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (488, 'Maury', 'Short', to_date('08-01-2006', 'dd-mm-yyyy'), to_date('29-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (489, 'Tobey', 'Polley', to_date('11-05-2006', 'dd-mm-yyyy'), to_date('29-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (490, 'Phoebe', 'Linney', to_date('01-10-2006', 'dd-mm-yyyy'), to_date('06-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (491, 'Charles', 'Lerner', to_date('01-06-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (492, 'Rebecca', 'Caine', to_date('27-09-2006', 'dd-mm-yyyy'), to_date('18-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (493, 'Curtis', 'Viterelli', to_date('21-08-2006', 'dd-mm-yyyy'), to_date('27-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (494, 'Ralph', 'Zeta-Jones', to_date('02-04-2006', 'dd-mm-yyyy'), to_date('18-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (495, 'Sheryl', 'Miller', to_date('07-10-2006', 'dd-mm-yyyy'), to_date('04-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (496, 'Jackson', 'Leguizamo', to_date('03-06-2006', 'dd-mm-yyyy'), to_date('20-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (497, 'Peabo', 'Bachman', to_date('22-12-2006', 'dd-mm-yyyy'), to_date('24-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (498, 'Grant', 'Magnuson', to_date('19-03-2006', 'dd-mm-yyyy'), to_date('16-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (499, 'Dar', 'James', to_date('29-03-2006', 'dd-mm-yyyy'), to_date('04-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (500, 'Gena', 'Derringer', to_date('06-09-2006', 'dd-mm-yyyy'), to_date('13-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (501, 'Daryl', 'Rosas', to_date('02-01-2006', 'dd-mm-yyyy'), to_date('20-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (502, 'Azucar', 'McCoy', to_date('28-07-2006', 'dd-mm-yyyy'), to_date('09-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (503, 'Stanley', 'Napolitano', to_date('10-03-2006', 'dd-mm-yyyy'), to_date('19-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (504, 'Betty', 'Garr', to_date('16-03-2006', 'dd-mm-yyyy'), to_date('22-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (505, 'Todd', 'Haggard', to_date('21-06-2006', 'dd-mm-yyyy'), to_date('07-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (506, 'Dianne', 'Richardson', to_date('06-09-2006', 'dd-mm-yyyy'), to_date('03-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (507, 'Stephanie', 'Crudup', to_date('02-12-2006', 'dd-mm-yyyy'), to_date('15-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (508, 'Cheech', 'McGoohan', to_date('06-06-2006', 'dd-mm-yyyy'), to_date('06-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (509, 'Bryan', 'Haslam', to_date('02-12-2006', 'dd-mm-yyyy'), to_date('18-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (510, 'Gaby', 'Winans', to_date('29-12-2006', 'dd-mm-yyyy'), to_date('01-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (511, 'Miriam', 'Kramer', to_date('26-05-2006', 'dd-mm-yyyy'), to_date('01-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (512, 'Colm', 'LaPaglia', to_date('28-03-2006', 'dd-mm-yyyy'), to_date('23-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (513, 'Aida', 'Overstreet', to_date('24-05-2006', 'dd-mm-yyyy'), to_date('02-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (514, 'Trini', 'Estevez', to_date('29-09-2006', 'dd-mm-yyyy'), to_date('08-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (515, 'Greg', 'Brooke', to_date('28-11-2006', 'dd-mm-yyyy'), to_date('25-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (516, 'Cheech', 'Chilton', to_date('22-08-2006', 'dd-mm-yyyy'), to_date('06-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (517, 'Cary', 'Garner', to_date('08-02-2006', 'dd-mm-yyyy'), to_date('12-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (518, 'Connie', 'Sheen', to_date('22-08-2006', 'dd-mm-yyyy'), to_date('10-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (519, 'Taye', 'Spears', to_date('07-10-2006', 'dd-mm-yyyy'), to_date('15-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (520, 'Kenny', 'Day-Lewis', to_date('21-06-2006', 'dd-mm-yyyy'), to_date('07-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (521, 'Jay', 'Mould', to_date('17-02-2006', 'dd-mm-yyyy'), to_date('12-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (522, 'Owen', 'Rucker', to_date('22-07-2006', 'dd-mm-yyyy'), to_date('19-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (523, 'Ernest', 'Pollak', to_date('24-12-2006', 'dd-mm-yyyy'), to_date('07-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (524, 'Joan', 'Sutherland', to_date('21-01-2006', 'dd-mm-yyyy'), to_date('31-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (525, 'Jon', 'Ward', to_date('05-02-2006', 'dd-mm-yyyy'), to_date('01-03-2009', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (526, 'Andrea', 'Feuerstein', to_date('16-03-2006', 'dd-mm-yyyy'), to_date('11-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (527, 'Nick', 'Pleasence', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('27-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (528, 'Andie', 'Randal', to_date('05-12-2006', 'dd-mm-yyyy'), to_date('06-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (529, 'Martin', 'Polito', to_date('18-11-2006', 'dd-mm-yyyy'), to_date('10-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (530, 'Lee', 'Hudson', to_date('03-11-2006', 'dd-mm-yyyy'), to_date('26-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (531, 'Petula', 'Taylor', to_date('28-03-2006', 'dd-mm-yyyy'), to_date('08-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (532, 'Hazel', 'Rodgers', to_date('29-06-2006', 'dd-mm-yyyy'), to_date('05-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (533, 'Edwin', 'Gatlin', to_date('11-04-2006', 'dd-mm-yyyy'), to_date('10-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (534, 'Taryn', 'Birch', to_date('13-12-2006', 'dd-mm-yyyy'), to_date('30-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (535, 'Mary Beth', 'Eldard', to_date('15-01-2006', 'dd-mm-yyyy'), to_date('18-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (536, 'Tamala', 'Evans', to_date('20-09-2006', 'dd-mm-yyyy'), to_date('14-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (537, 'Vertical', 'Chilton', to_date('09-09-2006', 'dd-mm-yyyy'), to_date('17-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (538, 'Bernie', 'Tinsley', to_date('02-12-2006', 'dd-mm-yyyy'), to_date('05-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (539, 'Faye', 'Reid', to_date('09-02-2006', 'dd-mm-yyyy'), to_date('11-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (540, 'Jimmie', 'Shawn', to_date('02-11-2006', 'dd-mm-yyyy'), to_date('25-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (541, 'Mary', 'Grant', to_date('01-11-2006', 'dd-mm-yyyy'), to_date('28-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (542, 'Lisa', 'Garza', to_date('27-09-2006', 'dd-mm-yyyy'), to_date('25-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (543, 'Nicolas', 'Barnett', to_date('24-04-2006', 'dd-mm-yyyy'), to_date('29-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (544, 'Kelly', 'Carrack', to_date('09-01-2006', 'dd-mm-yyyy'), to_date('14-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (545, 'Praga', 'Ward', to_date('01-06-2006', 'dd-mm-yyyy'), to_date('15-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (546, 'Millie', 'Holm', to_date('06-09-2006', 'dd-mm-yyyy'), to_date('14-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (547, 'Tommy', 'Oates', to_date('09-05-2006', 'dd-mm-yyyy'), to_date('16-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (548, 'Ice', 'Bentley', to_date('27-01-2006', 'dd-mm-yyyy'), to_date('20-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (549, 'Luis', 'Nielsen', to_date('22-10-2006', 'dd-mm-yyyy'), to_date('01-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (550, 'Keith', 'Schiavelli', to_date('30-12-2006', 'dd-mm-yyyy'), to_date('30-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (551, 'Jackson', 'Rucker', to_date('16-06-2006', 'dd-mm-yyyy'), to_date('24-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (552, 'Jesse', 'Macht', to_date('07-02-2006', 'dd-mm-yyyy'), to_date('16-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (553, 'First', 'Starr', to_date('03-10-2006', 'dd-mm-yyyy'), to_date('06-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (554, 'Hookah', 'Patrick', to_date('05-08-2006', 'dd-mm-yyyy'), to_date('05-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (555, 'Bruce', 'Duncan', to_date('22-01-2006', 'dd-mm-yyyy'), to_date('16-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (556, 'Christina', 'Levin', to_date('29-03-2006', 'dd-mm-yyyy'), to_date('11-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (557, 'Clea', 'McNarland', to_date('19-01-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (558, 'Spencer', 'Plimpton', to_date('23-09-2006', 'dd-mm-yyyy'), to_date('15-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (559, 'Naomi', 'Lemmon', to_date('26-06-2006', 'dd-mm-yyyy'), to_date('19-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (560, 'Josh', 'Shue', to_date('19-04-2006', 'dd-mm-yyyy'), to_date('08-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (561, 'Ronny', 'Hubbard', to_date('25-03-2006', 'dd-mm-yyyy'), to_date('09-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (190, 'Laurence', 'Mandrell', to_date('10-03-2006', 'dd-mm-yyyy'), to_date('03-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (191, 'Chalee', 'DeGraw', to_date('13-02-2006', 'dd-mm-yyyy'), to_date('02-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (192, 'Trey', 'Stewart', to_date('19-02-2006', 'dd-mm-yyyy'), to_date('16-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (193, 'Patricia', 'Chinlund', to_date('22-12-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (194, 'Casey', 'Assante', to_date('02-08-2006', 'dd-mm-yyyy'), to_date('17-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (195, 'Rowan', 'Reed', to_date('27-10-2006', 'dd-mm-yyyy'), to_date('13-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (196, 'Bette', 'Stiller', to_date('06-10-2006', 'dd-mm-yyyy'), to_date('07-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (197, 'Juliana', 'Akins', to_date('13-12-2006', 'dd-mm-yyyy'), to_date('07-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (198, 'Matthew', 'Kattan', to_date('22-01-2006', 'dd-mm-yyyy'), to_date('19-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (199, 'Barry', 'Chung', to_date('08-11-2006', 'dd-mm-yyyy'), to_date('24-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (200, 'Raymond', 'Grier', to_date('04-06-2006', 'dd-mm-yyyy'), to_date('01-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (201, 'Brothers', 'Cummings', to_date('12-01-2006', 'dd-mm-yyyy'), to_date('05-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (202, 'Nicolas', 'Wiedlin', to_date('01-02-2006', 'dd-mm-yyyy'), to_date('02-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (203, 'Bernard', 'McCracken', to_date('04-02-2006', 'dd-mm-yyyy'), to_date('30-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (204, 'Neneh', 'Venora', to_date('24-07-2006', 'dd-mm-yyyy'), to_date('17-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (205, 'Stockard', 'Schneider', to_date('17-03-2006', 'dd-mm-yyyy'), to_date('20-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (206, 'Rod', 'Mitchell', to_date('29-12-2006', 'dd-mm-yyyy'), to_date('25-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (207, 'Emm', 'Diddley', to_date('24-10-2006', 'dd-mm-yyyy'), to_date('13-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (208, 'Hilary', 'Mohr', to_date('22-10-2006', 'dd-mm-yyyy'), to_date('03-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (209, 'Udo', 'Todd', to_date('15-09-2006', 'dd-mm-yyyy'), to_date('18-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (210, 'Hector', 'Hanley', to_date('26-08-2006', 'dd-mm-yyyy'), to_date('21-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (211, 'Kristin', 'Goldwyn', to_date('16-05-2006', 'dd-mm-yyyy'), to_date('16-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (212, 'Jonny', 'Sevigny', to_date('06-09-2006', 'dd-mm-yyyy'), to_date('17-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (213, 'Horace', 'McDowall', to_date('07-09-2006', 'dd-mm-yyyy'), to_date('08-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (214, 'Alicia', 'Blige', to_date('22-02-2006', 'dd-mm-yyyy'), to_date('01-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (215, 'Diane', 'Bridges', to_date('21-11-2006', 'dd-mm-yyyy'), to_date('28-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (216, 'Rufus', 'Driver', to_date('08-04-2006', 'dd-mm-yyyy'), to_date('01-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (217, 'Kenneth', 'Stallone', to_date('29-11-2006', 'dd-mm-yyyy'), to_date('29-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (218, 'Neneh', 'Foley', to_date('21-06-2006', 'dd-mm-yyyy'), to_date('31-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (219, 'Marlon', 'Lopez', to_date('16-12-2006', 'dd-mm-yyyy'), to_date('28-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (220, 'Rob', 'Tinsley', to_date('23-11-2006', 'dd-mm-yyyy'), to_date('27-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (221, 'Wade', 'McDormand', to_date('18-06-2006', 'dd-mm-yyyy'), to_date('01-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (222, 'Tcheky', 'Hiatt', to_date('26-03-2006', 'dd-mm-yyyy'), to_date('12-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (223, 'Saffron', 'May', to_date('22-04-2006', 'dd-mm-yyyy'), to_date('04-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (224, 'Gordon', 'Turner', to_date('08-11-2006', 'dd-mm-yyyy'), to_date('26-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (225, 'Zooey', 'Imperioli', to_date('24-05-2006', 'dd-mm-yyyy'), to_date('05-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (226, 'Suzi', 'Giraldo', to_date('23-04-2006', 'dd-mm-yyyy'), to_date('14-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (227, 'Debbie', 'Swank', to_date('30-06-2006', 'dd-mm-yyyy'), to_date('18-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (228, 'Fairuza', 'McCormack', to_date('20-01-2006', 'dd-mm-yyyy'), to_date('22-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (229, 'Lenny', 'Seagal', to_date('10-06-2006', 'dd-mm-yyyy'), to_date('23-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (230, 'Robin', 'Phoenix', to_date('24-07-2006', 'dd-mm-yyyy'), to_date('22-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (231, 'Javon', 'Shearer', to_date('10-08-2006', 'dd-mm-yyyy'), to_date('10-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (232, 'Janice', 'D''Onofrio', to_date('18-09-2006', 'dd-mm-yyyy'), to_date('06-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (233, 'Lena', 'Rucker', to_date('17-09-2006', 'dd-mm-yyyy'), to_date('25-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (234, 'Teri', 'McCain', to_date('05-07-2006', 'dd-mm-yyyy'), to_date('06-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (235, 'Mika', 'Holly', to_date('08-12-2006', 'dd-mm-yyyy'), to_date('27-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (236, 'Philip', 'Dushku', to_date('28-01-2006', 'dd-mm-yyyy'), to_date('10-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (237, 'Alfie', 'Bacharach', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('22-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (238, 'Randy', 'Malone', to_date('07-01-2006', 'dd-mm-yyyy'), to_date('06-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (239, 'Rolando', 'Diggs', to_date('02-09-2006', 'dd-mm-yyyy'), to_date('19-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (240, 'Nanci', 'Uggams', to_date('21-01-2006', 'dd-mm-yyyy'), to_date('16-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (241, 'Eric', 'Sanders', to_date('08-04-2006', 'dd-mm-yyyy'), to_date('02-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (242, 'Isabella', 'Monk', to_date('27-12-2006', 'dd-mm-yyyy'), to_date('30-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (243, 'Nile', 'Holmes', to_date('30-07-2006', 'dd-mm-yyyy'), to_date('23-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (244, 'Collin', 'Harary', to_date('18-12-2006', 'dd-mm-yyyy'), to_date('04-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (245, 'Crispin', 'Rush', to_date('06-10-2006', 'dd-mm-yyyy'), to_date('01-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (246, 'Lara', 'Broadbent', to_date('21-01-2006', 'dd-mm-yyyy'), to_date('07-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (247, 'Drew', 'Langella', to_date('12-09-2006', 'dd-mm-yyyy'), to_date('25-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (248, 'Ahmad', 'Mitra', to_date('04-03-2006', 'dd-mm-yyyy'), to_date('21-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (249, 'Dwight', 'Chappelle', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('25-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (250, 'Olympia', 'McFerrin', to_date('03-04-2006', 'dd-mm-yyyy'), to_date('08-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (251, 'Martin', 'Ifans', to_date('14-01-2006', 'dd-mm-yyyy'), to_date('22-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (252, 'Roger', 'Griffin', to_date('21-10-2006', 'dd-mm-yyyy'), to_date('22-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (253, 'Shirley', 'Hamilton', to_date('20-01-2006', 'dd-mm-yyyy'), to_date('18-07-2009', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (254, 'Lili', 'Wainwright', to_date('20-09-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (255, 'Joey', 'Levin', to_date('25-03-2006', 'dd-mm-yyyy'), to_date('09-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (256, 'Jessica', 'Badalucco', to_date('08-06-2006', 'dd-mm-yyyy'), to_date('16-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (257, 'Joshua', 'Eckhart', to_date('21-10-2006', 'dd-mm-yyyy'), to_date('25-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (258, 'Tea', 'Cash', to_date('18-05-2006', 'dd-mm-yyyy'), to_date('04-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (259, 'Bernard', 'Evans', to_date('04-04-2006', 'dd-mm-yyyy'), to_date('04-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (260, 'Annie', 'Paige', to_date('03-10-2006', 'dd-mm-yyyy'), to_date('03-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (261, 'Regina', 'Stewart', to_date('11-06-2006', 'dd-mm-yyyy'), to_date('24-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (262, 'Alana', 'Donovan', to_date('16-08-2006', 'dd-mm-yyyy'), to_date('10-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (263, 'Mac', 'Lang', to_date('12-02-2006', 'dd-mm-yyyy'), to_date('07-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (264, 'Emerson', 'Tanon', to_date('16-04-2006', 'dd-mm-yyyy'), to_date('15-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (265, 'Ted', 'Hackman', to_date('22-09-2006', 'dd-mm-yyyy'), to_date('12-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (266, 'Ozzy', 'Heslov', to_date('07-01-2006', 'dd-mm-yyyy'), to_date('17-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (267, 'Darius', 'Baranski', to_date('08-07-2006', 'dd-mm-yyyy'), to_date('29-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (268, 'Katrin', 'Russo', to_date('21-01-2006', 'dd-mm-yyyy'), to_date('02-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (269, 'Marty', 'Brooks', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('24-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (270, 'Orlando', 'Parsons', to_date('18-12-2006', 'dd-mm-yyyy'), to_date('07-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (271, 'Emmylou', 'Tierney', to_date('22-07-2006', 'dd-mm-yyyy'), to_date('16-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (272, 'Wally', 'Trejo', to_date('08-04-2006', 'dd-mm-yyyy'), to_date('19-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (273, 'Joy', 'Holden', to_date('28-09-2006', 'dd-mm-yyyy'), to_date('13-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (274, 'Mekhi', 'Blossoms', to_date('28-05-2006', 'dd-mm-yyyy'), to_date('30-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (275, 'Marley', 'Bening', to_date('01-06-2006', 'dd-mm-yyyy'), to_date('28-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (276, 'Albertina', 'Cox', to_date('07-01-2006', 'dd-mm-yyyy'), to_date('29-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (277, 'Ani', 'Orlando', to_date('09-07-2006', 'dd-mm-yyyy'), to_date('12-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (278, 'Elizabeth', 'Holy', to_date('06-07-2006', 'dd-mm-yyyy'), to_date('24-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (279, 'Louise', 'Kapanka', to_date('22-01-2006', 'dd-mm-yyyy'), to_date('18-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (280, 'Darius', 'Soul', to_date('19-12-2006', 'dd-mm-yyyy'), to_date('22-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (281, 'Antonio', 'Carrack', to_date('26-05-2006', 'dd-mm-yyyy'), to_date('20-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (282, 'Rik', 'Gary', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('17-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (283, 'Goran', 'Wahlberg', to_date('21-11-2006', 'dd-mm-yyyy'), to_date('10-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (284, 'Lynette', 'Harry', to_date('14-01-2006', 'dd-mm-yyyy'), to_date('30-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (285, 'Matt', 'Vince', to_date('12-10-2006', 'dd-mm-yyyy'), to_date('08-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (286, 'Terry', 'Christie', to_date('13-08-2006', 'dd-mm-yyyy'), to_date('22-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (287, 'Angelina', 'Cole', to_date('21-06-2006', 'dd-mm-yyyy'), to_date('22-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (288, 'Scott', 'Kattan', to_date('30-01-2006', 'dd-mm-yyyy'), to_date('09-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (289, 'Jim', 'Archer', to_date('21-01-2006', 'dd-mm-yyyy'), to_date('15-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (290, 'Bette', 'Suchet', to_date('04-04-2006', 'dd-mm-yyyy'), to_date('08-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (291, 'Temuera', 'Martinez', to_date('13-03-2006', 'dd-mm-yyyy'), to_date('06-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (292, 'Judge', 'Tambor', to_date('02-08-2006', 'dd-mm-yyyy'), to_date('30-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (293, 'Tracy', 'Balin', to_date('16-04-2006', 'dd-mm-yyyy'), to_date('14-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (294, 'Maura', 'Brothers', to_date('18-03-2006', 'dd-mm-yyyy'), to_date('09-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (295, 'Madeleine', 'Englund', to_date('20-12-2006', 'dd-mm-yyyy'), to_date('20-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (296, 'Yaphet', 'Lizzy', to_date('12-05-2006', 'dd-mm-yyyy'), to_date('15-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (297, 'Joaquim', 'Getty', to_date('27-11-2006', 'dd-mm-yyyy'), to_date('01-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (298, 'Ann', 'Vince', to_date('28-01-2006', 'dd-mm-yyyy'), to_date('23-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (299, 'Donald', 'Bosco', to_date('01-12-2006', 'dd-mm-yyyy'), to_date('12-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (300, 'Brooke', 'Diehl', to_date('20-03-2006', 'dd-mm-yyyy'), to_date('14-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (301, 'Juan', 'Stoltz', to_date('25-05-2006', 'dd-mm-yyyy'), to_date('01-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (302, 'Bernie', 'Winter', to_date('18-10-2006', 'dd-mm-yyyy'), to_date('10-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (303, 'Oded', 'Gandolfini', to_date('20-01-2006', 'dd-mm-yyyy'), to_date('06-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (304, 'Temuera', 'Sinise', to_date('26-08-2006', 'dd-mm-yyyy'), to_date('05-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (305, 'Rip', 'Carrack', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('27-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (306, 'Vince', 'Deschanel', to_date('12-05-2006', 'dd-mm-yyyy'), to_date('04-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (307, 'Rawlins', 'Tanon', to_date('22-12-2006', 'dd-mm-yyyy'), to_date('05-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (308, 'Brent', 'Yorn', to_date('20-07-2006', 'dd-mm-yyyy'), to_date('18-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (309, 'Nicolas', 'Broderick', to_date('16-04-2006', 'dd-mm-yyyy'), to_date('16-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (310, 'Matt', 'Bancroft', to_date('20-06-2006', 'dd-mm-yyyy'), to_date('15-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (311, 'Eileen', 'Brooke', to_date('21-07-2006', 'dd-mm-yyyy'), to_date('14-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (312, 'Brendan', 'Crudup', to_date('12-11-2006', 'dd-mm-yyyy'), to_date('26-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (313, 'Christine', 'Conners', to_date('08-02-2006', 'dd-mm-yyyy'), to_date('19-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (314, 'Roscoe', 'Atkins', to_date('27-03-2006', 'dd-mm-yyyy'), to_date('15-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (315, 'Giancarlo', 'Orton', to_date('11-08-2006', 'dd-mm-yyyy'), to_date('23-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (316, 'Fiona', 'Playboys', to_date('21-04-2006', 'dd-mm-yyyy'), to_date('08-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (317, 'Allan', 'Ceasar', to_date('24-12-2006', 'dd-mm-yyyy'), to_date('05-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (318, 'Gwyneth', 'Balaban', to_date('17-11-2006', 'dd-mm-yyyy'), to_date('04-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (319, 'Lorraine', 'Nicholson', to_date('15-08-2006', 'dd-mm-yyyy'), to_date('15-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (320, 'Denzel', 'Jackson', to_date('03-01-2006', 'dd-mm-yyyy'), to_date('23-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (321, 'Collin', 'Barkin', to_date('22-12-2006', 'dd-mm-yyyy'), to_date('11-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (322, 'Ewan', 'Bonham', to_date('27-05-2006', 'dd-mm-yyyy'), to_date('15-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (323, 'Eddie', 'Goldwyn', to_date('24-05-2006', 'dd-mm-yyyy'), to_date('28-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (324, 'Phil', 'Whitman', to_date('03-04-2006', 'dd-mm-yyyy'), to_date('01-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (325, 'Robbie', 'Crewson', to_date('26-04-2006', 'dd-mm-yyyy'), to_date('30-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (326, 'Bebe', 'Diesel', to_date('12-04-2006', 'dd-mm-yyyy'), to_date('05-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (327, 'Joey', 'Field', to_date('01-10-2006', 'dd-mm-yyyy'), to_date('24-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (328, 'Dean', 'Hersh', to_date('20-02-2006', 'dd-mm-yyyy'), to_date('26-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (329, 'Jody', 'Benet', to_date('04-02-2006', 'dd-mm-yyyy'), to_date('26-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (330, 'Powers', 'Orlando', to_date('22-02-2006', 'dd-mm-yyyy'), to_date('11-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (331, 'Frankie', 'Cherry', to_date('25-03-2006', 'dd-mm-yyyy'), to_date('06-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (332, 'Neve', 'Hagar', to_date('07-04-2006', 'dd-mm-yyyy'), to_date('05-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (333, 'Graham', 'Davis', to_date('16-12-2006', 'dd-mm-yyyy'), to_date('20-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (334, 'Davy', 'Janney', to_date('25-06-2006', 'dd-mm-yyyy'), to_date('11-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (335, 'Cevin', 'Neill', to_date('02-10-2006', 'dd-mm-yyyy'), to_date('25-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (336, 'Charles', 'Vince', to_date('03-06-2006', 'dd-mm-yyyy'), to_date('20-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (337, 'Kim', 'Folds', to_date('16-10-2006', 'dd-mm-yyyy'), to_date('21-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (338, 'Famke', 'McGill', to_date('25-04-2006', 'dd-mm-yyyy'), to_date('09-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (339, 'Neve', 'Loeb', to_date('04-05-2006', 'dd-mm-yyyy'), to_date('19-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (340, 'Lou', 'Logue', to_date('12-04-2006', 'dd-mm-yyyy'), to_date('20-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (341, 'Victoria', 'Wainwright', to_date('30-05-2006', 'dd-mm-yyyy'), to_date('15-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (342, 'Adam', 'Wayans', to_date('20-11-2006', 'dd-mm-yyyy'), to_date('29-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (343, 'Freddy', 'Lithgow', to_date('07-10-2006', 'dd-mm-yyyy'), to_date('18-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (344, 'Frederic', 'Travers', to_date('29-01-2006', 'dd-mm-yyyy'), to_date('18-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (345, 'Solomon', 'Nunn', to_date('26-03-2006', 'dd-mm-yyyy'), to_date('27-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (346, 'Nicholas', 'Coe', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('25-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (347, 'Bridget', 'Del Toro', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('06-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (348, 'Benicio', 'Bonneville', to_date('25-04-2006', 'dd-mm-yyyy'), to_date('03-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (349, 'Rufus', 'Sossamon', to_date('28-12-2006', 'dd-mm-yyyy'), to_date('18-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (350, 'France', 'McCoy', to_date('22-06-2006', 'dd-mm-yyyy'), to_date('04-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (351, 'Cathy', 'Blair', to_date('08-04-2006', 'dd-mm-yyyy'), to_date('23-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (352, 'Dennis', 'Davidtz', to_date('03-06-2006', 'dd-mm-yyyy'), to_date('16-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (353, 'Viggo', 'Postlethwaite', to_date('27-05-2006', 'dd-mm-yyyy'), to_date('16-11-2009', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (354, 'Jodie', 'Darren', to_date('12-04-2006', 'dd-mm-yyyy'), to_date('14-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (355, 'Merillee', 'Dorff', to_date('10-12-2006', 'dd-mm-yyyy'), to_date('13-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (356, 'Adina', 'Norton', to_date('20-06-2006', 'dd-mm-yyyy'), to_date('27-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (357, 'Charlize', 'Crouse', to_date('10-11-2006', 'dd-mm-yyyy'), to_date('16-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (358, 'Olympia', 'Overstreet', to_date('15-10-2006', 'dd-mm-yyyy'), to_date('17-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (359, 'Dabney', 'Orton', to_date('19-01-2006', 'dd-mm-yyyy'), to_date('24-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (360, 'Lydia', 'Richards', to_date('01-11-2006', 'dd-mm-yyyy'), to_date('06-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (361, 'Crispin', 'Tanon', to_date('14-02-2006', 'dd-mm-yyyy'), to_date('02-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (362, 'Ralph', 'Branch', to_date('05-09-2006', 'dd-mm-yyyy'), to_date('06-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (363, 'Taryn', 'Stanley', to_date('14-07-2006', 'dd-mm-yyyy'), to_date('17-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (364, 'Jeff', 'Turturro', to_date('29-11-2006', 'dd-mm-yyyy'), to_date('27-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (365, 'Angie', 'Almond', to_date('30-12-2006', 'dd-mm-yyyy'), to_date('27-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (366, 'Lee', 'Blackwell', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('24-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (367, 'Lindsay', 'Weir', to_date('29-03-2006', 'dd-mm-yyyy'), to_date('19-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (368, 'Gailard', 'Jenkins', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('28-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (369, 'Thin', 'Furay', to_date('14-01-2006', 'dd-mm-yyyy'), to_date('24-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (370, 'Kieran', 'Nash', to_date('23-09-2006', 'dd-mm-yyyy'), to_date('29-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (371, 'Terrence', 'McGovern', to_date('05-08-2006', 'dd-mm-yyyy'), to_date('16-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (372, 'Maury', 'MacIsaac', to_date('27-11-2006', 'dd-mm-yyyy'), to_date('26-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (373, 'Loretta', 'Blair', to_date('19-03-2006', 'dd-mm-yyyy'), to_date('20-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (374, 'Rhett', 'Chaykin', to_date('24-09-2006', 'dd-mm-yyyy'), to_date('24-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (375, 'Philip', 'Stanton', to_date('17-04-2006', 'dd-mm-yyyy'), to_date('04-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (105, 'Kathy', 'Tambor', to_date('17-08-2006', 'dd-mm-yyyy'), to_date('30-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (106, 'Nick', 'Laurie', to_date('26-09-2006', 'dd-mm-yyyy'), to_date('07-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (107, 'Tal', 'Paquin', to_date('16-02-2006', 'dd-mm-yyyy'), to_date('13-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (108, 'Denise', 'O''Keefe', to_date('20-09-2006', 'dd-mm-yyyy'), to_date('28-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (109, 'Mekhi', 'Lavigne', to_date('18-03-2006', 'dd-mm-yyyy'), to_date('12-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (110, 'Thelma', 'Weisz', to_date('18-11-2006', 'dd-mm-yyyy'), to_date('30-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (111, 'Brenda', 'Williamson', to_date('23-07-2006', 'dd-mm-yyyy'), to_date('05-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (112, 'Adrien', 'Hoskins', to_date('25-09-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (113, 'Geraldine', 'Washington', to_date('02-03-2006', 'dd-mm-yyyy'), to_date('11-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (114, 'Kirk', 'Addy', to_date('30-06-2006', 'dd-mm-yyyy'), to_date('20-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (115, 'Bradley', 'Holy', to_date('10-09-2006', 'dd-mm-yyyy'), to_date('24-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (116, 'Julio', 'De Almeida', to_date('08-05-2006', 'dd-mm-yyyy'), to_date('06-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (117, 'Kyra', 'Holm', to_date('26-02-2006', 'dd-mm-yyyy'), to_date('31-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (118, 'Ron', 'Utada', to_date('18-01-2006', 'dd-mm-yyyy'), to_date('16-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (119, 'Stockard', 'Baranski', to_date('28-11-2006', 'dd-mm-yyyy'), to_date('17-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (120, 'Anita', 'Allan', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('25-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (121, 'Sally', 'Lemmon', to_date('14-12-2006', 'dd-mm-yyyy'), to_date('24-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (122, 'Ty', 'Flemyng', to_date('03-06-2006', 'dd-mm-yyyy'), to_date('19-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (123, 'Rachael', 'Eat World', to_date('21-07-2006', 'dd-mm-yyyy'), to_date('02-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (124, 'Teri', 'King', to_date('02-01-2006', 'dd-mm-yyyy'), to_date('20-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (125, 'Patty', 'Crowe', to_date('23-02-2006', 'dd-mm-yyyy'), to_date('21-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (126, 'Carlene', 'Watley', to_date('06-08-2006', 'dd-mm-yyyy'), to_date('27-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (127, 'Jessica', 'Sossamon', to_date('11-08-2006', 'dd-mm-yyyy'), to_date('17-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (128, 'Larenz', 'Albright', to_date('04-06-2006', 'dd-mm-yyyy'), to_date('15-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (129, 'Raymond', 'Renfro', to_date('18-10-2006', 'dd-mm-yyyy'), to_date('25-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (130, 'Randall', 'Secada', to_date('05-05-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (131, 'Geraldine', 'Sarandon', to_date('28-05-2006', 'dd-mm-yyyy'), to_date('12-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (132, 'Micky', 'Mitra', to_date('03-08-2006', 'dd-mm-yyyy'), to_date('03-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (133, 'Patti', 'Osmond', to_date('26-02-2006', 'dd-mm-yyyy'), to_date('01-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (134, 'Paul', 'Wainwright', to_date('23-11-2006', 'dd-mm-yyyy'), to_date('19-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (135, 'Moe', 'Gere', to_date('11-04-2006', 'dd-mm-yyyy'), to_date('06-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (136, 'Kevn', 'Summer', to_date('09-11-2006', 'dd-mm-yyyy'), to_date('03-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (137, 'Scott', 'Mortensen', to_date('29-04-2006', 'dd-mm-yyyy'), to_date('27-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (138, 'Julio', 'Horton', to_date('29-08-2006', 'dd-mm-yyyy'), to_date('23-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (139, 'Norm', 'Shue', to_date('11-04-2006', 'dd-mm-yyyy'), to_date('27-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (140, 'Bo', 'Stowe', to_date('04-02-2006', 'dd-mm-yyyy'), to_date('16-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (141, 'Wade', 'Hirsch', to_date('20-12-2006', 'dd-mm-yyyy'), to_date('04-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (142, 'Emma', 'Fogerty', to_date('20-11-2006', 'dd-mm-yyyy'), to_date('23-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (143, 'Ty', 'Preston', to_date('04-11-2006', 'dd-mm-yyyy'), to_date('09-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (144, 'Cuba', 'Busey', to_date('11-05-2006', 'dd-mm-yyyy'), to_date('23-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (145, 'Peter', 'Spacey', to_date('27-12-2006', 'dd-mm-yyyy'), to_date('27-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (146, 'Geraldine', 'Mann', to_date('14-05-2006', 'dd-mm-yyyy'), to_date('03-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (147, 'Dick', 'Kennedy', to_date('07-07-2006', 'dd-mm-yyyy'), to_date('07-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (148, 'Ray', 'Koyana', to_date('02-08-2006', 'dd-mm-yyyy'), to_date('08-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (149, 'Saffron', 'Rockwell', to_date('20-03-2006', 'dd-mm-yyyy'), to_date('27-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (150, 'Austin', 'Winter', to_date('06-02-2006', 'dd-mm-yyyy'), to_date('10-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (151, 'Blair', 'Knight', to_date('01-08-2006', 'dd-mm-yyyy'), to_date('15-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (152, 'Aaron', 'Cronin', to_date('14-04-2006', 'dd-mm-yyyy'), to_date('07-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (153, 'Beverley', 'Torino', to_date('01-02-2006', 'dd-mm-yyyy'), to_date('20-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (154, 'Darius', 'Clooney', to_date('06-01-2006', 'dd-mm-yyyy'), to_date('26-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (155, 'Nils', 'Biggs', to_date('21-10-2006', 'dd-mm-yyyy'), to_date('22-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (156, 'Kathleen', 'Phoenix', to_date('17-03-2006', 'dd-mm-yyyy'), to_date('14-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (157, 'Nanci', 'Stewart', to_date('06-05-2006', 'dd-mm-yyyy'), to_date('23-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (158, 'Bo', 'Heslov', to_date('18-08-2006', 'dd-mm-yyyy'), to_date('24-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (159, 'Goran', 'Gray', to_date('31-01-2006', 'dd-mm-yyyy'), to_date('28-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (160, 'Lena', 'Newman', to_date('24-01-2006', 'dd-mm-yyyy'), to_date('30-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (161, 'Jane', 'Barrymore', to_date('21-09-2006', 'dd-mm-yyyy'), to_date('10-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (162, 'Oliver', 'Paltrow', to_date('01-10-2006', 'dd-mm-yyyy'), to_date('22-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (163, 'Harvey', 'Drive', to_date('26-02-2006', 'dd-mm-yyyy'), to_date('12-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (164, 'Domingo', 'Sandler', to_date('07-03-2006', 'dd-mm-yyyy'), to_date('27-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (165, 'Roberta', 'McCann', to_date('19-08-2006', 'dd-mm-yyyy'), to_date('02-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (166, 'Bernard', 'Lunch', to_date('27-02-2006', 'dd-mm-yyyy'), to_date('15-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (167, 'Julianna', 'Griggs', to_date('10-04-2006', 'dd-mm-yyyy'), to_date('15-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (168, 'Natascha', 'Wong', to_date('18-03-2006', 'dd-mm-yyyy'), to_date('06-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (169, 'Faye', 'Elwes', to_date('05-11-2006', 'dd-mm-yyyy'), to_date('07-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (170, 'Curt', 'Borgnine', to_date('17-04-2006', 'dd-mm-yyyy'), to_date('15-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (171, 'Tony', 'Van Shelton', to_date('25-11-2006', 'dd-mm-yyyy'), to_date('31-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (172, 'Connie', 'Beatty', to_date('21-10-2006', 'dd-mm-yyyy'), to_date('07-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (173, 'Johnnie', 'Mahood', to_date('11-03-2006', 'dd-mm-yyyy'), to_date('16-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (174, 'Jet', 'Statham', to_date('09-12-2006', 'dd-mm-yyyy'), to_date('06-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (175, 'Minnie', 'Rollins', to_date('27-05-2006', 'dd-mm-yyyy'), to_date('20-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (176, 'Jeroen', 'Rickman', to_date('25-04-2006', 'dd-mm-yyyy'), to_date('22-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (177, 'Crystal', 'Harrelson', to_date('24-03-2006', 'dd-mm-yyyy'), to_date('29-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (178, 'Mika', 'Speaks', to_date('06-12-2006', 'dd-mm-yyyy'), to_date('08-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (179, 'Laurie', 'Dickinson', to_date('17-09-2006', 'dd-mm-yyyy'), to_date('03-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (180, 'Nora', 'Robbins', to_date('17-06-2006', 'dd-mm-yyyy'), to_date('13-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (181, 'Shelby', 'Cumming', to_date('12-12-2006', 'dd-mm-yyyy'), to_date('30-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (182, 'Geggy', 'Guilfoyle', to_date('23-10-2006', 'dd-mm-yyyy'), to_date('18-02-2009', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (183, 'King', 'Carlton', to_date('18-01-2006', 'dd-mm-yyyy'), to_date('27-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (184, 'Annie', 'Loggins', to_date('15-01-2006', 'dd-mm-yyyy'), to_date('02-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (185, 'Laura', 'Tilly', to_date('17-06-2006', 'dd-mm-yyyy'), to_date('29-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (186, 'Roscoe', 'Zeta-Jones', to_date('18-07-2006', 'dd-mm-yyyy'), to_date('01-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1, 'Jet', 'Gore', to_date('24-08-2006', 'dd-mm-yyyy'), to_date('09-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (2, 'Latin', 'Garber', to_date('25-09-2006', 'dd-mm-yyyy'), to_date('15-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (3, 'Sona', 'Valentin', to_date('14-11-2006', 'dd-mm-yyyy'), to_date('23-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (4, 'Nicolas', 'Alston', to_date('09-12-2006', 'dd-mm-yyyy'), to_date('04-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (5, 'Candice', 'Sheen', to_date('22-11-2006', 'dd-mm-yyyy'), to_date('02-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (6, 'Naomi', 'Webb', to_date('07-01-2006', 'dd-mm-yyyy'), to_date('01-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (7, 'Linda', 'Lloyd', to_date('05-06-2006', 'dd-mm-yyyy'), to_date('15-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (8, 'Xander', 'Flemyng', to_date('11-11-2006', 'dd-mm-yyyy'), to_date('04-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (9, 'Edwin', 'Kimball', to_date('14-02-2006', 'dd-mm-yyyy'), to_date('13-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (10, 'Rawlins', 'Dolenz', to_date('31-07-2006', 'dd-mm-yyyy'), to_date('10-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (11, 'Lupe', 'Pitney', to_date('11-09-2006', 'dd-mm-yyyy'), to_date('16-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (12, 'Nelly', 'Harris', to_date('30-06-2006', 'dd-mm-yyyy'), to_date('19-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (13, 'Ryan', 'MacDowell', to_date('04-05-2006', 'dd-mm-yyyy'), to_date('27-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (14, 'Mia', 'De Almeida', to_date('06-07-2006', 'dd-mm-yyyy'), to_date('07-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (15, 'Kim', 'Greenwood', to_date('20-06-2006', 'dd-mm-yyyy'), to_date('05-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (16, 'Don', 'Pony', to_date('25-09-2006', 'dd-mm-yyyy'), to_date('27-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (17, 'Lonnie', 'Goldberg', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('03-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (18, 'Chalee', 'Sevigny', to_date('11-06-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (19, 'Geena', 'Hunter', to_date('13-08-2006', 'dd-mm-yyyy'), to_date('25-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (20, 'Christian', 'Collie', to_date('12-05-2006', 'dd-mm-yyyy'), to_date('25-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (21, 'Dom', 'Collie', to_date('17-08-2006', 'dd-mm-yyyy'), to_date('10-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (22, 'Don', 'Savage', to_date('26-03-2006', 'dd-mm-yyyy'), to_date('09-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (23, 'Lonnie', 'Rydell', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('02-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (24, 'David', 'Tucker', to_date('21-09-2006', 'dd-mm-yyyy'), to_date('11-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (25, 'Rade', 'Darren', to_date('29-08-2006', 'dd-mm-yyyy'), to_date('26-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (26, 'Frederic', 'Quinn', to_date('21-08-2006', 'dd-mm-yyyy'), to_date('26-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (27, 'Mary Beth', 'Damon', to_date('25-01-2006', 'dd-mm-yyyy'), to_date('01-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (28, 'Matthew', 'Harnes', to_date('05-06-2006', 'dd-mm-yyyy'), to_date('22-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (29, 'Jeremy', 'Mantegna', to_date('19-12-2006', 'dd-mm-yyyy'), to_date('26-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (30, 'Dick', 'Sutherland', to_date('11-01-2006', 'dd-mm-yyyy'), to_date('28-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (31, 'Raul', 'Flanagan', to_date('19-09-2006', 'dd-mm-yyyy'), to_date('13-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (32, 'Elijah', 'Colman', to_date('06-01-2006', 'dd-mm-yyyy'), to_date('28-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (33, 'Cesar', 'Blaine', to_date('16-08-2006', 'dd-mm-yyyy'), to_date('04-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (34, 'Mike', 'Coverdale', to_date('20-01-2006', 'dd-mm-yyyy'), to_date('18-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (35, 'Judy', 'Hynde', to_date('22-10-2006', 'dd-mm-yyyy'), to_date('04-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (36, 'Rose', 'Avital', to_date('31-08-2006', 'dd-mm-yyyy'), to_date('11-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (37, 'Jonny', 'Goodall', to_date('20-05-2006', 'dd-mm-yyyy'), to_date('24-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (38, 'Brothers', 'Connelly', to_date('02-05-2006', 'dd-mm-yyyy'), to_date('09-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (39, 'Linda', 'Oszajca', to_date('09-12-2006', 'dd-mm-yyyy'), to_date('04-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (40, 'Yolanda', 'Ribisi', to_date('14-11-2006', 'dd-mm-yyyy'), to_date('22-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (41, 'Wes', 'Pantoliano', to_date('12-05-2006', 'dd-mm-yyyy'), to_date('29-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (42, 'Desmond', 'Todd', to_date('27-02-2006', 'dd-mm-yyyy'), to_date('06-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (43, 'Gran', 'Quinones', to_date('03-12-2006', 'dd-mm-yyyy'), to_date('28-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (44, 'Nancy', 'Clarkson', to_date('18-02-2006', 'dd-mm-yyyy'), to_date('02-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (45, 'Gilberto', 'Voight', to_date('24-09-2006', 'dd-mm-yyyy'), to_date('27-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (46, 'Adrien', 'Torn', to_date('26-02-2006', 'dd-mm-yyyy'), to_date('10-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (47, 'Taye', 'Torn', to_date('16-06-2006', 'dd-mm-yyyy'), to_date('21-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (48, 'Cliff', 'Whitmore', to_date('19-08-2006', 'dd-mm-yyyy'), to_date('25-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (49, 'Kitty', 'Martin', to_date('25-05-2006', 'dd-mm-yyyy'), to_date('03-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (50, 'Rosie', 'Cantrell', to_date('29-12-2006', 'dd-mm-yyyy'), to_date('29-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (51, 'Chris', 'Applegate', to_date('30-10-2006', 'dd-mm-yyyy'), to_date('24-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (52, 'Geraldine', 'Schwarzenegger', to_date('12-12-2006', 'dd-mm-yyyy'), to_date('03-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (53, 'Albertina', 'Koyana', to_date('11-09-2006', 'dd-mm-yyyy'), to_date('25-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (54, 'Roberta', 'Shearer', to_date('27-01-2006', 'dd-mm-yyyy'), to_date('21-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (55, 'Christina', 'Fox', to_date('05-08-2006', 'dd-mm-yyyy'), to_date('15-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (56, 'Rickie', 'Busey', to_date('18-09-2006', 'dd-mm-yyyy'), to_date('16-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (57, 'Vertical', 'Azaria', to_date('29-01-2006', 'dd-mm-yyyy'), to_date('02-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (58, 'Tal', 'McDiarmid', to_date('12-03-2006', 'dd-mm-yyyy'), to_date('24-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (59, 'Diamond', 'Kapanka', to_date('09-04-2006', 'dd-mm-yyyy'), to_date('25-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (60, 'Carrie', 'Belle', to_date('29-04-2006', 'dd-mm-yyyy'), to_date('12-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (61, 'Hookah', 'Tripplehorn', to_date('17-10-2006', 'dd-mm-yyyy'), to_date('28-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (62, 'Bret', 'Copeland', to_date('04-04-2006', 'dd-mm-yyyy'), to_date('19-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (63, 'Clint', 'Irons', to_date('06-01-2006', 'dd-mm-yyyy'), to_date('13-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (64, 'Annie', 'Lennix', to_date('12-08-2006', 'dd-mm-yyyy'), to_date('03-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (65, 'Isabella', 'Carrington', to_date('01-08-2006', 'dd-mm-yyyy'), to_date('26-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (66, 'Maxine', 'Mann', to_date('13-12-2006', 'dd-mm-yyyy'), to_date('14-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (67, 'Jake', 'Lavigne', to_date('26-04-2006', 'dd-mm-yyyy'), to_date('29-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (68, 'Luke', 'Wilson', to_date('18-07-2006', 'dd-mm-yyyy'), to_date('16-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (69, 'Gin', 'Union', to_date('13-05-2006', 'dd-mm-yyyy'), to_date('03-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (70, 'Cheryl', 'Reno', to_date('11-06-2006', 'dd-mm-yyyy'), to_date('05-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (71, 'Devon', 'Burrows', to_date('11-09-2006', 'dd-mm-yyyy'), to_date('05-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (72, 'Gaby', 'Ledger', to_date('24-11-2006', 'dd-mm-yyyy'), to_date('17-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (73, 'Vonda', 'Perlman', to_date('01-12-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (74, 'Terence', 'Shelton', to_date('21-01-2006', 'dd-mm-yyyy'), to_date('08-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (75, 'Vendetta', 'Spacek', to_date('16-05-2006', 'dd-mm-yyyy'), to_date('16-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (76, 'Juan', 'Osment', to_date('19-12-2006', 'dd-mm-yyyy'), to_date('19-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (77, 'Nancy', 'Whitwam', to_date('29-07-2006', 'dd-mm-yyyy'), to_date('30-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (78, 'Vickie', 'Shaw', to_date('15-12-2006', 'dd-mm-yyyy'), to_date('01-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (79, 'Boyd', 'Himmelman', to_date('16-12-2006', 'dd-mm-yyyy'), to_date('01-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (80, 'Daryle', 'Jovovich', to_date('25-03-2006', 'dd-mm-yyyy'), to_date('13-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (81, 'Natalie', 'Forrest', to_date('29-11-2006', 'dd-mm-yyyy'), to_date('05-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (82, 'Gailard', 'Paul', to_date('09-11-2006', 'dd-mm-yyyy'), to_date('03-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (83, 'Lindsey', 'King', to_date('28-02-2006', 'dd-mm-yyyy'), to_date('21-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (84, 'Parker', 'Dolenz', to_date('16-01-2006', 'dd-mm-yyyy'), to_date('22-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (85, 'Collective', 'Elwes', to_date('05-06-2006', 'dd-mm-yyyy'), to_date('30-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (86, 'Curt', 'Cruz', to_date('09-09-2006', 'dd-mm-yyyy'), to_date('15-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (87, 'Tia', 'Pepper', to_date('11-06-2006', 'dd-mm-yyyy'), to_date('30-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (88, 'Kim', 'Pullman', to_date('01-05-2006', 'dd-mm-yyyy'), to_date('02-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (89, 'Leonardo', 'Getty', to_date('26-03-2006', 'dd-mm-yyyy'), to_date('10-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (90, 'Chalee', 'Warburton', to_date('20-04-2006', 'dd-mm-yyyy'), to_date('26-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (91, 'Jesse', 'Mewes', to_date('26-09-2006', 'dd-mm-yyyy'), to_date('15-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (92, 'Kay', 'Sizemore', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('14-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (93, 'Lili', 'Sirtis', to_date('28-09-2006', 'dd-mm-yyyy'), to_date('05-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (94, 'Dylan', 'Curtis', to_date('15-02-2006', 'dd-mm-yyyy'), to_date('22-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (95, 'Horace', 'McConaughey', to_date('12-02-2006', 'dd-mm-yyyy'), to_date('23-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (96, 'Dorry', 'Pleasure', to_date('05-01-2006', 'dd-mm-yyyy'), to_date('12-12-2009', 'dd-mm-yyyy'));
commit;
prompt 500 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (97, 'Kris', 'Tilly', to_date('13-05-2006', 'dd-mm-yyyy'), to_date('22-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (98, 'Harris', 'Visnjic', to_date('22-11-2006', 'dd-mm-yyyy'), to_date('25-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (99, 'Courtney', 'Reubens', to_date('27-06-2006', 'dd-mm-yyyy'), to_date('10-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (100, 'Chely', 'McFadden', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('07-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (101, 'Kazem', 'Hewett', to_date('06-03-2006', 'dd-mm-yyyy'), to_date('03-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (102, 'Derek', 'Palminteri', to_date('24-04-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (103, 'Mac', 'Weiss', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('25-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (104, 'Marc', 'Savage', to_date('27-02-2006', 'dd-mm-yyyy'), to_date('03-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (187, 'Roscoe', 'Mitra', to_date('30-07-2006', 'dd-mm-yyyy'), to_date('17-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (188, 'Jaime', 'Durning', to_date('08-08-2006', 'dd-mm-yyyy'), to_date('20-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (189, 'Claire', 'Pleasence', to_date('02-09-2006', 'dd-mm-yyyy'), to_date('16-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (613, 'Vondie', 'Trevino', to_date('28-02-2006', 'dd-mm-yyyy'), to_date('25-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (614, 'Lily', 'Jay', to_date('07-03-2006', 'dd-mm-yyyy'), to_date('15-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (615, 'Lonnie', 'Dutton', to_date('11-04-2006', 'dd-mm-yyyy'), to_date('06-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (616, 'Andrea', 'Whitley', to_date('07-10-2006', 'dd-mm-yyyy'), to_date('16-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (617, 'Dwight', 'Reno', to_date('02-12-2006', 'dd-mm-yyyy'), to_date('08-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (618, 'Harvey', 'Hawn', to_date('23-03-2006', 'dd-mm-yyyy'), to_date('06-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (619, 'Sophie', 'Stone', to_date('01-02-2006', 'dd-mm-yyyy'), to_date('13-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (620, 'Embeth', 'Griffiths', to_date('19-01-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (621, 'Aaron', 'Foxx', to_date('10-10-2006', 'dd-mm-yyyy'), to_date('20-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (622, 'Temuera', 'Sisto', to_date('08-05-2006', 'dd-mm-yyyy'), to_date('23-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (623, 'Dabney', 'Pleasence', to_date('01-10-2006', 'dd-mm-yyyy'), to_date('02-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (624, 'John', 'McLean', to_date('19-06-2006', 'dd-mm-yyyy'), to_date('01-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (625, 'Donna', 'Hughes', to_date('01-08-2006', 'dd-mm-yyyy'), to_date('26-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (626, 'Jeff', 'Stewart', to_date('08-12-2006', 'dd-mm-yyyy'), to_date('21-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (627, 'Billy', 'Kilmer', to_date('06-01-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (628, 'Rene', 'Vince', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('18-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (629, 'Lin', 'Henstridge', to_date('20-08-2006', 'dd-mm-yyyy'), to_date('03-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (630, 'Sheena', 'Tierney', to_date('29-01-2006', 'dd-mm-yyyy'), to_date('22-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (631, 'Chaka', 'Furay', to_date('18-11-2006', 'dd-mm-yyyy'), to_date('08-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (632, 'Corey', 'Irons', to_date('05-11-2006', 'dd-mm-yyyy'), to_date('26-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (633, 'Colm', 'Whitford', to_date('03-05-2006', 'dd-mm-yyyy'), to_date('20-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (634, 'Willem', 'Newman', to_date('12-04-2006', 'dd-mm-yyyy'), to_date('14-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (635, 'Emily', 'Savage', to_date('29-04-2006', 'dd-mm-yyyy'), to_date('15-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (636, 'Lucinda', 'Vince', to_date('01-04-2006', 'dd-mm-yyyy'), to_date('16-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (637, 'Dean', 'Davison', to_date('18-11-2006', 'dd-mm-yyyy'), to_date('24-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (638, 'Mary-Louise', 'Armstrong', to_date('24-02-2006', 'dd-mm-yyyy'), to_date('07-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (639, 'Sheryl', 'Rydell', to_date('14-12-2006', 'dd-mm-yyyy'), to_date('31-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (640, 'Amanda', 'Vega', to_date('12-01-2006', 'dd-mm-yyyy'), to_date('28-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (641, 'Roy', 'Mahoney', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('06-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (642, 'Saffron', 'Byrd', to_date('28-01-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (643, 'Terrence', 'Houston', to_date('18-09-2006', 'dd-mm-yyyy'), to_date('22-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (644, 'Shelby', 'Masur', to_date('11-05-2006', 'dd-mm-yyyy'), to_date('06-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (645, 'Jeffery', 'McGriff', to_date('24-06-2006', 'dd-mm-yyyy'), to_date('07-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (646, 'Bridget', 'Brody', to_date('05-12-2006', 'dd-mm-yyyy'), to_date('18-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (647, 'Ethan', 'Belle', to_date('29-07-2006', 'dd-mm-yyyy'), to_date('20-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (648, 'William', 'MacDonald', to_date('21-03-2006', 'dd-mm-yyyy'), to_date('18-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (649, 'Stewart', 'Chao', to_date('18-02-2006', 'dd-mm-yyyy'), to_date('28-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (650, 'Juliette', 'Conroy', to_date('25-09-2006', 'dd-mm-yyyy'), to_date('27-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (651, 'Sonny', 'Collins', to_date('17-03-2006', 'dd-mm-yyyy'), to_date('10-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (652, 'Warren', 'Berenger', to_date('06-02-2006', 'dd-mm-yyyy'), to_date('14-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (653, 'Mili', 'Burrows', to_date('22-03-2006', 'dd-mm-yyyy'), to_date('19-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (654, 'Swoosie', 'Lucien', to_date('14-05-2006', 'dd-mm-yyyy'), to_date('05-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (655, 'Red', 'Gaynor', to_date('06-09-2006', 'dd-mm-yyyy'), to_date('31-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (656, 'First', 'Ribisi', to_date('07-09-2006', 'dd-mm-yyyy'), to_date('28-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (657, 'Angie', 'Jenkins', to_date('08-04-2006', 'dd-mm-yyyy'), to_date('25-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (658, 'Christine', 'Dunst', to_date('28-03-2006', 'dd-mm-yyyy'), to_date('31-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (659, 'Katie', 'Cassidy', to_date('26-02-2006', 'dd-mm-yyyy'), to_date('28-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (660, 'Kate', 'Nightingale', to_date('15-07-2006', 'dd-mm-yyyy'), to_date('21-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (661, 'Ewan', 'Burstyn', to_date('22-09-2006', 'dd-mm-yyyy'), to_date('22-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (662, 'Garth', 'England', to_date('25-12-2006', 'dd-mm-yyyy'), to_date('22-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (663, 'Cherry', 'Burns', to_date('19-07-2006', 'dd-mm-yyyy'), to_date('16-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (664, 'Hikaru', 'Berkoff', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('20-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (665, 'Suzi', 'Weaving', to_date('31-08-2006', 'dd-mm-yyyy'), to_date('15-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (666, 'Quentin', 'Firth', to_date('24-02-2006', 'dd-mm-yyyy'), to_date('02-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (667, 'Machine', 'Parm', to_date('29-03-2006', 'dd-mm-yyyy'), to_date('23-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (668, 'Daryle', 'McDiarmid', to_date('24-10-2006', 'dd-mm-yyyy'), to_date('30-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (669, 'Molly', 'Pollak', to_date('14-06-2006', 'dd-mm-yyyy'), to_date('07-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (670, 'Hugh', 'Ripley', to_date('16-11-2006', 'dd-mm-yyyy'), to_date('25-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (671, 'Natalie', 'Caan', to_date('05-10-2006', 'dd-mm-yyyy'), to_date('14-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (672, 'Simon', 'Winger', to_date('13-12-2006', 'dd-mm-yyyy'), to_date('11-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (673, 'Angela', 'Tolkan', to_date('11-06-2006', 'dd-mm-yyyy'), to_date('12-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (674, 'Sydney', 'Renfro', to_date('09-08-2006', 'dd-mm-yyyy'), to_date('30-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (675, 'Jackson', 'Hynde', to_date('21-06-2006', 'dd-mm-yyyy'), to_date('02-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (676, 'Bobbi', 'Cetera', to_date('26-02-2006', 'dd-mm-yyyy'), to_date('08-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (677, 'Busta', 'Sartain', to_date('03-09-2006', 'dd-mm-yyyy'), to_date('05-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (678, 'Rutger', 'Watley', to_date('24-09-2006', 'dd-mm-yyyy'), to_date('27-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (679, 'Burt', 'Guilfoyle', to_date('01-04-2006', 'dd-mm-yyyy'), to_date('19-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (680, 'Lorraine', 'Atkinson', to_date('11-09-2006', 'dd-mm-yyyy'), to_date('06-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (681, 'Willem', 'Furay', to_date('17-07-2006', 'dd-mm-yyyy'), to_date('16-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (682, 'Suzy', 'McCabe', to_date('30-04-2006', 'dd-mm-yyyy'), to_date('12-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (683, 'Merrill', 'Everett', to_date('08-03-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (684, 'Franco', 'McKellen', to_date('09-11-2006', 'dd-mm-yyyy'), to_date('01-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (685, 'Selma', 'Apple', to_date('01-07-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (686, 'Art', 'Freeman', to_date('20-10-2006', 'dd-mm-yyyy'), to_date('19-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (687, 'Machine', 'Chambers', to_date('05-04-2006', 'dd-mm-yyyy'), to_date('19-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (688, 'Lila', 'Reno', to_date('10-08-2006', 'dd-mm-yyyy'), to_date('01-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (689, 'Denny', 'Wills', to_date('25-09-2006', 'dd-mm-yyyy'), to_date('23-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (690, 'Raymond', 'Dzundza', to_date('11-08-2006', 'dd-mm-yyyy'), to_date('16-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (691, 'Jodie', 'Heald', to_date('17-01-2006', 'dd-mm-yyyy'), to_date('10-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (692, 'Earl', 'Duncan', to_date('20-04-2006', 'dd-mm-yyyy'), to_date('12-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (693, 'Carl', 'Ronstadt', to_date('10-11-2006', 'dd-mm-yyyy'), to_date('30-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (694, 'Coley', 'Stanley', to_date('03-12-2006', 'dd-mm-yyyy'), to_date('21-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (695, 'Rich', 'Willis', to_date('18-05-2006', 'dd-mm-yyyy'), to_date('24-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (696, 'Annie', 'Pollak', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('10-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (697, 'Daniel', 'Holeman', to_date('13-08-2006', 'dd-mm-yyyy'), to_date('10-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (698, 'Edgar', 'Sewell', to_date('30-04-2006', 'dd-mm-yyyy'), to_date('09-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (699, 'Joanna', 'Coverdale', to_date('19-01-2006', 'dd-mm-yyyy'), to_date('26-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (700, 'Kyle', 'James', to_date('10-12-2006', 'dd-mm-yyyy'), to_date('10-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (701, 'Armin', 'Doucette', to_date('11-07-2006', 'dd-mm-yyyy'), to_date('22-11-2009', 'dd-mm-yyyy'));
commit;
prompt 600 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (702, 'Anna', 'Botti', to_date('05-07-2006', 'dd-mm-yyyy'), to_date('15-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (703, 'Ramsey', 'Palmer', to_date('04-07-2006', 'dd-mm-yyyy'), to_date('01-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (704, 'Jon', 'Kotto', to_date('06-09-2006', 'dd-mm-yyyy'), to_date('12-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (705, 'Ernie', 'Ward', to_date('13-08-2006', 'dd-mm-yyyy'), to_date('18-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (706, 'Rhea', 'Reeves', to_date('07-12-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (707, 'Nickel', 'Gold', to_date('08-07-2006', 'dd-mm-yyyy'), to_date('27-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (708, 'Terry', 'Klugh', to_date('26-04-2006', 'dd-mm-yyyy'), to_date('10-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (709, 'Rebeka', 'Hayes', to_date('31-01-2006', 'dd-mm-yyyy'), to_date('25-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (710, 'Chubby', 'Alexander', to_date('20-07-2006', 'dd-mm-yyyy'), to_date('26-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (711, 'Ben', 'Franklin', to_date('18-11-2006', 'dd-mm-yyyy'), to_date('02-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (712, 'Jonny', 'Norton', to_date('31-05-2006', 'dd-mm-yyyy'), to_date('04-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (713, 'Rose', 'Noseworthy', to_date('27-12-2006', 'dd-mm-yyyy'), to_date('07-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (714, 'Josh', 'Bradford', to_date('17-06-2006', 'dd-mm-yyyy'), to_date('08-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (715, 'Nina', 'Sinise', to_date('06-02-2006', 'dd-mm-yyyy'), to_date('25-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (716, 'Ivan', 'Popper', to_date('14-01-2006', 'dd-mm-yyyy'), to_date('25-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (717, 'Grace', 'Tippe', to_date('13-12-2006', 'dd-mm-yyyy'), to_date('24-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (718, 'Rhona', 'Conlee', to_date('13-08-2006', 'dd-mm-yyyy'), to_date('21-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (719, 'Natasha', 'DeVito', to_date('26-01-2006', 'dd-mm-yyyy'), to_date('02-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (720, 'Taye', 'Sheen', to_date('13-06-2006', 'dd-mm-yyyy'), to_date('03-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (721, 'Burt', 'Hagar', to_date('26-10-2006', 'dd-mm-yyyy'), to_date('23-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (722, 'Christopher', 'Hanley', to_date('06-07-2006', 'dd-mm-yyyy'), to_date('23-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (723, 'Joey', 'Stiller', to_date('09-10-2006', 'dd-mm-yyyy'), to_date('26-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (724, 'Danny', 'Levin', to_date('15-10-2006', 'dd-mm-yyyy'), to_date('17-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (725, 'Ron', 'Dunst', to_date('18-05-2006', 'dd-mm-yyyy'), to_date('02-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (726, 'Sal', 'Neeson', to_date('09-11-2006', 'dd-mm-yyyy'), to_date('08-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (727, 'Bette', 'Bale', to_date('16-12-2006', 'dd-mm-yyyy'), to_date('07-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (728, 'Rory', 'Mortensen', to_date('08-10-2006', 'dd-mm-yyyy'), to_date('20-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (729, 'Holland', 'Plowright', to_date('08-01-2006', 'dd-mm-yyyy'), to_date('12-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (730, 'Howard', 'Paymer', to_date('12-04-2006', 'dd-mm-yyyy'), to_date('22-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (731, 'Hal', 'Vincent', to_date('03-11-2006', 'dd-mm-yyyy'), to_date('26-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (732, 'Nigel', 'Drive', to_date('08-05-2006', 'dd-mm-yyyy'), to_date('07-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (733, 'Carlos', 'Platt', to_date('10-06-2006', 'dd-mm-yyyy'), to_date('19-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (734, 'Vienna', 'Wiest', to_date('30-12-2006', 'dd-mm-yyyy'), to_date('16-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (735, 'Carolyn', 'McElhone', to_date('10-10-2006', 'dd-mm-yyyy'), to_date('04-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (736, 'John', 'Payton', to_date('08-06-2006', 'dd-mm-yyyy'), to_date('20-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (737, 'Shannyn', 'Banderas', to_date('29-04-2006', 'dd-mm-yyyy'), to_date('31-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (738, 'Ike', 'McGinley', to_date('11-07-2006', 'dd-mm-yyyy'), to_date('15-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (739, 'Forest', 'Russo', to_date('11-12-2006', 'dd-mm-yyyy'), to_date('13-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (740, 'Kenneth', 'Gates', to_date('24-07-2006', 'dd-mm-yyyy'), to_date('04-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (741, 'Daniel', 'Diesel', to_date('15-01-2006', 'dd-mm-yyyy'), to_date('08-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (742, 'Karon', 'Downey', to_date('05-05-2006', 'dd-mm-yyyy'), to_date('11-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (743, 'Connie', 'Assante', to_date('23-01-2006', 'dd-mm-yyyy'), to_date('06-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (744, 'Fairuza', 'Orbit', to_date('30-07-2006', 'dd-mm-yyyy'), to_date('27-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (745, 'Morris', 'Leachman', to_date('23-04-2006', 'dd-mm-yyyy'), to_date('05-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (746, 'CeCe', 'Coverdale', to_date('05-08-2006', 'dd-mm-yyyy'), to_date('03-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (747, 'Machine', 'Ingram', to_date('16-01-2006', 'dd-mm-yyyy'), to_date('19-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (748, 'Jena', 'Clayton', to_date('07-05-2006', 'dd-mm-yyyy'), to_date('12-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (376, 'Kenny', 'De Almeida', to_date('23-10-2006', 'dd-mm-yyyy'), to_date('21-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (377, 'Joanna', 'Vega', to_date('14-08-2006', 'dd-mm-yyyy'), to_date('21-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (378, 'Gailard', 'Diddley', to_date('06-03-2006', 'dd-mm-yyyy'), to_date('02-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (379, 'Christina', 'Dillon', to_date('28-12-2006', 'dd-mm-yyyy'), to_date('26-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (380, 'Austin', 'Detmer', to_date('12-10-2006', 'dd-mm-yyyy'), to_date('08-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (381, 'Roscoe', 'Vincent', to_date('23-02-2006', 'dd-mm-yyyy'), to_date('18-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (382, 'Catherine', 'Rudd', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('14-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (383, 'Nicolas', 'Manning', to_date('28-12-2006', 'dd-mm-yyyy'), to_date('23-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (384, 'Julio', 'Bacharach', to_date('15-07-2006', 'dd-mm-yyyy'), to_date('09-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (385, 'Arnold', 'Hobson', to_date('04-03-2006', 'dd-mm-yyyy'), to_date('07-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (386, 'Jonatha', 'Salonga', to_date('07-05-2006', 'dd-mm-yyyy'), to_date('23-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (387, 'Lonnie', 'Sweeney', to_date('03-12-2006', 'dd-mm-yyyy'), to_date('30-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (388, 'Heather', 'Paxton', to_date('09-12-2006', 'dd-mm-yyyy'), to_date('05-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (389, 'Penelope', 'Underwood', to_date('05-04-2006', 'dd-mm-yyyy'), to_date('08-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (390, 'Woody', 'Harary', to_date('15-09-2006', 'dd-mm-yyyy'), to_date('08-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (391, 'Sam', 'Lattimore', to_date('12-06-2006', 'dd-mm-yyyy'), to_date('21-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (392, 'Red', 'Sirtis', to_date('29-08-2006', 'dd-mm-yyyy'), to_date('06-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (393, 'Tori', 'Culkin', to_date('29-10-2006', 'dd-mm-yyyy'), to_date('27-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (394, 'Wade', 'Peet', to_date('24-02-2006', 'dd-mm-yyyy'), to_date('27-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (395, 'Liev', 'Sinise', to_date('01-12-2006', 'dd-mm-yyyy'), to_date('23-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (396, 'Joey', 'Moraz', to_date('15-11-2006', 'dd-mm-yyyy'), to_date('07-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (397, 'Ernest', 'Buscemi', to_date('06-11-2006', 'dd-mm-yyyy'), to_date('21-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (398, 'Jose', 'Snipes', to_date('27-03-2006', 'dd-mm-yyyy'), to_date('11-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (399, 'Angelina', 'Heald', to_date('05-02-2006', 'dd-mm-yyyy'), to_date('21-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (400, 'Bobbi', 'Moore', to_date('15-12-2006', 'dd-mm-yyyy'), to_date('13-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (401, 'Elijah', 'Lonsdale', to_date('16-07-2006', 'dd-mm-yyyy'), to_date('16-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (402, 'Larnelle', 'Steagall', to_date('24-01-2006', 'dd-mm-yyyy'), to_date('25-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (403, 'Vanessa', 'Phillippe', to_date('28-10-2006', 'dd-mm-yyyy'), to_date('30-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (404, 'Helen', 'Ruiz', to_date('25-02-2006', 'dd-mm-yyyy'), to_date('29-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (405, 'Gladys', 'Gordon', to_date('15-01-2006', 'dd-mm-yyyy'), to_date('26-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (406, 'Hilton', 'Minogue', to_date('17-12-2006', 'dd-mm-yyyy'), to_date('23-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (407, 'Madeline', 'De Almeida', to_date('16-09-2006', 'dd-mm-yyyy'), to_date('08-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (408, 'Gilberto', 'Harnes', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('24-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (409, 'Cledus', 'Hanley', to_date('06-02-2006', 'dd-mm-yyyy'), to_date('01-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (410, 'Lorraine', 'Reeve', to_date('27-02-2006', 'dd-mm-yyyy'), to_date('30-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (411, 'Antonio', 'Gatlin', to_date('28-10-2006', 'dd-mm-yyyy'), to_date('27-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (412, 'Jackie', 'Utada', to_date('01-06-2006', 'dd-mm-yyyy'), to_date('13-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (413, 'Raymond', 'Dutton', to_date('11-10-2006', 'dd-mm-yyyy'), to_date('08-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (414, 'Donald', 'Mueller-Stahl', to_date('27-06-2006', 'dd-mm-yyyy'), to_date('24-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (415, 'Gaby', 'Del Toro', to_date('19-05-2006', 'dd-mm-yyyy'), to_date('20-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (416, 'Mitchell', 'Cara', to_date('26-07-2006', 'dd-mm-yyyy'), to_date('24-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (417, 'Ozzy', 'Krabbe', to_date('14-02-2006', 'dd-mm-yyyy'), to_date('16-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (418, 'Delbert', 'Feliciano', to_date('25-01-2006', 'dd-mm-yyyy'), to_date('06-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (419, 'Mac', 'Stiers', to_date('05-06-2006', 'dd-mm-yyyy'), to_date('19-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (420, 'Andy', 'Scorsese', to_date('20-05-2006', 'dd-mm-yyyy'), to_date('18-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (421, 'Halle', 'DeGraw', to_date('05-11-2006', 'dd-mm-yyyy'), to_date('04-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (422, 'Ellen', 'Gore', to_date('27-12-2006', 'dd-mm-yyyy'), to_date('24-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (423, 'Jack', 'Tyson', to_date('13-07-2006', 'dd-mm-yyyy'), to_date('24-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (424, 'Jackie', 'Supernaw', to_date('28-10-2006', 'dd-mm-yyyy'), to_date('19-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (425, 'Vertical', 'Gunton', to_date('17-01-2006', 'dd-mm-yyyy'), to_date('09-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (801, 'Avril', 'Steagall', to_date('14-09-2006', 'dd-mm-yyyy'), to_date('03-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (802, 'Janice', 'Sarsgaard', to_date('02-05-2006', 'dd-mm-yyyy'), to_date('29-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (803, 'Larry', 'Phifer', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('02-11-2009', 'dd-mm-yyyy'));
commit;
prompt 700 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (804, 'Loren', 'MacDowell', to_date('16-02-2006', 'dd-mm-yyyy'), to_date('14-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (805, 'Jean', 'Coolidge', to_date('10-12-2006', 'dd-mm-yyyy'), to_date('15-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (806, 'Pete', 'Fender', to_date('11-09-2006', 'dd-mm-yyyy'), to_date('12-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (807, 'Ahmad', 'Conley', to_date('27-05-2006', 'dd-mm-yyyy'), to_date('09-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (808, 'Gilberto', 'Sewell', to_date('07-02-2006', 'dd-mm-yyyy'), to_date('23-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (809, 'Kevn', 'Diggs', to_date('26-11-2006', 'dd-mm-yyyy'), to_date('14-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (810, 'Emma', 'Choice', to_date('16-09-2006', 'dd-mm-yyyy'), to_date('17-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (811, 'Timothy', 'Easton', to_date('06-05-2006', 'dd-mm-yyyy'), to_date('15-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (812, 'Seth', 'Wine', to_date('18-03-2006', 'dd-mm-yyyy'), to_date('25-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (813, 'Jean', 'Carradine', to_date('11-09-2006', 'dd-mm-yyyy'), to_date('12-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (814, 'Jaime', 'Broderick', to_date('11-12-2006', 'dd-mm-yyyy'), to_date('26-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (815, 'Robby', 'Karyo', to_date('29-09-2006', 'dd-mm-yyyy'), to_date('04-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (816, 'Sharon', 'Wayans', to_date('29-07-2006', 'dd-mm-yyyy'), to_date('07-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (817, 'Loren', 'Kadison', to_date('27-02-2006', 'dd-mm-yyyy'), to_date('09-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (818, 'Aida', 'Diffie', to_date('05-01-2006', 'dd-mm-yyyy'), to_date('24-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (819, 'Alicia', 'Reiner', to_date('30-10-2006', 'dd-mm-yyyy'), to_date('20-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (820, 'Micky', 'MacNeil', to_date('16-09-2006', 'dd-mm-yyyy'), to_date('17-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (821, 'Stewart', 'Geldof', to_date('27-07-2006', 'dd-mm-yyyy'), to_date('12-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (822, 'Lou', 'Biggs', to_date('29-03-2006', 'dd-mm-yyyy'), to_date('07-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (823, 'Azucar', 'McDormand', to_date('02-02-2006', 'dd-mm-yyyy'), to_date('26-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (824, 'Fats', 'Hart', to_date('10-03-2006', 'dd-mm-yyyy'), to_date('11-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (825, 'Trick', 'Fichtner', to_date('24-04-2006', 'dd-mm-yyyy'), to_date('04-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (826, 'Lenny', 'Franks', to_date('14-05-2006', 'dd-mm-yyyy'), to_date('21-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (827, 'Nancy', 'Serbedzija', to_date('22-12-2006', 'dd-mm-yyyy'), to_date('25-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (828, 'Robby', 'Shearer', to_date('03-05-2006', 'dd-mm-yyyy'), to_date('14-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (829, 'Davy', 'DeLuise', to_date('30-07-2006', 'dd-mm-yyyy'), to_date('24-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (830, 'Gin', 'Whitman', to_date('27-03-2006', 'dd-mm-yyyy'), to_date('21-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (831, 'Burton', 'Mifune', to_date('04-08-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (832, 'Geoff', 'Vicious', to_date('05-12-2006', 'dd-mm-yyyy'), to_date('10-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (833, 'Derrick', 'Gallagher', to_date('16-01-2006', 'dd-mm-yyyy'), to_date('05-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (834, 'Mark', 'Chaplin', to_date('22-06-2006', 'dd-mm-yyyy'), to_date('23-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (835, 'Delroy', 'Himmelman', to_date('12-05-2006', 'dd-mm-yyyy'), to_date('20-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (836, 'Gordie', 'Hawthorne', to_date('14-11-2006', 'dd-mm-yyyy'), to_date('06-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (837, 'Red', 'Aglukark', to_date('24-07-2006', 'dd-mm-yyyy'), to_date('14-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (838, 'John', 'Blackmore', to_date('07-03-2006', 'dd-mm-yyyy'), to_date('04-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (839, 'Penelope', 'Speaks', to_date('26-09-2006', 'dd-mm-yyyy'), to_date('16-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (840, 'Sheena', 'James', to_date('17-11-2006', 'dd-mm-yyyy'), to_date('07-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (841, 'Armand', 'Steenburgen', to_date('08-11-2006', 'dd-mm-yyyy'), to_date('01-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (842, 'Linda', 'Addy', to_date('12-08-2006', 'dd-mm-yyyy'), to_date('14-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (843, 'Jake', 'Quinlan', to_date('17-11-2006', 'dd-mm-yyyy'), to_date('22-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (844, 'Lea', 'Sledge', to_date('08-03-2006', 'dd-mm-yyyy'), to_date('29-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (845, 'Stevie', 'Mirren', to_date('12-03-2006', 'dd-mm-yyyy'), to_date('04-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (846, 'Javon', 'Coburn', to_date('20-11-2006', 'dd-mm-yyyy'), to_date('11-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (847, 'Dan', 'Tinsley', to_date('05-05-2006', 'dd-mm-yyyy'), to_date('14-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (848, 'William', 'Rock', to_date('11-03-2006', 'dd-mm-yyyy'), to_date('13-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (849, 'Tom', 'Allison', to_date('31-01-2006', 'dd-mm-yyyy'), to_date('14-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (850, 'Karon', 'Paxton', to_date('24-08-2006', 'dd-mm-yyyy'), to_date('23-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (851, 'Jonathan', 'Doucette', to_date('04-10-2006', 'dd-mm-yyyy'), to_date('06-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (852, 'Rutger', 'Salt', to_date('16-03-2006', 'dd-mm-yyyy'), to_date('20-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (853, 'Ronny', 'Ryder', to_date('18-12-2006', 'dd-mm-yyyy'), to_date('04-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (854, 'Jann', 'MacNeil', to_date('05-10-2006', 'dd-mm-yyyy'), to_date('26-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (855, 'Clive', 'Milsap', to_date('18-07-2006', 'dd-mm-yyyy'), to_date('10-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (856, 'Aida', 'Rucker', to_date('01-02-2006', 'dd-mm-yyyy'), to_date('14-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (857, 'Harris', 'Moffat', to_date('21-11-2006', 'dd-mm-yyyy'), to_date('13-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (858, 'Cornell', 'Lennox', to_date('05-01-2006', 'dd-mm-yyyy'), to_date('13-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (859, 'Azucar', 'Pollack', to_date('24-07-2006', 'dd-mm-yyyy'), to_date('27-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (860, 'Shannyn', 'Stigers', to_date('15-12-2006', 'dd-mm-yyyy'), to_date('01-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (861, 'Ricardo', 'Applegate', to_date('18-03-2006', 'dd-mm-yyyy'), to_date('15-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (862, 'Gil', 'Beckinsale', to_date('10-10-2006', 'dd-mm-yyyy'), to_date('14-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (863, 'Roscoe', 'Bryson', to_date('26-10-2006', 'dd-mm-yyyy'), to_date('21-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (864, 'Jack', 'Gugino', to_date('17-11-2006', 'dd-mm-yyyy'), to_date('03-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (865, 'Rose', 'Folds', to_date('06-04-2006', 'dd-mm-yyyy'), to_date('31-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (866, 'Ceili', 'Flatts', to_date('19-09-2006', 'dd-mm-yyyy'), to_date('24-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (867, 'Gabrielle', 'Burstyn', to_date('01-03-2006', 'dd-mm-yyyy'), to_date('15-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (868, 'Judi', 'Portman', to_date('17-07-2006', 'dd-mm-yyyy'), to_date('08-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (869, 'Wayne', 'Madonna', to_date('27-01-2006', 'dd-mm-yyyy'), to_date('30-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (870, 'Randy', 'Alda', to_date('25-06-2006', 'dd-mm-yyyy'), to_date('01-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (871, 'Paul', 'Rhys-Davies', to_date('16-12-2006', 'dd-mm-yyyy'), to_date('03-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (872, 'Terri', 'Hudson', to_date('14-12-2006', 'dd-mm-yyyy'), to_date('04-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (873, 'Nathan', 'Kingsley', to_date('08-01-2006', 'dd-mm-yyyy'), to_date('18-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (874, 'Kristin', 'Holiday', to_date('13-05-2006', 'dd-mm-yyyy'), to_date('30-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (875, 'Ronnie', 'Pollak', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('02-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (876, 'Queen', 'Aaron', to_date('17-02-2006', 'dd-mm-yyyy'), to_date('15-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (877, 'Kiefer', 'Holmes', to_date('17-07-2006', 'dd-mm-yyyy'), to_date('27-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (878, 'Aimee', 'Dupree', to_date('06-01-2006', 'dd-mm-yyyy'), to_date('28-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (879, 'Wes', 'de Lancie', to_date('05-02-2006', 'dd-mm-yyyy'), to_date('15-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (880, 'Jean-Luc', 'Stuermer', to_date('10-10-2006', 'dd-mm-yyyy'), to_date('26-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (881, 'Geggy', 'Dzundza', to_date('22-10-2006', 'dd-mm-yyyy'), to_date('16-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (882, 'Eileen', 'Penn', to_date('13-02-2006', 'dd-mm-yyyy'), to_date('25-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (883, 'Lou', 'Belle', to_date('15-12-2006', 'dd-mm-yyyy'), to_date('18-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (884, 'Trini', 'Hatfield', to_date('22-12-2006', 'dd-mm-yyyy'), to_date('11-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (885, 'Julia', 'Henstridge', to_date('04-06-2006', 'dd-mm-yyyy'), to_date('13-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (886, 'April', 'Coyote', to_date('31-01-2006', 'dd-mm-yyyy'), to_date('10-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (887, 'Avenged', 'Horton', to_date('07-09-2006', 'dd-mm-yyyy'), to_date('24-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (888, 'Barbara', 'Oates', to_date('19-11-2006', 'dd-mm-yyyy'), to_date('11-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (889, 'Anne', 'Michaels', to_date('07-02-2006', 'dd-mm-yyyy'), to_date('21-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (890, 'Tzi', 'Lewis', to_date('24-09-2006', 'dd-mm-yyyy'), to_date('20-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (891, 'Campbell', 'Vincent', to_date('22-07-2006', 'dd-mm-yyyy'), to_date('22-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (892, 'Keanu', 'Matthau', to_date('30-05-2006', 'dd-mm-yyyy'), to_date('09-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (893, 'Thomas', 'Beckinsale', to_date('11-05-2006', 'dd-mm-yyyy'), to_date('10-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (894, 'Machine', 'Osborne', to_date('23-12-2006', 'dd-mm-yyyy'), to_date('01-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (895, 'Tommy', 'Lonsdale', to_date('02-07-2006', 'dd-mm-yyyy'), to_date('08-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (896, 'Cate', 'Polito', to_date('25-11-2006', 'dd-mm-yyyy'), to_date('10-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (897, 'Bridgette', 'Costa', to_date('15-03-2006', 'dd-mm-yyyy'), to_date('26-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (898, 'Sophie', 'Rowlands', to_date('12-07-2006', 'dd-mm-yyyy'), to_date('24-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (899, 'Gilbert', 'Holy', to_date('10-10-2006', 'dd-mm-yyyy'), to_date('25-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (900, 'Cameron', 'Dysart', to_date('04-11-2006', 'dd-mm-yyyy'), to_date('11-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (901, 'Roddy', 'Penn', to_date('23-10-2006', 'dd-mm-yyyy'), to_date('02-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (902, 'Barbara', 'Brolin', to_date('25-07-2006', 'dd-mm-yyyy'), to_date('17-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (903, 'Alec', 'Adler', to_date('29-08-2006', 'dd-mm-yyyy'), to_date('04-12-2009', 'dd-mm-yyyy'));
commit;
prompt 800 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (904, 'Chazz', 'Akins', to_date('13-07-2006', 'dd-mm-yyyy'), to_date('06-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (905, 'Nina', 'Isaak', to_date('28-03-2006', 'dd-mm-yyyy'), to_date('03-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (906, 'Avenged', 'Swinton', to_date('02-06-2006', 'dd-mm-yyyy'), to_date('27-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (907, 'Mickey', 'Silverman', to_date('21-02-2006', 'dd-mm-yyyy'), to_date('20-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (908, 'Maury', 'Cox', to_date('06-10-2006', 'dd-mm-yyyy'), to_date('06-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (909, 'Brendan', 'Heslov', to_date('29-01-2006', 'dd-mm-yyyy'), to_date('25-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (910, 'Lea', 'Hawke', to_date('15-04-2006', 'dd-mm-yyyy'), to_date('01-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (911, 'Clea', 'Lynn', to_date('08-08-2006', 'dd-mm-yyyy'), to_date('10-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (912, 'Salma', 'Lightfoot', to_date('17-07-2006', 'dd-mm-yyyy'), to_date('03-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (913, 'Armand', 'McLean', to_date('04-03-2006', 'dd-mm-yyyy'), to_date('21-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (914, 'Danny', 'Rhymes', to_date('19-11-2006', 'dd-mm-yyyy'), to_date('19-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (915, 'Sydney', 'Root', to_date('04-07-2006', 'dd-mm-yyyy'), to_date('02-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (916, 'CeCe', 'Bonham', to_date('26-09-2006', 'dd-mm-yyyy'), to_date('14-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (917, 'Miriam', 'Baldwin', to_date('12-04-2006', 'dd-mm-yyyy'), to_date('13-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (918, 'Shelby', 'Wincott', to_date('02-03-2006', 'dd-mm-yyyy'), to_date('12-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (919, 'Pamela', 'Cartlidge', to_date('03-02-2006', 'dd-mm-yyyy'), to_date('09-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (920, 'Casey', 'Dooley', to_date('16-10-2006', 'dd-mm-yyyy'), to_date('24-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (921, 'Derek', 'Neuwirth', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('03-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (922, 'Oro', 'Shepard', to_date('26-12-2006', 'dd-mm-yyyy'), to_date('02-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (923, 'Hank', 'Burmester', to_date('19-01-2006', 'dd-mm-yyyy'), to_date('12-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (924, 'Sydney', 'Patrick', to_date('28-05-2006', 'dd-mm-yyyy'), to_date('04-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (925, 'Hilary', 'Curfman', to_date('14-05-2006', 'dd-mm-yyyy'), to_date('12-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (926, 'Kirsten', 'Scaggs', to_date('21-10-2006', 'dd-mm-yyyy'), to_date('04-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (927, 'Joey', 'Arden', to_date('23-03-2006', 'dd-mm-yyyy'), to_date('04-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (928, 'Chalee', 'Cusack', to_date('20-03-2006', 'dd-mm-yyyy'), to_date('23-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (929, 'Giancarlo', 'Frampton', to_date('10-09-2006', 'dd-mm-yyyy'), to_date('24-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (930, 'Patti', 'Belles', to_date('14-05-2006', 'dd-mm-yyyy'), to_date('07-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (931, 'Rory', 'Weaver', to_date('14-04-2006', 'dd-mm-yyyy'), to_date('23-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (932, 'Hugo', 'Rucker', to_date('29-06-2006', 'dd-mm-yyyy'), to_date('31-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (933, 'Anna', 'Feliciano', to_date('12-02-2006', 'dd-mm-yyyy'), to_date('01-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (934, 'Petula', 'Garofalo', to_date('21-05-2006', 'dd-mm-yyyy'), to_date('16-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (562, 'Amanda', 'Wainwright', to_date('12-09-2006', 'dd-mm-yyyy'), to_date('24-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (563, 'Ossie', 'Kennedy', to_date('22-08-2006', 'dd-mm-yyyy'), to_date('23-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (564, 'Sigourney', 'DiBiasio', to_date('21-06-2006', 'dd-mm-yyyy'), to_date('31-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (565, 'Geggy', 'Harnes', to_date('01-04-2006', 'dd-mm-yyyy'), to_date('01-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (566, 'Lennie', 'Ryan', to_date('10-07-2006', 'dd-mm-yyyy'), to_date('02-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (567, 'Talvin', 'Lindley', to_date('19-09-2006', 'dd-mm-yyyy'), to_date('28-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (568, 'Lynette', 'Fehr', to_date('10-01-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (569, 'Juliet', 'Vaughan', to_date('08-03-2006', 'dd-mm-yyyy'), to_date('10-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (570, 'Anna', 'Visnjic', to_date('17-08-2006', 'dd-mm-yyyy'), to_date('04-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (571, 'Cherry', 'Johnson', to_date('05-11-2006', 'dd-mm-yyyy'), to_date('13-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (572, 'Selma', 'Fichtner', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('17-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (573, 'Vince', 'Torres', to_date('28-11-2006', 'dd-mm-yyyy'), to_date('26-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (574, 'Cameron', 'Field', to_date('16-07-2006', 'dd-mm-yyyy'), to_date('25-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (575, 'Sylvester', 'Gyllenhaal', to_date('25-10-2006', 'dd-mm-yyyy'), to_date('13-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (576, 'Yolanda', 'Dorff', to_date('11-10-2006', 'dd-mm-yyyy'), to_date('05-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (577, 'John', 'Isaak', to_date('17-10-2006', 'dd-mm-yyyy'), to_date('13-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (578, 'Martha', 'Visnjic', to_date('29-07-2006', 'dd-mm-yyyy'), to_date('29-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (579, 'Curtis', 'Noseworthy', to_date('28-09-2006', 'dd-mm-yyyy'), to_date('06-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (580, 'Miriam', 'Rollins', to_date('11-01-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (581, 'Tzi', 'Tah', to_date('20-05-2006', 'dd-mm-yyyy'), to_date('25-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (582, 'Ryan', 'Aniston', to_date('10-07-2006', 'dd-mm-yyyy'), to_date('25-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (583, 'Vin', 'Summer', to_date('06-10-2006', 'dd-mm-yyyy'), to_date('29-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (584, 'Barry', 'Bates', to_date('18-02-2006', 'dd-mm-yyyy'), to_date('10-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (585, 'Rory', 'Roy Parnell', to_date('28-01-2006', 'dd-mm-yyyy'), to_date('14-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (586, 'Mena', 'Price', to_date('30-04-2006', 'dd-mm-yyyy'), to_date('13-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (587, 'Cary', 'Rooker', to_date('24-09-2006', 'dd-mm-yyyy'), to_date('18-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (588, 'Art', 'Rifkin', to_date('01-01-2006', 'dd-mm-yyyy'), to_date('08-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (589, 'Breckin', 'Roberts', to_date('30-10-2006', 'dd-mm-yyyy'), to_date('22-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (590, 'Nigel', 'De Niro', to_date('16-10-2006', 'dd-mm-yyyy'), to_date('24-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (591, 'Samantha', 'Ceasar', to_date('17-11-2006', 'dd-mm-yyyy'), to_date('21-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (592, 'Illeana', 'Balk', to_date('27-09-2006', 'dd-mm-yyyy'), to_date('19-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (593, 'Madeline', 'Lynch', to_date('06-11-2006', 'dd-mm-yyyy'), to_date('22-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (594, 'Natacha', 'McGill', to_date('31-03-2006', 'dd-mm-yyyy'), to_date('25-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (595, 'Milla', 'Rydell', to_date('16-07-2006', 'dd-mm-yyyy'), to_date('23-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (596, 'Vendetta', 'Harper', to_date('02-05-2006', 'dd-mm-yyyy'), to_date('18-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (597, 'Claude', 'Roundtree', to_date('04-04-2006', 'dd-mm-yyyy'), to_date('29-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (598, 'Isabella', 'Ramis', to_date('30-03-2006', 'dd-mm-yyyy'), to_date('01-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (599, 'Pamela', 'Lapointe', to_date('20-10-2006', 'dd-mm-yyyy'), to_date('22-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (600, 'Rod', 'McIntosh', to_date('01-05-2006', 'dd-mm-yyyy'), to_date('10-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (601, 'Rodney', 'Borgnine', to_date('14-10-2006', 'dd-mm-yyyy'), to_date('20-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (602, 'Anthony', 'Gordon', to_date('05-04-2006', 'dd-mm-yyyy'), to_date('20-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (603, 'Wallace', 'Vassar', to_date('23-03-2006', 'dd-mm-yyyy'), to_date('22-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (604, 'Kim', 'Reynolds', to_date('16-07-2006', 'dd-mm-yyyy'), to_date('08-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (605, 'Taye', 'Torino', to_date('25-06-2006', 'dd-mm-yyyy'), to_date('11-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (606, 'Gena', 'Steagall', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('23-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (607, 'Embeth', 'McCain', to_date('02-07-2006', 'dd-mm-yyyy'), to_date('23-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (608, 'Emma', 'Bugnon', to_date('16-09-2006', 'dd-mm-yyyy'), to_date('13-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (609, 'Howie', 'Lindo', to_date('15-05-2006', 'dd-mm-yyyy'), to_date('30-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (610, 'Nils', 'Gershon', to_date('20-11-2006', 'dd-mm-yyyy'), to_date('13-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (611, 'Naomi', 'Pigott-Smith', to_date('03-03-2006', 'dd-mm-yyyy'), to_date('26-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (612, 'Burt', 'Austin', to_date('22-03-2006', 'dd-mm-yyyy'), to_date('17-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (800, 'Don', 'Colton', to_date('05-11-2006', 'dd-mm-yyyy'), to_date('14-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (986, 'Tori', 'Garfunkel', to_date('14-12-2006', 'dd-mm-yyyy'), to_date('27-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (987, 'Liam', 'Rhys-Davies', to_date('16-11-2006', 'dd-mm-yyyy'), to_date('28-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (988, 'Juliana', 'Brickell', to_date('11-11-2006', 'dd-mm-yyyy'), to_date('21-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (989, 'Ivan', 'Gellar', to_date('15-04-2006', 'dd-mm-yyyy'), to_date('30-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (990, 'Vienna', 'Miller', to_date('09-03-2006', 'dd-mm-yyyy'), to_date('11-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (991, 'Solomon', 'Moore', to_date('18-02-2006', 'dd-mm-yyyy'), to_date('17-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (992, 'Matthew', 'Negbaur', to_date('17-07-2006', 'dd-mm-yyyy'), to_date('21-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (993, 'Rhys', 'Shannon', to_date('06-09-2006', 'dd-mm-yyyy'), to_date('25-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (994, 'Jackie', 'Witherspoon', to_date('19-12-2006', 'dd-mm-yyyy'), to_date('17-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (995, 'Denny', 'Collins', to_date('29-04-2006', 'dd-mm-yyyy'), to_date('05-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (996, 'Kid', 'Paquin', to_date('31-08-2006', 'dd-mm-yyyy'), to_date('27-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (997, 'Robbie', 'Giannini', to_date('04-10-2006', 'dd-mm-yyyy'), to_date('27-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (998, 'Spencer', 'Cube', to_date('06-02-2006', 'dd-mm-yyyy'), to_date('08-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (999, 'Patrick', 'Wen', to_date('23-06-2006', 'dd-mm-yyyy'), to_date('27-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1000, 'Irene', 'Reiner', to_date('24-05-2006', 'dd-mm-yyyy'), to_date('05-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1001, 'Rip', 'Cleese', to_date('23-07-2006', 'dd-mm-yyyy'), to_date('15-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1002, 'Avenged', 'Matarazzo', to_date('13-01-2006', 'dd-mm-yyyy'), to_date('29-07-2009', 'dd-mm-yyyy'));
commit;
prompt 900 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1003, 'Alicia', 'Crewson', to_date('23-10-2006', 'dd-mm-yyyy'), to_date('19-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1004, 'Patrick', 'Hatfield', to_date('23-11-2006', 'dd-mm-yyyy'), to_date('22-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1005, 'Devon', 'Chao', to_date('04-03-2006', 'dd-mm-yyyy'), to_date('08-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1006, 'Val', 'Sobieski', to_date('30-07-2006', 'dd-mm-yyyy'), to_date('29-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1007, 'Jean-Luc', 'Newton', to_date('16-06-2006', 'dd-mm-yyyy'), to_date('29-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1008, 'Gloria', 'Berkoff', to_date('16-01-2006', 'dd-mm-yyyy'), to_date('14-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1009, 'Sylvester', 'Ponty', to_date('05-06-2006', 'dd-mm-yyyy'), to_date('02-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1010, 'Andie', 'Crystal', to_date('29-07-2006', 'dd-mm-yyyy'), to_date('23-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1011, 'Dean', 'Miles', to_date('15-02-2006', 'dd-mm-yyyy'), to_date('13-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1012, 'Mika', 'Cattrall', to_date('24-01-2006', 'dd-mm-yyyy'), to_date('27-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1013, 'Anthony', 'Roth', to_date('31-07-2006', 'dd-mm-yyyy'), to_date('09-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1014, 'Jean-Luc', 'Clayton', to_date('02-08-2006', 'dd-mm-yyyy'), to_date('16-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1015, 'Norm', 'Sizemore', to_date('14-10-2006', 'dd-mm-yyyy'), to_date('20-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1016, 'Rowan', 'Rivers', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('22-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1017, 'Merillee', 'O''Keefe', to_date('03-01-2006', 'dd-mm-yyyy'), to_date('13-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1018, 'Christine', 'Laws', to_date('03-08-2006', 'dd-mm-yyyy'), to_date('20-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1019, 'Leelee', 'Khan', to_date('20-05-2006', 'dd-mm-yyyy'), to_date('02-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1020, 'William', 'Stiller', to_date('01-10-2006', 'dd-mm-yyyy'), to_date('23-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1021, 'Kenny', 'Beals', to_date('15-11-2006', 'dd-mm-yyyy'), to_date('22-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1022, 'Elijah', 'Dzundza', to_date('28-08-2006', 'dd-mm-yyyy'), to_date('24-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1023, 'Robby', 'Williamson', to_date('29-06-2006', 'dd-mm-yyyy'), to_date('16-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1024, 'Ian', 'Bedelia', to_date('24-12-2006', 'dd-mm-yyyy'), to_date('17-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1025, 'Lea', 'Vannelli', to_date('06-11-2006', 'dd-mm-yyyy'), to_date('05-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1026, 'Alicia', 'Molina', to_date('26-08-2006', 'dd-mm-yyyy'), to_date('20-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1027, 'Davey', 'Branagh', to_date('13-01-2006', 'dd-mm-yyyy'), to_date('26-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1028, 'Michael', 'MacDonald', to_date('11-08-2006', 'dd-mm-yyyy'), to_date('12-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1029, 'Stanley', 'Lipnicki', to_date('09-10-2006', 'dd-mm-yyyy'), to_date('03-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1030, 'Carla', 'Sheen', to_date('28-11-2006', 'dd-mm-yyyy'), to_date('09-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1031, 'Gordie', 'Reeve', to_date('08-12-2006', 'dd-mm-yyyy'), to_date('13-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1032, 'Ryan', 'Chan', to_date('04-02-2006', 'dd-mm-yyyy'), to_date('16-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1033, 'Beverley', 'Dean', to_date('05-05-2006', 'dd-mm-yyyy'), to_date('23-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1034, 'Seth', 'Crosby', to_date('03-12-2006', 'dd-mm-yyyy'), to_date('18-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1035, 'Salma', 'Bale', to_date('07-11-2006', 'dd-mm-yyyy'), to_date('26-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1036, 'Rachel', 'Cassidy', to_date('22-05-2006', 'dd-mm-yyyy'), to_date('17-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1037, 'George', 'Lucien', to_date('25-10-2006', 'dd-mm-yyyy'), to_date('14-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1038, 'Giancarlo', 'Abraham', to_date('15-01-2006', 'dd-mm-yyyy'), to_date('07-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1039, 'Julie', 'Camp', to_date('23-10-2006', 'dd-mm-yyyy'), to_date('14-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1040, 'Buddy', 'Dunaway', to_date('23-08-2006', 'dd-mm-yyyy'), to_date('20-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1041, 'Michelle', 'Aniston', to_date('08-09-2006', 'dd-mm-yyyy'), to_date('30-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1042, 'Max', 'Holeman', to_date('19-02-2006', 'dd-mm-yyyy'), to_date('02-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1043, 'Kyle', 'Colon', to_date('09-12-2006', 'dd-mm-yyyy'), to_date('19-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1044, 'Merillee', 'Mortensen', to_date('22-11-2006', 'dd-mm-yyyy'), to_date('21-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1045, 'Allison', 'Craig', to_date('19-05-2006', 'dd-mm-yyyy'), to_date('22-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1046, 'William', 'Keaton', to_date('26-04-2006', 'dd-mm-yyyy'), to_date('11-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1047, 'Remy', 'Galecki', to_date('17-02-2006', 'dd-mm-yyyy'), to_date('31-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1048, 'Holland', 'Oates', to_date('25-09-2006', 'dd-mm-yyyy'), to_date('22-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1049, 'Mel', 'Lloyd', to_date('03-12-2006', 'dd-mm-yyyy'), to_date('24-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1050, 'Al', 'Weaving', to_date('07-08-2006', 'dd-mm-yyyy'), to_date('05-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1051, 'Russell', 'McKennitt', to_date('23-09-2006', 'dd-mm-yyyy'), to_date('20-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1052, 'Rosco', 'Askew', to_date('09-01-2006', 'dd-mm-yyyy'), to_date('29-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1053, 'Annie', 'Gleeson', to_date('29-08-2006', 'dd-mm-yyyy'), to_date('13-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1054, 'Russell', 'Holiday', to_date('06-08-2006', 'dd-mm-yyyy'), to_date('11-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1055, 'Donal', 'Soul', to_date('28-03-2006', 'dd-mm-yyyy'), to_date('12-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1056, 'Ashley', 'McGill', to_date('21-07-2006', 'dd-mm-yyyy'), to_date('09-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1057, 'Guy', 'Rispoli', to_date('30-11-2006', 'dd-mm-yyyy'), to_date('12-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1058, 'Giovanni', 'Assante', to_date('17-03-2006', 'dd-mm-yyyy'), to_date('27-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1059, 'Peabo', 'Perry', to_date('23-12-2006', 'dd-mm-yyyy'), to_date('27-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1060, 'Andrae', 'Giraldo', to_date('30-09-2006', 'dd-mm-yyyy'), to_date('06-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1061, 'Jimmy', 'Napolitano', to_date('10-09-2006', 'dd-mm-yyyy'), to_date('23-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1062, 'Gilbert', 'Marin', to_date('22-04-2006', 'dd-mm-yyyy'), to_date('12-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1063, 'Harriet', 'Kapanka', to_date('21-10-2006', 'dd-mm-yyyy'), to_date('10-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1064, 'Natasha', 'Giannini', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('12-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1065, 'Bruce', 'Krieger', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('25-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1066, 'Oliver', 'Giannini', to_date('04-06-2006', 'dd-mm-yyyy'), to_date('25-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1067, 'Nora', 'Bullock', to_date('10-10-2006', 'dd-mm-yyyy'), to_date('04-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1068, 'Courtney', 'Mould', to_date('13-02-2006', 'dd-mm-yyyy'), to_date('24-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1069, 'Dom', 'Jonze', to_date('30-04-2006', 'dd-mm-yyyy'), to_date('19-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1070, 'Mykelti', 'Ceasar', to_date('13-06-2006', 'dd-mm-yyyy'), to_date('12-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1071, 'Betty', 'Connick', to_date('03-11-2006', 'dd-mm-yyyy'), to_date('16-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1072, 'Beth', 'Crowell', to_date('25-06-2006', 'dd-mm-yyyy'), to_date('28-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1073, 'Brendan', 'De Niro', to_date('06-10-2006', 'dd-mm-yyyy'), to_date('26-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1074, 'Tamala', 'Cetera', to_date('20-04-2006', 'dd-mm-yyyy'), to_date('08-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1075, 'Miki', 'Randal', to_date('15-07-2006', 'dd-mm-yyyy'), to_date('23-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1076, 'Jimmie', 'Union', to_date('07-04-2006', 'dd-mm-yyyy'), to_date('03-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1077, 'Herbie', 'Whitman', to_date('03-04-2006', 'dd-mm-yyyy'), to_date('21-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1078, 'Ossie', 'Stuermer', to_date('13-08-2006', 'dd-mm-yyyy'), to_date('03-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1079, 'Philip', 'Ferrell', to_date('01-09-2006', 'dd-mm-yyyy'), to_date('07-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1080, 'Curt', 'Kinski', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('17-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1081, 'Kevn', 'Elizabeth', to_date('29-06-2006', 'dd-mm-yyyy'), to_date('31-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1082, 'Grant', 'Collette', to_date('15-06-2006', 'dd-mm-yyyy'), to_date('03-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1083, 'Todd', 'Richter', to_date('02-01-2006', 'dd-mm-yyyy'), to_date('27-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1084, 'Cevin', 'Fender', to_date('23-05-2006', 'dd-mm-yyyy'), to_date('28-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1085, 'Red', 'Brosnan', to_date('25-12-2006', 'dd-mm-yyyy'), to_date('03-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1086, 'Art', 'Barkin', to_date('19-12-2006', 'dd-mm-yyyy'), to_date('20-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1087, 'Dennis', 'Guinness', to_date('12-12-2006', 'dd-mm-yyyy'), to_date('10-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1088, 'Dom', 'Landau', to_date('18-06-2006', 'dd-mm-yyyy'), to_date('10-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1089, 'Kay', 'Penn', to_date('18-09-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1090, 'Emm', 'Perez', to_date('04-02-2006', 'dd-mm-yyyy'), to_date('01-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1091, 'Gina', 'Molina', to_date('01-04-2006', 'dd-mm-yyyy'), to_date('10-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1092, 'Rob', 'Shaw', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('26-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1093, 'Eugene', 'Lynne', to_date('08-11-2006', 'dd-mm-yyyy'), to_date('29-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1094, 'Trick', 'Hewitt', to_date('31-03-2006', 'dd-mm-yyyy'), to_date('04-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1095, 'Robbie', 'Davidtz', to_date('31-08-2006', 'dd-mm-yyyy'), to_date('20-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1096, 'Marie', 'McGinley', to_date('21-05-2006', 'dd-mm-yyyy'), to_date('11-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1097, 'Chet', 'Fogerty', to_date('09-06-2006', 'dd-mm-yyyy'), to_date('24-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1098, 'Latin', 'LaPaglia', to_date('30-12-2006', 'dd-mm-yyyy'), to_date('11-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1099, 'Chubby', 'Aniston', to_date('03-09-2006', 'dd-mm-yyyy'), to_date('19-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1100, 'Coley', 'Mifune', to_date('20-10-2006', 'dd-mm-yyyy'), to_date('04-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1101, 'Paula', 'Richardson', to_date('16-01-2006', 'dd-mm-yyyy'), to_date('27-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1102, 'Heather', 'Dreyfuss', to_date('08-10-2006', 'dd-mm-yyyy'), to_date('05-02-2009', 'dd-mm-yyyy'));
commit;
prompt 1000 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1103, 'Dave', 'Vicious', to_date('19-02-2006', 'dd-mm-yyyy'), to_date('08-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1104, 'Sylvester', 'Carmen', to_date('08-10-2006', 'dd-mm-yyyy'), to_date('01-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1105, 'Katrin', 'Pollak', to_date('30-06-2006', 'dd-mm-yyyy'), to_date('22-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1106, 'Pablo', 'Street', to_date('11-07-2006', 'dd-mm-yyyy'), to_date('05-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1107, 'Carl', 'Uggams', to_date('01-01-2006', 'dd-mm-yyyy'), to_date('24-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1108, 'Demi', 'Robards', to_date('21-11-2006', 'dd-mm-yyyy'), to_date('22-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1109, 'Sylvester', 'Willard', to_date('17-07-2006', 'dd-mm-yyyy'), to_date('07-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1110, 'Anne', 'Heatherly', to_date('10-06-2006', 'dd-mm-yyyy'), to_date('08-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1111, 'Mickey', 'Stiller', to_date('29-12-2006', 'dd-mm-yyyy'), to_date('12-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1112, 'Sylvester', 'Kenoly', to_date('07-05-2006', 'dd-mm-yyyy'), to_date('25-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1113, 'Lenny', 'Dupree', to_date('19-07-2006', 'dd-mm-yyyy'), to_date('10-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1114, 'Carrie-Anne', 'Neill', to_date('11-08-2006', 'dd-mm-yyyy'), to_date('04-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1115, 'Halle', 'Matheson', to_date('17-04-2006', 'dd-mm-yyyy'), to_date('26-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1116, 'Bonnie', 'Hornsby', to_date('27-07-2006', 'dd-mm-yyyy'), to_date('09-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1117, 'Judi', 'Colon', to_date('06-03-2006', 'dd-mm-yyyy'), to_date('02-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1118, 'Geggy', 'Checker', to_date('23-09-2006', 'dd-mm-yyyy'), to_date('11-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1119, 'Ray', 'Neuwirth', to_date('21-03-2006', 'dd-mm-yyyy'), to_date('20-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1120, 'Marina', 'Akins', to_date('04-12-2006', 'dd-mm-yyyy'), to_date('17-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (749, 'Trace', 'Nelson', to_date('28-11-2006', 'dd-mm-yyyy'), to_date('13-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (750, 'Juliet', 'Broadbent', to_date('09-10-2006', 'dd-mm-yyyy'), to_date('07-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (751, 'Bernard', 'Redgrave', to_date('11-09-2006', 'dd-mm-yyyy'), to_date('16-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (752, 'Vivica', 'De Almeida', to_date('01-06-2006', 'dd-mm-yyyy'), to_date('20-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (753, 'Ty', 'Albright', to_date('13-05-2006', 'dd-mm-yyyy'), to_date('02-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (754, 'Dermot', 'Borgnine', to_date('28-05-2006', 'dd-mm-yyyy'), to_date('13-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (755, 'Ann', 'Connelly', to_date('03-06-2006', 'dd-mm-yyyy'), to_date('19-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (756, 'Julia', 'Choice', to_date('18-09-2006', 'dd-mm-yyyy'), to_date('19-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (757, 'Christian', 'Isaacs', to_date('11-08-2006', 'dd-mm-yyyy'), to_date('01-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (758, 'Neil', 'Mellencamp', to_date('30-09-2006', 'dd-mm-yyyy'), to_date('02-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (759, 'Angela', 'Holm', to_date('18-11-2006', 'dd-mm-yyyy'), to_date('28-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (760, 'Goldie', 'Bates', to_date('29-03-2006', 'dd-mm-yyyy'), to_date('04-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (761, 'Ossie', 'Dale', to_date('17-09-2006', 'dd-mm-yyyy'), to_date('23-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (762, 'Arturo', 'Hector', to_date('18-06-2006', 'dd-mm-yyyy'), to_date('30-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (763, 'Seth', 'MacDonald', to_date('14-09-2006', 'dd-mm-yyyy'), to_date('28-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (764, 'Sonny', 'Rifkin', to_date('28-09-2006', 'dd-mm-yyyy'), to_date('07-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (765, 'Mika', 'Waits', to_date('12-07-2006', 'dd-mm-yyyy'), to_date('01-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (766, 'Lennie', 'Holy', to_date('23-04-2006', 'dd-mm-yyyy'), to_date('25-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (767, 'Rhett', 'Wilder', to_date('26-02-2006', 'dd-mm-yyyy'), to_date('22-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (768, 'Kay', 'Sirtis', to_date('02-06-2006', 'dd-mm-yyyy'), to_date('23-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (769, 'Andie', 'Malone', to_date('30-05-2006', 'dd-mm-yyyy'), to_date('24-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (770, 'Mia', 'Roundtree', to_date('01-11-2006', 'dd-mm-yyyy'), to_date('22-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (771, 'Peabo', 'Griggs', to_date('01-11-2006', 'dd-mm-yyyy'), to_date('23-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (772, 'Ali', 'Isaak', to_date('04-08-2006', 'dd-mm-yyyy'), to_date('09-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (773, 'Christina', 'Darren', to_date('17-11-2006', 'dd-mm-yyyy'), to_date('24-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (774, 'Delroy', 'Paul', to_date('26-01-2006', 'dd-mm-yyyy'), to_date('01-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (775, 'Julie', 'Meniketti', to_date('17-05-2006', 'dd-mm-yyyy'), to_date('06-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (776, 'Nickel', 'Flanery', to_date('28-05-2006', 'dd-mm-yyyy'), to_date('07-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (777, 'Ronny', 'Domino', to_date('03-05-2006', 'dd-mm-yyyy'), to_date('15-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (778, 'Raul', 'Harnes', to_date('11-03-2006', 'dd-mm-yyyy'), to_date('19-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (779, 'Rufus', 'Plummer', to_date('04-02-2006', 'dd-mm-yyyy'), to_date('06-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (780, 'Lara', 'O''Neill', to_date('02-07-2006', 'dd-mm-yyyy'), to_date('17-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (781, 'Harriet', 'Brock', to_date('17-09-2006', 'dd-mm-yyyy'), to_date('18-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (782, 'Lin', 'Blackmore', to_date('25-03-2006', 'dd-mm-yyyy'), to_date('21-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (783, 'Randy', 'Roy Parnell', to_date('22-09-2006', 'dd-mm-yyyy'), to_date('04-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (784, 'Irene', 'Costner', to_date('20-09-2006', 'dd-mm-yyyy'), to_date('15-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (785, 'Albertina', 'Dillane', to_date('13-03-2006', 'dd-mm-yyyy'), to_date('27-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (786, 'Stellan', 'Stone', to_date('02-10-2006', 'dd-mm-yyyy'), to_date('08-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (787, 'Oliver', 'Vanian', to_date('29-01-2006', 'dd-mm-yyyy'), to_date('26-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (788, 'Doug', 'Turner', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('13-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (789, 'Timothy', 'Conners', to_date('22-11-2006', 'dd-mm-yyyy'), to_date('04-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (790, 'Chanté', 'Reiner', to_date('22-07-2006', 'dd-mm-yyyy'), to_date('27-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (791, 'Natalie', 'Def', to_date('24-09-2006', 'dd-mm-yyyy'), to_date('03-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (792, 'Famke', 'Davis', to_date('22-12-2006', 'dd-mm-yyyy'), to_date('14-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (793, 'Juice', 'Evanswood', to_date('13-07-2006', 'dd-mm-yyyy'), to_date('19-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (794, 'Chalee', 'Jamal', to_date('03-05-2006', 'dd-mm-yyyy'), to_date('21-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (795, 'Jodie', 'Myers', to_date('20-09-2006', 'dd-mm-yyyy'), to_date('04-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (796, 'Courtney', 'Piven', to_date('01-11-2006', 'dd-mm-yyyy'), to_date('02-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (797, 'Jean-Claude', 'Shepard', to_date('17-02-2006', 'dd-mm-yyyy'), to_date('30-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (798, 'David', 'Hopper', to_date('27-05-2006', 'dd-mm-yyyy'), to_date('31-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (799, 'Raymond', 'Voight', to_date('26-03-2006', 'dd-mm-yyyy'), to_date('06-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1174, 'Albertina', 'Playboys', to_date('05-07-2006', 'dd-mm-yyyy'), to_date('23-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1175, 'Giancarlo', 'Fierstein', to_date('06-05-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1176, 'Liquid', 'Visnjic', to_date('22-04-2006', 'dd-mm-yyyy'), to_date('08-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1177, 'Curt', 'Isaak', to_date('15-06-2006', 'dd-mm-yyyy'), to_date('23-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1178, 'Julia', 'Galecki', to_date('04-09-2006', 'dd-mm-yyyy'), to_date('30-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1179, 'Gloria', 'Miles', to_date('04-04-2006', 'dd-mm-yyyy'), to_date('25-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1180, 'Jonny', 'Day-Lewis', to_date('10-03-2006', 'dd-mm-yyyy'), to_date('23-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1181, 'Tcheky', 'Reilly', to_date('08-07-2006', 'dd-mm-yyyy'), to_date('01-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1182, 'Mekhi', 'Renfro', to_date('09-04-2006', 'dd-mm-yyyy'), to_date('18-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1183, 'Mekhi', 'Vinton', to_date('08-10-2006', 'dd-mm-yyyy'), to_date('26-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1184, 'Julianna', 'Sepulveda', to_date('11-05-2006', 'dd-mm-yyyy'), to_date('28-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1185, 'Melanie', 'Plowright', to_date('14-11-2006', 'dd-mm-yyyy'), to_date('24-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1186, 'Peter', 'Culkin', to_date('09-05-2006', 'dd-mm-yyyy'), to_date('28-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1187, 'Ron', 'Humphrey', to_date('12-11-2006', 'dd-mm-yyyy'), to_date('18-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1188, 'Wally', 'Ratzenberger', to_date('25-05-2006', 'dd-mm-yyyy'), to_date('24-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1189, 'Chi', 'Plowright', to_date('04-03-2006', 'dd-mm-yyyy'), to_date('23-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1190, 'Alicia', 'LaBelle', to_date('13-12-2006', 'dd-mm-yyyy'), to_date('28-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1191, 'Samuel', 'Vinton', to_date('21-01-2006', 'dd-mm-yyyy'), to_date('19-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1192, 'Emma', 'Blaine', to_date('15-03-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1193, 'Christmas', 'Schiff', to_date('12-06-2006', 'dd-mm-yyyy'), to_date('09-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1194, 'Randall', 'Weber', to_date('03-10-2006', 'dd-mm-yyyy'), to_date('29-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1195, 'Debi', 'Weller', to_date('18-01-2006', 'dd-mm-yyyy'), to_date('21-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1196, 'Wallace', 'Ticotin', to_date('05-09-2006', 'dd-mm-yyyy'), to_date('30-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1197, 'Julia', 'Osbourne', to_date('06-10-2006', 'dd-mm-yyyy'), to_date('31-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1198, 'Louise', 'Hewett', to_date('22-10-2006', 'dd-mm-yyyy'), to_date('19-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1199, 'Charlie', 'Matthau', to_date('14-06-2006', 'dd-mm-yyyy'), to_date('15-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1200, 'Winona', 'Dillon', to_date('04-06-2006', 'dd-mm-yyyy'), to_date('15-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1201, 'Dylan', 'Leigh', to_date('12-12-2006', 'dd-mm-yyyy'), to_date('28-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1202, 'Lin', 'Bentley', to_date('08-03-2006', 'dd-mm-yyyy'), to_date('12-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1203, 'Ozzy', 'Guinness', to_date('17-06-2006', 'dd-mm-yyyy'), to_date('15-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1204, 'Scott', 'Allan', to_date('31-05-2006', 'dd-mm-yyyy'), to_date('16-08-2009', 'dd-mm-yyyy'));
commit;
prompt 1100 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1205, 'Bruce', 'Baez', to_date('27-03-2006', 'dd-mm-yyyy'), to_date('15-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1206, 'Joey', 'Krabbe', to_date('04-09-2006', 'dd-mm-yyyy'), to_date('10-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1207, 'Clarence', 'Hawke', to_date('16-07-2006', 'dd-mm-yyyy'), to_date('18-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1208, 'Sander', 'Thornton', to_date('09-09-2006', 'dd-mm-yyyy'), to_date('22-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1209, 'Glen', 'Guest', to_date('23-12-2006', 'dd-mm-yyyy'), to_date('06-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1210, 'Sonny', 'Lillard', to_date('03-07-2006', 'dd-mm-yyyy'), to_date('07-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1211, 'Tyrone', 'Bloch', to_date('07-02-2006', 'dd-mm-yyyy'), to_date('02-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1212, 'Daniel', 'Harnes', to_date('20-01-2006', 'dd-mm-yyyy'), to_date('06-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1213, 'Clea', 'Woods', to_date('04-05-2006', 'dd-mm-yyyy'), to_date('12-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1214, 'Johnnie', 'Deschanel', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('14-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1215, 'Aida', 'Cozier', to_date('23-03-2006', 'dd-mm-yyyy'), to_date('28-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1216, 'Ewan', 'McPherson', to_date('30-09-2006', 'dd-mm-yyyy'), to_date('11-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1217, 'Roy', 'Patrick', to_date('17-12-2006', 'dd-mm-yyyy'), to_date('05-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1218, 'Candice', 'Sorvino', to_date('06-03-2006', 'dd-mm-yyyy'), to_date('29-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1219, 'Trace', 'Roberts', to_date('18-04-2006', 'dd-mm-yyyy'), to_date('09-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1220, 'Rodney', 'Gilliam', to_date('20-02-2006', 'dd-mm-yyyy'), to_date('20-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1221, 'Robert', 'Kier', to_date('02-09-2006', 'dd-mm-yyyy'), to_date('24-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1222, 'Cate', 'Parker', to_date('07-09-2006', 'dd-mm-yyyy'), to_date('26-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1223, 'Collin', 'Bassett', to_date('27-09-2006', 'dd-mm-yyyy'), to_date('07-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1224, 'Vivica', 'Warden', to_date('02-06-2006', 'dd-mm-yyyy'), to_date('11-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1225, 'Angela', 'LuPone', to_date('26-02-2006', 'dd-mm-yyyy'), to_date('23-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1226, 'Jann', 'Boorem', to_date('24-03-2006', 'dd-mm-yyyy'), to_date('02-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1227, 'Dean', 'Hewett', to_date('08-09-2006', 'dd-mm-yyyy'), to_date('17-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1228, 'Moe', 'Douglas', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('04-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1229, 'Barry', 'Crewson', to_date('26-08-2006', 'dd-mm-yyyy'), to_date('08-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1230, 'Nathan', 'Grier', to_date('20-05-2006', 'dd-mm-yyyy'), to_date('09-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1231, 'Nils', 'Fierstein', to_date('27-08-2006', 'dd-mm-yyyy'), to_date('20-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1232, 'Orlando', 'Luongo', to_date('10-08-2006', 'dd-mm-yyyy'), to_date('08-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1233, 'Ed', 'Roth', to_date('22-08-2006', 'dd-mm-yyyy'), to_date('12-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1234, 'Matt', 'Rhymes', to_date('07-04-2006', 'dd-mm-yyyy'), to_date('16-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1235, 'Praga', 'Cummings', to_date('04-04-2006', 'dd-mm-yyyy'), to_date('03-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1236, 'Willie', 'Keitel', to_date('03-03-2006', 'dd-mm-yyyy'), to_date('18-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1237, 'Walter', 'Moss', to_date('12-07-2006', 'dd-mm-yyyy'), to_date('07-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1238, 'Bo', 'Garr', to_date('20-03-2006', 'dd-mm-yyyy'), to_date('03-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1239, 'Amanda', 'Macy', to_date('10-11-2006', 'dd-mm-yyyy'), to_date('11-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1240, 'Malcolm', 'Adams', to_date('17-04-2006', 'dd-mm-yyyy'), to_date('10-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1241, 'Pierce', 'Affleck', to_date('01-05-2006', 'dd-mm-yyyy'), to_date('08-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1242, 'Elijah', 'Waits', to_date('24-06-2006', 'dd-mm-yyyy'), to_date('03-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1243, 'Wally', 'Oakenfold', to_date('23-04-2006', 'dd-mm-yyyy'), to_date('22-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1244, 'Chris', 'Griffith', to_date('28-07-2006', 'dd-mm-yyyy'), to_date('22-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1245, 'Keanu', 'Archer', to_date('17-05-2006', 'dd-mm-yyyy'), to_date('21-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1246, 'Trey', 'Cobbs', to_date('27-11-2006', 'dd-mm-yyyy'), to_date('10-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1247, 'Amanda', 'Osmond', to_date('29-07-2006', 'dd-mm-yyyy'), to_date('30-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1248, 'Sigourney', 'Whitaker', to_date('13-07-2006', 'dd-mm-yyyy'), to_date('18-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1249, 'Nina', 'McDormand', to_date('18-12-2006', 'dd-mm-yyyy'), to_date('07-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1250, 'Lucinda', 'Davidson', to_date('20-08-2006', 'dd-mm-yyyy'), to_date('04-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1251, 'Petula', 'Ledger', to_date('23-06-2006', 'dd-mm-yyyy'), to_date('04-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1252, 'Rhea', 'Gershon', to_date('03-05-2006', 'dd-mm-yyyy'), to_date('21-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1253, 'Lucinda', 'Griggs', to_date('04-02-2006', 'dd-mm-yyyy'), to_date('08-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1254, 'Marina', 'Vincent', to_date('07-10-2006', 'dd-mm-yyyy'), to_date('25-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1255, 'Balthazar', 'Sainte-Marie', to_date('07-05-2006', 'dd-mm-yyyy'), to_date('01-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1256, 'Vincent', 'Branagh', to_date('18-06-2006', 'dd-mm-yyyy'), to_date('22-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1257, 'Ewan', 'Overstreet', to_date('10-02-2006', 'dd-mm-yyyy'), to_date('28-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1258, 'Kristin', 'Page', to_date('27-01-2006', 'dd-mm-yyyy'), to_date('19-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1259, 'Isaiah', 'Roth', to_date('22-09-2006', 'dd-mm-yyyy'), to_date('10-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1260, 'Moe', 'Sayer', to_date('22-05-2006', 'dd-mm-yyyy'), to_date('21-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1261, 'Bret', 'Jackman', to_date('03-06-2006', 'dd-mm-yyyy'), to_date('15-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1262, 'Chalee', 'Driver', to_date('02-09-2006', 'dd-mm-yyyy'), to_date('24-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1263, 'Trini', 'Forrest', to_date('20-01-2006', 'dd-mm-yyyy'), to_date('11-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1264, 'Leon', 'Azaria', to_date('18-04-2006', 'dd-mm-yyyy'), to_date('01-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1265, 'Lydia', 'Cleese', to_date('02-03-2006', 'dd-mm-yyyy'), to_date('19-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1266, 'Patty', 'Underwood', to_date('18-09-2006', 'dd-mm-yyyy'), to_date('19-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1267, 'Pat', 'Reinhold', to_date('07-05-2006', 'dd-mm-yyyy'), to_date('13-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1268, 'Saffron', 'Copeland', to_date('25-09-2006', 'dd-mm-yyyy'), to_date('08-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1269, 'Shirley', 'Ryan', to_date('29-11-2006', 'dd-mm-yyyy'), to_date('14-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1270, 'Elvis', 'Diesel', to_date('31-01-2006', 'dd-mm-yyyy'), to_date('18-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1271, 'Tobey', 'Tilly', to_date('24-11-2006', 'dd-mm-yyyy'), to_date('28-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1272, 'Kathy', 'Krabbe', to_date('29-04-2006', 'dd-mm-yyyy'), to_date('19-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1273, 'Nancy', 'Posey', to_date('08-05-2006', 'dd-mm-yyyy'), to_date('03-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1274, 'Lili', 'Bracco', to_date('23-01-2006', 'dd-mm-yyyy'), to_date('09-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1275, 'Victor', 'Williams', to_date('14-12-2006', 'dd-mm-yyyy'), to_date('29-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1276, 'Julianna', 'Tucker', to_date('14-06-2006', 'dd-mm-yyyy'), to_date('27-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1277, 'Nanci', 'Pigott-Smith', to_date('16-12-2006', 'dd-mm-yyyy'), to_date('27-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1278, 'Johnny', 'Lipnicki', to_date('15-01-2006', 'dd-mm-yyyy'), to_date('28-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1279, 'Oro', 'Lachey', to_date('31-05-2006', 'dd-mm-yyyy'), to_date('06-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1280, 'Sigourney', 'Chappelle', to_date('03-12-2006', 'dd-mm-yyyy'), to_date('05-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1281, 'Lily', 'Ryan', to_date('19-09-2006', 'dd-mm-yyyy'), to_date('05-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1282, 'Barbara', 'Saxon', to_date('11-03-2006', 'dd-mm-yyyy'), to_date('29-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1283, 'Raymond', 'Duncan', to_date('02-07-2006', 'dd-mm-yyyy'), to_date('07-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1284, 'Anne', 'Keaton', to_date('12-09-2006', 'dd-mm-yyyy'), to_date('19-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1285, 'Emm', 'Drive', to_date('11-10-2006', 'dd-mm-yyyy'), to_date('07-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1286, 'Shirley', 'Dorff', to_date('28-02-2006', 'dd-mm-yyyy'), to_date('10-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1287, 'Karon', 'English', to_date('18-06-2006', 'dd-mm-yyyy'), to_date('05-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1288, 'Thora', 'Puckett', to_date('16-07-2006', 'dd-mm-yyyy'), to_date('05-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1289, 'Dave', 'Marsden', to_date('25-02-2006', 'dd-mm-yyyy'), to_date('02-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1290, 'Willie', 'Derringer', to_date('03-10-2006', 'dd-mm-yyyy'), to_date('13-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1291, 'Gabrielle', 'Perez', to_date('03-04-2006', 'dd-mm-yyyy'), to_date('07-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1292, 'Carlos', 'Ferrell', to_date('19-09-2006', 'dd-mm-yyyy'), to_date('07-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1293, 'Grace', 'Ermey', to_date('29-05-2006', 'dd-mm-yyyy'), to_date('22-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1294, 'Giancarlo', 'Branagh', to_date('20-08-2006', 'dd-mm-yyyy'), to_date('27-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1295, 'Shirley', 'Puckett', to_date('25-03-2006', 'dd-mm-yyyy'), to_date('22-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1296, 'Celia', 'Wen', to_date('11-09-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1297, 'Lance', 'Arkin', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('25-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1298, 'Rob', 'Beals', to_date('28-12-2006', 'dd-mm-yyyy'), to_date('07-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1299, 'Colleen', 'Mohr', to_date('27-10-2006', 'dd-mm-yyyy'), to_date('22-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1300, 'Lauren', 'Thorton', to_date('26-10-2006', 'dd-mm-yyyy'), to_date('03-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1301, 'Leo', 'Harnes', to_date('22-09-2006', 'dd-mm-yyyy'), to_date('08-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1302, 'Jeremy', 'Curtis-Hall', to_date('30-03-2006', 'dd-mm-yyyy'), to_date('18-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1303, 'Tanya', 'Margolyes', to_date('27-03-2006', 'dd-mm-yyyy'), to_date('15-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1304, 'Collective', 'McGowan', to_date('01-01-2006', 'dd-mm-yyyy'), to_date('09-10-2009', 'dd-mm-yyyy'));
commit;
prompt 1200 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1305, 'Jackie', 'Suvari', to_date('13-11-2006', 'dd-mm-yyyy'), to_date('31-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1306, 'Millie', 'Idol', to_date('17-09-2006', 'dd-mm-yyyy'), to_date('17-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1307, 'Jarvis', 'Neuwirth', to_date('18-02-2006', 'dd-mm-yyyy'), to_date('26-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (935, 'Lucinda', 'Platt', to_date('04-06-2006', 'dd-mm-yyyy'), to_date('27-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (936, 'Daryl', 'Houston', to_date('27-10-2006', 'dd-mm-yyyy'), to_date('04-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (937, 'Holly', 'Cartlidge', to_date('06-05-2006', 'dd-mm-yyyy'), to_date('27-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (938, 'Austin', 'Tomei', to_date('30-03-2006', 'dd-mm-yyyy'), to_date('23-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (939, 'Jimmy', 'Pleasure', to_date('16-01-2006', 'dd-mm-yyyy'), to_date('23-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (940, 'Garland', 'Church', to_date('18-10-2006', 'dd-mm-yyyy'), to_date('22-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (941, 'Hope', 'Jackson', to_date('20-02-2006', 'dd-mm-yyyy'), to_date('04-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (942, 'Joaquin', 'Loring', to_date('30-08-2006', 'dd-mm-yyyy'), to_date('17-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (943, 'Ricky', 'Williamson', to_date('10-06-2006', 'dd-mm-yyyy'), to_date('03-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (944, 'Shelby', 'Vincent', to_date('13-09-2006', 'dd-mm-yyyy'), to_date('26-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (945, 'Harriet', 'Hamilton', to_date('02-01-2006', 'dd-mm-yyyy'), to_date('30-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (946, 'Dave', 'Guilfoyle', to_date('30-05-2006', 'dd-mm-yyyy'), to_date('23-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (947, 'Thora', 'Avital', to_date('29-06-2006', 'dd-mm-yyyy'), to_date('24-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (948, 'Lee', 'McPherson', to_date('14-03-2006', 'dd-mm-yyyy'), to_date('12-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (949, 'Chanté', 'Martinez', to_date('12-11-2006', 'dd-mm-yyyy'), to_date('09-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (950, 'Elias', 'Todd', to_date('20-12-2006', 'dd-mm-yyyy'), to_date('21-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (951, 'Davy', 'Stanley', to_date('09-05-2006', 'dd-mm-yyyy'), to_date('29-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (952, 'Samuel', 'Scheider', to_date('08-01-2006', 'dd-mm-yyyy'), to_date('12-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (953, 'Davis', 'Bradford', to_date('08-10-2006', 'dd-mm-yyyy'), to_date('22-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (954, 'Janice', 'Vicious', to_date('30-03-2006', 'dd-mm-yyyy'), to_date('08-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (955, 'Gin', 'Skerritt', to_date('17-02-2006', 'dd-mm-yyyy'), to_date('03-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (956, 'Clea', 'Waite', to_date('26-08-2006', 'dd-mm-yyyy'), to_date('01-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (957, 'Vickie', 'Giraldo', to_date('24-07-2006', 'dd-mm-yyyy'), to_date('28-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (958, 'Kenneth', 'Jones', to_date('23-03-2006', 'dd-mm-yyyy'), to_date('11-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (959, 'Jeff', 'Paige', to_date('28-07-2006', 'dd-mm-yyyy'), to_date('16-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (960, 'Bradley', 'Bugnon', to_date('10-01-2006', 'dd-mm-yyyy'), to_date('01-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (961, 'Rod', 'Blanchett', to_date('29-07-2006', 'dd-mm-yyyy'), to_date('02-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (962, 'Marisa', 'Morse', to_date('10-09-2006', 'dd-mm-yyyy'), to_date('29-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (963, 'Elle', 'Garr', to_date('08-10-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (964, 'Judi', 'Alda', to_date('13-03-2006', 'dd-mm-yyyy'), to_date('01-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (965, 'Jim', 'Davison', to_date('27-04-2006', 'dd-mm-yyyy'), to_date('26-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (966, 'Debi', 'Pigott-Smith', to_date('28-11-2006', 'dd-mm-yyyy'), to_date('16-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (967, 'Julianna', 'Woodard', to_date('31-10-2006', 'dd-mm-yyyy'), to_date('11-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (968, 'Penelope', 'Vai', to_date('15-01-2006', 'dd-mm-yyyy'), to_date('17-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (969, 'Yaphet', 'Turner', to_date('04-03-2006', 'dd-mm-yyyy'), to_date('29-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (970, 'Jason', 'Wilkinson', to_date('18-04-2006', 'dd-mm-yyyy'), to_date('07-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (971, 'Parker', 'Weiland', to_date('27-07-2006', 'dd-mm-yyyy'), to_date('09-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (972, 'Wallace', 'Neill', to_date('08-12-2006', 'dd-mm-yyyy'), to_date('21-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (973, 'Coley', 'Henstridge', to_date('21-01-2006', 'dd-mm-yyyy'), to_date('26-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (974, 'Caroline', 'Pearce', to_date('08-02-2006', 'dd-mm-yyyy'), to_date('27-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (975, 'Sona', 'Nakai', to_date('13-03-2006', 'dd-mm-yyyy'), to_date('26-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (976, 'Chely', 'Gyllenhaal', to_date('18-06-2006', 'dd-mm-yyyy'), to_date('24-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (977, 'LeVar', 'Weiland', to_date('21-02-2006', 'dd-mm-yyyy'), to_date('22-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (978, 'Collin', 'Arkenstone', to_date('25-02-2006', 'dd-mm-yyyy'), to_date('29-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (979, 'Colm', 'Ifans', to_date('02-01-2006', 'dd-mm-yyyy'), to_date('27-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (980, 'Gilberto', 'Plimpton', to_date('26-01-2006', 'dd-mm-yyyy'), to_date('01-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (981, 'Morris', 'Stallone', to_date('09-07-2006', 'dd-mm-yyyy'), to_date('07-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (982, 'Miki', 'Whitwam', to_date('16-06-2006', 'dd-mm-yyyy'), to_date('25-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (983, 'Lance', 'Pride', to_date('21-01-2006', 'dd-mm-yyyy'), to_date('01-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (984, 'Shawn', 'Marie', to_date('11-10-2006', 'dd-mm-yyyy'), to_date('25-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (985, 'Ed', 'Finney', to_date('24-11-2006', 'dd-mm-yyyy'), to_date('23-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1360, 'Catherine', 'Burton', to_date('24-06-2006', 'dd-mm-yyyy'), to_date('11-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1361, 'Gavin', 'Northam', to_date('31-01-2006', 'dd-mm-yyyy'), to_date('19-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1362, 'Hector', 'Clooney', to_date('15-11-2006', 'dd-mm-yyyy'), to_date('29-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1363, 'Maggie', 'Sampson', to_date('07-04-2006', 'dd-mm-yyyy'), to_date('20-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1364, 'Catherine', 'Flanagan', to_date('26-05-2006', 'dd-mm-yyyy'), to_date('23-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1365, 'Jackie', 'Garber', to_date('24-12-2006', 'dd-mm-yyyy'), to_date('06-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1366, 'Elizabeth', 'Elliott', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('10-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1367, 'Chet', 'Dzundza', to_date('26-02-2006', 'dd-mm-yyyy'), to_date('29-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1368, 'Julie', 'Oates', to_date('11-02-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1369, 'Grace', 'Arkin', to_date('02-10-2006', 'dd-mm-yyyy'), to_date('11-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1370, 'Seth', 'Rapaport', to_date('23-01-2006', 'dd-mm-yyyy'), to_date('23-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1371, 'Stevie', 'Lemmon', to_date('03-06-2006', 'dd-mm-yyyy'), to_date('17-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1372, 'Daniel', 'Holiday', to_date('16-05-2006', 'dd-mm-yyyy'), to_date('03-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1373, 'Will', 'Hamilton', to_date('20-05-2006', 'dd-mm-yyyy'), to_date('28-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1374, 'First', 'Chilton', to_date('22-03-2006', 'dd-mm-yyyy'), to_date('12-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1375, 'Carrie-Anne', 'Crowe', to_date('13-09-2006', 'dd-mm-yyyy'), to_date('18-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1376, 'Suzi', 'Arjona', to_date('08-11-2006', 'dd-mm-yyyy'), to_date('26-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1377, 'Moe', 'Skaggs', to_date('30-10-2006', 'dd-mm-yyyy'), to_date('23-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1378, 'Julie', 'Rossellini', to_date('20-01-2006', 'dd-mm-yyyy'), to_date('28-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1379, 'Gordie', 'Ruffalo', to_date('20-06-2006', 'dd-mm-yyyy'), to_date('12-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1380, 'Alex', 'Baker', to_date('19-11-2006', 'dd-mm-yyyy'), to_date('26-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1381, 'Leelee', 'McIntyre', to_date('28-09-2006', 'dd-mm-yyyy'), to_date('25-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1382, 'Diane', 'Kidman', to_date('25-10-2006', 'dd-mm-yyyy'), to_date('02-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1383, 'Horace', 'Holeman', to_date('14-09-2006', 'dd-mm-yyyy'), to_date('10-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1384, 'Anjelica', 'Brooks', to_date('03-02-2006', 'dd-mm-yyyy'), to_date('08-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1385, 'Morris', 'Latifah', to_date('16-02-2006', 'dd-mm-yyyy'), to_date('14-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1386, 'Jonatha', 'Moody', to_date('11-06-2006', 'dd-mm-yyyy'), to_date('15-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1387, 'Lucinda', 'Supernaw', to_date('12-08-2006', 'dd-mm-yyyy'), to_date('15-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1388, 'Maury', 'Shue', to_date('11-02-2006', 'dd-mm-yyyy'), to_date('10-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1389, 'Devon', 'Applegate', to_date('16-01-2006', 'dd-mm-yyyy'), to_date('12-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1390, 'Hilary', 'Bradford', to_date('15-03-2006', 'dd-mm-yyyy'), to_date('23-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1391, 'Alana', 'Malone', to_date('16-04-2006', 'dd-mm-yyyy'), to_date('09-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1392, 'Sammy', 'Scott', to_date('14-04-2006', 'dd-mm-yyyy'), to_date('02-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1393, 'Oro', 'Clarkson', to_date('16-04-2006', 'dd-mm-yyyy'), to_date('19-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1394, 'Natascha', 'Carnes', to_date('27-05-2006', 'dd-mm-yyyy'), to_date('11-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1395, 'Martha', 'Gates', to_date('28-05-2006', 'dd-mm-yyyy'), to_date('18-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1396, 'Frankie', 'Kleinenberg', to_date('24-04-2006', 'dd-mm-yyyy'), to_date('01-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1397, 'Cary', 'Hopkins', to_date('03-02-2006', 'dd-mm-yyyy'), to_date('22-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1398, 'Patti', 'Greene', to_date('30-01-2006', 'dd-mm-yyyy'), to_date('16-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1399, 'Judge', 'MacPherson', to_date('27-11-2006', 'dd-mm-yyyy'), to_date('07-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1400, 'Jake', 'Brock', to_date('22-12-2006', 'dd-mm-yyyy'), to_date('06-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1401, 'Caroline', 'Pullman', to_date('16-10-2006', 'dd-mm-yyyy'), to_date('06-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1402, 'Phoebe', 'Page', to_date('05-09-2006', 'dd-mm-yyyy'), to_date('29-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1403, 'Tommy', 'Wainwright', to_date('14-09-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1404, 'Keith', 'Orton', to_date('22-10-2006', 'dd-mm-yyyy'), to_date('17-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1405, 'Dylan', 'Greene', to_date('13-07-2006', 'dd-mm-yyyy'), to_date('17-07-2009', 'dd-mm-yyyy'));
commit;
prompt 1300 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1406, 'Yolanda', 'Cook', to_date('29-09-2006', 'dd-mm-yyyy'), to_date('10-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1407, 'Raymond', 'Matheson', to_date('05-05-2006', 'dd-mm-yyyy'), to_date('20-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1408, 'Ben', 'Tennison', to_date('15-10-2006', 'dd-mm-yyyy'), to_date('16-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1409, 'Celia', 'Thornton', to_date('08-12-2006', 'dd-mm-yyyy'), to_date('25-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1410, 'Victoria', 'Cherry', to_date('09-08-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1411, 'Johnette', 'Robinson', to_date('16-09-2006', 'dd-mm-yyyy'), to_date('16-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1412, 'Tamala', 'Bruce', to_date('07-01-2006', 'dd-mm-yyyy'), to_date('21-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1413, 'Marisa', 'Clark', to_date('27-10-2006', 'dd-mm-yyyy'), to_date('12-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1414, 'Liev', 'Waits', to_date('24-01-2006', 'dd-mm-yyyy'), to_date('16-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1415, 'Fionnula', 'Black', to_date('15-09-2006', 'dd-mm-yyyy'), to_date('18-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1416, 'Garth', 'Conners', to_date('02-06-2006', 'dd-mm-yyyy'), to_date('13-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1417, 'Wayne', 'Camp', to_date('08-11-2006', 'dd-mm-yyyy'), to_date('23-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1418, 'Garry', 'Weisz', to_date('01-02-2006', 'dd-mm-yyyy'), to_date('17-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1419, 'Malcolm', 'Charles', to_date('12-12-2006', 'dd-mm-yyyy'), to_date('16-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1420, 'Goran', 'Ledger', to_date('03-06-2006', 'dd-mm-yyyy'), to_date('13-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1421, 'Chalee', 'Tanon', to_date('07-04-2006', 'dd-mm-yyyy'), to_date('13-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1422, 'Leelee', 'Marie', to_date('24-06-2006', 'dd-mm-yyyy'), to_date('14-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1423, 'Tilda', 'Rhodes', to_date('09-06-2006', 'dd-mm-yyyy'), to_date('26-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1424, 'Sylvester', 'Unger', to_date('24-08-2006', 'dd-mm-yyyy'), to_date('28-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1425, 'Rosario', 'Mifune', to_date('04-07-2006', 'dd-mm-yyyy'), to_date('03-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1426, 'Laura', 'Atkinson', to_date('07-08-2006', 'dd-mm-yyyy'), to_date('31-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1427, 'Daniel', 'Osborne', to_date('09-04-2006', 'dd-mm-yyyy'), to_date('05-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1428, 'Trace', 'Moorer', to_date('03-08-2006', 'dd-mm-yyyy'), to_date('03-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1429, 'Pat', 'Holden', to_date('22-12-2006', 'dd-mm-yyyy'), to_date('12-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1430, 'Randall', 'Kenoly', to_date('06-01-2006', 'dd-mm-yyyy'), to_date('25-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1431, 'Wallace', 'Michael', to_date('21-04-2006', 'dd-mm-yyyy'), to_date('03-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1432, 'Oded', 'Carlton', to_date('28-04-2006', 'dd-mm-yyyy'), to_date('30-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1433, 'Remy', 'Goldwyn', to_date('03-09-2006', 'dd-mm-yyyy'), to_date('16-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1434, 'Anjelica', 'Rydell', to_date('19-03-2006', 'dd-mm-yyyy'), to_date('26-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1435, 'Leelee', 'Cromwell', to_date('09-11-2006', 'dd-mm-yyyy'), to_date('28-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1436, 'Tommy', 'Crow', to_date('02-03-2006', 'dd-mm-yyyy'), to_date('29-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1437, 'Devon', 'Gershon', to_date('27-11-2006', 'dd-mm-yyyy'), to_date('30-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1438, 'Ozzy', 'Metcalf', to_date('10-04-2006', 'dd-mm-yyyy'), to_date('06-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1439, 'Davy', 'Stormare', to_date('26-05-2006', 'dd-mm-yyyy'), to_date('14-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1440, 'Teena', 'Sartain', to_date('20-05-2006', 'dd-mm-yyyy'), to_date('27-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1441, 'Tori', 'Braugher', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1442, 'Tim', 'Crouse', to_date('25-07-2006', 'dd-mm-yyyy'), to_date('01-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1443, 'Ice', 'Spector', to_date('22-03-2006', 'dd-mm-yyyy'), to_date('23-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1444, 'Rolando', 'Allan', to_date('13-11-2006', 'dd-mm-yyyy'), to_date('20-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1445, 'Joaquin', 'Bean', to_date('03-11-2006', 'dd-mm-yyyy'), to_date('09-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1446, 'Michael', 'Ifans', to_date('05-06-2006', 'dd-mm-yyyy'), to_date('29-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1447, 'Stellan', 'Bening', to_date('23-02-2006', 'dd-mm-yyyy'), to_date('27-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1448, 'Robin', 'Wilder', to_date('01-11-2006', 'dd-mm-yyyy'), to_date('28-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1449, 'Freda', 'Gertner', to_date('06-11-2006', 'dd-mm-yyyy'), to_date('24-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1450, 'Alice', 'Pride', to_date('13-11-2006', 'dd-mm-yyyy'), to_date('04-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1451, 'Veruca', 'Bancroft', to_date('13-03-2006', 'dd-mm-yyyy'), to_date('13-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1452, 'Edward', 'Simpson', to_date('03-07-2006', 'dd-mm-yyyy'), to_date('26-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1453, 'Chaka', 'Peet', to_date('20-05-2006', 'dd-mm-yyyy'), to_date('08-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1454, 'Joan', 'Vicious', to_date('30-03-2006', 'dd-mm-yyyy'), to_date('28-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1455, 'Mia', 'Wagner', to_date('19-04-2006', 'dd-mm-yyyy'), to_date('27-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1456, 'Treat', 'Parsons', to_date('10-10-2006', 'dd-mm-yyyy'), to_date('29-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1457, 'Susan', 'Harrelson', to_date('27-07-2006', 'dd-mm-yyyy'), to_date('12-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1458, 'Sammy', 'Goldberg', to_date('05-12-2006', 'dd-mm-yyyy'), to_date('15-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1459, 'Sonny', 'Hobson', to_date('12-12-2006', 'dd-mm-yyyy'), to_date('14-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1460, 'Clarence', 'Kirkwood', to_date('10-12-2006', 'dd-mm-yyyy'), to_date('18-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1461, 'Ahmad', 'Conlee', to_date('18-12-2006', 'dd-mm-yyyy'), to_date('14-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1462, 'Rachel', 'McGovern', to_date('18-01-2006', 'dd-mm-yyyy'), to_date('23-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1463, 'Mickey', 'Mann', to_date('05-12-2006', 'dd-mm-yyyy'), to_date('21-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1464, 'Anthony', 'Young', to_date('13-05-2006', 'dd-mm-yyyy'), to_date('13-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1465, 'Maggie', 'Driver', to_date('28-03-2006', 'dd-mm-yyyy'), to_date('23-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1466, 'Marty', 'May', to_date('12-02-2006', 'dd-mm-yyyy'), to_date('30-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1467, 'Eileen', 'Sylvian', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('23-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1468, 'Marlon', 'Rhames', to_date('24-02-2006', 'dd-mm-yyyy'), to_date('30-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1469, 'Nick', 'Connick', to_date('07-11-2006', 'dd-mm-yyyy'), to_date('10-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1470, 'Tal', 'Hornsby', to_date('04-10-2006', 'dd-mm-yyyy'), to_date('22-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1471, 'Joshua', 'Day', to_date('16-06-2006', 'dd-mm-yyyy'), to_date('13-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1472, 'Bebe', 'Wilson', to_date('06-11-2006', 'dd-mm-yyyy'), to_date('19-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1473, 'Gina', 'Rowlands', to_date('10-10-2006', 'dd-mm-yyyy'), to_date('27-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1474, 'Eric', 'Holm', to_date('20-05-2006', 'dd-mm-yyyy'), to_date('11-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1475, 'Ned', 'Ojeda', to_date('02-02-2006', 'dd-mm-yyyy'), to_date('09-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1476, 'Tamala', 'LaPaglia', to_date('25-02-2006', 'dd-mm-yyyy'), to_date('11-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1477, 'Samuel', 'Chappelle', to_date('20-02-2006', 'dd-mm-yyyy'), to_date('19-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1478, 'Sylvester', 'Wahlberg', to_date('13-11-2006', 'dd-mm-yyyy'), to_date('26-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1479, 'Christine', 'LaSalle', to_date('10-08-2006', 'dd-mm-yyyy'), to_date('17-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1480, 'Chalee', 'Pressly', to_date('22-07-2006', 'dd-mm-yyyy'), to_date('14-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1481, 'Ty', 'Lithgow', to_date('09-12-2006', 'dd-mm-yyyy'), to_date('20-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1482, 'Joey', 'Hewett', to_date('05-04-2006', 'dd-mm-yyyy'), to_date('26-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1483, 'Chuck', 'Costa', to_date('13-06-2006', 'dd-mm-yyyy'), to_date('16-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1484, 'Kenneth', 'Maguire', to_date('25-01-2006', 'dd-mm-yyyy'), to_date('05-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1485, 'Alana', 'Evans', to_date('26-09-2006', 'dd-mm-yyyy'), to_date('05-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1486, 'Julie', 'Craig', to_date('11-06-2006', 'dd-mm-yyyy'), to_date('25-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1487, 'Daniel', 'Dench', to_date('13-06-2006', 'dd-mm-yyyy'), to_date('12-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1488, 'Martin', 'Gayle', to_date('18-11-2006', 'dd-mm-yyyy'), to_date('15-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1489, 'Dar', 'Simpson', to_date('26-04-2006', 'dd-mm-yyyy'), to_date('18-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1490, 'Juice', 'McDormand', to_date('07-11-2006', 'dd-mm-yyyy'), to_date('15-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1491, 'Christmas', 'Cook', to_date('12-07-2006', 'dd-mm-yyyy'), to_date('17-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1492, 'Chely', 'Russell', to_date('31-01-2006', 'dd-mm-yyyy'), to_date('08-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1493, 'Nik', 'Matarazzo', to_date('26-05-2006', 'dd-mm-yyyy'), to_date('04-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1121, 'Donna', 'Bosco', to_date('31-01-2006', 'dd-mm-yyyy'), to_date('17-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1122, 'Pablo', 'Callow', to_date('09-10-2006', 'dd-mm-yyyy'), to_date('18-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1123, 'Larnelle', 'Kershaw', to_date('05-12-2006', 'dd-mm-yyyy'), to_date('09-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1124, 'Carla', 'Potter', to_date('06-06-2006', 'dd-mm-yyyy'), to_date('02-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1125, 'Clea', 'Butler', to_date('07-08-2006', 'dd-mm-yyyy'), to_date('30-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1126, 'Gavin', 'Glenn', to_date('10-09-2006', 'dd-mm-yyyy'), to_date('06-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1127, 'Morris', 'Cervine', to_date('08-02-2006', 'dd-mm-yyyy'), to_date('16-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1128, 'Drew', 'Cattrall', to_date('25-05-2006', 'dd-mm-yyyy'), to_date('31-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1129, 'Karon', 'Belushi', to_date('04-06-2006', 'dd-mm-yyyy'), to_date('28-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1130, 'Demi', 'Clayton', to_date('07-02-2006', 'dd-mm-yyyy'), to_date('25-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1131, 'Olga', 'Harrison', to_date('16-08-2006', 'dd-mm-yyyy'), to_date('12-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1132, 'Sonny', 'Shandling', to_date('24-02-2006', 'dd-mm-yyyy'), to_date('05-07-2009', 'dd-mm-yyyy'));
commit;
prompt 1400 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1133, 'Mac', 'Franklin', to_date('19-04-2006', 'dd-mm-yyyy'), to_date('14-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1134, 'Rufus', 'Gilliam', to_date('18-12-2006', 'dd-mm-yyyy'), to_date('07-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1135, 'Thelma', 'Ledger', to_date('11-04-2006', 'dd-mm-yyyy'), to_date('29-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1136, 'Delroy', 'Ermey', to_date('18-09-2006', 'dd-mm-yyyy'), to_date('16-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1137, 'Cherry', 'Snider', to_date('16-09-2006', 'dd-mm-yyyy'), to_date('22-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1138, 'Alfred', 'Butler', to_date('10-04-2006', 'dd-mm-yyyy'), to_date('13-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1139, 'Jeanne', 'Gibbons', to_date('03-06-2006', 'dd-mm-yyyy'), to_date('30-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1140, 'Carlos', 'Tierney', to_date('26-06-2006', 'dd-mm-yyyy'), to_date('05-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1141, 'Gilbert', 'Blige', to_date('29-07-2006', 'dd-mm-yyyy'), to_date('19-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1142, 'Gilbert', 'Allan', to_date('01-10-2006', 'dd-mm-yyyy'), to_date('19-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1143, 'Kay', 'Cohn', to_date('09-09-2006', 'dd-mm-yyyy'), to_date('23-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1144, 'Chad', 'Streep', to_date('04-12-2006', 'dd-mm-yyyy'), to_date('06-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1145, 'Allan', 'Statham', to_date('02-12-2006', 'dd-mm-yyyy'), to_date('27-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1146, 'Danni', 'Stanley', to_date('13-07-2006', 'dd-mm-yyyy'), to_date('25-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1147, 'Ming-Na', 'Niven', to_date('06-09-2006', 'dd-mm-yyyy'), to_date('23-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1148, 'Ron', 'Child', to_date('07-04-2006', 'dd-mm-yyyy'), to_date('18-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1149, 'Tori', 'Hutton', to_date('29-07-2006', 'dd-mm-yyyy'), to_date('09-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1150, 'Ashton', 'Potter', to_date('04-11-2006', 'dd-mm-yyyy'), to_date('04-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1151, 'Tamala', 'Sanchez', to_date('18-08-2006', 'dd-mm-yyyy'), to_date('13-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1152, 'Roger', 'Griggs', to_date('26-02-2006', 'dd-mm-yyyy'), to_date('16-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1153, 'Simon', 'Field', to_date('08-11-2006', 'dd-mm-yyyy'), to_date('30-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1154, 'Loretta', 'Sample', to_date('15-09-2006', 'dd-mm-yyyy'), to_date('12-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1155, 'Selma', 'Stevenson', to_date('09-02-2006', 'dd-mm-yyyy'), to_date('31-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1156, 'Carrie', 'Roth', to_date('25-05-2006', 'dd-mm-yyyy'), to_date('15-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1157, 'Sinead', 'Dalton', to_date('05-04-2006', 'dd-mm-yyyy'), to_date('24-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1158, 'Steven', 'Harmon', to_date('10-08-2006', 'dd-mm-yyyy'), to_date('06-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1159, 'Alfie', 'Gertner', to_date('14-09-2006', 'dd-mm-yyyy'), to_date('03-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1160, 'Eddie', 'Daniels', to_date('06-08-2006', 'dd-mm-yyyy'), to_date('04-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1161, 'Jack', 'Browne', to_date('23-02-2006', 'dd-mm-yyyy'), to_date('13-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1162, 'Mint', 'Secada', to_date('16-03-2006', 'dd-mm-yyyy'), to_date('23-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1163, 'Sydney', 'Shawn', to_date('20-09-2006', 'dd-mm-yyyy'), to_date('23-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1164, 'Jared', 'Aiken', to_date('14-11-2006', 'dd-mm-yyyy'), to_date('16-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1165, 'Lucinda', 'Aaron', to_date('05-06-2006', 'dd-mm-yyyy'), to_date('14-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1166, 'Jeff', 'Hector', to_date('27-12-2006', 'dd-mm-yyyy'), to_date('04-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1167, 'Debra', 'Apple', to_date('07-11-2006', 'dd-mm-yyyy'), to_date('18-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1168, 'Night', 'Tomei', to_date('12-07-2006', 'dd-mm-yyyy'), to_date('04-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1169, 'Freddie', 'Woods', to_date('02-04-2006', 'dd-mm-yyyy'), to_date('02-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1170, 'Mindy', 'Gill', to_date('03-01-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1171, 'Cary', 'Mollard', to_date('16-11-2006', 'dd-mm-yyyy'), to_date('17-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1172, 'Emilio', 'Biggs', to_date('02-10-2006', 'dd-mm-yyyy'), to_date('08-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1173, 'Juice', 'Cervine', to_date('11-09-2006', 'dd-mm-yyyy'), to_date('30-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1546, 'Christopher', 'Kurtz', to_date('08-09-2006', 'dd-mm-yyyy'), to_date('07-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1547, 'Ed', 'Parish', to_date('21-04-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1548, 'Martha', 'Channing', to_date('27-06-2006', 'dd-mm-yyyy'), to_date('10-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1549, 'Jerry', 'Gagnon', to_date('28-06-2006', 'dd-mm-yyyy'), to_date('11-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1550, 'Lindsay', 'Garfunkel', to_date('08-01-2006', 'dd-mm-yyyy'), to_date('23-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1551, 'Sydney', 'McLachlan', to_date('24-12-2006', 'dd-mm-yyyy'), to_date('02-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1552, 'Julianne', 'Fariq', to_date('16-11-2006', 'dd-mm-yyyy'), to_date('11-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1553, 'Mint', 'Dunaway', to_date('15-03-2006', 'dd-mm-yyyy'), to_date('05-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1554, 'Hookah', 'Roundtree', to_date('29-04-2006', 'dd-mm-yyyy'), to_date('25-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1555, 'Murray', 'Dzundza', to_date('21-09-2006', 'dd-mm-yyyy'), to_date('29-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1556, 'Victor', 'Randal', to_date('25-07-2006', 'dd-mm-yyyy'), to_date('13-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1557, 'Kim', 'Rauhofer', to_date('09-12-2006', 'dd-mm-yyyy'), to_date('16-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1558, 'Karen', 'Woodard', to_date('30-04-2006', 'dd-mm-yyyy'), to_date('13-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1559, 'Armand', 'Wahlberg', to_date('19-01-2006', 'dd-mm-yyyy'), to_date('11-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1560, 'Morris', 'Bachman', to_date('08-10-2006', 'dd-mm-yyyy'), to_date('07-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1561, 'Robin', 'Gleeson', to_date('14-05-2006', 'dd-mm-yyyy'), to_date('11-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1562, 'Candice', 'Sweet', to_date('03-09-2006', 'dd-mm-yyyy'), to_date('27-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1563, 'Denny', 'Rizzo', to_date('06-12-2006', 'dd-mm-yyyy'), to_date('26-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1564, 'Percy', 'Wincott', to_date('22-12-2006', 'dd-mm-yyyy'), to_date('10-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1565, 'Night', 'Lizzy', to_date('11-06-2006', 'dd-mm-yyyy'), to_date('09-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1566, 'Alfie', 'Cara', to_date('06-08-2006', 'dd-mm-yyyy'), to_date('19-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1567, 'Isabella', 'Preston', to_date('30-06-2006', 'dd-mm-yyyy'), to_date('22-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1568, 'Tamala', 'Makowicz', to_date('07-08-2006', 'dd-mm-yyyy'), to_date('07-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1569, 'Vickie', 'Linney', to_date('15-02-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1570, 'Nicole', 'Ammons', to_date('17-08-2006', 'dd-mm-yyyy'), to_date('03-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1571, 'Terri', 'Madsen', to_date('08-09-2006', 'dd-mm-yyyy'), to_date('04-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1572, 'Night', 'Swinton', to_date('10-09-2006', 'dd-mm-yyyy'), to_date('25-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1573, 'April', 'Frakes', to_date('13-01-2006', 'dd-mm-yyyy'), to_date('28-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1574, 'Mac', 'Johansen', to_date('05-04-2006', 'dd-mm-yyyy'), to_date('13-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1575, 'Jeroen', 'Pitt', to_date('26-12-2006', 'dd-mm-yyyy'), to_date('25-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1576, 'Patty', 'Cetera', to_date('16-08-2006', 'dd-mm-yyyy'), to_date('13-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1577, 'Ian', 'Maguire', to_date('02-03-2006', 'dd-mm-yyyy'), to_date('26-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1578, 'Delroy', 'Studi', to_date('26-08-2006', 'dd-mm-yyyy'), to_date('07-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1579, 'Colm', 'Dysart', to_date('28-01-2006', 'dd-mm-yyyy'), to_date('18-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1580, 'Ray', 'Lange', to_date('07-10-2006', 'dd-mm-yyyy'), to_date('14-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1581, 'Lennie', 'Lattimore', to_date('24-07-2006', 'dd-mm-yyyy'), to_date('05-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1582, 'Ivan', 'Cronin', to_date('25-04-2006', 'dd-mm-yyyy'), to_date('30-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1583, 'Bo', 'Travers', to_date('13-07-2006', 'dd-mm-yyyy'), to_date('10-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1584, 'Walter', 'Blanchett', to_date('10-03-2006', 'dd-mm-yyyy'), to_date('24-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1585, 'Greg', 'Whitley', to_date('05-01-2006', 'dd-mm-yyyy'), to_date('28-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1586, 'Jimmy', 'Porter', to_date('16-10-2006', 'dd-mm-yyyy'), to_date('13-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1587, 'Vanessa', 'Shand', to_date('07-07-2006', 'dd-mm-yyyy'), to_date('18-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1588, 'Bo', 'Stampley', to_date('30-04-2006', 'dd-mm-yyyy'), to_date('09-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1589, 'Cliff', 'Dillon', to_date('19-09-2006', 'dd-mm-yyyy'), to_date('21-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1590, 'Gary', 'Brosnan', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('23-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1591, 'Nora', 'Myles', to_date('15-06-2006', 'dd-mm-yyyy'), to_date('13-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1592, 'Lynn', 'Orbit', to_date('14-09-2006', 'dd-mm-yyyy'), to_date('24-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1593, 'Andre', 'Belushi', to_date('05-01-2006', 'dd-mm-yyyy'), to_date('04-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1594, 'Selma', 'England', to_date('04-09-2006', 'dd-mm-yyyy'), to_date('23-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1595, 'Lindsay', 'Haslam', to_date('28-09-2006', 'dd-mm-yyyy'), to_date('08-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1596, 'Wade', 'Barkin', to_date('31-07-2006', 'dd-mm-yyyy'), to_date('13-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1597, 'Roy', 'Kirshner', to_date('05-01-2006', 'dd-mm-yyyy'), to_date('28-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1598, 'Thin', 'Holmes', to_date('16-07-2006', 'dd-mm-yyyy'), to_date('05-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1599, 'Clint', 'Huston', to_date('01-06-2006', 'dd-mm-yyyy'), to_date('07-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1600, 'Rickie', 'Diddley', to_date('01-09-2006', 'dd-mm-yyyy'), to_date('22-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1601, 'Larenz', 'Swinton', to_date('05-05-2006', 'dd-mm-yyyy'), to_date('26-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1602, 'Martha', 'Shocked', to_date('04-07-2006', 'dd-mm-yyyy'), to_date('26-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1603, 'Scott', 'Herndon', to_date('02-11-2006', 'dd-mm-yyyy'), to_date('12-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1604, 'Wes', 'Carrack', to_date('22-10-2006', 'dd-mm-yyyy'), to_date('07-09-2009', 'dd-mm-yyyy'));
commit;
prompt 1500 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1605, 'Harrison', 'Tarantino', to_date('15-10-2006', 'dd-mm-yyyy'), to_date('17-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1606, 'Joy', 'Van Der Beek', to_date('12-08-2006', 'dd-mm-yyyy'), to_date('03-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1607, 'Praga', 'Cantrell', to_date('26-05-2006', 'dd-mm-yyyy'), to_date('07-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1608, 'Vienna', 'Chambers', to_date('27-08-2006', 'dd-mm-yyyy'), to_date('13-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1609, 'Wayman', 'Emmerich', to_date('04-01-2006', 'dd-mm-yyyy'), to_date('18-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1610, 'Marty', 'Child', to_date('23-01-2006', 'dd-mm-yyyy'), to_date('29-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1611, 'Ben', 'Matheson', to_date('13-03-2006', 'dd-mm-yyyy'), to_date('15-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1612, 'Shannon', 'Dalton', to_date('17-05-2006', 'dd-mm-yyyy'), to_date('04-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1613, 'Matt', 'Wainwright', to_date('19-03-2006', 'dd-mm-yyyy'), to_date('17-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1614, 'Warren', 'Tucci', to_date('23-11-2006', 'dd-mm-yyyy'), to_date('10-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1615, 'Crispin', 'Santana', to_date('20-09-2006', 'dd-mm-yyyy'), to_date('26-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1616, 'Nathan', 'Posener', to_date('27-04-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1617, 'Howie', 'Shaye', to_date('05-11-2006', 'dd-mm-yyyy'), to_date('04-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1618, 'Jill', 'Lucien', to_date('12-09-2006', 'dd-mm-yyyy'), to_date('06-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1619, 'Tony', 'Stigers', to_date('19-07-2006', 'dd-mm-yyyy'), to_date('23-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1620, 'Lee', 'Hidalgo', to_date('20-09-2006', 'dd-mm-yyyy'), to_date('29-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1621, 'Grant', 'Spiner', to_date('14-04-2006', 'dd-mm-yyyy'), to_date('31-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1622, 'Bryan', 'Coughlan', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('03-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1623, 'Natacha', 'Schock', to_date('08-01-2006', 'dd-mm-yyyy'), to_date('30-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1624, 'Rhett', 'Gilliam', to_date('21-05-2006', 'dd-mm-yyyy'), to_date('13-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1625, 'Rhea', 'Sylvian', to_date('07-07-2006', 'dd-mm-yyyy'), to_date('15-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1626, 'Hex', 'Schiavelli', to_date('11-05-2006', 'dd-mm-yyyy'), to_date('09-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1627, 'Mary', 'Lloyd', to_date('10-12-2006', 'dd-mm-yyyy'), to_date('28-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1628, 'Danny', 'Snider', to_date('14-05-2006', 'dd-mm-yyyy'), to_date('11-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1629, 'Fiona', 'Morrison', to_date('29-10-2006', 'dd-mm-yyyy'), to_date('05-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1630, 'Drew', 'Berenger', to_date('01-04-2006', 'dd-mm-yyyy'), to_date('21-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1631, 'Stephen', 'Romijn-Stamos', to_date('08-04-2006', 'dd-mm-yyyy'), to_date('15-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1632, 'Domingo', 'Himmelman', to_date('31-08-2006', 'dd-mm-yyyy'), to_date('28-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1633, 'Brenda', 'McCoy', to_date('03-07-2006', 'dd-mm-yyyy'), to_date('19-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1634, 'Janice', 'England', to_date('21-07-2006', 'dd-mm-yyyy'), to_date('16-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1635, 'Rachel', 'Beckinsale', to_date('09-10-2006', 'dd-mm-yyyy'), to_date('21-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1636, 'Clint', 'Orlando', to_date('27-11-2006', 'dd-mm-yyyy'), to_date('24-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1637, 'Cameron', 'Aglukark', to_date('01-07-2006', 'dd-mm-yyyy'), to_date('15-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1638, 'Kelli', 'Hanks', to_date('07-11-2006', 'dd-mm-yyyy'), to_date('17-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1639, 'Stevie', 'McCain', to_date('06-10-2006', 'dd-mm-yyyy'), to_date('23-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1640, 'Embeth', 'Foley', to_date('16-01-2006', 'dd-mm-yyyy'), to_date('23-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1641, 'Denise', 'Scaggs', to_date('18-02-2006', 'dd-mm-yyyy'), to_date('01-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1642, 'Drew', 'Sayer', to_date('19-05-2006', 'dd-mm-yyyy'), to_date('03-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1643, 'Jarvis', 'Curtis', to_date('30-09-2006', 'dd-mm-yyyy'), to_date('07-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1644, 'Amanda', 'Bachman', to_date('08-01-2006', 'dd-mm-yyyy'), to_date('01-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1645, 'Jena', 'Lennox', to_date('10-10-2006', 'dd-mm-yyyy'), to_date('21-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1646, 'Moe', 'Knight', to_date('21-09-2006', 'dd-mm-yyyy'), to_date('12-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1647, 'Dorry', 'Hampton', to_date('18-02-2006', 'dd-mm-yyyy'), to_date('21-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1648, 'Ethan', 'Kelly', to_date('26-06-2006', 'dd-mm-yyyy'), to_date('08-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1649, 'Anne', 'Crystal', to_date('18-07-2006', 'dd-mm-yyyy'), to_date('01-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1650, 'Emerson', 'Rankin', to_date('03-07-2006', 'dd-mm-yyyy'), to_date('24-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1651, 'Charlton', 'Avalon', to_date('27-11-2006', 'dd-mm-yyyy'), to_date('16-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1652, 'Keith', 'Camp', to_date('16-06-2006', 'dd-mm-yyyy'), to_date('29-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1653, 'Sarah', 'Ingram', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('20-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1654, 'Dianne', 'DiFranco', to_date('26-01-2006', 'dd-mm-yyyy'), to_date('05-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1655, 'Whoopi', 'Mazzello', to_date('01-05-2006', 'dd-mm-yyyy'), to_date('08-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1656, 'Suzanne', 'Fox', to_date('11-01-2006', 'dd-mm-yyyy'), to_date('17-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1657, 'Giovanni', 'Crudup', to_date('18-09-2006', 'dd-mm-yyyy'), to_date('18-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1658, 'Lydia', 'Weber', to_date('07-03-2006', 'dd-mm-yyyy'), to_date('29-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1659, 'Terence', 'Sedaka', to_date('14-08-2006', 'dd-mm-yyyy'), to_date('01-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1660, 'Luis', 'Camp', to_date('18-01-2006', 'dd-mm-yyyy'), to_date('27-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1661, 'Susan', 'Singletary', to_date('24-03-2006', 'dd-mm-yyyy'), to_date('07-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1662, 'Jaime', 'Bates', to_date('07-09-2006', 'dd-mm-yyyy'), to_date('20-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1663, 'Lee', 'Stevens', to_date('21-08-2006', 'dd-mm-yyyy'), to_date('23-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1664, 'Tamala', 'Fierstein', to_date('19-10-2006', 'dd-mm-yyyy'), to_date('10-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1665, 'Tamala', 'Witt', to_date('12-06-2006', 'dd-mm-yyyy'), to_date('05-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1666, 'Al', 'Soul', to_date('26-03-2006', 'dd-mm-yyyy'), to_date('26-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1667, 'Christian', 'Carlton', to_date('31-07-2006', 'dd-mm-yyyy'), to_date('06-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1668, 'Jennifer', 'DiCaprio', to_date('14-09-2006', 'dd-mm-yyyy'), to_date('28-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1669, 'Annette', 'Lindley', to_date('01-07-2006', 'dd-mm-yyyy'), to_date('26-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1670, 'Bret', 'Sainte-Marie', to_date('06-12-2006', 'dd-mm-yyyy'), to_date('17-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1671, 'Shannon', 'Cozier', to_date('31-08-2006', 'dd-mm-yyyy'), to_date('15-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1672, 'George', 'Tankard', to_date('29-12-2006', 'dd-mm-yyyy'), to_date('29-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1673, 'Jann', 'LaSalle', to_date('15-05-2006', 'dd-mm-yyyy'), to_date('07-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1674, 'Ali', 'Gambon', to_date('25-01-2006', 'dd-mm-yyyy'), to_date('11-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1675, 'Remy', 'Sandoval', to_date('26-10-2006', 'dd-mm-yyyy'), to_date('31-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1676, 'Janeane', 'Phillippe', to_date('01-06-2006', 'dd-mm-yyyy'), to_date('25-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1677, 'Powers', 'Boothe', to_date('03-08-2006', 'dd-mm-yyyy'), to_date('22-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1678, 'Tal', 'Swinton', to_date('03-10-2006', 'dd-mm-yyyy'), to_date('25-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1679, 'Emily', 'Rickles', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('04-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1308, 'Gilbert', 'Rubinek', to_date('27-05-2006', 'dd-mm-yyyy'), to_date('13-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1309, 'Jonny Lee', 'Trejo', to_date('07-06-2006', 'dd-mm-yyyy'), to_date('07-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1310, 'Jeffery', 'Frakes', to_date('01-05-2006', 'dd-mm-yyyy'), to_date('26-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1311, 'Carolyn', 'Roth', to_date('28-04-2006', 'dd-mm-yyyy'), to_date('16-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1312, 'Treat', 'Hatchet', to_date('19-02-2006', 'dd-mm-yyyy'), to_date('25-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1313, 'Milla', 'Northam', to_date('21-01-2006', 'dd-mm-yyyy'), to_date('06-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1314, 'Jeroen', 'Brody', to_date('22-04-2006', 'dd-mm-yyyy'), to_date('08-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1315, 'Kylie', 'Nicks', to_date('13-06-2006', 'dd-mm-yyyy'), to_date('29-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1316, 'Patrick', 'Kane', to_date('08-12-2006', 'dd-mm-yyyy'), to_date('29-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1317, 'Miki', 'Andrews', to_date('21-01-2006', 'dd-mm-yyyy'), to_date('28-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1318, 'Eugene', 'Mitra', to_date('28-10-2006', 'dd-mm-yyyy'), to_date('02-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1319, 'Kevn', 'Napolitano', to_date('01-09-2006', 'dd-mm-yyyy'), to_date('26-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1320, 'Julianna', 'Caan', to_date('11-11-2006', 'dd-mm-yyyy'), to_date('07-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1321, 'Bebe', 'McFerrin', to_date('10-02-2006', 'dd-mm-yyyy'), to_date('07-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1322, 'Nickel', 'Donovan', to_date('27-09-2006', 'dd-mm-yyyy'), to_date('03-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1323, 'Jonatha', 'Rodriguez', to_date('09-05-2006', 'dd-mm-yyyy'), to_date('16-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1324, 'Christmas', 'Kenoly', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('12-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1325, 'Marlon', 'McCain', to_date('13-12-2006', 'dd-mm-yyyy'), to_date('07-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1326, 'Mos', 'Sisto', to_date('29-03-2006', 'dd-mm-yyyy'), to_date('03-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1327, 'Kathy', 'Oldman', to_date('08-10-2006', 'dd-mm-yyyy'), to_date('29-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1328, 'Busta', 'Matthau', to_date('08-01-2006', 'dd-mm-yyyy'), to_date('14-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1329, 'Gordie', 'Purefoy', to_date('19-01-2006', 'dd-mm-yyyy'), to_date('02-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1330, 'Norm', 'Mulroney', to_date('23-07-2006', 'dd-mm-yyyy'), to_date('04-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1331, 'Meg', 'Hudson', to_date('06-10-2006', 'dd-mm-yyyy'), to_date('02-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1332, 'Ed', 'Greene', to_date('20-02-2006', 'dd-mm-yyyy'), to_date('20-12-2009', 'dd-mm-yyyy'));
commit;
prompt 1600 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1333, 'Roger', 'Eat World', to_date('21-04-2006', 'dd-mm-yyyy'), to_date('25-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1334, 'Wade', 'Day-Lewis', to_date('27-08-2006', 'dd-mm-yyyy'), to_date('17-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1335, 'Vonda', 'Neville', to_date('17-06-2006', 'dd-mm-yyyy'), to_date('04-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1336, 'Faye', 'Matarazzo', to_date('11-07-2006', 'dd-mm-yyyy'), to_date('01-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1337, 'Dave', 'Stampley', to_date('22-09-2006', 'dd-mm-yyyy'), to_date('02-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1338, 'John', 'Kudrow', to_date('21-11-2006', 'dd-mm-yyyy'), to_date('14-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1339, 'Suzanne', 'Esposito', to_date('04-12-2006', 'dd-mm-yyyy'), to_date('22-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1340, 'Sharon', 'Phillippe', to_date('20-02-2006', 'dd-mm-yyyy'), to_date('26-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1341, 'Meryl', 'Levert', to_date('16-02-2006', 'dd-mm-yyyy'), to_date('24-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1342, 'Don', 'Lizzy', to_date('26-09-2006', 'dd-mm-yyyy'), to_date('24-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1343, 'Dorry', 'Nelligan', to_date('21-11-2006', 'dd-mm-yyyy'), to_date('10-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1344, 'Parker', 'Vanian', to_date('17-05-2006', 'dd-mm-yyyy'), to_date('04-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1345, 'Elle', 'MacDowell', to_date('24-10-2006', 'dd-mm-yyyy'), to_date('09-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1346, 'Mark', 'McFadden', to_date('09-06-2006', 'dd-mm-yyyy'), to_date('22-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1347, 'Lennie', 'Ermey', to_date('29-05-2006', 'dd-mm-yyyy'), to_date('08-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1348, 'Albert', 'Blackmore', to_date('05-10-2006', 'dd-mm-yyyy'), to_date('15-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1349, 'Julianne', 'Laws', to_date('07-04-2006', 'dd-mm-yyyy'), to_date('10-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1350, 'Emma', 'Astin', to_date('21-09-2006', 'dd-mm-yyyy'), to_date('24-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1351, 'Chad', 'Wills', to_date('21-07-2006', 'dd-mm-yyyy'), to_date('04-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1352, 'Freda', 'Kutcher', to_date('23-08-2006', 'dd-mm-yyyy'), to_date('24-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1353, 'Cate', 'Butler', to_date('27-10-2006', 'dd-mm-yyyy'), to_date('20-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1354, 'LeVar', 'Danger', to_date('24-06-2006', 'dd-mm-yyyy'), to_date('06-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1355, 'Hex', 'Moss', to_date('10-02-2006', 'dd-mm-yyyy'), to_date('05-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1356, 'Val', 'Biggs', to_date('13-11-2006', 'dd-mm-yyyy'), to_date('26-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1357, 'Miguel', 'Cruise', to_date('20-05-2006', 'dd-mm-yyyy'), to_date('31-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1358, 'Liam', 'Leary', to_date('10-06-2006', 'dd-mm-yyyy'), to_date('06-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1359, 'Sonny', 'Depp', to_date('06-04-2006', 'dd-mm-yyyy'), to_date('03-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1732, 'Powers', 'Keen', to_date('26-03-2006', 'dd-mm-yyyy'), to_date('05-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1733, 'Lindsey', 'Diehl', to_date('19-09-2006', 'dd-mm-yyyy'), to_date('09-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1734, 'Kim', 'Koyana', to_date('18-06-2006', 'dd-mm-yyyy'), to_date('17-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1735, 'Jamie', 'Gill', to_date('07-06-2006', 'dd-mm-yyyy'), to_date('10-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1736, 'Elias', 'Dolenz', to_date('12-06-2006', 'dd-mm-yyyy'), to_date('23-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1737, 'Pam', 'Stiller', to_date('12-07-2006', 'dd-mm-yyyy'), to_date('21-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1738, 'Laura', 'Watley', to_date('22-05-2006', 'dd-mm-yyyy'), to_date('16-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1739, 'Loretta', 'Favreau', to_date('08-11-2006', 'dd-mm-yyyy'), to_date('06-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1740, 'Julianne', 'Lynne', to_date('18-04-2006', 'dd-mm-yyyy'), to_date('22-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1741, 'Albert', 'Page', to_date('24-04-2006', 'dd-mm-yyyy'), to_date('07-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1742, 'Kimberly', 'Connick', to_date('17-04-2006', 'dd-mm-yyyy'), to_date('17-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1743, 'Gladys', 'Hurley', to_date('29-07-2006', 'dd-mm-yyyy'), to_date('07-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1744, 'Samantha', 'Ribisi', to_date('15-04-2006', 'dd-mm-yyyy'), to_date('19-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1745, 'Hugo', 'Carlton', to_date('03-03-2006', 'dd-mm-yyyy'), to_date('12-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1746, 'Radney', 'Leto', to_date('29-11-2006', 'dd-mm-yyyy'), to_date('29-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1747, 'Jaime', 'Grant', to_date('26-10-2006', 'dd-mm-yyyy'), to_date('07-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1748, 'Rosie', 'O''Sullivan', to_date('24-10-2006', 'dd-mm-yyyy'), to_date('28-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1749, 'Sona', 'Paul', to_date('19-02-2006', 'dd-mm-yyyy'), to_date('28-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1750, 'Philip', 'Chung', to_date('21-03-2006', 'dd-mm-yyyy'), to_date('19-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1751, 'Bonnie', 'Mueller-Stahl', to_date('05-08-2006', 'dd-mm-yyyy'), to_date('14-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1752, 'Cuba', 'Hannah', to_date('01-11-2006', 'dd-mm-yyyy'), to_date('06-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1753, 'Malcolm', 'Randal', to_date('07-11-2006', 'dd-mm-yyyy'), to_date('14-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1754, 'Gaby', 'Boone', to_date('28-01-2006', 'dd-mm-yyyy'), to_date('03-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1755, 'Jill', 'Peniston', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('16-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1756, 'Christine', 'De Almeida', to_date('24-07-2006', 'dd-mm-yyyy'), to_date('12-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1757, 'Cathy', 'Li', to_date('07-04-2006', 'dd-mm-yyyy'), to_date('02-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1758, 'Sandra', 'Withers', to_date('18-12-2006', 'dd-mm-yyyy'), to_date('26-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1759, 'Larenz', 'Sepulveda', to_date('15-09-2006', 'dd-mm-yyyy'), to_date('25-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1760, 'Liv', 'Redford', to_date('24-02-2006', 'dd-mm-yyyy'), to_date('22-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1761, 'Lennie', 'Bloch', to_date('25-04-2006', 'dd-mm-yyyy'), to_date('27-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1762, 'Jimmie', 'Day', to_date('21-08-2006', 'dd-mm-yyyy'), to_date('12-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1763, 'Leslie', 'Barnett', to_date('03-02-2006', 'dd-mm-yyyy'), to_date('22-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1764, 'Bryan', 'McKellen', to_date('20-05-2006', 'dd-mm-yyyy'), to_date('14-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1765, 'Noah', 'Connick', to_date('09-08-2006', 'dd-mm-yyyy'), to_date('22-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1766, 'Chet', 'Reeve', to_date('01-11-2006', 'dd-mm-yyyy'), to_date('26-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1767, 'Armand', 'Campbell', to_date('19-06-2006', 'dd-mm-yyyy'), to_date('21-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1768, 'Jeremy', 'Leigh', to_date('13-05-2006', 'dd-mm-yyyy'), to_date('23-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1769, 'Howard', 'Emmett', to_date('14-02-2006', 'dd-mm-yyyy'), to_date('05-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1770, 'Bridgette', 'Balk', to_date('11-12-2006', 'dd-mm-yyyy'), to_date('28-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1771, 'Billy', 'Hyde', to_date('29-12-2006', 'dd-mm-yyyy'), to_date('28-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1772, 'Joey', 'Crystal', to_date('15-03-2006', 'dd-mm-yyyy'), to_date('02-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1773, 'Junior', 'Idle', to_date('20-11-2006', 'dd-mm-yyyy'), to_date('03-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1774, 'Oded', 'Beck', to_date('18-09-2006', 'dd-mm-yyyy'), to_date('04-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1775, 'Jean-Claude', 'Walker', to_date('28-09-2006', 'dd-mm-yyyy'), to_date('05-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1776, 'Jesus', 'Gibbons', to_date('10-09-2006', 'dd-mm-yyyy'), to_date('18-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1777, 'Denzel', 'Douglas', to_date('03-09-2006', 'dd-mm-yyyy'), to_date('16-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1778, 'Terry', 'Chambers', to_date('02-12-2006', 'dd-mm-yyyy'), to_date('12-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1779, 'Ricardo', 'Chan', to_date('10-05-2006', 'dd-mm-yyyy'), to_date('03-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1780, 'Diamond', 'Keeslar', to_date('09-01-2006', 'dd-mm-yyyy'), to_date('01-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1781, 'Freddie', 'Shaye', to_date('03-09-2006', 'dd-mm-yyyy'), to_date('08-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1782, 'Emmylou', 'Almond', to_date('24-01-2006', 'dd-mm-yyyy'), to_date('24-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1783, 'Tori', 'Webb', to_date('29-09-2006', 'dd-mm-yyyy'), to_date('27-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1784, 'Joaquim', 'Vai', to_date('07-06-2006', 'dd-mm-yyyy'), to_date('12-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1785, 'Cary', 'Osbourne', to_date('13-03-2006', 'dd-mm-yyyy'), to_date('29-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1786, 'Dorry', 'Nightingale', to_date('22-01-2006', 'dd-mm-yyyy'), to_date('09-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1787, 'Tia', 'Popper', to_date('15-10-2006', 'dd-mm-yyyy'), to_date('28-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1788, 'Mickey', 'Shaw', to_date('04-12-2006', 'dd-mm-yyyy'), to_date('21-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1789, 'Tzi', 'Numan', to_date('08-05-2006', 'dd-mm-yyyy'), to_date('04-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1790, 'Frances', 'Duke', to_date('01-12-2006', 'dd-mm-yyyy'), to_date('21-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1791, 'Elvis', 'Bosco', to_date('02-01-2006', 'dd-mm-yyyy'), to_date('13-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1792, 'Kyle', 'Weber', to_date('12-12-2006', 'dd-mm-yyyy'), to_date('23-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1793, 'Brenda', 'Weisberg', to_date('25-09-2006', 'dd-mm-yyyy'), to_date('01-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1794, 'Chet', 'Cumming', to_date('09-06-2006', 'dd-mm-yyyy'), to_date('27-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1795, 'Claire', 'Willis', to_date('31-03-2006', 'dd-mm-yyyy'), to_date('20-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1796, 'Carla', 'Rapaport', to_date('28-01-2006', 'dd-mm-yyyy'), to_date('02-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1797, 'Chad', 'Woods', to_date('17-02-2006', 'dd-mm-yyyy'), to_date('03-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1798, 'Tori', 'Walken', to_date('22-11-2006', 'dd-mm-yyyy'), to_date('08-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1799, 'Marlon', 'Lindo', to_date('19-05-2006', 'dd-mm-yyyy'), to_date('31-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1800, 'Tyrone', 'Chilton', to_date('10-09-2006', 'dd-mm-yyyy'), to_date('06-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1801, 'Brenda', 'Gallant', to_date('05-03-2006', 'dd-mm-yyyy'), to_date('02-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1802, 'Hex', 'Whitley', to_date('19-09-2006', 'dd-mm-yyyy'), to_date('27-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1803, 'Mint', 'Zahn', to_date('29-12-2006', 'dd-mm-yyyy'), to_date('09-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1804, 'Dustin', 'Paquin', to_date('13-09-2006', 'dd-mm-yyyy'), to_date('29-11-2009', 'dd-mm-yyyy'));
commit;
prompt 1700 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1805, 'Loren', 'Oldman', to_date('23-01-2006', 'dd-mm-yyyy'), to_date('11-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1806, 'Angela', 'Quinn', to_date('11-03-2006', 'dd-mm-yyyy'), to_date('22-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1807, 'Lloyd', 'Rauhofer', to_date('24-01-2006', 'dd-mm-yyyy'), to_date('08-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1808, 'Claire', 'Diehl', to_date('11-03-2006', 'dd-mm-yyyy'), to_date('26-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1809, 'Anthony', 'Ramis', to_date('23-03-2006', 'dd-mm-yyyy'), to_date('04-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1810, 'Humberto', 'Melvin', to_date('16-02-2006', 'dd-mm-yyyy'), to_date('26-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1811, 'Alec', 'Candy', to_date('24-08-2006', 'dd-mm-yyyy'), to_date('14-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1812, 'Stevie', 'Cassidy', to_date('15-02-2006', 'dd-mm-yyyy'), to_date('26-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1813, 'Thomas', 'Eldard', to_date('07-01-2006', 'dd-mm-yyyy'), to_date('24-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1814, 'Christina', 'Sarandon', to_date('29-07-2006', 'dd-mm-yyyy'), to_date('29-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1815, 'Denise', 'Katt', to_date('28-07-2006', 'dd-mm-yyyy'), to_date('23-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1816, 'Solomon', 'Wilkinson', to_date('17-01-2006', 'dd-mm-yyyy'), to_date('12-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1817, 'Rose', 'Underwood', to_date('01-06-2006', 'dd-mm-yyyy'), to_date('25-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1818, 'Grant', 'Flack', to_date('26-06-2006', 'dd-mm-yyyy'), to_date('01-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1819, 'Drew', 'Whitwam', to_date('16-02-2006', 'dd-mm-yyyy'), to_date('18-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1820, 'Anita', 'Miles', to_date('27-09-2006', 'dd-mm-yyyy'), to_date('26-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1821, 'Philip', 'Cox', to_date('10-09-2006', 'dd-mm-yyyy'), to_date('25-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1822, 'Lonnie', 'Skaggs', to_date('27-05-2006', 'dd-mm-yyyy'), to_date('12-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1823, 'Brad', 'Pastore', to_date('30-09-2006', 'dd-mm-yyyy'), to_date('25-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1824, 'Tori', 'Buckingham', to_date('10-12-2006', 'dd-mm-yyyy'), to_date('10-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1825, 'Dorry', 'Harrelson', to_date('12-02-2006', 'dd-mm-yyyy'), to_date('18-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1826, 'Celia', 'Rodriguez', to_date('04-03-2006', 'dd-mm-yyyy'), to_date('09-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1827, 'Stockard', 'Hoffman', to_date('12-09-2006', 'dd-mm-yyyy'), to_date('21-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1828, 'Tracy', 'Morrison', to_date('07-01-2006', 'dd-mm-yyyy'), to_date('21-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1829, 'Mary Beth', 'Lucien', to_date('16-08-2006', 'dd-mm-yyyy'), to_date('23-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1830, 'Eddie', 'Black', to_date('07-08-2006', 'dd-mm-yyyy'), to_date('14-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1831, 'Chanté', 'O''Neill', to_date('06-10-2006', 'dd-mm-yyyy'), to_date('08-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1832, 'Jennifer', 'Holland', to_date('22-08-2006', 'dd-mm-yyyy'), to_date('27-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1833, 'Bruce', 'Hannah', to_date('09-07-2006', 'dd-mm-yyyy'), to_date('15-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1834, 'Famke', 'De Niro', to_date('01-03-2006', 'dd-mm-yyyy'), to_date('07-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1835, 'Solomon', 'McGinley', to_date('10-12-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1836, 'Alice', 'Pollak', to_date('04-07-2006', 'dd-mm-yyyy'), to_date('01-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1837, 'Anthony', 'Davison', to_date('01-03-2006', 'dd-mm-yyyy'), to_date('15-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1838, 'Simon', 'Cusack', to_date('04-09-2006', 'dd-mm-yyyy'), to_date('31-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1839, 'Ronnie', 'Van Helden', to_date('16-02-2006', 'dd-mm-yyyy'), to_date('20-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1840, 'Millie', 'Peterson', to_date('25-12-2006', 'dd-mm-yyyy'), to_date('27-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1841, 'Candice', 'Wagner', to_date('25-08-2006', 'dd-mm-yyyy'), to_date('08-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1842, 'Bruce', 'Heche', to_date('01-01-2006', 'dd-mm-yyyy'), to_date('05-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1843, 'Maria', 'Tyler', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('12-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1844, 'Terry', 'Howard', to_date('01-11-2006', 'dd-mm-yyyy'), to_date('30-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1845, 'Joseph', 'Theron', to_date('01-07-2006', 'dd-mm-yyyy'), to_date('16-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1846, 'Renee', 'Leachman', to_date('18-09-2006', 'dd-mm-yyyy'), to_date('19-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1847, 'Winona', 'Dysart', to_date('29-08-2006', 'dd-mm-yyyy'), to_date('08-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1848, 'Brian', 'Rickles', to_date('19-11-2006', 'dd-mm-yyyy'), to_date('27-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1849, 'Vivica', 'Steenburgen', to_date('07-05-2006', 'dd-mm-yyyy'), to_date('11-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1850, 'Lauren', 'Lucien', to_date('23-10-2006', 'dd-mm-yyyy'), to_date('30-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1851, 'Vin', 'Biehn', to_date('16-06-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1852, 'Jonathan', 'Gandolfini', to_date('17-09-2006', 'dd-mm-yyyy'), to_date('15-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1853, 'Gabrielle', 'Worrell', to_date('21-08-2006', 'dd-mm-yyyy'), to_date('09-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1854, 'Bette', 'Pony', to_date('19-05-2006', 'dd-mm-yyyy'), to_date('19-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1855, 'Aimee', 'Rapaport', to_date('10-07-2006', 'dd-mm-yyyy'), to_date('03-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1856, 'Jeff', 'Hunter', to_date('05-05-2006', 'dd-mm-yyyy'), to_date('04-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1857, 'First', 'Plowright', to_date('18-04-2006', 'dd-mm-yyyy'), to_date('28-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1858, 'Ewan', 'Holliday', to_date('19-04-2006', 'dd-mm-yyyy'), to_date('11-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1859, 'Dionne', 'Willard', to_date('16-07-2006', 'dd-mm-yyyy'), to_date('24-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1860, 'Norm', 'Adkins', to_date('02-12-2006', 'dd-mm-yyyy'), to_date('01-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1861, 'Treat', 'Pfeiffer', to_date('05-06-2006', 'dd-mm-yyyy'), to_date('20-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1862, 'Kristin', 'Buscemi', to_date('30-11-2006', 'dd-mm-yyyy'), to_date('02-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1863, 'Mia', 'Olyphant', to_date('16-03-2006', 'dd-mm-yyyy'), to_date('22-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1864, 'LeVar', 'LuPone', to_date('04-06-2006', 'dd-mm-yyyy'), to_date('15-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1865, 'Nick', 'Saxon', to_date('30-12-2006', 'dd-mm-yyyy'), to_date('21-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1866, 'Owen', 'Flemyng', to_date('27-09-2006', 'dd-mm-yyyy'), to_date('20-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1494, 'Cameron', 'Puckett', to_date('19-02-2006', 'dd-mm-yyyy'), to_date('31-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1495, 'Larry', 'Lillard', to_date('17-05-2006', 'dd-mm-yyyy'), to_date('05-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1496, 'Armin', 'Viterelli', to_date('24-04-2006', 'dd-mm-yyyy'), to_date('03-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1497, 'Sigourney', 'Sedgwick', to_date('26-04-2006', 'dd-mm-yyyy'), to_date('25-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1498, 'Hugh', 'Lithgow', to_date('07-11-2006', 'dd-mm-yyyy'), to_date('04-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1499, 'Madeline', 'Myles', to_date('18-02-2006', 'dd-mm-yyyy'), to_date('10-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1500, 'Norm', 'Bloch', to_date('21-06-2006', 'dd-mm-yyyy'), to_date('09-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1501, 'Jake', 'Red', to_date('13-09-2006', 'dd-mm-yyyy'), to_date('21-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1502, 'Taryn', 'Molina', to_date('03-03-2006', 'dd-mm-yyyy'), to_date('15-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1503, 'Lois', 'Ramirez', to_date('06-02-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1504, 'Colleen', 'Orton', to_date('27-05-2006', 'dd-mm-yyyy'), to_date('09-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1505, 'Meg', 'Gere', to_date('06-03-2006', 'dd-mm-yyyy'), to_date('08-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1506, 'Tori', 'Feuerstein', to_date('11-07-2006', 'dd-mm-yyyy'), to_date('31-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1507, 'Shannon', 'Sartain', to_date('26-05-2006', 'dd-mm-yyyy'), to_date('07-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1508, 'Freddy', 'Forrest', to_date('29-07-2006', 'dd-mm-yyyy'), to_date('16-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1509, 'Lesley', 'Foley', to_date('17-01-2006', 'dd-mm-yyyy'), to_date('16-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1510, 'Night', 'Jeter', to_date('06-05-2006', 'dd-mm-yyyy'), to_date('29-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1511, 'Chuck', 'Leigh', to_date('04-09-2006', 'dd-mm-yyyy'), to_date('19-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1512, 'Warren', 'Owen', to_date('14-10-2006', 'dd-mm-yyyy'), to_date('17-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1513, 'Chi', 'Barnett', to_date('18-12-2006', 'dd-mm-yyyy'), to_date('14-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1514, 'Latin', 'Langella', to_date('16-09-2006', 'dd-mm-yyyy'), to_date('09-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1515, 'Rachid', 'Craddock', to_date('15-10-2006', 'dd-mm-yyyy'), to_date('23-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1516, 'Donal', 'Hingle', to_date('28-10-2006', 'dd-mm-yyyy'), to_date('05-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1517, 'Kid', 'Lunch', to_date('29-08-2006', 'dd-mm-yyyy'), to_date('04-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1518, 'Barbara', 'Gallant', to_date('19-01-2006', 'dd-mm-yyyy'), to_date('27-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1519, 'Maria', 'Redgrave', to_date('25-06-2006', 'dd-mm-yyyy'), to_date('23-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1520, 'Louise', 'Capshaw', to_date('07-03-2006', 'dd-mm-yyyy'), to_date('14-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1521, 'Anjelica', 'Gere', to_date('01-08-2006', 'dd-mm-yyyy'), to_date('23-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1522, 'Harold', 'Dern', to_date('30-10-2006', 'dd-mm-yyyy'), to_date('24-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1523, 'Luis', 'McGovern', to_date('03-02-2006', 'dd-mm-yyyy'), to_date('19-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1524, 'Andrew', 'Fehr', to_date('20-09-2006', 'dd-mm-yyyy'), to_date('20-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1525, 'Marty', 'Khan', to_date('11-08-2006', 'dd-mm-yyyy'), to_date('12-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1526, 'Demi', 'Stanley', to_date('30-03-2006', 'dd-mm-yyyy'), to_date('11-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1527, 'Minnie', 'Michael', to_date('21-03-2006', 'dd-mm-yyyy'), to_date('21-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1528, 'Heather', 'Cube', to_date('18-05-2006', 'dd-mm-yyyy'), to_date('26-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1529, 'Sammy', 'Hauer', to_date('30-09-2006', 'dd-mm-yyyy'), to_date('29-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1530, 'Edgar', 'Carrey', to_date('19-11-2006', 'dd-mm-yyyy'), to_date('27-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1531, 'Bob', 'Belle', to_date('04-06-2006', 'dd-mm-yyyy'), to_date('18-01-2009', 'dd-mm-yyyy'));
commit;
prompt 1800 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1532, 'Heath', 'Tierney', to_date('03-11-2006', 'dd-mm-yyyy'), to_date('16-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1533, 'Chrissie', 'Tisdale', to_date('13-10-2006', 'dd-mm-yyyy'), to_date('11-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1534, 'Charles', 'Coward', to_date('17-06-2006', 'dd-mm-yyyy'), to_date('08-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1535, 'Lea', 'Loeb', to_date('01-12-2006', 'dd-mm-yyyy'), to_date('25-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1536, 'Terence', 'Butler', to_date('01-04-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1537, 'Blair', 'Carrere', to_date('06-01-2006', 'dd-mm-yyyy'), to_date('24-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1538, 'Rebecca', 'Garr', to_date('15-06-2006', 'dd-mm-yyyy'), to_date('23-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1539, 'Jason', 'Tarantino', to_date('28-03-2006', 'dd-mm-yyyy'), to_date('27-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1540, 'Cyndi', 'Crimson', to_date('07-11-2006', 'dd-mm-yyyy'), to_date('25-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1541, 'Harold', 'Hobson', to_date('23-11-2006', 'dd-mm-yyyy'), to_date('09-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1542, 'Joseph', 'Weiland', to_date('27-10-2006', 'dd-mm-yyyy'), to_date('28-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1543, 'Thelma', 'Cumming', to_date('10-12-2006', 'dd-mm-yyyy'), to_date('10-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1544, 'Victor', 'Berkley', to_date('26-09-2006', 'dd-mm-yyyy'), to_date('31-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1545, 'Dean', 'Dushku', to_date('05-10-2006', 'dd-mm-yyyy'), to_date('15-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1867, 'Debbie', 'Smith', to_date('04-12-2006', 'dd-mm-yyyy'), to_date('18-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1868, 'Taryn', 'Barrymore', to_date('29-04-2006', 'dd-mm-yyyy'), to_date('27-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1869, 'Miles', 'Winstone', to_date('13-07-2006', 'dd-mm-yyyy'), to_date('12-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1870, 'Mary', 'Klugh', to_date('19-02-2006', 'dd-mm-yyyy'), to_date('19-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1871, 'Christmas', 'Moss', to_date('06-07-2006', 'dd-mm-yyyy'), to_date('17-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1872, 'Lizzy', 'Watson', to_date('16-04-2006', 'dd-mm-yyyy'), to_date('17-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1873, 'Nils', 'Deschanel', to_date('14-10-2006', 'dd-mm-yyyy'), to_date('08-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1874, 'Tori', 'Amos', to_date('30-12-2006', 'dd-mm-yyyy'), to_date('26-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1875, 'Brothers', 'Cherry', to_date('06-11-2006', 'dd-mm-yyyy'), to_date('01-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1876, 'Jude', 'Blige', to_date('11-11-2006', 'dd-mm-yyyy'), to_date('03-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1877, 'Percy', 'Malone', to_date('14-06-2006', 'dd-mm-yyyy'), to_date('21-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1878, 'Laurie', 'Carrere', to_date('11-06-2006', 'dd-mm-yyyy'), to_date('17-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1879, 'Domingo', 'Kudrow', to_date('05-08-2006', 'dd-mm-yyyy'), to_date('17-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1880, 'Remy', 'Loring', to_date('01-03-2006', 'dd-mm-yyyy'), to_date('20-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1881, 'Russell', 'Steagall', to_date('28-10-2006', 'dd-mm-yyyy'), to_date('22-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1882, 'Nicolas', 'Sledge', to_date('04-07-2006', 'dd-mm-yyyy'), to_date('21-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1883, 'Lisa', 'Morrison', to_date('11-11-2006', 'dd-mm-yyyy'), to_date('04-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1884, 'Brenda', 'Polley', to_date('22-07-2006', 'dd-mm-yyyy'), to_date('08-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1885, 'Janeane', 'Utada', to_date('06-07-2006', 'dd-mm-yyyy'), to_date('21-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1886, 'Connie', 'Suchet', to_date('24-10-2006', 'dd-mm-yyyy'), to_date('03-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1887, 'Anne', 'Griffiths', to_date('01-12-2006', 'dd-mm-yyyy'), to_date('13-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1888, 'Molly', 'Conlee', to_date('09-05-2006', 'dd-mm-yyyy'), to_date('22-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1889, 'Kelly', 'Forrest', to_date('08-02-2006', 'dd-mm-yyyy'), to_date('02-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1890, 'Kim', 'Morse', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('18-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1891, 'Queen', 'Elliott', to_date('07-11-2006', 'dd-mm-yyyy'), to_date('07-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1892, 'Machine', 'Michaels', to_date('01-07-2006', 'dd-mm-yyyy'), to_date('20-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1893, 'Shannyn', 'Garza', to_date('13-11-2006', 'dd-mm-yyyy'), to_date('02-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1894, 'Cevin', 'Berkley', to_date('18-10-2006', 'dd-mm-yyyy'), to_date('23-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1895, 'Chrissie', 'Napolitano', to_date('13-04-2006', 'dd-mm-yyyy'), to_date('17-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1896, 'Vin', 'Rollins', to_date('01-04-2006', 'dd-mm-yyyy'), to_date('16-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1897, 'Chely', 'Whitmore', to_date('09-06-2006', 'dd-mm-yyyy'), to_date('24-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1898, 'Loren', 'Place', to_date('30-11-2006', 'dd-mm-yyyy'), to_date('19-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1899, 'Demi', 'Gryner', to_date('11-01-2006', 'dd-mm-yyyy'), to_date('23-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1900, 'Ashton', 'Horizon', to_date('13-11-2006', 'dd-mm-yyyy'), to_date('08-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1901, 'Cuba', 'Schiff', to_date('02-07-2006', 'dd-mm-yyyy'), to_date('08-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1902, 'Neil', 'Love', to_date('13-07-2006', 'dd-mm-yyyy'), to_date('05-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1903, 'Meryl', 'Weisberg', to_date('23-10-2006', 'dd-mm-yyyy'), to_date('01-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1904, 'Leonardo', 'D''Onofrio', to_date('25-04-2006', 'dd-mm-yyyy'), to_date('12-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1905, 'Buffy', 'Wood', to_date('23-06-2006', 'dd-mm-yyyy'), to_date('05-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1906, 'Rhona', 'Wainwright', to_date('31-07-2006', 'dd-mm-yyyy'), to_date('17-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1907, 'Alfie', 'Hunt', to_date('06-12-2006', 'dd-mm-yyyy'), to_date('18-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1908, 'Omar', 'Shaye', to_date('01-12-2006', 'dd-mm-yyyy'), to_date('28-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1909, 'Kazem', 'Carrey', to_date('21-03-2006', 'dd-mm-yyyy'), to_date('13-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1910, 'Scarlett', 'O''Keefe', to_date('20-09-2006', 'dd-mm-yyyy'), to_date('14-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1911, 'Alfie', 'Diggs', to_date('17-12-2006', 'dd-mm-yyyy'), to_date('21-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1912, 'Lily', 'Love', to_date('01-02-2006', 'dd-mm-yyyy'), to_date('07-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1913, 'Nathan', 'Evett', to_date('09-09-2006', 'dd-mm-yyyy'), to_date('01-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1914, 'Pamela', 'Pleasure', to_date('10-01-2006', 'dd-mm-yyyy'), to_date('27-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1915, 'Marianne', 'Duschel', to_date('07-06-2006', 'dd-mm-yyyy'), to_date('09-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1916, 'Avril', 'Leoni', to_date('23-12-2006', 'dd-mm-yyyy'), to_date('27-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1917, 'Rupert', 'Stamp', to_date('28-08-2006', 'dd-mm-yyyy'), to_date('05-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1918, 'Frederic', 'Gagnon', to_date('29-08-2006', 'dd-mm-yyyy'), to_date('08-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1919, 'Denise', 'Palmieri', to_date('08-07-2006', 'dd-mm-yyyy'), to_date('27-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1920, 'Frankie', 'McConaughey', to_date('12-03-2006', 'dd-mm-yyyy'), to_date('26-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1921, 'Christina', 'Maguire', to_date('19-05-2006', 'dd-mm-yyyy'), to_date('06-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1922, 'Olympia', 'Thomas', to_date('30-07-2006', 'dd-mm-yyyy'), to_date('22-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1923, 'Uma', 'Vincent', to_date('21-09-2006', 'dd-mm-yyyy'), to_date('05-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1924, 'Patty', 'Craddock', to_date('17-06-2006', 'dd-mm-yyyy'), to_date('08-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1925, 'Chris', 'Fonda', to_date('16-04-2006', 'dd-mm-yyyy'), to_date('05-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1926, 'Juliana', 'Tyson', to_date('18-03-2006', 'dd-mm-yyyy'), to_date('06-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1927, 'Neve', 'Pierce', to_date('02-08-2006', 'dd-mm-yyyy'), to_date('26-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1928, 'Faye', 'Gooding', to_date('30-04-2006', 'dd-mm-yyyy'), to_date('23-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1929, 'Patricia', 'Dickinson', to_date('06-09-2006', 'dd-mm-yyyy'), to_date('27-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1930, 'Rachel', 'Travolta', to_date('22-02-2006', 'dd-mm-yyyy'), to_date('31-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1931, 'Jann', 'Rooker', to_date('03-05-2006', 'dd-mm-yyyy'), to_date('07-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1932, 'Mary Beth', 'McClinton', to_date('06-11-2006', 'dd-mm-yyyy'), to_date('23-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1933, 'Javon', 'Martin', to_date('28-05-2006', 'dd-mm-yyyy'), to_date('13-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1934, 'Juan', 'Gryner', to_date('26-10-2006', 'dd-mm-yyyy'), to_date('13-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1935, 'Etta', 'Badalucco', to_date('10-08-2006', 'dd-mm-yyyy'), to_date('12-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1936, 'Dustin', 'Shelton', to_date('09-04-2006', 'dd-mm-yyyy'), to_date('01-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1937, 'Lois', 'Margolyes', to_date('20-07-2006', 'dd-mm-yyyy'), to_date('02-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1938, 'Leslie', 'Palminteri', to_date('18-03-2006', 'dd-mm-yyyy'), to_date('02-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1939, 'Sissy', 'Hanks', to_date('12-02-2006', 'dd-mm-yyyy'), to_date('05-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1940, 'Richie', 'Hornsby', to_date('17-09-2006', 'dd-mm-yyyy'), to_date('30-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1941, 'Kylie', 'Kleinenberg', to_date('17-02-2006', 'dd-mm-yyyy'), to_date('24-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1942, 'Brent', 'Breslin', to_date('05-07-2006', 'dd-mm-yyyy'), to_date('25-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1943, 'Geena', 'Nivola', to_date('08-05-2006', 'dd-mm-yyyy'), to_date('28-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1944, 'Buddy', 'Aiken', to_date('14-11-2006', 'dd-mm-yyyy'), to_date('09-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1945, 'Ronny', 'LaSalle', to_date('09-10-2006', 'dd-mm-yyyy'), to_date('14-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1946, 'Kurtwood', 'Moss', to_date('30-10-2006', 'dd-mm-yyyy'), to_date('09-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1947, 'Lynn', 'McLachlan', to_date('01-04-2006', 'dd-mm-yyyy'), to_date('10-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1948, 'Kid', 'Kennedy', to_date('10-09-2006', 'dd-mm-yyyy'), to_date('28-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1949, 'Geena', 'Olyphant', to_date('30-05-2006', 'dd-mm-yyyy'), to_date('28-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1950, 'Seann', 'Baldwin', to_date('17-11-2006', 'dd-mm-yyyy'), to_date('28-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1951, 'Loretta', 'Sandler', to_date('26-11-2006', 'dd-mm-yyyy'), to_date('25-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1952, 'Wendy', 'Tempest', to_date('26-01-2006', 'dd-mm-yyyy'), to_date('06-02-2009', 'dd-mm-yyyy'));
commit;
prompt 1900 records committed...
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1953, 'Kimberly', 'Scaggs', to_date('17-12-2006', 'dd-mm-yyyy'), to_date('14-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1954, 'Richard', 'Postlethwaite', to_date('26-08-2006', 'dd-mm-yyyy'), to_date('13-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1955, 'Gladys', 'Matthau', to_date('30-03-2006', 'dd-mm-yyyy'), to_date('23-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1956, 'Emilio', 'Kristofferson', to_date('08-07-2006', 'dd-mm-yyyy'), to_date('14-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1957, 'Mandy', 'Langella', to_date('10-01-2006', 'dd-mm-yyyy'), to_date('31-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1958, 'Walter', 'O''Sullivan', to_date('11-02-2006', 'dd-mm-yyyy'), to_date('30-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1959, 'Ernest', 'Wincott', to_date('13-09-2006', 'dd-mm-yyyy'), to_date('26-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1960, 'Darius', 'Lindo', to_date('14-11-2006', 'dd-mm-yyyy'), to_date('26-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1961, 'Omar', 'Woodard', to_date('25-07-2006', 'dd-mm-yyyy'), to_date('04-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1962, 'Chloe', 'Hong', to_date('21-11-2006', 'dd-mm-yyyy'), to_date('08-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1963, 'Geena', 'Peebles', to_date('06-12-2006', 'dd-mm-yyyy'), to_date('04-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1964, 'Quentin', 'Duvall', to_date('23-12-2006', 'dd-mm-yyyy'), to_date('01-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1965, 'Cary', 'Carradine', to_date('02-08-2006', 'dd-mm-yyyy'), to_date('26-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1966, 'Harvey', 'Wheel', to_date('18-12-2006', 'dd-mm-yyyy'), to_date('29-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1967, 'Campbell', 'Williamson', to_date('26-06-2006', 'dd-mm-yyyy'), to_date('17-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1968, 'Gabrielle', 'Vaughn', to_date('15-05-2006', 'dd-mm-yyyy'), to_date('04-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1969, 'Hugo', 'Garber', to_date('05-11-2006', 'dd-mm-yyyy'), to_date('08-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1970, 'Chely', 'Plummer', to_date('06-05-2006', 'dd-mm-yyyy'), to_date('29-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1971, 'Crispin', 'Mewes', to_date('27-06-2006', 'dd-mm-yyyy'), to_date('01-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1972, 'Sally', 'Merchant', to_date('15-12-2006', 'dd-mm-yyyy'), to_date('31-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1973, 'Maceo', 'Kier', to_date('10-07-2006', 'dd-mm-yyyy'), to_date('03-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1974, 'Morris', 'Hirsch', to_date('08-10-2006', 'dd-mm-yyyy'), to_date('12-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1975, 'Dan', 'Shaw', to_date('04-05-2006', 'dd-mm-yyyy'), to_date('11-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1976, 'April', 'Costello', to_date('22-09-2006', 'dd-mm-yyyy'), to_date('17-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1977, 'Judy', 'Stoltz', to_date('28-11-2006', 'dd-mm-yyyy'), to_date('06-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1978, 'Adina', 'Broderick', to_date('21-05-2006', 'dd-mm-yyyy'), to_date('12-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1979, 'Art', 'D''Onofrio', to_date('26-05-2006', 'dd-mm-yyyy'), to_date('12-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1980, 'Marina', 'Freeman', to_date('31-05-2006', 'dd-mm-yyyy'), to_date('04-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1981, 'Mos', 'Crowell', to_date('07-02-2006', 'dd-mm-yyyy'), to_date('03-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1982, 'Daryl', 'Archer', to_date('10-06-2006', 'dd-mm-yyyy'), to_date('21-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1983, 'Cathy', 'Singh', to_date('02-09-2006', 'dd-mm-yyyy'), to_date('06-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1984, 'Gin', 'Goldwyn', to_date('12-03-2006', 'dd-mm-yyyy'), to_date('10-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1985, 'Shirley', 'Hunter', to_date('06-09-2006', 'dd-mm-yyyy'), to_date('01-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1986, 'Maura', 'McDormand', to_date('18-12-2006', 'dd-mm-yyyy'), to_date('12-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1987, 'Joseph', 'Sayer', to_date('28-06-2006', 'dd-mm-yyyy'), to_date('02-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1988, 'Harriet', 'Diesel', to_date('18-05-2006', 'dd-mm-yyyy'), to_date('27-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1989, 'Wendy', 'Rickles', to_date('31-05-2006', 'dd-mm-yyyy'), to_date('23-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1990, 'Adrien', 'Fogerty', to_date('20-06-2006', 'dd-mm-yyyy'), to_date('26-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1991, 'Uma', 'McCain', to_date('20-03-2006', 'dd-mm-yyyy'), to_date('17-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1992, 'Gilberto', 'Linney', to_date('03-02-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1993, 'Hilton', 'May', to_date('30-11-2006', 'dd-mm-yyyy'), to_date('25-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1994, 'Miriam', 'Posener', to_date('13-08-2006', 'dd-mm-yyyy'), to_date('05-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1995, 'Jon', 'Pullman', to_date('27-11-2006', 'dd-mm-yyyy'), to_date('18-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1996, 'Mae', 'Dawson', to_date('18-12-2006', 'dd-mm-yyyy'), to_date('24-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1997, 'Bernie', 'Greene', to_date('17-05-2006', 'dd-mm-yyyy'), to_date('23-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1998, 'Renee', 'Gagnon', to_date('04-12-2006', 'dd-mm-yyyy'), to_date('13-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1999, 'Charles', 'Tennison', to_date('13-01-2006', 'dd-mm-yyyy'), to_date('27-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (2000, 'Hookah', 'Scheider', to_date('27-10-2006', 'dd-mm-yyyy'), to_date('14-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1680, 'Jaime', 'Margolyes', to_date('22-11-2006', 'dd-mm-yyyy'), to_date('19-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1681, 'Lizzy', 'Kennedy', to_date('09-12-2006', 'dd-mm-yyyy'), to_date('25-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1682, 'Samantha', 'Scheider', to_date('01-09-2006', 'dd-mm-yyyy'), to_date('26-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1683, 'Carl', 'Tyson', to_date('06-09-2006', 'dd-mm-yyyy'), to_date('03-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1684, 'Buffy', 'Rawls', to_date('30-03-2006', 'dd-mm-yyyy'), to_date('02-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1685, 'James', 'Stamp', to_date('13-02-2006', 'dd-mm-yyyy'), to_date('21-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1686, 'Cary', 'Dupree', to_date('06-09-2006', 'dd-mm-yyyy'), to_date('13-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1687, 'Mekhi', 'Bening', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('08-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1688, 'Liam', 'Sedgwick', to_date('04-11-2006', 'dd-mm-yyyy'), to_date('01-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1689, 'William', 'Gyllenhaal', to_date('12-06-2006', 'dd-mm-yyyy'), to_date('13-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1690, 'Holland', 'De Almeida', to_date('06-08-2006', 'dd-mm-yyyy'), to_date('19-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1691, 'Vincent', 'Springfield', to_date('08-11-2006', 'dd-mm-yyyy'), to_date('23-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1692, 'Emily', 'Minogue', to_date('02-05-2006', 'dd-mm-yyyy'), to_date('20-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1693, 'Heath', 'Wincott', to_date('16-07-2006', 'dd-mm-yyyy'), to_date('09-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1694, 'Rob', 'Gunton', to_date('22-10-2006', 'dd-mm-yyyy'), to_date('29-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1695, 'Cyndi', 'Shaye', to_date('10-02-2006', 'dd-mm-yyyy'), to_date('04-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1696, 'Isaiah', 'Cleary', to_date('15-04-2006', 'dd-mm-yyyy'), to_date('19-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1697, 'Dennis', 'Jolie', to_date('02-01-2006', 'dd-mm-yyyy'), to_date('21-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1698, 'Elle', 'Balaban', to_date('29-12-2006', 'dd-mm-yyyy'), to_date('15-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1699, 'Lloyd', 'DeVito', to_date('07-05-2006', 'dd-mm-yyyy'), to_date('05-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1700, 'Teri', 'McGill', to_date('27-11-2006', 'dd-mm-yyyy'), to_date('16-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1701, 'Tracy', 'Forrest', to_date('16-02-2006', 'dd-mm-yyyy'), to_date('22-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1702, 'Meg', 'Coburn', to_date('24-10-2006', 'dd-mm-yyyy'), to_date('19-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1703, 'Nelly', 'Blair', to_date('10-09-2006', 'dd-mm-yyyy'), to_date('20-03-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1704, 'Rene', 'Camp', to_date('22-09-2006', 'dd-mm-yyyy'), to_date('22-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1705, 'Rufus', 'Rains', to_date('22-07-2006', 'dd-mm-yyyy'), to_date('13-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1706, 'Ronny', 'Dale', to_date('31-07-2006', 'dd-mm-yyyy'), to_date('09-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1707, 'Miko', 'Washington', to_date('29-06-2006', 'dd-mm-yyyy'), to_date('27-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1708, 'Courtney', 'Weber', to_date('09-04-2006', 'dd-mm-yyyy'), to_date('05-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1709, 'Gordie', 'Lennix', to_date('27-12-2006', 'dd-mm-yyyy'), to_date('27-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1710, 'Antonio', 'Camp', to_date('16-12-2006', 'dd-mm-yyyy'), to_date('10-10-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1711, 'Frances', 'Blige', to_date('21-12-2006', 'dd-mm-yyyy'), to_date('07-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1712, 'Norm', 'Diggs', to_date('03-10-2006', 'dd-mm-yyyy'), to_date('03-12-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1713, 'Elisabeth', 'Wood', to_date('13-11-2006', 'dd-mm-yyyy'), to_date('16-04-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1714, 'Anita', 'Depp', to_date('25-08-2006', 'dd-mm-yyyy'), to_date('01-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1715, 'Gwyneth', 'Clarkson', to_date('16-12-2006', 'dd-mm-yyyy'), to_date('19-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1716, 'Kasey', 'Allison', to_date('16-10-2006', 'dd-mm-yyyy'), to_date('23-11-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1717, 'Russell', 'Wood', to_date('23-01-2006', 'dd-mm-yyyy'), to_date('12-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1718, 'Christopher', 'Devine', to_date('29-01-2006', 'dd-mm-yyyy'), to_date('23-07-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1719, 'Milla', 'Hackman', to_date('13-07-2006', 'dd-mm-yyyy'), to_date('10-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1720, 'Jim', 'Brandt', to_date('16-01-2006', 'dd-mm-yyyy'), to_date('10-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1721, 'Wesley', 'Richardson', to_date('19-07-2006', 'dd-mm-yyyy'), to_date('12-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1722, 'Millie', 'Brown', to_date('28-01-2006', 'dd-mm-yyyy'), to_date('23-01-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1723, 'Forest', 'Emmerich', to_date('27-09-2006', 'dd-mm-yyyy'), to_date('06-06-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1724, 'Jann', 'Birch', to_date('07-12-2006', 'dd-mm-yyyy'), to_date('07-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1725, 'Kylie', 'Tucci', to_date('09-02-2006', 'dd-mm-yyyy'), to_date('15-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1726, 'Rolando', 'Apple', to_date('31-07-2006', 'dd-mm-yyyy'), to_date('04-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1727, 'Scott', 'Rock', to_date('10-04-2006', 'dd-mm-yyyy'), to_date('25-05-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1728, 'Jamie', 'De Niro', to_date('01-05-2006', 'dd-mm-yyyy'), to_date('18-08-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1729, 'Gordon', 'Grier', to_date('06-01-2006', 'dd-mm-yyyy'), to_date('04-02-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1730, 'Carole', 'Garfunkel', to_date('24-04-2006', 'dd-mm-yyyy'), to_date('04-09-2009', 'dd-mm-yyyy'));
insert into SOLDIERS (sid, firstname, lastname, draftdate, releasedate)
values (1731, 'Lara', 'Akins', to_date('26-02-2006', 'dd-mm-yyyy'), to_date('18-07-2009', 'dd-mm-yyyy'));
commit;
prompt 2000 records loaded
prompt Loading COMMANDER...
insert into COMMANDER (cid)
values (1);
insert into COMMANDER (cid)
values (2);
insert into COMMANDER (cid)
values (3);
insert into COMMANDER (cid)
values (4);
insert into COMMANDER (cid)
values (5);
insert into COMMANDER (cid)
values (6);
insert into COMMANDER (cid)
values (7);
insert into COMMANDER (cid)
values (8);
insert into COMMANDER (cid)
values (9);
insert into COMMANDER (cid)
values (10);
insert into COMMANDER (cid)
values (11);
insert into COMMANDER (cid)
values (12);
insert into COMMANDER (cid)
values (13);
insert into COMMANDER (cid)
values (14);
insert into COMMANDER (cid)
values (15);
insert into COMMANDER (cid)
values (16);
insert into COMMANDER (cid)
values (17);
insert into COMMANDER (cid)
values (18);
insert into COMMANDER (cid)
values (19);
insert into COMMANDER (cid)
values (20);
insert into COMMANDER (cid)
values (21);
insert into COMMANDER (cid)
values (22);
insert into COMMANDER (cid)
values (23);
insert into COMMANDER (cid)
values (24);
insert into COMMANDER (cid)
values (25);
insert into COMMANDER (cid)
values (26);
insert into COMMANDER (cid)
values (27);
insert into COMMANDER (cid)
values (28);
insert into COMMANDER (cid)
values (29);
insert into COMMANDER (cid)
values (30);
insert into COMMANDER (cid)
values (31);
insert into COMMANDER (cid)
values (32);
insert into COMMANDER (cid)
values (33);
insert into COMMANDER (cid)
values (34);
insert into COMMANDER (cid)
values (35);
insert into COMMANDER (cid)
values (36);
insert into COMMANDER (cid)
values (37);
insert into COMMANDER (cid)
values (38);
insert into COMMANDER (cid)
values (39);
insert into COMMANDER (cid)
values (40);
insert into COMMANDER (cid)
values (41);
insert into COMMANDER (cid)
values (42);
insert into COMMANDER (cid)
values (43);
insert into COMMANDER (cid)
values (44);
insert into COMMANDER (cid)
values (45);
insert into COMMANDER (cid)
values (46);
insert into COMMANDER (cid)
values (47);
insert into COMMANDER (cid)
values (48);
insert into COMMANDER (cid)
values (49);
insert into COMMANDER (cid)
values (50);
insert into COMMANDER (cid)
values (51);
insert into COMMANDER (cid)
values (52);
insert into COMMANDER (cid)
values (53);
insert into COMMANDER (cid)
values (54);
insert into COMMANDER (cid)
values (55);
insert into COMMANDER (cid)
values (56);
insert into COMMANDER (cid)
values (57);
insert into COMMANDER (cid)
values (58);
insert into COMMANDER (cid)
values (59);
insert into COMMANDER (cid)
values (60);
insert into COMMANDER (cid)
values (61);
insert into COMMANDER (cid)
values (62);
insert into COMMANDER (cid)
values (63);
insert into COMMANDER (cid)
values (64);
insert into COMMANDER (cid)
values (65);
insert into COMMANDER (cid)
values (66);
insert into COMMANDER (cid)
values (67);
insert into COMMANDER (cid)
values (68);
insert into COMMANDER (cid)
values (69);
insert into COMMANDER (cid)
values (70);
insert into COMMANDER (cid)
values (71);
insert into COMMANDER (cid)
values (72);
insert into COMMANDER (cid)
values (73);
insert into COMMANDER (cid)
values (74);
insert into COMMANDER (cid)
values (75);
insert into COMMANDER (cid)
values (76);
insert into COMMANDER (cid)
values (77);
insert into COMMANDER (cid)
values (78);
insert into COMMANDER (cid)
values (79);
insert into COMMANDER (cid)
values (80);
insert into COMMANDER (cid)
values (81);
insert into COMMANDER (cid)
values (82);
insert into COMMANDER (cid)
values (83);
insert into COMMANDER (cid)
values (84);
insert into COMMANDER (cid)
values (85);
insert into COMMANDER (cid)
values (86);
insert into COMMANDER (cid)
values (87);
insert into COMMANDER (cid)
values (88);
insert into COMMANDER (cid)
values (89);
insert into COMMANDER (cid)
values (90);
insert into COMMANDER (cid)
values (91);
insert into COMMANDER (cid)
values (92);
insert into COMMANDER (cid)
values (93);
insert into COMMANDER (cid)
values (94);
insert into COMMANDER (cid)
values (95);
insert into COMMANDER (cid)
values (96);
insert into COMMANDER (cid)
values (97);
insert into COMMANDER (cid)
values (98);
insert into COMMANDER (cid)
values (99);
insert into COMMANDER (cid)
values (100);
commit;
prompt 100 records committed...
insert into COMMANDER (cid)
values (101);
insert into COMMANDER (cid)
values (102);
insert into COMMANDER (cid)
values (103);
insert into COMMANDER (cid)
values (104);
insert into COMMANDER (cid)
values (105);
insert into COMMANDER (cid)
values (106);
insert into COMMANDER (cid)
values (107);
insert into COMMANDER (cid)
values (108);
insert into COMMANDER (cid)
values (109);
insert into COMMANDER (cid)
values (110);
insert into COMMANDER (cid)
values (111);
insert into COMMANDER (cid)
values (112);
insert into COMMANDER (cid)
values (113);
insert into COMMANDER (cid)
values (114);
insert into COMMANDER (cid)
values (115);
insert into COMMANDER (cid)
values (116);
insert into COMMANDER (cid)
values (117);
insert into COMMANDER (cid)
values (118);
insert into COMMANDER (cid)
values (119);
insert into COMMANDER (cid)
values (120);
insert into COMMANDER (cid)
values (121);
insert into COMMANDER (cid)
values (122);
insert into COMMANDER (cid)
values (123);
insert into COMMANDER (cid)
values (124);
insert into COMMANDER (cid)
values (125);
insert into COMMANDER (cid)
values (126);
insert into COMMANDER (cid)
values (127);
insert into COMMANDER (cid)
values (128);
insert into COMMANDER (cid)
values (129);
insert into COMMANDER (cid)
values (130);
insert into COMMANDER (cid)
values (131);
insert into COMMANDER (cid)
values (132);
insert into COMMANDER (cid)
values (133);
insert into COMMANDER (cid)
values (134);
insert into COMMANDER (cid)
values (135);
insert into COMMANDER (cid)
values (136);
insert into COMMANDER (cid)
values (137);
insert into COMMANDER (cid)
values (138);
insert into COMMANDER (cid)
values (139);
insert into COMMANDER (cid)
values (140);
insert into COMMANDER (cid)
values (141);
insert into COMMANDER (cid)
values (142);
insert into COMMANDER (cid)
values (143);
insert into COMMANDER (cid)
values (144);
insert into COMMANDER (cid)
values (145);
insert into COMMANDER (cid)
values (146);
insert into COMMANDER (cid)
values (147);
insert into COMMANDER (cid)
values (148);
insert into COMMANDER (cid)
values (149);
insert into COMMANDER (cid)
values (150);
insert into COMMANDER (cid)
values (151);
insert into COMMANDER (cid)
values (152);
insert into COMMANDER (cid)
values (153);
insert into COMMANDER (cid)
values (154);
insert into COMMANDER (cid)
values (155);
insert into COMMANDER (cid)
values (156);
insert into COMMANDER (cid)
values (157);
insert into COMMANDER (cid)
values (158);
insert into COMMANDER (cid)
values (159);
insert into COMMANDER (cid)
values (160);
insert into COMMANDER (cid)
values (161);
insert into COMMANDER (cid)
values (162);
insert into COMMANDER (cid)
values (163);
insert into COMMANDER (cid)
values (164);
insert into COMMANDER (cid)
values (165);
insert into COMMANDER (cid)
values (166);
insert into COMMANDER (cid)
values (167);
insert into COMMANDER (cid)
values (168);
insert into COMMANDER (cid)
values (169);
insert into COMMANDER (cid)
values (170);
insert into COMMANDER (cid)
values (171);
insert into COMMANDER (cid)
values (172);
insert into COMMANDER (cid)
values (173);
insert into COMMANDER (cid)
values (174);
insert into COMMANDER (cid)
values (175);
insert into COMMANDER (cid)
values (176);
insert into COMMANDER (cid)
values (177);
insert into COMMANDER (cid)
values (178);
insert into COMMANDER (cid)
values (179);
insert into COMMANDER (cid)
values (180);
insert into COMMANDER (cid)
values (181);
insert into COMMANDER (cid)
values (182);
insert into COMMANDER (cid)
values (183);
insert into COMMANDER (cid)
values (184);
insert into COMMANDER (cid)
values (185);
insert into COMMANDER (cid)
values (186);
insert into COMMANDER (cid)
values (187);
insert into COMMANDER (cid)
values (188);
insert into COMMANDER (cid)
values (189);
insert into COMMANDER (cid)
values (190);
insert into COMMANDER (cid)
values (191);
insert into COMMANDER (cid)
values (192);
insert into COMMANDER (cid)
values (193);
insert into COMMANDER (cid)
values (194);
insert into COMMANDER (cid)
values (195);
insert into COMMANDER (cid)
values (196);
insert into COMMANDER (cid)
values (197);
insert into COMMANDER (cid)
values (198);
insert into COMMANDER (cid)
values (199);
insert into COMMANDER (cid)
values (200);
commit;
prompt 200 records committed...
insert into COMMANDER (cid)
values (201);
insert into COMMANDER (cid)
values (202);
insert into COMMANDER (cid)
values (203);
insert into COMMANDER (cid)
values (204);
insert into COMMANDER (cid)
values (205);
insert into COMMANDER (cid)
values (206);
insert into COMMANDER (cid)
values (207);
insert into COMMANDER (cid)
values (208);
insert into COMMANDER (cid)
values (209);
insert into COMMANDER (cid)
values (210);
insert into COMMANDER (cid)
values (211);
insert into COMMANDER (cid)
values (212);
insert into COMMANDER (cid)
values (213);
insert into COMMANDER (cid)
values (214);
insert into COMMANDER (cid)
values (215);
insert into COMMANDER (cid)
values (216);
insert into COMMANDER (cid)
values (217);
insert into COMMANDER (cid)
values (218);
insert into COMMANDER (cid)
values (219);
insert into COMMANDER (cid)
values (220);
insert into COMMANDER (cid)
values (221);
insert into COMMANDER (cid)
values (222);
insert into COMMANDER (cid)
values (223);
insert into COMMANDER (cid)
values (224);
insert into COMMANDER (cid)
values (225);
insert into COMMANDER (cid)
values (226);
insert into COMMANDER (cid)
values (227);
insert into COMMANDER (cid)
values (228);
insert into COMMANDER (cid)
values (229);
insert into COMMANDER (cid)
values (230);
insert into COMMANDER (cid)
values (231);
insert into COMMANDER (cid)
values (232);
insert into COMMANDER (cid)
values (233);
insert into COMMANDER (cid)
values (234);
insert into COMMANDER (cid)
values (235);
insert into COMMANDER (cid)
values (236);
insert into COMMANDER (cid)
values (237);
insert into COMMANDER (cid)
values (238);
insert into COMMANDER (cid)
values (239);
insert into COMMANDER (cid)
values (240);
insert into COMMANDER (cid)
values (241);
insert into COMMANDER (cid)
values (242);
insert into COMMANDER (cid)
values (243);
insert into COMMANDER (cid)
values (244);
insert into COMMANDER (cid)
values (245);
insert into COMMANDER (cid)
values (246);
insert into COMMANDER (cid)
values (247);
insert into COMMANDER (cid)
values (248);
insert into COMMANDER (cid)
values (249);
insert into COMMANDER (cid)
values (250);
insert into COMMANDER (cid)
values (251);
insert into COMMANDER (cid)
values (252);
insert into COMMANDER (cid)
values (253);
insert into COMMANDER (cid)
values (254);
insert into COMMANDER (cid)
values (255);
insert into COMMANDER (cid)
values (256);
insert into COMMANDER (cid)
values (257);
insert into COMMANDER (cid)
values (258);
insert into COMMANDER (cid)
values (259);
insert into COMMANDER (cid)
values (260);
insert into COMMANDER (cid)
values (261);
insert into COMMANDER (cid)
values (262);
insert into COMMANDER (cid)
values (263);
insert into COMMANDER (cid)
values (264);
insert into COMMANDER (cid)
values (265);
insert into COMMANDER (cid)
values (266);
insert into COMMANDER (cid)
values (267);
insert into COMMANDER (cid)
values (268);
insert into COMMANDER (cid)
values (269);
insert into COMMANDER (cid)
values (270);
insert into COMMANDER (cid)
values (271);
insert into COMMANDER (cid)
values (272);
insert into COMMANDER (cid)
values (273);
insert into COMMANDER (cid)
values (274);
insert into COMMANDER (cid)
values (275);
insert into COMMANDER (cid)
values (276);
insert into COMMANDER (cid)
values (277);
insert into COMMANDER (cid)
values (278);
insert into COMMANDER (cid)
values (279);
insert into COMMANDER (cid)
values (280);
insert into COMMANDER (cid)
values (281);
insert into COMMANDER (cid)
values (282);
insert into COMMANDER (cid)
values (283);
insert into COMMANDER (cid)
values (284);
insert into COMMANDER (cid)
values (285);
insert into COMMANDER (cid)
values (286);
insert into COMMANDER (cid)
values (287);
insert into COMMANDER (cid)
values (288);
insert into COMMANDER (cid)
values (289);
insert into COMMANDER (cid)
values (290);
insert into COMMANDER (cid)
values (291);
insert into COMMANDER (cid)
values (292);
insert into COMMANDER (cid)
values (293);
insert into COMMANDER (cid)
values (294);
insert into COMMANDER (cid)
values (295);
insert into COMMANDER (cid)
values (296);
insert into COMMANDER (cid)
values (297);
insert into COMMANDER (cid)
values (298);
insert into COMMANDER (cid)
values (299);
insert into COMMANDER (cid)
values (300);
commit;
prompt 300 records committed...
insert into COMMANDER (cid)
values (301);
insert into COMMANDER (cid)
values (302);
insert into COMMANDER (cid)
values (303);
insert into COMMANDER (cid)
values (304);
insert into COMMANDER (cid)
values (305);
insert into COMMANDER (cid)
values (306);
insert into COMMANDER (cid)
values (307);
insert into COMMANDER (cid)
values (308);
insert into COMMANDER (cid)
values (309);
insert into COMMANDER (cid)
values (310);
insert into COMMANDER (cid)
values (311);
insert into COMMANDER (cid)
values (312);
insert into COMMANDER (cid)
values (313);
insert into COMMANDER (cid)
values (314);
insert into COMMANDER (cid)
values (315);
insert into COMMANDER (cid)
values (316);
insert into COMMANDER (cid)
values (317);
insert into COMMANDER (cid)
values (318);
insert into COMMANDER (cid)
values (319);
insert into COMMANDER (cid)
values (320);
insert into COMMANDER (cid)
values (321);
insert into COMMANDER (cid)
values (322);
insert into COMMANDER (cid)
values (323);
insert into COMMANDER (cid)
values (324);
insert into COMMANDER (cid)
values (325);
insert into COMMANDER (cid)
values (326);
insert into COMMANDER (cid)
values (327);
insert into COMMANDER (cid)
values (328);
insert into COMMANDER (cid)
values (329);
insert into COMMANDER (cid)
values (330);
insert into COMMANDER (cid)
values (331);
insert into COMMANDER (cid)
values (332);
insert into COMMANDER (cid)
values (333);
insert into COMMANDER (cid)
values (334);
insert into COMMANDER (cid)
values (335);
insert into COMMANDER (cid)
values (336);
insert into COMMANDER (cid)
values (337);
insert into COMMANDER (cid)
values (338);
insert into COMMANDER (cid)
values (339);
insert into COMMANDER (cid)
values (340);
insert into COMMANDER (cid)
values (341);
insert into COMMANDER (cid)
values (342);
insert into COMMANDER (cid)
values (343);
insert into COMMANDER (cid)
values (344);
insert into COMMANDER (cid)
values (345);
insert into COMMANDER (cid)
values (346);
insert into COMMANDER (cid)
values (347);
insert into COMMANDER (cid)
values (348);
insert into COMMANDER (cid)
values (349);
insert into COMMANDER (cid)
values (350);
insert into COMMANDER (cid)
values (351);
insert into COMMANDER (cid)
values (352);
insert into COMMANDER (cid)
values (353);
insert into COMMANDER (cid)
values (354);
insert into COMMANDER (cid)
values (355);
insert into COMMANDER (cid)
values (356);
insert into COMMANDER (cid)
values (357);
insert into COMMANDER (cid)
values (358);
insert into COMMANDER (cid)
values (359);
insert into COMMANDER (cid)
values (360);
insert into COMMANDER (cid)
values (361);
insert into COMMANDER (cid)
values (362);
insert into COMMANDER (cid)
values (363);
insert into COMMANDER (cid)
values (364);
insert into COMMANDER (cid)
values (365);
insert into COMMANDER (cid)
values (366);
insert into COMMANDER (cid)
values (367);
insert into COMMANDER (cid)
values (368);
insert into COMMANDER (cid)
values (369);
insert into COMMANDER (cid)
values (370);
insert into COMMANDER (cid)
values (371);
insert into COMMANDER (cid)
values (372);
insert into COMMANDER (cid)
values (373);
insert into COMMANDER (cid)
values (374);
insert into COMMANDER (cid)
values (375);
insert into COMMANDER (cid)
values (376);
insert into COMMANDER (cid)
values (377);
insert into COMMANDER (cid)
values (378);
insert into COMMANDER (cid)
values (379);
insert into COMMANDER (cid)
values (380);
insert into COMMANDER (cid)
values (381);
insert into COMMANDER (cid)
values (382);
insert into COMMANDER (cid)
values (383);
insert into COMMANDER (cid)
values (384);
insert into COMMANDER (cid)
values (385);
insert into COMMANDER (cid)
values (386);
insert into COMMANDER (cid)
values (387);
insert into COMMANDER (cid)
values (388);
insert into COMMANDER (cid)
values (389);
insert into COMMANDER (cid)
values (390);
insert into COMMANDER (cid)
values (391);
insert into COMMANDER (cid)
values (392);
insert into COMMANDER (cid)
values (393);
insert into COMMANDER (cid)
values (394);
insert into COMMANDER (cid)
values (395);
insert into COMMANDER (cid)
values (396);
insert into COMMANDER (cid)
values (397);
insert into COMMANDER (cid)
values (398);
insert into COMMANDER (cid)
values (399);
insert into COMMANDER (cid)
values (400);
commit;
prompt 400 records committed...
insert into COMMANDER (cid)
values (401);
insert into COMMANDER (cid)
values (402);
insert into COMMANDER (cid)
values (403);
insert into COMMANDER (cid)
values (404);
insert into COMMANDER (cid)
values (405);
insert into COMMANDER (cid)
values (406);
insert into COMMANDER (cid)
values (407);
insert into COMMANDER (cid)
values (408);
insert into COMMANDER (cid)
values (409);
insert into COMMANDER (cid)
values (410);
insert into COMMANDER (cid)
values (411);
insert into COMMANDER (cid)
values (412);
insert into COMMANDER (cid)
values (413);
insert into COMMANDER (cid)
values (414);
insert into COMMANDER (cid)
values (415);
insert into COMMANDER (cid)
values (416);
insert into COMMANDER (cid)
values (417);
insert into COMMANDER (cid)
values (418);
insert into COMMANDER (cid)
values (419);
insert into COMMANDER (cid)
values (420);
insert into COMMANDER (cid)
values (421);
insert into COMMANDER (cid)
values (422);
insert into COMMANDER (cid)
values (423);
insert into COMMANDER (cid)
values (424);
insert into COMMANDER (cid)
values (425);
insert into COMMANDER (cid)
values (426);
insert into COMMANDER (cid)
values (427);
insert into COMMANDER (cid)
values (428);
insert into COMMANDER (cid)
values (429);
insert into COMMANDER (cid)
values (430);
insert into COMMANDER (cid)
values (431);
insert into COMMANDER (cid)
values (432);
insert into COMMANDER (cid)
values (433);
insert into COMMANDER (cid)
values (434);
insert into COMMANDER (cid)
values (435);
insert into COMMANDER (cid)
values (436);
insert into COMMANDER (cid)
values (437);
insert into COMMANDER (cid)
values (438);
insert into COMMANDER (cid)
values (439);
insert into COMMANDER (cid)
values (440);
insert into COMMANDER (cid)
values (441);
insert into COMMANDER (cid)
values (442);
insert into COMMANDER (cid)
values (443);
insert into COMMANDER (cid)
values (444);
insert into COMMANDER (cid)
values (445);
insert into COMMANDER (cid)
values (446);
insert into COMMANDER (cid)
values (447);
insert into COMMANDER (cid)
values (448);
insert into COMMANDER (cid)
values (449);
insert into COMMANDER (cid)
values (450);
insert into COMMANDER (cid)
values (451);
insert into COMMANDER (cid)
values (452);
insert into COMMANDER (cid)
values (453);
insert into COMMANDER (cid)
values (454);
insert into COMMANDER (cid)
values (455);
insert into COMMANDER (cid)
values (456);
insert into COMMANDER (cid)
values (457);
insert into COMMANDER (cid)
values (458);
insert into COMMANDER (cid)
values (459);
insert into COMMANDER (cid)
values (460);
insert into COMMANDER (cid)
values (461);
insert into COMMANDER (cid)
values (462);
insert into COMMANDER (cid)
values (463);
insert into COMMANDER (cid)
values (464);
insert into COMMANDER (cid)
values (465);
insert into COMMANDER (cid)
values (466);
insert into COMMANDER (cid)
values (467);
insert into COMMANDER (cid)
values (468);
insert into COMMANDER (cid)
values (469);
insert into COMMANDER (cid)
values (470);
insert into COMMANDER (cid)
values (471);
insert into COMMANDER (cid)
values (472);
insert into COMMANDER (cid)
values (473);
insert into COMMANDER (cid)
values (474);
insert into COMMANDER (cid)
values (475);
insert into COMMANDER (cid)
values (476);
insert into COMMANDER (cid)
values (477);
insert into COMMANDER (cid)
values (478);
insert into COMMANDER (cid)
values (479);
insert into COMMANDER (cid)
values (480);
insert into COMMANDER (cid)
values (481);
insert into COMMANDER (cid)
values (482);
insert into COMMANDER (cid)
values (483);
insert into COMMANDER (cid)
values (484);
insert into COMMANDER (cid)
values (485);
insert into COMMANDER (cid)
values (486);
insert into COMMANDER (cid)
values (487);
insert into COMMANDER (cid)
values (488);
insert into COMMANDER (cid)
values (489);
insert into COMMANDER (cid)
values (490);
insert into COMMANDER (cid)
values (491);
insert into COMMANDER (cid)
values (492);
insert into COMMANDER (cid)
values (493);
insert into COMMANDER (cid)
values (494);
insert into COMMANDER (cid)
values (495);
insert into COMMANDER (cid)
values (496);
insert into COMMANDER (cid)
values (497);
insert into COMMANDER (cid)
values (498);
insert into COMMANDER (cid)
values (499);
insert into COMMANDER (cid)
values (500);
commit;
prompt 500 records committed...
insert into COMMANDER (cid)
values (501);
insert into COMMANDER (cid)
values (502);
insert into COMMANDER (cid)
values (503);
insert into COMMANDER (cid)
values (504);
insert into COMMANDER (cid)
values (505);
insert into COMMANDER (cid)
values (506);
insert into COMMANDER (cid)
values (507);
insert into COMMANDER (cid)
values (508);
insert into COMMANDER (cid)
values (509);
insert into COMMANDER (cid)
values (510);
insert into COMMANDER (cid)
values (511);
insert into COMMANDER (cid)
values (512);
insert into COMMANDER (cid)
values (513);
insert into COMMANDER (cid)
values (514);
insert into COMMANDER (cid)
values (515);
insert into COMMANDER (cid)
values (516);
insert into COMMANDER (cid)
values (517);
insert into COMMANDER (cid)
values (518);
insert into COMMANDER (cid)
values (519);
insert into COMMANDER (cid)
values (520);
insert into COMMANDER (cid)
values (521);
insert into COMMANDER (cid)
values (522);
insert into COMMANDER (cid)
values (523);
insert into COMMANDER (cid)
values (524);
insert into COMMANDER (cid)
values (525);
insert into COMMANDER (cid)
values (526);
insert into COMMANDER (cid)
values (527);
insert into COMMANDER (cid)
values (528);
insert into COMMANDER (cid)
values (529);
insert into COMMANDER (cid)
values (530);
insert into COMMANDER (cid)
values (531);
insert into COMMANDER (cid)
values (532);
insert into COMMANDER (cid)
values (533);
insert into COMMANDER (cid)
values (534);
insert into COMMANDER (cid)
values (535);
insert into COMMANDER (cid)
values (536);
insert into COMMANDER (cid)
values (537);
insert into COMMANDER (cid)
values (538);
insert into COMMANDER (cid)
values (539);
insert into COMMANDER (cid)
values (540);
insert into COMMANDER (cid)
values (541);
insert into COMMANDER (cid)
values (542);
insert into COMMANDER (cid)
values (543);
insert into COMMANDER (cid)
values (544);
insert into COMMANDER (cid)
values (545);
insert into COMMANDER (cid)
values (546);
insert into COMMANDER (cid)
values (547);
insert into COMMANDER (cid)
values (548);
insert into COMMANDER (cid)
values (549);
insert into COMMANDER (cid)
values (550);
insert into COMMANDER (cid)
values (551);
insert into COMMANDER (cid)
values (552);
insert into COMMANDER (cid)
values (553);
insert into COMMANDER (cid)
values (554);
insert into COMMANDER (cid)
values (555);
insert into COMMANDER (cid)
values (556);
insert into COMMANDER (cid)
values (557);
insert into COMMANDER (cid)
values (558);
insert into COMMANDER (cid)
values (559);
insert into COMMANDER (cid)
values (560);
insert into COMMANDER (cid)
values (561);
insert into COMMANDER (cid)
values (562);
insert into COMMANDER (cid)
values (563);
insert into COMMANDER (cid)
values (564);
insert into COMMANDER (cid)
values (565);
insert into COMMANDER (cid)
values (566);
insert into COMMANDER (cid)
values (567);
insert into COMMANDER (cid)
values (568);
insert into COMMANDER (cid)
values (569);
insert into COMMANDER (cid)
values (570);
insert into COMMANDER (cid)
values (571);
insert into COMMANDER (cid)
values (572);
insert into COMMANDER (cid)
values (573);
insert into COMMANDER (cid)
values (574);
insert into COMMANDER (cid)
values (575);
insert into COMMANDER (cid)
values (576);
insert into COMMANDER (cid)
values (577);
insert into COMMANDER (cid)
values (578);
insert into COMMANDER (cid)
values (579);
insert into COMMANDER (cid)
values (580);
insert into COMMANDER (cid)
values (581);
insert into COMMANDER (cid)
values (582);
insert into COMMANDER (cid)
values (583);
insert into COMMANDER (cid)
values (584);
insert into COMMANDER (cid)
values (585);
insert into COMMANDER (cid)
values (586);
insert into COMMANDER (cid)
values (587);
insert into COMMANDER (cid)
values (588);
insert into COMMANDER (cid)
values (589);
insert into COMMANDER (cid)
values (590);
insert into COMMANDER (cid)
values (591);
insert into COMMANDER (cid)
values (592);
insert into COMMANDER (cid)
values (593);
insert into COMMANDER (cid)
values (594);
insert into COMMANDER (cid)
values (595);
insert into COMMANDER (cid)
values (596);
insert into COMMANDER (cid)
values (597);
insert into COMMANDER (cid)
values (598);
insert into COMMANDER (cid)
values (599);
insert into COMMANDER (cid)
values (600);
commit;
prompt 600 records loaded
prompt Loading CREWMATE...
insert into CREWMATE (type, crid, cid)
values ('Loader', 1705, 369);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1706, 369);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1707, 369);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1708, 370);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1709, 370);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1710, 370);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1711, 371);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1712, 371);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1713, 371);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1714, 372);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1715, 372);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1716, 372);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1717, 373);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1718, 373);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1719, 373);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1720, 374);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1721, 374);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1722, 374);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1723, 375);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1724, 375);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1725, 375);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1726, 376);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1727, 376);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1728, 376);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1729, 377);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1730, 377);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1731, 377);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1732, 378);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1733, 378);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1734, 378);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1735, 379);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1736, 379);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1737, 379);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1738, 380);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1739, 380);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1740, 380);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1741, 381);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1742, 381);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1743, 381);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1744, 382);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1745, 382);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1746, 382);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1747, 383);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1748, 383);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1749, 383);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1750, 384);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1751, 384);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1752, 384);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1753, 385);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1754, 385);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1755, 385);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1756, 386);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1757, 386);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1758, 386);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1759, 387);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1760, 387);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1761, 387);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1762, 388);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1763, 388);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1764, 388);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1765, 389);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1766, 389);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1767, 389);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1768, 390);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1769, 390);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1770, 390);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1771, 391);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1772, 391);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1773, 391);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1774, 392);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1775, 392);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1776, 392);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1777, 393);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1778, 393);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1779, 393);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1780, 394);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1781, 394);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1782, 394);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1783, 395);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1784, 395);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1785, 395);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1786, 396);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1787, 396);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1788, 396);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1789, 397);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1790, 397);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1791, 397);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1792, 398);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1793, 398);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1794, 398);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1795, 399);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1796, 399);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1797, 399);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1798, 400);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1799, 400);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1800, 400);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1801, 401);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1802, 401);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1803, 401);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1804, 402);
commit;
prompt 100 records committed...
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1805, 402);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1806, 402);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1807, 403);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1808, 403);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1809, 403);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1810, 404);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1811, 404);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1812, 404);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1813, 405);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1814, 405);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1815, 405);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1816, 406);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1817, 406);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1818, 406);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1819, 407);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1820, 407);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1821, 407);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1822, 408);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1823, 408);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1824, 408);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1825, 409);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1826, 409);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1827, 409);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1828, 410);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1829, 410);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1830, 410);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1831, 411);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1832, 411);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1833, 411);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1834, 412);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1835, 412);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1836, 412);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1837, 413);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1838, 413);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1839, 413);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1840, 414);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1841, 414);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1842, 414);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1843, 415);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1844, 415);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1845, 415);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1846, 416);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1847, 416);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1848, 416);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1849, 417);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1850, 417);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1851, 417);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1852, 418);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1853, 418);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1854, 418);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1855, 419);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1856, 419);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1857, 419);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1858, 420);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1859, 420);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1860, 420);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1861, 421);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1862, 421);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1863, 421);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1864, 422);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1865, 422);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1866, 422);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1867, 423);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1868, 423);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1869, 423);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1870, 424);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1871, 424);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1872, 424);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1873, 425);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1874, 425);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1875, 425);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1876, 426);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1877, 426);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1878, 426);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1879, 427);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1880, 427);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1881, 427);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1882, 428);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1883, 428);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1884, 428);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1885, 429);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1886, 429);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1887, 429);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1888, 430);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1889, 430);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1890, 430);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1891, 431);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1892, 431);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1893, 431);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1894, 432);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1895, 432);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1896, 432);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1897, 433);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1898, 433);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1899, 433);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1900, 434);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1901, 434);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1902, 434);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1903, 435);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1904, 435);
commit;
prompt 200 records committed...
insert into CREWMATE (type, crid, cid)
values ('Driver', 1905, 435);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1906, 436);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1907, 436);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1908, 436);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1909, 437);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1910, 437);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1911, 437);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1912, 438);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1913, 438);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1914, 438);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1915, 439);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1916, 439);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1917, 439);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1918, 440);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1919, 440);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1920, 440);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1921, 441);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1922, 441);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1923, 441);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1924, 442);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1925, 442);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1926, 442);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1927, 443);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1928, 443);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1929, 443);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1930, 444);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1931, 444);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1932, 444);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1933, 445);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1934, 445);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1935, 445);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1936, 446);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1937, 446);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1938, 446);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1939, 447);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1940, 447);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1941, 447);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1942, 448);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1943, 448);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1944, 448);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1945, 449);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1946, 449);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1947, 449);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1948, 450);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1949, 450);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1950, 450);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1951, 451);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1952, 451);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1953, 451);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1954, 452);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1955, 452);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1956, 452);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1957, 453);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1958, 453);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1959, 453);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1960, 454);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1961, 454);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1962, 454);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1963, 455);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1964, 455);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1965, 455);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1966, 456);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1967, 456);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1968, 456);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1969, 457);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1970, 457);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1971, 457);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1972, 458);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1973, 458);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1974, 458);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1975, 459);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1976, 459);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1977, 459);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1978, 460);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1979, 460);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1980, 460);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1981, 461);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1982, 461);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1983, 461);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1984, 462);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1985, 462);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1986, 462);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1987, 463);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1988, 463);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1989, 463);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1990, 464);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1991, 464);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1992, 464);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1993, 465);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1994, 465);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1995, 465);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1996, 466);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1997, 466);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1998, 466);
insert into CREWMATE (type, crid, cid)
values ('Loader', 979, 127);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 980, 127);
insert into CREWMATE (type, crid, cid)
values ('Driver', 981, 127);
insert into CREWMATE (type, crid, cid)
values ('Loader', 982, 128);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 983, 128);
insert into CREWMATE (type, crid, cid)
values ('Driver', 984, 128);
commit;
prompt 300 records committed...
insert into CREWMATE (type, crid, cid)
values ('Loader', 985, 129);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 986, 129);
insert into CREWMATE (type, crid, cid)
values ('Driver', 987, 129);
insert into CREWMATE (type, crid, cid)
values ('Loader', 988, 130);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 989, 130);
insert into CREWMATE (type, crid, cid)
values ('Driver', 990, 130);
insert into CREWMATE (type, crid, cid)
values ('Loader', 991, 131);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 992, 131);
insert into CREWMATE (type, crid, cid)
values ('Driver', 993, 131);
insert into CREWMATE (type, crid, cid)
values ('Loader', 994, 132);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 995, 132);
insert into CREWMATE (type, crid, cid)
values ('Driver', 996, 132);
insert into CREWMATE (type, crid, cid)
values ('Loader', 997, 133);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 998, 133);
insert into CREWMATE (type, crid, cid)
values ('Driver', 999, 133);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1000, 134);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1001, 134);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1002, 134);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1003, 135);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1004, 135);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1005, 135);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1006, 136);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1007, 136);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1008, 136);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1009, 137);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1010, 137);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1011, 137);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1012, 138);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1013, 138);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1014, 138);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1015, 139);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1016, 139);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1017, 139);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1018, 140);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1019, 140);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1020, 140);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1021, 141);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1022, 141);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1023, 141);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1024, 142);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1025, 142);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1026, 142);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1027, 143);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1028, 143);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1029, 143);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1030, 144);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1031, 144);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1032, 144);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1033, 145);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1034, 145);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1035, 145);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1036, 146);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1037, 146);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1038, 146);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1039, 147);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1040, 147);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1041, 147);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1042, 148);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1043, 148);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1044, 148);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1045, 149);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1046, 149);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1047, 149);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1048, 150);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1049, 150);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1050, 150);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1051, 151);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1052, 151);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1053, 151);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1054, 152);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1055, 152);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1056, 152);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1057, 153);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1058, 153);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1059, 153);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1060, 154);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1061, 154);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1062, 154);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1063, 155);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1064, 155);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1065, 155);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1066, 156);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1067, 156);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1068, 156);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1069, 157);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1070, 157);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1071, 157);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1072, 158);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1073, 158);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1074, 158);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1075, 159);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1076, 159);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1077, 159);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1078, 160);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1079, 160);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1080, 160);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1081, 161);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1082, 161);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1083, 161);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1084, 162);
commit;
prompt 400 records committed...
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1085, 162);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1086, 162);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1087, 163);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1088, 163);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1089, 163);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1090, 164);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1091, 164);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1092, 164);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1093, 165);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1094, 165);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1095, 165);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1096, 166);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1097, 166);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1098, 166);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1099, 167);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1100, 167);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1101, 167);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1102, 168);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1103, 168);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1104, 168);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1105, 169);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1106, 169);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1107, 169);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1108, 170);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1109, 170);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1110, 170);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1111, 171);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1112, 171);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1113, 171);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1114, 172);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1115, 172);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1116, 172);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1117, 173);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1118, 173);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1119, 173);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1120, 174);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1121, 174);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1122, 174);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1123, 175);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1124, 175);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1125, 175);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1126, 176);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1127, 176);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1128, 176);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1129, 177);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1130, 177);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1131, 177);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1132, 178);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1133, 178);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1134, 178);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1135, 179);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1136, 179);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1137, 179);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1138, 180);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1139, 180);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1140, 180);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1141, 181);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1142, 181);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1143, 181);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1144, 182);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1145, 182);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1146, 182);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1147, 183);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1148, 183);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1149, 183);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1150, 184);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1151, 184);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1152, 184);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1153, 185);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1154, 185);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1155, 185);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1156, 186);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1157, 186);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1158, 186);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1159, 187);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1160, 187);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1161, 187);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1162, 188);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1163, 188);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1164, 188);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1165, 189);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1166, 189);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1167, 189);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1168, 190);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1169, 190);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1170, 190);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1171, 191);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1172, 191);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1173, 191);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1174, 192);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1175, 192);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1176, 192);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1177, 193);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1178, 193);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1179, 193);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1180, 194);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1181, 194);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1182, 194);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1183, 195);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1184, 195);
commit;
prompt 500 records committed...
insert into CREWMATE (type, crid, cid)
values ('Driver', 1185, 195);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1186, 196);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1187, 196);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1188, 196);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1189, 197);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1190, 197);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1191, 197);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1192, 198);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1193, 198);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1194, 198);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1195, 199);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1196, 199);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1197, 199);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1198, 200);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1199, 200);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1200, 200);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1201, 201);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1202, 201);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1203, 201);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1204, 202);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1205, 202);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1206, 202);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1207, 203);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1208, 203);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1209, 203);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1210, 204);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1211, 204);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1212, 204);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1213, 205);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1214, 205);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1215, 205);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1216, 206);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1217, 206);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1218, 206);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1219, 207);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1220, 207);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1221, 207);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1222, 208);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1223, 208);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1224, 208);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1225, 209);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1226, 209);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1227, 209);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1228, 210);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1229, 210);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1230, 210);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1231, 211);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1232, 211);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1233, 211);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1234, 212);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1235, 212);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1236, 212);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1237, 213);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1238, 213);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1239, 213);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1240, 214);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1241, 214);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1242, 214);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1243, 215);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1244, 215);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1245, 215);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1246, 216);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1247, 216);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1248, 216);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1249, 217);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1250, 217);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1251, 217);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1252, 218);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1253, 218);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1254, 218);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1255, 219);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1256, 219);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1257, 219);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1258, 220);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1259, 220);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1260, 220);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1261, 221);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1262, 221);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1263, 221);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1264, 222);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1265, 222);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1266, 222);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1267, 223);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1268, 223);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1269, 223);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1270, 224);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1271, 224);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1272, 224);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1273, 225);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1274, 225);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1275, 225);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1276, 226);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1277, 226);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1278, 226);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1279, 227);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1280, 227);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1281, 227);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1282, 228);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1283, 228);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1284, 228);
commit;
prompt 600 records committed...
insert into CREWMATE (type, crid, cid)
values ('Loader', 1285, 229);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1286, 229);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1287, 229);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1288, 230);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1289, 230);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1290, 230);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1291, 231);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1292, 231);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1293, 231);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1294, 232);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1295, 232);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1296, 232);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1297, 233);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1298, 233);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1299, 233);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1300, 234);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1301, 234);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1302, 234);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1303, 235);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1304, 235);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1305, 235);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1306, 236);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1307, 236);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1308, 236);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1309, 237);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1310, 237);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1311, 237);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1312, 238);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1313, 238);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1314, 238);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1315, 239);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1316, 239);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1317, 239);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1318, 240);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1319, 240);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1320, 240);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1321, 241);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1322, 241);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1323, 241);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1324, 242);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1325, 242);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1326, 242);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1327, 243);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1328, 243);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1329, 243);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1330, 244);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1331, 244);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1332, 244);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1333, 245);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1334, 245);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1335, 245);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1336, 246);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1337, 246);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1338, 246);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1339, 247);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1340, 247);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1341, 247);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1342, 248);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1343, 248);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1344, 248);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1345, 249);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1346, 249);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1347, 249);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1348, 250);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1349, 250);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1350, 250);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1351, 251);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1352, 251);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1353, 251);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1354, 252);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1355, 252);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1356, 252);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1357, 253);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1358, 253);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1359, 253);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1360, 254);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1361, 254);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1362, 254);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1363, 255);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1364, 255);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1365, 255);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1366, 256);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1367, 256);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1368, 256);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1369, 257);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1370, 257);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1371, 257);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1372, 258);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1373, 258);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1374, 258);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1375, 259);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1376, 259);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1377, 259);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1378, 260);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1379, 260);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1380, 260);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1381, 261);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1382, 261);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1383, 261);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1384, 262);
commit;
prompt 700 records committed...
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1385, 262);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1386, 262);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1387, 263);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1388, 263);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1389, 263);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1390, 264);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1391, 264);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1392, 264);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1393, 265);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1394, 265);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1395, 265);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1396, 266);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1397, 266);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1398, 266);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1399, 267);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1400, 267);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1401, 267);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1402, 268);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1403, 268);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1404, 268);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1405, 269);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1406, 269);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1407, 269);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1408, 270);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1409, 270);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1410, 270);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1411, 271);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1412, 271);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1413, 271);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1414, 272);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1415, 272);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1416, 272);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1417, 273);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1418, 273);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1419, 273);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1420, 274);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1421, 274);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1422, 274);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1423, 275);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1424, 275);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1425, 275);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1426, 276);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1427, 276);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1428, 276);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1429, 277);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1430, 277);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1431, 277);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1432, 278);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1433, 278);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1434, 278);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1435, 279);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1436, 279);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1437, 279);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1438, 280);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1439, 280);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1440, 280);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1441, 281);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1442, 281);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1443, 281);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1444, 282);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1445, 282);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1446, 282);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1447, 283);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1448, 283);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1449, 283);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1450, 284);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1451, 284);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1452, 284);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1453, 285);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1454, 285);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1455, 285);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1456, 286);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1457, 286);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1458, 286);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1459, 287);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1460, 287);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1461, 287);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1462, 288);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1463, 288);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1464, 288);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1465, 289);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1466, 289);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1467, 289);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1468, 290);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1469, 290);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1470, 290);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1471, 291);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1472, 291);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1473, 291);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1474, 292);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1475, 292);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1476, 292);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1477, 293);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1478, 293);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1479, 293);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1480, 294);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1481, 294);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1482, 294);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1483, 295);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1484, 295);
commit;
prompt 800 records committed...
insert into CREWMATE (type, crid, cid)
values ('Driver', 1485, 295);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1486, 296);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1487, 296);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1488, 296);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1489, 297);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1490, 297);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1491, 297);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1492, 298);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1493, 298);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1494, 298);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1495, 299);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1496, 299);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1497, 299);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1498, 300);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1499, 300);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1500, 300);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1501, 301);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1502, 301);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1503, 301);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1504, 302);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1505, 302);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1506, 302);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1507, 303);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1508, 303);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1509, 303);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1510, 304);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1511, 304);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1512, 304);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1513, 305);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1514, 305);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1515, 305);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1516, 306);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1517, 306);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1518, 306);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1519, 307);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1520, 307);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1521, 307);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1522, 308);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1523, 308);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1524, 308);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1525, 309);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1526, 309);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1527, 309);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1528, 310);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1529, 310);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1530, 310);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1531, 311);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1532, 311);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1533, 311);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1534, 312);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1535, 312);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1536, 312);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1537, 313);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1538, 313);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1539, 313);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1540, 314);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1541, 314);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1542, 314);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1543, 315);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1544, 315);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1545, 315);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1546, 316);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1547, 316);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1548, 316);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1549, 317);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1550, 317);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1551, 317);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1552, 318);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1553, 318);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1554, 318);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1555, 319);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1556, 319);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1557, 319);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1558, 320);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1559, 320);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1560, 320);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1561, 321);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1562, 321);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1563, 321);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1564, 322);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1565, 322);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1566, 322);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1567, 323);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1568, 323);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1569, 323);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1570, 324);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1571, 324);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1572, 324);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1573, 325);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1574, 325);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1575, 325);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1576, 326);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1577, 326);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1578, 326);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1579, 327);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1580, 327);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1581, 327);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1582, 328);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1583, 328);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1584, 328);
commit;
prompt 900 records committed...
insert into CREWMATE (type, crid, cid)
values ('Loader', 1585, 329);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1586, 329);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1587, 329);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1588, 330);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1589, 330);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1590, 330);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1591, 331);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1592, 331);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1593, 331);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1594, 332);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1595, 332);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1596, 332);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1597, 333);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1598, 333);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1599, 333);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1600, 334);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1601, 334);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1602, 334);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1603, 335);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1604, 335);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1605, 335);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1606, 336);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1607, 336);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1608, 336);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1609, 337);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1610, 337);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1611, 337);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1612, 338);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1613, 338);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1614, 338);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1615, 339);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1616, 339);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1617, 339);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1618, 340);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1619, 340);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1620, 340);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1621, 341);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1622, 341);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1623, 341);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1624, 342);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1625, 342);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1626, 342);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1627, 343);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1628, 343);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1629, 343);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1630, 344);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1631, 344);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1632, 344);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1633, 345);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1634, 345);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1635, 345);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1636, 346);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1637, 346);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1638, 346);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1639, 347);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1640, 347);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1641, 347);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1642, 348);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1643, 348);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1644, 348);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1645, 349);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1646, 349);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1647, 349);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1648, 350);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1649, 350);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1650, 350);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1651, 351);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1652, 351);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1653, 351);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1654, 352);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1655, 352);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1656, 352);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1657, 353);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1658, 353);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1659, 353);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1660, 354);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1661, 354);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1662, 354);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1663, 355);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1664, 355);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1665, 355);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1666, 356);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1667, 356);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1668, 356);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1669, 357);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1670, 357);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1671, 357);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1672, 358);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1673, 358);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1674, 358);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1675, 359);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1676, 359);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1677, 359);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1678, 360);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1679, 360);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1680, 360);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1681, 361);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1682, 361);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1683, 361);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1684, 362);
commit;
prompt 1000 records committed...
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1685, 362);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1686, 362);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1687, 363);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1688, 363);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1689, 363);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1690, 364);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1691, 364);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1692, 364);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1693, 365);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1694, 365);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1695, 365);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1696, 366);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1697, 366);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1698, 366);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1699, 367);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1700, 367);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1701, 367);
insert into CREWMATE (type, crid, cid)
values ('Loader', 1702, 368);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 1703, 368);
insert into CREWMATE (type, crid, cid)
values ('Driver', 1704, 368);
insert into CREWMATE (type, crid, cid)
values ('Driver', 747, 49);
insert into CREWMATE (type, crid, cid)
values ('Loader', 748, 50);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 749, 50);
insert into CREWMATE (type, crid, cid)
values ('Driver', 750, 50);
insert into CREWMATE (type, crid, cid)
values ('Loader', 751, 51);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 752, 51);
insert into CREWMATE (type, crid, cid)
values ('Driver', 753, 51);
insert into CREWMATE (type, crid, cid)
values ('Loader', 754, 52);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 755, 52);
insert into CREWMATE (type, crid, cid)
values ('Driver', 756, 52);
insert into CREWMATE (type, crid, cid)
values ('Loader', 757, 53);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 758, 53);
insert into CREWMATE (type, crid, cid)
values ('Driver', 759, 53);
insert into CREWMATE (type, crid, cid)
values ('Loader', 760, 54);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 761, 54);
insert into CREWMATE (type, crid, cid)
values ('Driver', 762, 54);
insert into CREWMATE (type, crid, cid)
values ('Loader', 763, 55);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 764, 55);
insert into CREWMATE (type, crid, cid)
values ('Driver', 765, 55);
insert into CREWMATE (type, crid, cid)
values ('Loader', 766, 56);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 767, 56);
insert into CREWMATE (type, crid, cid)
values ('Driver', 768, 56);
insert into CREWMATE (type, crid, cid)
values ('Loader', 769, 57);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 770, 57);
insert into CREWMATE (type, crid, cid)
values ('Driver', 771, 57);
insert into CREWMATE (type, crid, cid)
values ('Loader', 772, 58);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 773, 58);
insert into CREWMATE (type, crid, cid)
values ('Driver', 774, 58);
insert into CREWMATE (type, crid, cid)
values ('Loader', 775, 59);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 776, 59);
insert into CREWMATE (type, crid, cid)
values ('Driver', 777, 59);
insert into CREWMATE (type, crid, cid)
values ('Loader', 778, 60);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 779, 60);
insert into CREWMATE (type, crid, cid)
values ('Driver', 780, 60);
insert into CREWMATE (type, crid, cid)
values ('Loader', 781, 61);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 782, 61);
insert into CREWMATE (type, crid, cid)
values ('Driver', 783, 61);
insert into CREWMATE (type, crid, cid)
values ('Loader', 784, 62);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 785, 62);
insert into CREWMATE (type, crid, cid)
values ('Driver', 786, 62);
insert into CREWMATE (type, crid, cid)
values ('Loader', 787, 63);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 788, 63);
insert into CREWMATE (type, crid, cid)
values ('Driver', 789, 63);
insert into CREWMATE (type, crid, cid)
values ('Loader', 790, 64);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 791, 64);
insert into CREWMATE (type, crid, cid)
values ('Driver', 792, 64);
insert into CREWMATE (type, crid, cid)
values ('Loader', 793, 65);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 794, 65);
insert into CREWMATE (type, crid, cid)
values ('Driver', 795, 65);
insert into CREWMATE (type, crid, cid)
values ('Loader', 796, 66);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 797, 66);
insert into CREWMATE (type, crid, cid)
values ('Driver', 798, 66);
insert into CREWMATE (type, crid, cid)
values ('Loader', 799, 67);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 800, 67);
insert into CREWMATE (type, crid, cid)
values ('Driver', 801, 67);
insert into CREWMATE (type, crid, cid)
values ('Loader', 802, 68);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 803, 68);
insert into CREWMATE (type, crid, cid)
values ('Driver', 804, 68);
insert into CREWMATE (type, crid, cid)
values ('Loader', 805, 69);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 806, 69);
insert into CREWMATE (type, crid, cid)
values ('Driver', 807, 69);
insert into CREWMATE (type, crid, cid)
values ('Loader', 808, 70);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 809, 70);
insert into CREWMATE (type, crid, cid)
values ('Driver', 810, 70);
insert into CREWMATE (type, crid, cid)
values ('Loader', 811, 71);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 812, 71);
insert into CREWMATE (type, crid, cid)
values ('Driver', 813, 71);
insert into CREWMATE (type, crid, cid)
values ('Loader', 814, 72);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 815, 72);
insert into CREWMATE (type, crid, cid)
values ('Driver', 816, 72);
insert into CREWMATE (type, crid, cid)
values ('Loader', 817, 73);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 818, 73);
insert into CREWMATE (type, crid, cid)
values ('Driver', 819, 73);
insert into CREWMATE (type, crid, cid)
values ('Loader', 820, 74);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 821, 74);
insert into CREWMATE (type, crid, cid)
values ('Driver', 822, 74);
insert into CREWMATE (type, crid, cid)
values ('Loader', 823, 75);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 824, 75);
insert into CREWMATE (type, crid, cid)
values ('Driver', 825, 75);
insert into CREWMATE (type, crid, cid)
values ('Loader', 826, 76);
commit;
prompt 1100 records committed...
insert into CREWMATE (type, crid, cid)
values ('Gunner', 827, 76);
insert into CREWMATE (type, crid, cid)
values ('Driver', 828, 76);
insert into CREWMATE (type, crid, cid)
values ('Loader', 829, 77);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 830, 77);
insert into CREWMATE (type, crid, cid)
values ('Driver', 831, 77);
insert into CREWMATE (type, crid, cid)
values ('Loader', 832, 78);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 833, 78);
insert into CREWMATE (type, crid, cid)
values ('Driver', 834, 78);
insert into CREWMATE (type, crid, cid)
values ('Loader', 835, 79);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 836, 79);
insert into CREWMATE (type, crid, cid)
values ('Driver', 837, 79);
insert into CREWMATE (type, crid, cid)
values ('Loader', 838, 80);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 839, 80);
insert into CREWMATE (type, crid, cid)
values ('Driver', 840, 80);
insert into CREWMATE (type, crid, cid)
values ('Loader', 841, 81);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 842, 81);
insert into CREWMATE (type, crid, cid)
values ('Driver', 843, 81);
insert into CREWMATE (type, crid, cid)
values ('Loader', 844, 82);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 845, 82);
insert into CREWMATE (type, crid, cid)
values ('Driver', 846, 82);
insert into CREWMATE (type, crid, cid)
values ('Loader', 847, 83);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 848, 83);
insert into CREWMATE (type, crid, cid)
values ('Driver', 849, 83);
insert into CREWMATE (type, crid, cid)
values ('Loader', 850, 84);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 851, 84);
insert into CREWMATE (type, crid, cid)
values ('Driver', 852, 84);
insert into CREWMATE (type, crid, cid)
values ('Loader', 853, 85);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 854, 85);
insert into CREWMATE (type, crid, cid)
values ('Driver', 855, 85);
insert into CREWMATE (type, crid, cid)
values ('Loader', 856, 86);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 857, 86);
insert into CREWMATE (type, crid, cid)
values ('Driver', 858, 86);
insert into CREWMATE (type, crid, cid)
values ('Loader', 859, 87);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 860, 87);
insert into CREWMATE (type, crid, cid)
values ('Driver', 861, 87);
insert into CREWMATE (type, crid, cid)
values ('Loader', 862, 88);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 863, 88);
insert into CREWMATE (type, crid, cid)
values ('Driver', 864, 88);
insert into CREWMATE (type, crid, cid)
values ('Loader', 865, 89);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 866, 89);
insert into CREWMATE (type, crid, cid)
values ('Driver', 867, 89);
insert into CREWMATE (type, crid, cid)
values ('Loader', 868, 90);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 869, 90);
insert into CREWMATE (type, crid, cid)
values ('Driver', 870, 90);
insert into CREWMATE (type, crid, cid)
values ('Loader', 871, 91);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 872, 91);
insert into CREWMATE (type, crid, cid)
values ('Driver', 873, 91);
insert into CREWMATE (type, crid, cid)
values ('Loader', 874, 92);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 875, 92);
insert into CREWMATE (type, crid, cid)
values ('Driver', 876, 92);
insert into CREWMATE (type, crid, cid)
values ('Loader', 877, 93);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 878, 93);
insert into CREWMATE (type, crid, cid)
values ('Driver', 879, 93);
insert into CREWMATE (type, crid, cid)
values ('Loader', 880, 94);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 881, 94);
insert into CREWMATE (type, crid, cid)
values ('Driver', 882, 94);
insert into CREWMATE (type, crid, cid)
values ('Loader', 883, 95);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 884, 95);
insert into CREWMATE (type, crid, cid)
values ('Driver', 885, 95);
insert into CREWMATE (type, crid, cid)
values ('Loader', 886, 96);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 887, 96);
insert into CREWMATE (type, crid, cid)
values ('Driver', 888, 96);
insert into CREWMATE (type, crid, cid)
values ('Loader', 889, 97);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 890, 97);
insert into CREWMATE (type, crid, cid)
values ('Driver', 891, 97);
insert into CREWMATE (type, crid, cid)
values ('Loader', 892, 98);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 893, 98);
insert into CREWMATE (type, crid, cid)
values ('Driver', 894, 98);
insert into CREWMATE (type, crid, cid)
values ('Loader', 895, 99);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 896, 99);
insert into CREWMATE (type, crid, cid)
values ('Driver', 897, 99);
insert into CREWMATE (type, crid, cid)
values ('Loader', 898, 100);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 899, 100);
insert into CREWMATE (type, crid, cid)
values ('Driver', 900, 100);
insert into CREWMATE (type, crid, cid)
values ('Loader', 901, 101);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 902, 101);
insert into CREWMATE (type, crid, cid)
values ('Driver', 903, 101);
insert into CREWMATE (type, crid, cid)
values ('Loader', 904, 102);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 905, 102);
insert into CREWMATE (type, crid, cid)
values ('Driver', 906, 102);
insert into CREWMATE (type, crid, cid)
values ('Loader', 907, 103);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 908, 103);
insert into CREWMATE (type, crid, cid)
values ('Driver', 909, 103);
insert into CREWMATE (type, crid, cid)
values ('Loader', 910, 104);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 911, 104);
insert into CREWMATE (type, crid, cid)
values ('Driver', 912, 104);
insert into CREWMATE (type, crid, cid)
values ('Loader', 913, 105);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 914, 105);
insert into CREWMATE (type, crid, cid)
values ('Driver', 915, 105);
insert into CREWMATE (type, crid, cid)
values ('Loader', 916, 106);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 917, 106);
insert into CREWMATE (type, crid, cid)
values ('Driver', 918, 106);
insert into CREWMATE (type, crid, cid)
values ('Loader', 919, 107);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 920, 107);
insert into CREWMATE (type, crid, cid)
values ('Driver', 921, 107);
insert into CREWMATE (type, crid, cid)
values ('Loader', 922, 108);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 923, 108);
insert into CREWMATE (type, crid, cid)
values ('Driver', 924, 108);
insert into CREWMATE (type, crid, cid)
values ('Loader', 925, 109);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 926, 109);
commit;
prompt 1200 records committed...
insert into CREWMATE (type, crid, cid)
values ('Driver', 927, 109);
insert into CREWMATE (type, crid, cid)
values ('Loader', 928, 110);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 929, 110);
insert into CREWMATE (type, crid, cid)
values ('Driver', 930, 110);
insert into CREWMATE (type, crid, cid)
values ('Loader', 931, 111);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 932, 111);
insert into CREWMATE (type, crid, cid)
values ('Driver', 933, 111);
insert into CREWMATE (type, crid, cid)
values ('Loader', 934, 112);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 935, 112);
insert into CREWMATE (type, crid, cid)
values ('Driver', 936, 112);
insert into CREWMATE (type, crid, cid)
values ('Loader', 937, 113);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 938, 113);
insert into CREWMATE (type, crid, cid)
values ('Driver', 939, 113);
insert into CREWMATE (type, crid, cid)
values ('Loader', 940, 114);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 941, 114);
insert into CREWMATE (type, crid, cid)
values ('Driver', 942, 114);
insert into CREWMATE (type, crid, cid)
values ('Loader', 943, 115);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 944, 115);
insert into CREWMATE (type, crid, cid)
values ('Driver', 945, 115);
insert into CREWMATE (type, crid, cid)
values ('Loader', 946, 116);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 947, 116);
insert into CREWMATE (type, crid, cid)
values ('Driver', 948, 116);
insert into CREWMATE (type, crid, cid)
values ('Loader', 949, 117);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 950, 117);
insert into CREWMATE (type, crid, cid)
values ('Driver', 951, 117);
insert into CREWMATE (type, crid, cid)
values ('Loader', 952, 118);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 953, 118);
insert into CREWMATE (type, crid, cid)
values ('Driver', 954, 118);
insert into CREWMATE (type, crid, cid)
values ('Loader', 955, 119);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 956, 119);
insert into CREWMATE (type, crid, cid)
values ('Driver', 957, 119);
insert into CREWMATE (type, crid, cid)
values ('Loader', 958, 120);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 959, 120);
insert into CREWMATE (type, crid, cid)
values ('Driver', 960, 120);
insert into CREWMATE (type, crid, cid)
values ('Loader', 961, 121);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 962, 121);
insert into CREWMATE (type, crid, cid)
values ('Driver', 963, 121);
insert into CREWMATE (type, crid, cid)
values ('Loader', 964, 122);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 965, 122);
insert into CREWMATE (type, crid, cid)
values ('Driver', 966, 122);
insert into CREWMATE (type, crid, cid)
values ('Loader', 967, 123);
insert into CREWMATE (type, crid, cid)
values ('Loader', 601, 1);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 602, 1);
insert into CREWMATE (type, crid, cid)
values ('Driver', 603, 1);
insert into CREWMATE (type, crid, cid)
values ('Loader', 604, 2);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 605, 2);
insert into CREWMATE (type, crid, cid)
values ('Driver', 606, 2);
insert into CREWMATE (type, crid, cid)
values ('Loader', 607, 3);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 608, 3);
insert into CREWMATE (type, crid, cid)
values ('Driver', 609, 3);
insert into CREWMATE (type, crid, cid)
values ('Loader', 610, 4);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 611, 4);
insert into CREWMATE (type, crid, cid)
values ('Driver', 612, 4);
insert into CREWMATE (type, crid, cid)
values ('Loader', 613, 5);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 614, 5);
insert into CREWMATE (type, crid, cid)
values ('Driver', 615, 5);
insert into CREWMATE (type, crid, cid)
values ('Loader', 616, 6);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 617, 6);
insert into CREWMATE (type, crid, cid)
values ('Driver', 618, 6);
insert into CREWMATE (type, crid, cid)
values ('Loader', 619, 7);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 620, 7);
insert into CREWMATE (type, crid, cid)
values ('Driver', 621, 7);
insert into CREWMATE (type, crid, cid)
values ('Loader', 622, 8);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 623, 8);
insert into CREWMATE (type, crid, cid)
values ('Driver', 624, 8);
insert into CREWMATE (type, crid, cid)
values ('Loader', 625, 9);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 626, 9);
insert into CREWMATE (type, crid, cid)
values ('Driver', 627, 9);
insert into CREWMATE (type, crid, cid)
values ('Loader', 628, 10);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 629, 10);
insert into CREWMATE (type, crid, cid)
values ('Driver', 630, 10);
insert into CREWMATE (type, crid, cid)
values ('Loader', 631, 11);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 632, 11);
insert into CREWMATE (type, crid, cid)
values ('Driver', 633, 11);
insert into CREWMATE (type, crid, cid)
values ('Loader', 634, 12);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 635, 12);
insert into CREWMATE (type, crid, cid)
values ('Driver', 636, 12);
insert into CREWMATE (type, crid, cid)
values ('Loader', 637, 13);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 638, 13);
insert into CREWMATE (type, crid, cid)
values ('Driver', 639, 13);
insert into CREWMATE (type, crid, cid)
values ('Loader', 640, 14);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 641, 14);
insert into CREWMATE (type, crid, cid)
values ('Driver', 642, 14);
insert into CREWMATE (type, crid, cid)
values ('Loader', 643, 15);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 644, 15);
insert into CREWMATE (type, crid, cid)
values ('Driver', 645, 15);
insert into CREWMATE (type, crid, cid)
values ('Loader', 646, 16);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 647, 16);
insert into CREWMATE (type, crid, cid)
values ('Driver', 648, 16);
insert into CREWMATE (type, crid, cid)
values ('Loader', 649, 17);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 650, 17);
insert into CREWMATE (type, crid, cid)
values ('Driver', 651, 17);
insert into CREWMATE (type, crid, cid)
values ('Loader', 652, 18);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 653, 18);
insert into CREWMATE (type, crid, cid)
values ('Driver', 654, 18);
insert into CREWMATE (type, crid, cid)
values ('Loader', 655, 19);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 656, 19);
insert into CREWMATE (type, crid, cid)
values ('Driver', 657, 19);
insert into CREWMATE (type, crid, cid)
values ('Loader', 658, 20);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 659, 20);
commit;
prompt 1300 records committed...
insert into CREWMATE (type, crid, cid)
values ('Driver', 660, 20);
insert into CREWMATE (type, crid, cid)
values ('Loader', 661, 21);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 662, 21);
insert into CREWMATE (type, crid, cid)
values ('Driver', 663, 21);
insert into CREWMATE (type, crid, cid)
values ('Loader', 664, 22);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 665, 22);
insert into CREWMATE (type, crid, cid)
values ('Driver', 666, 22);
insert into CREWMATE (type, crid, cid)
values ('Loader', 667, 23);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 668, 23);
insert into CREWMATE (type, crid, cid)
values ('Driver', 669, 23);
insert into CREWMATE (type, crid, cid)
values ('Loader', 670, 24);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 671, 24);
insert into CREWMATE (type, crid, cid)
values ('Driver', 672, 24);
insert into CREWMATE (type, crid, cid)
values ('Loader', 673, 25);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 674, 25);
insert into CREWMATE (type, crid, cid)
values ('Driver', 675, 25);
insert into CREWMATE (type, crid, cid)
values ('Loader', 676, 26);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 677, 26);
insert into CREWMATE (type, crid, cid)
values ('Driver', 678, 26);
insert into CREWMATE (type, crid, cid)
values ('Loader', 679, 27);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 680, 27);
insert into CREWMATE (type, crid, cid)
values ('Driver', 681, 27);
insert into CREWMATE (type, crid, cid)
values ('Loader', 682, 28);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 683, 28);
insert into CREWMATE (type, crid, cid)
values ('Driver', 684, 28);
insert into CREWMATE (type, crid, cid)
values ('Loader', 685, 29);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 686, 29);
insert into CREWMATE (type, crid, cid)
values ('Driver', 687, 29);
insert into CREWMATE (type, crid, cid)
values ('Loader', 688, 30);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 689, 30);
insert into CREWMATE (type, crid, cid)
values ('Driver', 690, 30);
insert into CREWMATE (type, crid, cid)
values ('Loader', 691, 31);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 692, 31);
insert into CREWMATE (type, crid, cid)
values ('Driver', 693, 31);
insert into CREWMATE (type, crid, cid)
values ('Loader', 694, 32);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 695, 32);
insert into CREWMATE (type, crid, cid)
values ('Driver', 696, 32);
insert into CREWMATE (type, crid, cid)
values ('Loader', 697, 33);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 698, 33);
insert into CREWMATE (type, crid, cid)
values ('Driver', 699, 33);
insert into CREWMATE (type, crid, cid)
values ('Loader', 700, 34);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 701, 34);
insert into CREWMATE (type, crid, cid)
values ('Driver', 702, 34);
insert into CREWMATE (type, crid, cid)
values ('Loader', 703, 35);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 704, 35);
insert into CREWMATE (type, crid, cid)
values ('Driver', 705, 35);
insert into CREWMATE (type, crid, cid)
values ('Loader', 706, 36);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 707, 36);
insert into CREWMATE (type, crid, cid)
values ('Driver', 708, 36);
insert into CREWMATE (type, crid, cid)
values ('Loader', 709, 37);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 710, 37);
insert into CREWMATE (type, crid, cid)
values ('Driver', 711, 37);
insert into CREWMATE (type, crid, cid)
values ('Loader', 712, 38);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 713, 38);
insert into CREWMATE (type, crid, cid)
values ('Driver', 714, 38);
insert into CREWMATE (type, crid, cid)
values ('Loader', 715, 39);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 716, 39);
insert into CREWMATE (type, crid, cid)
values ('Driver', 717, 39);
insert into CREWMATE (type, crid, cid)
values ('Loader', 718, 40);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 719, 40);
insert into CREWMATE (type, crid, cid)
values ('Driver', 720, 40);
insert into CREWMATE (type, crid, cid)
values ('Loader', 721, 41);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 722, 41);
insert into CREWMATE (type, crid, cid)
values ('Driver', 723, 41);
insert into CREWMATE (type, crid, cid)
values ('Loader', 724, 42);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 725, 42);
insert into CREWMATE (type, crid, cid)
values ('Driver', 726, 42);
insert into CREWMATE (type, crid, cid)
values ('Loader', 727, 43);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 728, 43);
insert into CREWMATE (type, crid, cid)
values ('Driver', 729, 43);
insert into CREWMATE (type, crid, cid)
values ('Loader', 730, 44);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 731, 44);
insert into CREWMATE (type, crid, cid)
values ('Driver', 732, 44);
insert into CREWMATE (type, crid, cid)
values ('Loader', 733, 45);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 734, 45);
insert into CREWMATE (type, crid, cid)
values ('Driver', 735, 45);
insert into CREWMATE (type, crid, cid)
values ('Loader', 736, 46);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 737, 46);
insert into CREWMATE (type, crid, cid)
values ('Driver', 738, 46);
insert into CREWMATE (type, crid, cid)
values ('Loader', 739, 47);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 740, 47);
insert into CREWMATE (type, crid, cid)
values ('Driver', 741, 47);
insert into CREWMATE (type, crid, cid)
values ('Loader', 742, 48);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 743, 48);
insert into CREWMATE (type, crid, cid)
values ('Driver', 744, 48);
insert into CREWMATE (type, crid, cid)
values ('Loader', 745, 49);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 746, 49);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 968, 123);
insert into CREWMATE (type, crid, cid)
values ('Driver', 969, 123);
insert into CREWMATE (type, crid, cid)
values ('Loader', 970, 124);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 971, 124);
insert into CREWMATE (type, crid, cid)
values ('Driver', 972, 124);
insert into CREWMATE (type, crid, cid)
values ('Loader', 973, 125);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 974, 125);
insert into CREWMATE (type, crid, cid)
values ('Driver', 975, 125);
insert into CREWMATE (type, crid, cid)
values ('Loader', 976, 126);
insert into CREWMATE (type, crid, cid)
values ('Gunner', 977, 126);
insert into CREWMATE (type, crid, cid)
values ('Driver', 978, 126);
commit;
prompt 1398 records loaded
prompt Loading MISSION...
insert into MISSION (mdate, mid)
values (to_date('23-09-1993', 'dd-mm-yyyy'), 1716);
insert into MISSION (mdate, mid)
values (to_date('27-03-2009', 'dd-mm-yyyy'), 1717);
insert into MISSION (mdate, mid)
values (to_date('15-02-1998', 'dd-mm-yyyy'), 1718);
insert into MISSION (mdate, mid)
values (to_date('29-11-1997', 'dd-mm-yyyy'), 1719);
insert into MISSION (mdate, mid)
values (to_date('12-10-2002', 'dd-mm-yyyy'), 1720);
insert into MISSION (mdate, mid)
values (to_date('20-11-1997', 'dd-mm-yyyy'), 1721);
insert into MISSION (mdate, mid)
values (to_date('28-02-2003', 'dd-mm-yyyy'), 1722);
insert into MISSION (mdate, mid)
values (to_date('13-12-2009', 'dd-mm-yyyy'), 1723);
insert into MISSION (mdate, mid)
values (to_date('16-01-2004', 'dd-mm-yyyy'), 1724);
insert into MISSION (mdate, mid)
values (to_date('26-07-2007', 'dd-mm-yyyy'), 1725);
insert into MISSION (mdate, mid)
values (to_date('09-06-2007', 'dd-mm-yyyy'), 1726);
insert into MISSION (mdate, mid)
values (to_date('22-09-2000', 'dd-mm-yyyy'), 1727);
insert into MISSION (mdate, mid)
values (to_date('05-10-1995', 'dd-mm-yyyy'), 1728);
insert into MISSION (mdate, mid)
values (to_date('16-09-2020', 'dd-mm-yyyy'), 1729);
insert into MISSION (mdate, mid)
values (to_date('09-11-2002', 'dd-mm-yyyy'), 1730);
insert into MISSION (mdate, mid)
values (to_date('06-02-1990', 'dd-mm-yyyy'), 1731);
insert into MISSION (mdate, mid)
values (to_date('23-09-2007', 'dd-mm-yyyy'), 1732);
insert into MISSION (mdate, mid)
values (to_date('04-08-1995', 'dd-mm-yyyy'), 1733);
insert into MISSION (mdate, mid)
values (to_date('01-02-2007', 'dd-mm-yyyy'), 1734);
insert into MISSION (mdate, mid)
values (to_date('06-08-2001', 'dd-mm-yyyy'), 1735);
insert into MISSION (mdate, mid)
values (to_date('05-04-1990', 'dd-mm-yyyy'), 1736);
insert into MISSION (mdate, mid)
values (to_date('12-11-1993', 'dd-mm-yyyy'), 1737);
insert into MISSION (mdate, mid)
values (to_date('03-09-2022', 'dd-mm-yyyy'), 1738);
insert into MISSION (mdate, mid)
values (to_date('28-02-1996', 'dd-mm-yyyy'), 1739);
insert into MISSION (mdate, mid)
values (to_date('23-10-2008', 'dd-mm-yyyy'), 1740);
insert into MISSION (mdate, mid)
values (to_date('07-06-2021', 'dd-mm-yyyy'), 1741);
insert into MISSION (mdate, mid)
values (to_date('16-11-2014', 'dd-mm-yyyy'), 1742);
insert into MISSION (mdate, mid)
values (to_date('28-06-1998', 'dd-mm-yyyy'), 1743);
insert into MISSION (mdate, mid)
values (to_date('23-09-2015', 'dd-mm-yyyy'), 1744);
insert into MISSION (mdate, mid)
values (to_date('17-10-1998', 'dd-mm-yyyy'), 1745);
insert into MISSION (mdate, mid)
values (to_date('09-10-2008', 'dd-mm-yyyy'), 1746);
insert into MISSION (mdate, mid)
values (to_date('12-10-1994', 'dd-mm-yyyy'), 1747);
insert into MISSION (mdate, mid)
values (to_date('24-09-1996', 'dd-mm-yyyy'), 1748);
insert into MISSION (mdate, mid)
values (to_date('03-03-2021', 'dd-mm-yyyy'), 1749);
insert into MISSION (mdate, mid)
values (to_date('05-06-2018', 'dd-mm-yyyy'), 1750);
insert into MISSION (mdate, mid)
values (to_date('29-09-2013', 'dd-mm-yyyy'), 1751);
insert into MISSION (mdate, mid)
values (to_date('02-02-2011', 'dd-mm-yyyy'), 1752);
insert into MISSION (mdate, mid)
values (to_date('04-02-2021', 'dd-mm-yyyy'), 1753);
insert into MISSION (mdate, mid)
values (to_date('09-03-1991', 'dd-mm-yyyy'), 1754);
insert into MISSION (mdate, mid)
values (to_date('01-04-2019', 'dd-mm-yyyy'), 1755);
insert into MISSION (mdate, mid)
values (to_date('26-08-2015', 'dd-mm-yyyy'), 1756);
insert into MISSION (mdate, mid)
values (to_date('04-04-2000', 'dd-mm-yyyy'), 1757);
insert into MISSION (mdate, mid)
values (to_date('10-05-1991', 'dd-mm-yyyy'), 1758);
insert into MISSION (mdate, mid)
values (to_date('22-12-2009', 'dd-mm-yyyy'), 1759);
insert into MISSION (mdate, mid)
values (to_date('03-03-1998', 'dd-mm-yyyy'), 1760);
insert into MISSION (mdate, mid)
values (to_date('30-09-1992', 'dd-mm-yyyy'), 1761);
insert into MISSION (mdate, mid)
values (to_date('18-11-1997', 'dd-mm-yyyy'), 1762);
insert into MISSION (mdate, mid)
values (to_date('25-11-2003', 'dd-mm-yyyy'), 1763);
insert into MISSION (mdate, mid)
values (to_date('17-07-1996', 'dd-mm-yyyy'), 1764);
insert into MISSION (mdate, mid)
values (to_date('17-01-2019', 'dd-mm-yyyy'), 1765);
insert into MISSION (mdate, mid)
values (to_date('01-10-2018', 'dd-mm-yyyy'), 1766);
insert into MISSION (mdate, mid)
values (to_date('09-07-2022', 'dd-mm-yyyy'), 1767);
insert into MISSION (mdate, mid)
values (to_date('20-12-2017', 'dd-mm-yyyy'), 1768);
insert into MISSION (mdate, mid)
values (to_date('20-05-2001', 'dd-mm-yyyy'), 1769);
insert into MISSION (mdate, mid)
values (to_date('09-03-2012', 'dd-mm-yyyy'), 1770);
insert into MISSION (mdate, mid)
values (to_date('08-02-2000', 'dd-mm-yyyy'), 1771);
insert into MISSION (mdate, mid)
values (to_date('10-02-2012', 'dd-mm-yyyy'), 1772);
insert into MISSION (mdate, mid)
values (to_date('26-04-2015', 'dd-mm-yyyy'), 1773);
insert into MISSION (mdate, mid)
values (to_date('28-12-2003', 'dd-mm-yyyy'), 1774);
insert into MISSION (mdate, mid)
values (to_date('11-06-2013', 'dd-mm-yyyy'), 1775);
insert into MISSION (mdate, mid)
values (to_date('25-09-1994', 'dd-mm-yyyy'), 1776);
insert into MISSION (mdate, mid)
values (to_date('19-08-2006', 'dd-mm-yyyy'), 1777);
insert into MISSION (mdate, mid)
values (to_date('21-06-2006', 'dd-mm-yyyy'), 1778);
insert into MISSION (mdate, mid)
values (to_date('22-10-2014', 'dd-mm-yyyy'), 1779);
insert into MISSION (mdate, mid)
values (to_date('01-07-1997', 'dd-mm-yyyy'), 1780);
insert into MISSION (mdate, mid)
values (to_date('06-12-1991', 'dd-mm-yyyy'), 1781);
insert into MISSION (mdate, mid)
values (to_date('09-11-2012', 'dd-mm-yyyy'), 1782);
insert into MISSION (mdate, mid)
values (to_date('18-02-2008', 'dd-mm-yyyy'), 1783);
insert into MISSION (mdate, mid)
values (to_date('22-10-2022', 'dd-mm-yyyy'), 1784);
insert into MISSION (mdate, mid)
values (to_date('11-07-2020', 'dd-mm-yyyy'), 1785);
insert into MISSION (mdate, mid)
values (to_date('08-03-2019', 'dd-mm-yyyy'), 1786);
insert into MISSION (mdate, mid)
values (to_date('23-08-1999', 'dd-mm-yyyy'), 1787);
insert into MISSION (mdate, mid)
values (to_date('07-11-1992', 'dd-mm-yyyy'), 1788);
insert into MISSION (mdate, mid)
values (to_date('30-06-2008', 'dd-mm-yyyy'), 1789);
insert into MISSION (mdate, mid)
values (to_date('14-12-2000', 'dd-mm-yyyy'), 1790);
insert into MISSION (mdate, mid)
values (to_date('31-05-2019', 'dd-mm-yyyy'), 1791);
insert into MISSION (mdate, mid)
values (to_date('13-05-2020', 'dd-mm-yyyy'), 1792);
insert into MISSION (mdate, mid)
values (to_date('22-12-1992', 'dd-mm-yyyy'), 1793);
insert into MISSION (mdate, mid)
values (to_date('05-03-2011', 'dd-mm-yyyy'), 1794);
insert into MISSION (mdate, mid)
values (to_date('04-08-1990', 'dd-mm-yyyy'), 1795);
insert into MISSION (mdate, mid)
values (to_date('24-08-2016', 'dd-mm-yyyy'), 1796);
insert into MISSION (mdate, mid)
values (to_date('14-02-2010', 'dd-mm-yyyy'), 1797);
insert into MISSION (mdate, mid)
values (to_date('15-06-2013', 'dd-mm-yyyy'), 1798);
insert into MISSION (mdate, mid)
values (to_date('08-04-1990', 'dd-mm-yyyy'), 1799);
insert into MISSION (mdate, mid)
values (to_date('20-11-2003', 'dd-mm-yyyy'), 1800);
insert into MISSION (mdate, mid)
values (to_date('10-04-1996', 'dd-mm-yyyy'), 1801);
insert into MISSION (mdate, mid)
values (to_date('10-05-1996', 'dd-mm-yyyy'), 1802);
insert into MISSION (mdate, mid)
values (to_date('25-03-2002', 'dd-mm-yyyy'), 1803);
insert into MISSION (mdate, mid)
values (to_date('10-11-1998', 'dd-mm-yyyy'), 1804);
insert into MISSION (mdate, mid)
values (to_date('25-03-2021', 'dd-mm-yyyy'), 1805);
insert into MISSION (mdate, mid)
values (to_date('26-02-1999', 'dd-mm-yyyy'), 1806);
insert into MISSION (mdate, mid)
values (to_date('03-02-2019', 'dd-mm-yyyy'), 1807);
insert into MISSION (mdate, mid)
values (to_date('30-06-1993', 'dd-mm-yyyy'), 1808);
insert into MISSION (mdate, mid)
values (to_date('19-09-2015', 'dd-mm-yyyy'), 1809);
insert into MISSION (mdate, mid)
values (to_date('27-08-2017', 'dd-mm-yyyy'), 1810);
insert into MISSION (mdate, mid)
values (to_date('08-07-2006', 'dd-mm-yyyy'), 1811);
insert into MISSION (mdate, mid)
values (to_date('09-12-2004', 'dd-mm-yyyy'), 1812);
insert into MISSION (mdate, mid)
values (to_date('06-06-2011', 'dd-mm-yyyy'), 1813);
insert into MISSION (mdate, mid)
values (to_date('30-10-1997', 'dd-mm-yyyy'), 1814);
insert into MISSION (mdate, mid)
values (to_date('11-07-2009', 'dd-mm-yyyy'), 1815);
commit;
prompt 100 records committed...
insert into MISSION (mdate, mid)
values (to_date('27-01-2011', 'dd-mm-yyyy'), 1816);
insert into MISSION (mdate, mid)
values (to_date('28-03-2006', 'dd-mm-yyyy'), 1817);
insert into MISSION (mdate, mid)
values (to_date('13-04-2001', 'dd-mm-yyyy'), 1818);
insert into MISSION (mdate, mid)
values (to_date('23-02-1996', 'dd-mm-yyyy'), 1819);
insert into MISSION (mdate, mid)
values (to_date('09-08-1991', 'dd-mm-yyyy'), 1820);
insert into MISSION (mdate, mid)
values (to_date('10-06-1994', 'dd-mm-yyyy'), 1821);
insert into MISSION (mdate, mid)
values (to_date('04-12-2007', 'dd-mm-yyyy'), 1822);
insert into MISSION (mdate, mid)
values (to_date('01-11-1998', 'dd-mm-yyyy'), 1823);
insert into MISSION (mdate, mid)
values (to_date('21-03-2006', 'dd-mm-yyyy'), 1824);
insert into MISSION (mdate, mid)
values (to_date('18-02-2017', 'dd-mm-yyyy'), 1825);
insert into MISSION (mdate, mid)
values (to_date('24-04-2017', 'dd-mm-yyyy'), 1826);
insert into MISSION (mdate, mid)
values (to_date('22-06-2000', 'dd-mm-yyyy'), 1827);
insert into MISSION (mdate, mid)
values (to_date('03-06-2018', 'dd-mm-yyyy'), 1828);
insert into MISSION (mdate, mid)
values (to_date('10-02-1997', 'dd-mm-yyyy'), 1829);
insert into MISSION (mdate, mid)
values (to_date('14-07-1996', 'dd-mm-yyyy'), 1830);
insert into MISSION (mdate, mid)
values (to_date('11-11-2009', 'dd-mm-yyyy'), 1831);
insert into MISSION (mdate, mid)
values (to_date('29-12-2006', 'dd-mm-yyyy'), 1832);
insert into MISSION (mdate, mid)
values (to_date('06-11-2021', 'dd-mm-yyyy'), 1833);
insert into MISSION (mdate, mid)
values (to_date('06-08-2022', 'dd-mm-yyyy'), 1834);
insert into MISSION (mdate, mid)
values (to_date('30-12-2020', 'dd-mm-yyyy'), 1835);
insert into MISSION (mdate, mid)
values (to_date('31-03-1991', 'dd-mm-yyyy'), 1836);
insert into MISSION (mdate, mid)
values (to_date('21-06-1997', 'dd-mm-yyyy'), 1837);
insert into MISSION (mdate, mid)
values (to_date('17-09-2018', 'dd-mm-yyyy'), 1838);
insert into MISSION (mdate, mid)
values (to_date('22-07-2020', 'dd-mm-yyyy'), 1839);
insert into MISSION (mdate, mid)
values (to_date('28-06-2000', 'dd-mm-yyyy'), 1840);
insert into MISSION (mdate, mid)
values (to_date('18-10-2013', 'dd-mm-yyyy'), 1841);
insert into MISSION (mdate, mid)
values (to_date('13-12-2009', 'dd-mm-yyyy'), 1842);
insert into MISSION (mdate, mid)
values (to_date('27-05-2018', 'dd-mm-yyyy'), 1843);
insert into MISSION (mdate, mid)
values (to_date('31-05-1993', 'dd-mm-yyyy'), 1844);
insert into MISSION (mdate, mid)
values (to_date('01-11-1996', 'dd-mm-yyyy'), 1845);
insert into MISSION (mdate, mid)
values (to_date('31-01-2017', 'dd-mm-yyyy'), 1846);
insert into MISSION (mdate, mid)
values (to_date('08-01-2018', 'dd-mm-yyyy'), 1847);
insert into MISSION (mdate, mid)
values (to_date('23-03-2005', 'dd-mm-yyyy'), 1848);
insert into MISSION (mdate, mid)
values (to_date('16-04-2005', 'dd-mm-yyyy'), 1849);
insert into MISSION (mdate, mid)
values (to_date('10-09-2002', 'dd-mm-yyyy'), 1850);
insert into MISSION (mdate, mid)
values (to_date('02-03-2017', 'dd-mm-yyyy'), 1851);
insert into MISSION (mdate, mid)
values (to_date('23-10-2016', 'dd-mm-yyyy'), 1852);
insert into MISSION (mdate, mid)
values (to_date('08-01-1995', 'dd-mm-yyyy'), 1853);
insert into MISSION (mdate, mid)
values (to_date('09-10-1994', 'dd-mm-yyyy'), 1854);
insert into MISSION (mdate, mid)
values (to_date('08-03-2005', 'dd-mm-yyyy'), 1855);
insert into MISSION (mdate, mid)
values (to_date('23-04-2005', 'dd-mm-yyyy'), 1856);
insert into MISSION (mdate, mid)
values (to_date('27-06-1995', 'dd-mm-yyyy'), 1857);
insert into MISSION (mdate, mid)
values (to_date('20-06-1993', 'dd-mm-yyyy'), 1858);
insert into MISSION (mdate, mid)
values (to_date('27-09-1997', 'dd-mm-yyyy'), 1859);
insert into MISSION (mdate, mid)
values (to_date('14-09-2016', 'dd-mm-yyyy'), 1860);
insert into MISSION (mdate, mid)
values (to_date('29-07-2000', 'dd-mm-yyyy'), 1861);
insert into MISSION (mdate, mid)
values (to_date('22-08-2000', 'dd-mm-yyyy'), 1862);
insert into MISSION (mdate, mid)
values (to_date('21-12-1992', 'dd-mm-yyyy'), 1863);
insert into MISSION (mdate, mid)
values (to_date('24-06-2010', 'dd-mm-yyyy'), 1864);
insert into MISSION (mdate, mid)
values (to_date('07-06-2006', 'dd-mm-yyyy'), 1865);
insert into MISSION (mdate, mid)
values (to_date('27-05-1992', 'dd-mm-yyyy'), 1866);
insert into MISSION (mdate, mid)
values (to_date('04-04-2005', 'dd-mm-yyyy'), 1867);
insert into MISSION (mdate, mid)
values (to_date('26-05-1993', 'dd-mm-yyyy'), 1868);
insert into MISSION (mdate, mid)
values (to_date('04-02-2010', 'dd-mm-yyyy'), 1869);
insert into MISSION (mdate, mid)
values (to_date('04-11-1992', 'dd-mm-yyyy'), 1870);
insert into MISSION (mdate, mid)
values (to_date('03-02-2011', 'dd-mm-yyyy'), 1871);
insert into MISSION (mdate, mid)
values (to_date('25-11-2010', 'dd-mm-yyyy'), 1872);
insert into MISSION (mdate, mid)
values (to_date('21-02-2022', 'dd-mm-yyyy'), 1873);
insert into MISSION (mdate, mid)
values (to_date('22-07-2019', 'dd-mm-yyyy'), 1874);
insert into MISSION (mdate, mid)
values (to_date('07-11-2012', 'dd-mm-yyyy'), 1875);
insert into MISSION (mdate, mid)
values (to_date('25-09-2001', 'dd-mm-yyyy'), 1876);
insert into MISSION (mdate, mid)
values (to_date('04-08-2022', 'dd-mm-yyyy'), 1877);
insert into MISSION (mdate, mid)
values (to_date('11-09-2009', 'dd-mm-yyyy'), 1878);
insert into MISSION (mdate, mid)
values (to_date('08-05-2005', 'dd-mm-yyyy'), 1879);
insert into MISSION (mdate, mid)
values (to_date('20-10-1991', 'dd-mm-yyyy'), 1880);
insert into MISSION (mdate, mid)
values (to_date('08-10-1995', 'dd-mm-yyyy'), 1881);
insert into MISSION (mdate, mid)
values (to_date('10-09-2008', 'dd-mm-yyyy'), 1882);
insert into MISSION (mdate, mid)
values (to_date('04-07-2001', 'dd-mm-yyyy'), 1883);
insert into MISSION (mdate, mid)
values (to_date('06-05-2022', 'dd-mm-yyyy'), 1884);
insert into MISSION (mdate, mid)
values (to_date('06-12-2022', 'dd-mm-yyyy'), 1885);
insert into MISSION (mdate, mid)
values (to_date('04-11-2020', 'dd-mm-yyyy'), 1886);
insert into MISSION (mdate, mid)
values (to_date('16-07-2017', 'dd-mm-yyyy'), 1887);
insert into MISSION (mdate, mid)
values (to_date('30-11-2007', 'dd-mm-yyyy'), 1888);
insert into MISSION (mdate, mid)
values (to_date('20-10-1990', 'dd-mm-yyyy'), 1889);
insert into MISSION (mdate, mid)
values (to_date('17-05-2018', 'dd-mm-yyyy'), 1890);
insert into MISSION (mdate, mid)
values (to_date('22-06-1992', 'dd-mm-yyyy'), 1891);
insert into MISSION (mdate, mid)
values (to_date('13-10-1991', 'dd-mm-yyyy'), 1892);
insert into MISSION (mdate, mid)
values (to_date('02-05-2000', 'dd-mm-yyyy'), 1893);
insert into MISSION (mdate, mid)
values (to_date('06-10-2019', 'dd-mm-yyyy'), 1894);
insert into MISSION (mdate, mid)
values (to_date('23-11-2020', 'dd-mm-yyyy'), 1895);
insert into MISSION (mdate, mid)
values (to_date('26-09-2020', 'dd-mm-yyyy'), 1896);
insert into MISSION (mdate, mid)
values (to_date('11-05-1994', 'dd-mm-yyyy'), 1897);
insert into MISSION (mdate, mid)
values (to_date('08-05-1991', 'dd-mm-yyyy'), 1898);
insert into MISSION (mdate, mid)
values (to_date('03-04-1999', 'dd-mm-yyyy'), 1899);
insert into MISSION (mdate, mid)
values (to_date('02-06-1991', 'dd-mm-yyyy'), 1900);
insert into MISSION (mdate, mid)
values (to_date('07-12-2001', 'dd-mm-yyyy'), 1901);
insert into MISSION (mdate, mid)
values (to_date('22-07-1994', 'dd-mm-yyyy'), 1902);
insert into MISSION (mdate, mid)
values (to_date('08-02-2005', 'dd-mm-yyyy'), 1903);
insert into MISSION (mdate, mid)
values (to_date('08-08-1993', 'dd-mm-yyyy'), 1904);
insert into MISSION (mdate, mid)
values (to_date('12-07-1996', 'dd-mm-yyyy'), 1905);
insert into MISSION (mdate, mid)
values (to_date('03-04-2019', 'dd-mm-yyyy'), 1906);
insert into MISSION (mdate, mid)
values (to_date('22-02-1998', 'dd-mm-yyyy'), 1907);
insert into MISSION (mdate, mid)
values (to_date('01-03-2001', 'dd-mm-yyyy'), 1908);
insert into MISSION (mdate, mid)
values (to_date('27-05-1990', 'dd-mm-yyyy'), 1909);
insert into MISSION (mdate, mid)
values (to_date('24-01-2008', 'dd-mm-yyyy'), 1910);
insert into MISSION (mdate, mid)
values (to_date('20-11-2013', 'dd-mm-yyyy'), 1911);
insert into MISSION (mdate, mid)
values (to_date('19-07-2013', 'dd-mm-yyyy'), 1912);
insert into MISSION (mdate, mid)
values (to_date('07-10-2005', 'dd-mm-yyyy'), 1913);
insert into MISSION (mdate, mid)
values (to_date('27-08-1990', 'dd-mm-yyyy'), 1914);
insert into MISSION (mdate, mid)
values (to_date('07-05-2016', 'dd-mm-yyyy'), 1915);
commit;
prompt 200 records committed...
insert into MISSION (mdate, mid)
values (to_date('06-01-2010', 'dd-mm-yyyy'), 1916);
insert into MISSION (mdate, mid)
values (to_date('17-08-2000', 'dd-mm-yyyy'), 1917);
insert into MISSION (mdate, mid)
values (to_date('23-04-1991', 'dd-mm-yyyy'), 1918);
insert into MISSION (mdate, mid)
values (to_date('16-02-2003', 'dd-mm-yyyy'), 1919);
insert into MISSION (mdate, mid)
values (to_date('07-01-2011', 'dd-mm-yyyy'), 1920);
insert into MISSION (mdate, mid)
values (to_date('13-05-2000', 'dd-mm-yyyy'), 1921);
insert into MISSION (mdate, mid)
values (to_date('11-05-2008', 'dd-mm-yyyy'), 1922);
insert into MISSION (mdate, mid)
values (to_date('25-08-2007', 'dd-mm-yyyy'), 1923);
insert into MISSION (mdate, mid)
values (to_date('26-05-2021', 'dd-mm-yyyy'), 1924);
insert into MISSION (mdate, mid)
values (to_date('21-06-2001', 'dd-mm-yyyy'), 1925);
insert into MISSION (mdate, mid)
values (to_date('19-03-2009', 'dd-mm-yyyy'), 1926);
insert into MISSION (mdate, mid)
values (to_date('31-07-2014', 'dd-mm-yyyy'), 1927);
insert into MISSION (mdate, mid)
values (to_date('14-05-2001', 'dd-mm-yyyy'), 1928);
insert into MISSION (mdate, mid)
values (to_date('27-12-2013', 'dd-mm-yyyy'), 1929);
insert into MISSION (mdate, mid)
values (to_date('01-02-1992', 'dd-mm-yyyy'), 1930);
insert into MISSION (mdate, mid)
values (to_date('14-08-2010', 'dd-mm-yyyy'), 1931);
insert into MISSION (mdate, mid)
values (to_date('05-05-2019', 'dd-mm-yyyy'), 1932);
insert into MISSION (mdate, mid)
values (to_date('30-07-1990', 'dd-mm-yyyy'), 1933);
insert into MISSION (mdate, mid)
values (to_date('04-09-2008', 'dd-mm-yyyy'), 1934);
insert into MISSION (mdate, mid)
values (to_date('19-02-2005', 'dd-mm-yyyy'), 1935);
insert into MISSION (mdate, mid)
values (to_date('09-03-1990', 'dd-mm-yyyy'), 1936);
insert into MISSION (mdate, mid)
values (to_date('03-04-1992', 'dd-mm-yyyy'), 1937);
insert into MISSION (mdate, mid)
values (to_date('27-05-2017', 'dd-mm-yyyy'), 1938);
insert into MISSION (mdate, mid)
values (to_date('13-06-1995', 'dd-mm-yyyy'), 1939);
insert into MISSION (mdate, mid)
values (to_date('04-06-1994', 'dd-mm-yyyy'), 1940);
insert into MISSION (mdate, mid)
values (to_date('27-03-1992', 'dd-mm-yyyy'), 1941);
insert into MISSION (mdate, mid)
values (to_date('30-11-2005', 'dd-mm-yyyy'), 1942);
insert into MISSION (mdate, mid)
values (to_date('24-08-1991', 'dd-mm-yyyy'), 1943);
insert into MISSION (mdate, mid)
values (to_date('31-05-2004', 'dd-mm-yyyy'), 1944);
insert into MISSION (mdate, mid)
values (to_date('27-05-2014', 'dd-mm-yyyy'), 1945);
insert into MISSION (mdate, mid)
values (to_date('03-01-2005', 'dd-mm-yyyy'), 1946);
insert into MISSION (mdate, mid)
values (to_date('11-04-1993', 'dd-mm-yyyy'), 1947);
insert into MISSION (mdate, mid)
values (to_date('05-08-1996', 'dd-mm-yyyy'), 1948);
insert into MISSION (mdate, mid)
values (to_date('03-05-1991', 'dd-mm-yyyy'), 1949);
insert into MISSION (mdate, mid)
values (to_date('28-02-2020', 'dd-mm-yyyy'), 1950);
insert into MISSION (mdate, mid)
values (to_date('20-04-2016', 'dd-mm-yyyy'), 1951);
insert into MISSION (mdate, mid)
values (to_date('21-04-2018', 'dd-mm-yyyy'), 1952);
insert into MISSION (mdate, mid)
values (to_date('27-12-2021', 'dd-mm-yyyy'), 1953);
insert into MISSION (mdate, mid)
values (to_date('25-04-2014', 'dd-mm-yyyy'), 1954);
insert into MISSION (mdate, mid)
values (to_date('15-02-2013', 'dd-mm-yyyy'), 1955);
insert into MISSION (mdate, mid)
values (to_date('02-10-2016', 'dd-mm-yyyy'), 1956);
insert into MISSION (mdate, mid)
values (to_date('06-05-2001', 'dd-mm-yyyy'), 1957);
insert into MISSION (mdate, mid)
values (to_date('21-08-2017', 'dd-mm-yyyy'), 1958);
insert into MISSION (mdate, mid)
values (to_date('10-08-1998', 'dd-mm-yyyy'), 1959);
insert into MISSION (mdate, mid)
values (to_date('01-03-2005', 'dd-mm-yyyy'), 1960);
insert into MISSION (mdate, mid)
values (to_date('10-09-2011', 'dd-mm-yyyy'), 1961);
insert into MISSION (mdate, mid)
values (to_date('06-05-2019', 'dd-mm-yyyy'), 1962);
insert into MISSION (mdate, mid)
values (to_date('18-05-2010', 'dd-mm-yyyy'), 1963);
insert into MISSION (mdate, mid)
values (to_date('02-03-1994', 'dd-mm-yyyy'), 1964);
insert into MISSION (mdate, mid)
values (to_date('19-05-2002', 'dd-mm-yyyy'), 1965);
insert into MISSION (mdate, mid)
values (to_date('15-11-1997', 'dd-mm-yyyy'), 1966);
insert into MISSION (mdate, mid)
values (to_date('13-11-2001', 'dd-mm-yyyy'), 1967);
insert into MISSION (mdate, mid)
values (to_date('06-12-2015', 'dd-mm-yyyy'), 1968);
insert into MISSION (mdate, mid)
values (to_date('19-02-1999', 'dd-mm-yyyy'), 1969);
insert into MISSION (mdate, mid)
values (to_date('10-12-1991', 'dd-mm-yyyy'), 1970);
insert into MISSION (mdate, mid)
values (to_date('27-10-2005', 'dd-mm-yyyy'), 1971);
insert into MISSION (mdate, mid)
values (to_date('09-09-2015', 'dd-mm-yyyy'), 1972);
insert into MISSION (mdate, mid)
values (to_date('01-05-2013', 'dd-mm-yyyy'), 1973);
insert into MISSION (mdate, mid)
values (to_date('23-04-1991', 'dd-mm-yyyy'), 1974);
insert into MISSION (mdate, mid)
values (to_date('13-04-1990', 'dd-mm-yyyy'), 1975);
insert into MISSION (mdate, mid)
values (to_date('19-07-2020', 'dd-mm-yyyy'), 1976);
insert into MISSION (mdate, mid)
values (to_date('19-10-2017', 'dd-mm-yyyy'), 1977);
insert into MISSION (mdate, mid)
values (to_date('13-04-1995', 'dd-mm-yyyy'), 1978);
insert into MISSION (mdate, mid)
values (to_date('03-04-1992', 'dd-mm-yyyy'), 1979);
insert into MISSION (mdate, mid)
values (to_date('22-10-2013', 'dd-mm-yyyy'), 1980);
insert into MISSION (mdate, mid)
values (to_date('17-01-2001', 'dd-mm-yyyy'), 1981);
insert into MISSION (mdate, mid)
values (to_date('24-03-2001', 'dd-mm-yyyy'), 1982);
insert into MISSION (mdate, mid)
values (to_date('29-07-2000', 'dd-mm-yyyy'), 1983);
insert into MISSION (mdate, mid)
values (to_date('01-03-2007', 'dd-mm-yyyy'), 1984);
insert into MISSION (mdate, mid)
values (to_date('27-12-2020', 'dd-mm-yyyy'), 1985);
insert into MISSION (mdate, mid)
values (to_date('20-09-1990', 'dd-mm-yyyy'), 1986);
insert into MISSION (mdate, mid)
values (to_date('31-08-1991', 'dd-mm-yyyy'), 1987);
insert into MISSION (mdate, mid)
values (to_date('29-06-2019', 'dd-mm-yyyy'), 1988);
insert into MISSION (mdate, mid)
values (to_date('27-07-2022', 'dd-mm-yyyy'), 1989);
insert into MISSION (mdate, mid)
values (to_date('01-01-2022', 'dd-mm-yyyy'), 1990);
insert into MISSION (mdate, mid)
values (to_date('16-03-2002', 'dd-mm-yyyy'), 1991);
insert into MISSION (mdate, mid)
values (to_date('17-02-2009', 'dd-mm-yyyy'), 1992);
insert into MISSION (mdate, mid)
values (to_date('08-11-2016', 'dd-mm-yyyy'), 1993);
insert into MISSION (mdate, mid)
values (to_date('07-12-2017', 'dd-mm-yyyy'), 1994);
insert into MISSION (mdate, mid)
values (to_date('12-12-1998', 'dd-mm-yyyy'), 1995);
insert into MISSION (mdate, mid)
values (to_date('03-11-2012', 'dd-mm-yyyy'), 1996);
insert into MISSION (mdate, mid)
values (to_date('20-06-2006', 'dd-mm-yyyy'), 1997);
insert into MISSION (mdate, mid)
values (to_date('19-08-2001', 'dd-mm-yyyy'), 1998);
insert into MISSION (mdate, mid)
values (to_date('13-02-2007', 'dd-mm-yyyy'), 1999);
insert into MISSION (mdate, mid)
values (to_date('31-10-1993', 'dd-mm-yyyy'), 2000);
insert into MISSION (mdate, mid)
values (to_date('30-06-2024 21:35:06', 'dd-mm-yyyy hh24:mi:ss'), 2001);
insert into MISSION (mdate, mid)
values (to_date('10-05-1990', 'dd-mm-yyyy'), 1289);
insert into MISSION (mdate, mid)
values (to_date('20-04-2013', 'dd-mm-yyyy'), 1290);
insert into MISSION (mdate, mid)
values (to_date('13-10-1993', 'dd-mm-yyyy'), 1291);
insert into MISSION (mdate, mid)
values (to_date('07-05-2006', 'dd-mm-yyyy'), 1292);
insert into MISSION (mdate, mid)
values (to_date('11-06-2014', 'dd-mm-yyyy'), 1293);
insert into MISSION (mdate, mid)
values (to_date('18-09-1995', 'dd-mm-yyyy'), 1294);
insert into MISSION (mdate, mid)
values (to_date('19-06-1993', 'dd-mm-yyyy'), 1295);
insert into MISSION (mdate, mid)
values (to_date('11-11-2008', 'dd-mm-yyyy'), 1296);
insert into MISSION (mdate, mid)
values (to_date('24-03-2022', 'dd-mm-yyyy'), 1297);
insert into MISSION (mdate, mid)
values (to_date('07-03-2016', 'dd-mm-yyyy'), 1298);
insert into MISSION (mdate, mid)
values (to_date('19-02-1998', 'dd-mm-yyyy'), 1299);
insert into MISSION (mdate, mid)
values (to_date('09-08-2011', 'dd-mm-yyyy'), 1300);
insert into MISSION (mdate, mid)
values (to_date('22-09-1994', 'dd-mm-yyyy'), 1301);
insert into MISSION (mdate, mid)
values (to_date('17-10-2014', 'dd-mm-yyyy'), 1302);
commit;
prompt 300 records committed...
insert into MISSION (mdate, mid)
values (to_date('30-11-2006', 'dd-mm-yyyy'), 1303);
insert into MISSION (mdate, mid)
values (to_date('01-06-2010', 'dd-mm-yyyy'), 1304);
insert into MISSION (mdate, mid)
values (to_date('20-02-2003', 'dd-mm-yyyy'), 1305);
insert into MISSION (mdate, mid)
values (to_date('27-04-2007', 'dd-mm-yyyy'), 1306);
insert into MISSION (mdate, mid)
values (to_date('09-02-2006', 'dd-mm-yyyy'), 1307);
insert into MISSION (mdate, mid)
values (to_date('14-12-1993', 'dd-mm-yyyy'), 1308);
insert into MISSION (mdate, mid)
values (to_date('25-12-2003', 'dd-mm-yyyy'), 1309);
insert into MISSION (mdate, mid)
values (to_date('26-03-1999', 'dd-mm-yyyy'), 1310);
insert into MISSION (mdate, mid)
values (to_date('17-07-2007', 'dd-mm-yyyy'), 1311);
insert into MISSION (mdate, mid)
values (to_date('11-03-2001', 'dd-mm-yyyy'), 1312);
insert into MISSION (mdate, mid)
values (to_date('27-04-2017', 'dd-mm-yyyy'), 1313);
insert into MISSION (mdate, mid)
values (to_date('16-06-2000', 'dd-mm-yyyy'), 1314);
insert into MISSION (mdate, mid)
values (to_date('24-05-1996', 'dd-mm-yyyy'), 1315);
insert into MISSION (mdate, mid)
values (to_date('30-08-1990', 'dd-mm-yyyy'), 1316);
insert into MISSION (mdate, mid)
values (to_date('23-07-1990', 'dd-mm-yyyy'), 1317);
insert into MISSION (mdate, mid)
values (to_date('08-08-2018', 'dd-mm-yyyy'), 1318);
insert into MISSION (mdate, mid)
values (to_date('07-08-2002', 'dd-mm-yyyy'), 1319);
insert into MISSION (mdate, mid)
values (to_date('06-04-1997', 'dd-mm-yyyy'), 1320);
insert into MISSION (mdate, mid)
values (to_date('10-04-2011', 'dd-mm-yyyy'), 1321);
insert into MISSION (mdate, mid)
values (to_date('28-09-2015', 'dd-mm-yyyy'), 1322);
insert into MISSION (mdate, mid)
values (to_date('17-12-2022', 'dd-mm-yyyy'), 1323);
insert into MISSION (mdate, mid)
values (to_date('26-11-2004', 'dd-mm-yyyy'), 1324);
insert into MISSION (mdate, mid)
values (to_date('04-02-1990', 'dd-mm-yyyy'), 1325);
insert into MISSION (mdate, mid)
values (to_date('23-01-2020', 'dd-mm-yyyy'), 1326);
insert into MISSION (mdate, mid)
values (to_date('22-07-1991', 'dd-mm-yyyy'), 1327);
insert into MISSION (mdate, mid)
values (to_date('11-05-1994', 'dd-mm-yyyy'), 1328);
insert into MISSION (mdate, mid)
values (to_date('06-08-2021', 'dd-mm-yyyy'), 1329);
insert into MISSION (mdate, mid)
values (to_date('26-11-1997', 'dd-mm-yyyy'), 1330);
insert into MISSION (mdate, mid)
values (to_date('30-01-2004', 'dd-mm-yyyy'), 1331);
insert into MISSION (mdate, mid)
values (to_date('23-12-2006', 'dd-mm-yyyy'), 1332);
insert into MISSION (mdate, mid)
values (to_date('01-09-1999', 'dd-mm-yyyy'), 1333);
insert into MISSION (mdate, mid)
values (to_date('20-12-1990', 'dd-mm-yyyy'), 1334);
insert into MISSION (mdate, mid)
values (to_date('04-03-2020', 'dd-mm-yyyy'), 1335);
insert into MISSION (mdate, mid)
values (to_date('02-04-2007', 'dd-mm-yyyy'), 1336);
insert into MISSION (mdate, mid)
values (to_date('28-11-2008', 'dd-mm-yyyy'), 1337);
insert into MISSION (mdate, mid)
values (to_date('21-10-2008', 'dd-mm-yyyy'), 1338);
insert into MISSION (mdate, mid)
values (to_date('11-12-1991', 'dd-mm-yyyy'), 1339);
insert into MISSION (mdate, mid)
values (to_date('02-05-1995', 'dd-mm-yyyy'), 1340);
insert into MISSION (mdate, mid)
values (to_date('16-12-2018', 'dd-mm-yyyy'), 1341);
insert into MISSION (mdate, mid)
values (to_date('19-10-1999', 'dd-mm-yyyy'), 1342);
insert into MISSION (mdate, mid)
values (to_date('25-02-2022', 'dd-mm-yyyy'), 1343);
insert into MISSION (mdate, mid)
values (to_date('13-12-2003', 'dd-mm-yyyy'), 1344);
insert into MISSION (mdate, mid)
values (to_date('22-10-1990', 'dd-mm-yyyy'), 1345);
insert into MISSION (mdate, mid)
values (to_date('06-04-2001', 'dd-mm-yyyy'), 1346);
insert into MISSION (mdate, mid)
values (to_date('03-11-1998', 'dd-mm-yyyy'), 1347);
insert into MISSION (mdate, mid)
values (to_date('07-06-2018', 'dd-mm-yyyy'), 1348);
insert into MISSION (mdate, mid)
values (to_date('06-07-1994', 'dd-mm-yyyy'), 1349);
insert into MISSION (mdate, mid)
values (to_date('25-05-2016', 'dd-mm-yyyy'), 1350);
insert into MISSION (mdate, mid)
values (to_date('29-04-2009', 'dd-mm-yyyy'), 1351);
insert into MISSION (mdate, mid)
values (to_date('11-09-1998', 'dd-mm-yyyy'), 1352);
insert into MISSION (mdate, mid)
values (to_date('20-11-2011', 'dd-mm-yyyy'), 1353);
insert into MISSION (mdate, mid)
values (to_date('11-03-1999', 'dd-mm-yyyy'), 1354);
insert into MISSION (mdate, mid)
values (to_date('14-11-2006', 'dd-mm-yyyy'), 1355);
insert into MISSION (mdate, mid)
values (to_date('01-06-1992', 'dd-mm-yyyy'), 1356);
insert into MISSION (mdate, mid)
values (to_date('15-01-1997', 'dd-mm-yyyy'), 1357);
insert into MISSION (mdate, mid)
values (to_date('11-07-2006', 'dd-mm-yyyy'), 1358);
insert into MISSION (mdate, mid)
values (to_date('04-06-2016', 'dd-mm-yyyy'), 1359);
insert into MISSION (mdate, mid)
values (to_date('16-10-2006', 'dd-mm-yyyy'), 1360);
insert into MISSION (mdate, mid)
values (to_date('08-11-2016', 'dd-mm-yyyy'), 1361);
insert into MISSION (mdate, mid)
values (to_date('26-01-1991', 'dd-mm-yyyy'), 1362);
insert into MISSION (mdate, mid)
values (to_date('05-04-1996', 'dd-mm-yyyy'), 1363);
insert into MISSION (mdate, mid)
values (to_date('25-07-2007', 'dd-mm-yyyy'), 1364);
insert into MISSION (mdate, mid)
values (to_date('21-10-2004', 'dd-mm-yyyy'), 1365);
insert into MISSION (mdate, mid)
values (to_date('23-09-2003', 'dd-mm-yyyy'), 1366);
insert into MISSION (mdate, mid)
values (to_date('30-05-1998', 'dd-mm-yyyy'), 1367);
insert into MISSION (mdate, mid)
values (to_date('24-03-1993', 'dd-mm-yyyy'), 1368);
insert into MISSION (mdate, mid)
values (to_date('02-09-2022', 'dd-mm-yyyy'), 1369);
insert into MISSION (mdate, mid)
values (to_date('16-09-1998', 'dd-mm-yyyy'), 1370);
insert into MISSION (mdate, mid)
values (to_date('16-03-1992', 'dd-mm-yyyy'), 1371);
insert into MISSION (mdate, mid)
values (to_date('03-08-2001', 'dd-mm-yyyy'), 1372);
insert into MISSION (mdate, mid)
values (to_date('18-01-2019', 'dd-mm-yyyy'), 1373);
insert into MISSION (mdate, mid)
values (to_date('04-07-1993', 'dd-mm-yyyy'), 1374);
insert into MISSION (mdate, mid)
values (to_date('08-05-2010', 'dd-mm-yyyy'), 1375);
insert into MISSION (mdate, mid)
values (to_date('14-02-2013', 'dd-mm-yyyy'), 1376);
insert into MISSION (mdate, mid)
values (to_date('03-10-1995', 'dd-mm-yyyy'), 1377);
insert into MISSION (mdate, mid)
values (to_date('02-05-1991', 'dd-mm-yyyy'), 1378);
insert into MISSION (mdate, mid)
values (to_date('19-04-1998', 'dd-mm-yyyy'), 1379);
insert into MISSION (mdate, mid)
values (to_date('28-09-2020', 'dd-mm-yyyy'), 1380);
insert into MISSION (mdate, mid)
values (to_date('24-06-2016', 'dd-mm-yyyy'), 1381);
insert into MISSION (mdate, mid)
values (to_date('24-10-2005', 'dd-mm-yyyy'), 1382);
insert into MISSION (mdate, mid)
values (to_date('19-11-2009', 'dd-mm-yyyy'), 1383);
insert into MISSION (mdate, mid)
values (to_date('28-12-2015', 'dd-mm-yyyy'), 1384);
insert into MISSION (mdate, mid)
values (to_date('15-04-1995', 'dd-mm-yyyy'), 1385);
insert into MISSION (mdate, mid)
values (to_date('25-12-2007', 'dd-mm-yyyy'), 1386);
insert into MISSION (mdate, mid)
values (to_date('02-07-2014', 'dd-mm-yyyy'), 1387);
insert into MISSION (mdate, mid)
values (to_date('20-09-2012', 'dd-mm-yyyy'), 1388);
insert into MISSION (mdate, mid)
values (to_date('09-11-2002', 'dd-mm-yyyy'), 1389);
insert into MISSION (mdate, mid)
values (to_date('10-11-2019', 'dd-mm-yyyy'), 1390);
insert into MISSION (mdate, mid)
values (to_date('23-03-2008', 'dd-mm-yyyy'), 1391);
insert into MISSION (mdate, mid)
values (to_date('17-10-2006', 'dd-mm-yyyy'), 1392);
insert into MISSION (mdate, mid)
values (to_date('15-07-2021', 'dd-mm-yyyy'), 1393);
insert into MISSION (mdate, mid)
values (to_date('20-03-1993', 'dd-mm-yyyy'), 1394);
insert into MISSION (mdate, mid)
values (to_date('16-09-2007', 'dd-mm-yyyy'), 1395);
insert into MISSION (mdate, mid)
values (to_date('19-05-2009', 'dd-mm-yyyy'), 1396);
insert into MISSION (mdate, mid)
values (to_date('06-08-2002', 'dd-mm-yyyy'), 1397);
insert into MISSION (mdate, mid)
values (to_date('22-03-2011', 'dd-mm-yyyy'), 1398);
insert into MISSION (mdate, mid)
values (to_date('29-09-2008', 'dd-mm-yyyy'), 1399);
insert into MISSION (mdate, mid)
values (to_date('01-11-2002', 'dd-mm-yyyy'), 1400);
insert into MISSION (mdate, mid)
values (to_date('08-04-1998', 'dd-mm-yyyy'), 1401);
insert into MISSION (mdate, mid)
values (to_date('20-02-2006', 'dd-mm-yyyy'), 1402);
commit;
prompt 400 records committed...
insert into MISSION (mdate, mid)
values (to_date('01-11-1999', 'dd-mm-yyyy'), 1403);
insert into MISSION (mdate, mid)
values (to_date('18-04-2006', 'dd-mm-yyyy'), 1404);
insert into MISSION (mdate, mid)
values (to_date('16-06-2017', 'dd-mm-yyyy'), 1405);
insert into MISSION (mdate, mid)
values (to_date('08-04-2009', 'dd-mm-yyyy'), 1406);
insert into MISSION (mdate, mid)
values (to_date('09-02-1997', 'dd-mm-yyyy'), 1407);
insert into MISSION (mdate, mid)
values (to_date('11-06-2017', 'dd-mm-yyyy'), 1408);
insert into MISSION (mdate, mid)
values (to_date('17-03-2021', 'dd-mm-yyyy'), 1409);
insert into MISSION (mdate, mid)
values (to_date('26-09-2010', 'dd-mm-yyyy'), 1410);
insert into MISSION (mdate, mid)
values (to_date('29-06-2009', 'dd-mm-yyyy'), 1411);
insert into MISSION (mdate, mid)
values (to_date('02-02-2001', 'dd-mm-yyyy'), 1412);
insert into MISSION (mdate, mid)
values (to_date('19-04-2020', 'dd-mm-yyyy'), 1413);
insert into MISSION (mdate, mid)
values (to_date('29-11-1999', 'dd-mm-yyyy'), 1414);
insert into MISSION (mdate, mid)
values (to_date('21-12-2015', 'dd-mm-yyyy'), 1415);
insert into MISSION (mdate, mid)
values (to_date('28-06-2004', 'dd-mm-yyyy'), 1416);
insert into MISSION (mdate, mid)
values (to_date('30-07-2014', 'dd-mm-yyyy'), 1417);
insert into MISSION (mdate, mid)
values (to_date('05-07-2006', 'dd-mm-yyyy'), 1418);
insert into MISSION (mdate, mid)
values (to_date('28-03-2012', 'dd-mm-yyyy'), 1419);
insert into MISSION (mdate, mid)
values (to_date('11-08-1992', 'dd-mm-yyyy'), 1420);
insert into MISSION (mdate, mid)
values (to_date('19-11-2016', 'dd-mm-yyyy'), 1421);
insert into MISSION (mdate, mid)
values (to_date('25-08-2003', 'dd-mm-yyyy'), 1422);
insert into MISSION (mdate, mid)
values (to_date('02-04-1994', 'dd-mm-yyyy'), 1423);
insert into MISSION (mdate, mid)
values (to_date('12-09-1994', 'dd-mm-yyyy'), 1424);
insert into MISSION (mdate, mid)
values (to_date('06-09-2016', 'dd-mm-yyyy'), 1425);
insert into MISSION (mdate, mid)
values (to_date('11-06-2004', 'dd-mm-yyyy'), 1426);
insert into MISSION (mdate, mid)
values (to_date('04-05-2018', 'dd-mm-yyyy'), 1427);
insert into MISSION (mdate, mid)
values (to_date('23-11-2006', 'dd-mm-yyyy'), 1428);
insert into MISSION (mdate, mid)
values (to_date('03-10-2010', 'dd-mm-yyyy'), 1429);
insert into MISSION (mdate, mid)
values (to_date('05-12-1998', 'dd-mm-yyyy'), 1430);
insert into MISSION (mdate, mid)
values (to_date('12-12-1990', 'dd-mm-yyyy'), 1431);
insert into MISSION (mdate, mid)
values (to_date('09-10-1994', 'dd-mm-yyyy'), 1432);
insert into MISSION (mdate, mid)
values (to_date('25-07-2005', 'dd-mm-yyyy'), 1433);
insert into MISSION (mdate, mid)
values (to_date('16-04-2013', 'dd-mm-yyyy'), 1434);
insert into MISSION (mdate, mid)
values (to_date('26-02-2004', 'dd-mm-yyyy'), 1435);
insert into MISSION (mdate, mid)
values (to_date('18-12-2017', 'dd-mm-yyyy'), 1436);
insert into MISSION (mdate, mid)
values (to_date('01-03-2003', 'dd-mm-yyyy'), 1437);
insert into MISSION (mdate, mid)
values (to_date('01-11-2020', 'dd-mm-yyyy'), 1438);
insert into MISSION (mdate, mid)
values (to_date('16-07-1995', 'dd-mm-yyyy'), 1439);
insert into MISSION (mdate, mid)
values (to_date('07-05-2012', 'dd-mm-yyyy'), 1440);
insert into MISSION (mdate, mid)
values (to_date('20-09-1990', 'dd-mm-yyyy'), 1441);
insert into MISSION (mdate, mid)
values (to_date('14-02-2003', 'dd-mm-yyyy'), 1442);
insert into MISSION (mdate, mid)
values (to_date('17-01-1994', 'dd-mm-yyyy'), 1443);
insert into MISSION (mdate, mid)
values (to_date('31-05-1994', 'dd-mm-yyyy'), 1444);
insert into MISSION (mdate, mid)
values (to_date('28-01-1995', 'dd-mm-yyyy'), 1445);
insert into MISSION (mdate, mid)
values (to_date('31-01-2006', 'dd-mm-yyyy'), 1446);
insert into MISSION (mdate, mid)
values (to_date('02-12-2010', 'dd-mm-yyyy'), 1447);
insert into MISSION (mdate, mid)
values (to_date('30-09-2008', 'dd-mm-yyyy'), 1448);
insert into MISSION (mdate, mid)
values (to_date('19-11-2007', 'dd-mm-yyyy'), 1449);
insert into MISSION (mdate, mid)
values (to_date('03-04-2011', 'dd-mm-yyyy'), 1450);
insert into MISSION (mdate, mid)
values (to_date('09-11-1995', 'dd-mm-yyyy'), 1451);
insert into MISSION (mdate, mid)
values (to_date('01-11-2005', 'dd-mm-yyyy'), 1452);
insert into MISSION (mdate, mid)
values (to_date('27-03-1991', 'dd-mm-yyyy'), 1453);
insert into MISSION (mdate, mid)
values (to_date('19-04-2011', 'dd-mm-yyyy'), 1454);
insert into MISSION (mdate, mid)
values (to_date('05-12-2022', 'dd-mm-yyyy'), 1455);
insert into MISSION (mdate, mid)
values (to_date('18-07-2010', 'dd-mm-yyyy'), 1456);
insert into MISSION (mdate, mid)
values (to_date('09-11-2016', 'dd-mm-yyyy'), 1457);
insert into MISSION (mdate, mid)
values (to_date('13-06-1994', 'dd-mm-yyyy'), 1458);
insert into MISSION (mdate, mid)
values (to_date('19-12-2020', 'dd-mm-yyyy'), 1459);
insert into MISSION (mdate, mid)
values (to_date('13-01-1993', 'dd-mm-yyyy'), 1460);
insert into MISSION (mdate, mid)
values (to_date('09-04-2006', 'dd-mm-yyyy'), 1461);
insert into MISSION (mdate, mid)
values (to_date('26-08-2012', 'dd-mm-yyyy'), 1462);
insert into MISSION (mdate, mid)
values (to_date('01-06-2021', 'dd-mm-yyyy'), 1463);
insert into MISSION (mdate, mid)
values (to_date('10-12-2016', 'dd-mm-yyyy'), 1464);
insert into MISSION (mdate, mid)
values (to_date('10-06-1999', 'dd-mm-yyyy'), 1465);
insert into MISSION (mdate, mid)
values (to_date('05-06-2021', 'dd-mm-yyyy'), 1466);
insert into MISSION (mdate, mid)
values (to_date('22-11-1990', 'dd-mm-yyyy'), 1467);
insert into MISSION (mdate, mid)
values (to_date('27-01-1994', 'dd-mm-yyyy'), 1468);
insert into MISSION (mdate, mid)
values (to_date('26-11-2006', 'dd-mm-yyyy'), 1469);
insert into MISSION (mdate, mid)
values (to_date('14-10-2012', 'dd-mm-yyyy'), 1470);
insert into MISSION (mdate, mid)
values (to_date('21-11-2006', 'dd-mm-yyyy'), 1471);
insert into MISSION (mdate, mid)
values (to_date('24-12-1999', 'dd-mm-yyyy'), 1472);
insert into MISSION (mdate, mid)
values (to_date('12-05-1993', 'dd-mm-yyyy'), 1473);
insert into MISSION (mdate, mid)
values (to_date('18-09-2013', 'dd-mm-yyyy'), 1474);
insert into MISSION (mdate, mid)
values (to_date('15-06-1992', 'dd-mm-yyyy'), 1475);
insert into MISSION (mdate, mid)
values (to_date('11-02-2001', 'dd-mm-yyyy'), 1476);
insert into MISSION (mdate, mid)
values (to_date('05-03-2021', 'dd-mm-yyyy'), 1477);
insert into MISSION (mdate, mid)
values (to_date('19-01-1993', 'dd-mm-yyyy'), 1478);
insert into MISSION (mdate, mid)
values (to_date('15-09-2015', 'dd-mm-yyyy'), 1479);
insert into MISSION (mdate, mid)
values (to_date('07-07-1997', 'dd-mm-yyyy'), 1480);
insert into MISSION (mdate, mid)
values (to_date('02-05-1996', 'dd-mm-yyyy'), 1481);
insert into MISSION (mdate, mid)
values (to_date('12-10-1991', 'dd-mm-yyyy'), 1482);
insert into MISSION (mdate, mid)
values (to_date('09-07-1990', 'dd-mm-yyyy'), 1483);
insert into MISSION (mdate, mid)
values (to_date('02-02-2009', 'dd-mm-yyyy'), 1484);
insert into MISSION (mdate, mid)
values (to_date('10-10-2018', 'dd-mm-yyyy'), 1485);
insert into MISSION (mdate, mid)
values (to_date('20-01-2008', 'dd-mm-yyyy'), 1486);
insert into MISSION (mdate, mid)
values (to_date('01-11-1998', 'dd-mm-yyyy'), 1487);
insert into MISSION (mdate, mid)
values (to_date('27-01-2002', 'dd-mm-yyyy'), 1488);
insert into MISSION (mdate, mid)
values (to_date('22-02-2004', 'dd-mm-yyyy'), 1489);
insert into MISSION (mdate, mid)
values (to_date('28-06-2001', 'dd-mm-yyyy'), 1490);
insert into MISSION (mdate, mid)
values (to_date('15-04-2021', 'dd-mm-yyyy'), 1491);
insert into MISSION (mdate, mid)
values (to_date('03-03-1992', 'dd-mm-yyyy'), 1492);
insert into MISSION (mdate, mid)
values (to_date('25-05-1991', 'dd-mm-yyyy'), 1493);
insert into MISSION (mdate, mid)
values (to_date('12-07-1993', 'dd-mm-yyyy'), 1494);
insert into MISSION (mdate, mid)
values (to_date('15-03-2016', 'dd-mm-yyyy'), 1495);
insert into MISSION (mdate, mid)
values (to_date('13-06-2008', 'dd-mm-yyyy'), 1496);
insert into MISSION (mdate, mid)
values (to_date('15-10-2017', 'dd-mm-yyyy'), 1497);
insert into MISSION (mdate, mid)
values (to_date('25-11-2017', 'dd-mm-yyyy'), 1498);
insert into MISSION (mdate, mid)
values (to_date('25-02-2008', 'dd-mm-yyyy'), 1499);
insert into MISSION (mdate, mid)
values (to_date('18-01-2006', 'dd-mm-yyyy'), 1500);
insert into MISSION (mdate, mid)
values (to_date('08-03-2002', 'dd-mm-yyyy'), 1501);
insert into MISSION (mdate, mid)
values (to_date('09-07-2013', 'dd-mm-yyyy'), 1502);
commit;
prompt 500 records committed...
insert into MISSION (mdate, mid)
values (to_date('23-07-2020', 'dd-mm-yyyy'), 1503);
insert into MISSION (mdate, mid)
values (to_date('04-03-2022', 'dd-mm-yyyy'), 1504);
insert into MISSION (mdate, mid)
values (to_date('19-09-2019', 'dd-mm-yyyy'), 1505);
insert into MISSION (mdate, mid)
values (to_date('28-04-1991', 'dd-mm-yyyy'), 1506);
insert into MISSION (mdate, mid)
values (to_date('12-02-1992', 'dd-mm-yyyy'), 1507);
insert into MISSION (mdate, mid)
values (to_date('18-01-2020', 'dd-mm-yyyy'), 1508);
insert into MISSION (mdate, mid)
values (to_date('27-03-2006', 'dd-mm-yyyy'), 1509);
insert into MISSION (mdate, mid)
values (to_date('10-11-2022', 'dd-mm-yyyy'), 1510);
insert into MISSION (mdate, mid)
values (to_date('11-12-2022', 'dd-mm-yyyy'), 1511);
insert into MISSION (mdate, mid)
values (to_date('30-09-1995', 'dd-mm-yyyy'), 1512);
insert into MISSION (mdate, mid)
values (to_date('01-02-2018', 'dd-mm-yyyy'), 1513);
insert into MISSION (mdate, mid)
values (to_date('18-09-2002', 'dd-mm-yyyy'), 1514);
insert into MISSION (mdate, mid)
values (to_date('13-10-2017', 'dd-mm-yyyy'), 1515);
insert into MISSION (mdate, mid)
values (to_date('13-01-2007', 'dd-mm-yyyy'), 1516);
insert into MISSION (mdate, mid)
values (to_date('22-02-2003', 'dd-mm-yyyy'), 1517);
insert into MISSION (mdate, mid)
values (to_date('24-12-2002', 'dd-mm-yyyy'), 1518);
insert into MISSION (mdate, mid)
values (to_date('07-09-2012', 'dd-mm-yyyy'), 1519);
insert into MISSION (mdate, mid)
values (to_date('22-09-2022', 'dd-mm-yyyy'), 1520);
insert into MISSION (mdate, mid)
values (to_date('16-02-1994', 'dd-mm-yyyy'), 1521);
insert into MISSION (mdate, mid)
values (to_date('31-05-2000', 'dd-mm-yyyy'), 1522);
insert into MISSION (mdate, mid)
values (to_date('22-11-2004', 'dd-mm-yyyy'), 1523);
insert into MISSION (mdate, mid)
values (to_date('17-02-1994', 'dd-mm-yyyy'), 1524);
insert into MISSION (mdate, mid)
values (to_date('23-08-1993', 'dd-mm-yyyy'), 1525);
insert into MISSION (mdate, mid)
values (to_date('08-01-2009', 'dd-mm-yyyy'), 1526);
insert into MISSION (mdate, mid)
values (to_date('28-12-1994', 'dd-mm-yyyy'), 1527);
insert into MISSION (mdate, mid)
values (to_date('07-08-1997', 'dd-mm-yyyy'), 1528);
insert into MISSION (mdate, mid)
values (to_date('09-07-2016', 'dd-mm-yyyy'), 1529);
insert into MISSION (mdate, mid)
values (to_date('19-02-2009', 'dd-mm-yyyy'), 1530);
insert into MISSION (mdate, mid)
values (to_date('09-06-2001', 'dd-mm-yyyy'), 1531);
insert into MISSION (mdate, mid)
values (to_date('07-04-2008', 'dd-mm-yyyy'), 1532);
insert into MISSION (mdate, mid)
values (to_date('11-04-2004', 'dd-mm-yyyy'), 1533);
insert into MISSION (mdate, mid)
values (to_date('09-04-1996', 'dd-mm-yyyy'), 1534);
insert into MISSION (mdate, mid)
values (to_date('30-01-2014', 'dd-mm-yyyy'), 1535);
insert into MISSION (mdate, mid)
values (to_date('23-06-1995', 'dd-mm-yyyy'), 1536);
insert into MISSION (mdate, mid)
values (to_date('21-11-1994', 'dd-mm-yyyy'), 1537);
insert into MISSION (mdate, mid)
values (to_date('28-04-2019', 'dd-mm-yyyy'), 1538);
insert into MISSION (mdate, mid)
values (to_date('27-04-1993', 'dd-mm-yyyy'), 1539);
insert into MISSION (mdate, mid)
values (to_date('08-07-2015', 'dd-mm-yyyy'), 1540);
insert into MISSION (mdate, mid)
values (to_date('25-02-2015', 'dd-mm-yyyy'), 1541);
insert into MISSION (mdate, mid)
values (to_date('21-11-2019', 'dd-mm-yyyy'), 1542);
insert into MISSION (mdate, mid)
values (to_date('22-11-1996', 'dd-mm-yyyy'), 1543);
insert into MISSION (mdate, mid)
values (to_date('06-08-2018', 'dd-mm-yyyy'), 1544);
insert into MISSION (mdate, mid)
values (to_date('23-04-1996', 'dd-mm-yyyy'), 1545);
insert into MISSION (mdate, mid)
values (to_date('11-10-2018', 'dd-mm-yyyy'), 1546);
insert into MISSION (mdate, mid)
values (to_date('05-08-1996', 'dd-mm-yyyy'), 1547);
insert into MISSION (mdate, mid)
values (to_date('08-04-2019', 'dd-mm-yyyy'), 1548);
insert into MISSION (mdate, mid)
values (to_date('01-10-2021', 'dd-mm-yyyy'), 1549);
insert into MISSION (mdate, mid)
values (to_date('22-12-2015', 'dd-mm-yyyy'), 1550);
insert into MISSION (mdate, mid)
values (to_date('01-05-2011', 'dd-mm-yyyy'), 1551);
insert into MISSION (mdate, mid)
values (to_date('25-08-2000', 'dd-mm-yyyy'), 1552);
insert into MISSION (mdate, mid)
values (to_date('03-12-2002', 'dd-mm-yyyy'), 1553);
insert into MISSION (mdate, mid)
values (to_date('21-08-2001', 'dd-mm-yyyy'), 1554);
insert into MISSION (mdate, mid)
values (to_date('08-04-2003', 'dd-mm-yyyy'), 1555);
insert into MISSION (mdate, mid)
values (to_date('14-03-2020', 'dd-mm-yyyy'), 1556);
insert into MISSION (mdate, mid)
values (to_date('21-10-1999', 'dd-mm-yyyy'), 1557);
insert into MISSION (mdate, mid)
values (to_date('02-12-2021', 'dd-mm-yyyy'), 1558);
insert into MISSION (mdate, mid)
values (to_date('09-02-2015', 'dd-mm-yyyy'), 1559);
insert into MISSION (mdate, mid)
values (to_date('25-11-2002', 'dd-mm-yyyy'), 1560);
insert into MISSION (mdate, mid)
values (to_date('24-07-2001', 'dd-mm-yyyy'), 1561);
insert into MISSION (mdate, mid)
values (to_date('19-08-2020', 'dd-mm-yyyy'), 1562);
insert into MISSION (mdate, mid)
values (to_date('22-08-2011', 'dd-mm-yyyy'), 1563);
insert into MISSION (mdate, mid)
values (to_date('23-01-2003', 'dd-mm-yyyy'), 1564);
insert into MISSION (mdate, mid)
values (to_date('21-03-2004', 'dd-mm-yyyy'), 1565);
insert into MISSION (mdate, mid)
values (to_date('05-02-2011', 'dd-mm-yyyy'), 1566);
insert into MISSION (mdate, mid)
values (to_date('17-02-2019', 'dd-mm-yyyy'), 1567);
insert into MISSION (mdate, mid)
values (to_date('21-02-2008', 'dd-mm-yyyy'), 1568);
insert into MISSION (mdate, mid)
values (to_date('29-06-2009', 'dd-mm-yyyy'), 1569);
insert into MISSION (mdate, mid)
values (to_date('05-09-2018', 'dd-mm-yyyy'), 1570);
insert into MISSION (mdate, mid)
values (to_date('28-03-2009', 'dd-mm-yyyy'), 1571);
insert into MISSION (mdate, mid)
values (to_date('10-04-2016', 'dd-mm-yyyy'), 1572);
insert into MISSION (mdate, mid)
values (to_date('04-02-2006', 'dd-mm-yyyy'), 1573);
insert into MISSION (mdate, mid)
values (to_date('04-11-2001', 'dd-mm-yyyy'), 1574);
insert into MISSION (mdate, mid)
values (to_date('13-06-2005', 'dd-mm-yyyy'), 1575);
insert into MISSION (mdate, mid)
values (to_date('07-06-2005', 'dd-mm-yyyy'), 1576);
insert into MISSION (mdate, mid)
values (to_date('09-03-2003', 'dd-mm-yyyy'), 1577);
insert into MISSION (mdate, mid)
values (to_date('05-10-2000', 'dd-mm-yyyy'), 1578);
insert into MISSION (mdate, mid)
values (to_date('17-04-2007', 'dd-mm-yyyy'), 1579);
insert into MISSION (mdate, mid)
values (to_date('09-05-2014', 'dd-mm-yyyy'), 1580);
insert into MISSION (mdate, mid)
values (to_date('06-10-1995', 'dd-mm-yyyy'), 1581);
insert into MISSION (mdate, mid)
values (to_date('05-10-2011', 'dd-mm-yyyy'), 1582);
insert into MISSION (mdate, mid)
values (to_date('07-10-1995', 'dd-mm-yyyy'), 1583);
insert into MISSION (mdate, mid)
values (to_date('12-09-2002', 'dd-mm-yyyy'), 1584);
insert into MISSION (mdate, mid)
values (to_date('25-02-2014', 'dd-mm-yyyy'), 1585);
insert into MISSION (mdate, mid)
values (to_date('01-03-2018', 'dd-mm-yyyy'), 1586);
insert into MISSION (mdate, mid)
values (to_date('12-10-1994', 'dd-mm-yyyy'), 1587);
insert into MISSION (mdate, mid)
values (to_date('10-02-1991', 'dd-mm-yyyy'), 1588);
insert into MISSION (mdate, mid)
values (to_date('02-12-2021', 'dd-mm-yyyy'), 1589);
insert into MISSION (mdate, mid)
values (to_date('05-05-2022', 'dd-mm-yyyy'), 1590);
insert into MISSION (mdate, mid)
values (to_date('09-07-2006', 'dd-mm-yyyy'), 1591);
insert into MISSION (mdate, mid)
values (to_date('26-01-2000', 'dd-mm-yyyy'), 1592);
insert into MISSION (mdate, mid)
values (to_date('08-11-1995', 'dd-mm-yyyy'), 1593);
insert into MISSION (mdate, mid)
values (to_date('23-12-1997', 'dd-mm-yyyy'), 1594);
insert into MISSION (mdate, mid)
values (to_date('15-01-2010', 'dd-mm-yyyy'), 1595);
insert into MISSION (mdate, mid)
values (to_date('20-09-2007', 'dd-mm-yyyy'), 1596);
insert into MISSION (mdate, mid)
values (to_date('25-10-2001', 'dd-mm-yyyy'), 1597);
insert into MISSION (mdate, mid)
values (to_date('21-11-2019', 'dd-mm-yyyy'), 1598);
insert into MISSION (mdate, mid)
values (to_date('10-07-2022', 'dd-mm-yyyy'), 1599);
insert into MISSION (mdate, mid)
values (to_date('11-02-1990', 'dd-mm-yyyy'), 1600);
insert into MISSION (mdate, mid)
values (to_date('31-08-2022', 'dd-mm-yyyy'), 1601);
insert into MISSION (mdate, mid)
values (to_date('05-12-2011', 'dd-mm-yyyy'), 1602);
commit;
prompt 600 records committed...
insert into MISSION (mdate, mid)
values (to_date('10-12-1999', 'dd-mm-yyyy'), 1603);
insert into MISSION (mdate, mid)
values (to_date('16-07-2016', 'dd-mm-yyyy'), 1604);
insert into MISSION (mdate, mid)
values (to_date('01-07-1995', 'dd-mm-yyyy'), 1605);
insert into MISSION (mdate, mid)
values (to_date('01-10-2013', 'dd-mm-yyyy'), 1606);
insert into MISSION (mdate, mid)
values (to_date('24-02-2022', 'dd-mm-yyyy'), 1607);
insert into MISSION (mdate, mid)
values (to_date('26-10-2017', 'dd-mm-yyyy'), 1608);
insert into MISSION (mdate, mid)
values (to_date('30-11-1995', 'dd-mm-yyyy'), 1609);
insert into MISSION (mdate, mid)
values (to_date('15-07-1994', 'dd-mm-yyyy'), 1610);
insert into MISSION (mdate, mid)
values (to_date('07-08-1994', 'dd-mm-yyyy'), 1611);
insert into MISSION (mdate, mid)
values (to_date('18-10-2008', 'dd-mm-yyyy'), 1612);
insert into MISSION (mdate, mid)
values (to_date('12-02-2020', 'dd-mm-yyyy'), 1613);
insert into MISSION (mdate, mid)
values (to_date('22-11-1998', 'dd-mm-yyyy'), 1614);
insert into MISSION (mdate, mid)
values (to_date('16-02-2021', 'dd-mm-yyyy'), 1615);
insert into MISSION (mdate, mid)
values (to_date('02-06-2003', 'dd-mm-yyyy'), 1616);
insert into MISSION (mdate, mid)
values (to_date('16-12-2011', 'dd-mm-yyyy'), 1617);
insert into MISSION (mdate, mid)
values (to_date('28-07-1999', 'dd-mm-yyyy'), 1618);
insert into MISSION (mdate, mid)
values (to_date('11-09-2003', 'dd-mm-yyyy'), 1619);
insert into MISSION (mdate, mid)
values (to_date('19-01-1991', 'dd-mm-yyyy'), 1620);
insert into MISSION (mdate, mid)
values (to_date('23-04-1998', 'dd-mm-yyyy'), 1621);
insert into MISSION (mdate, mid)
values (to_date('26-09-1994', 'dd-mm-yyyy'), 1622);
insert into MISSION (mdate, mid)
values (to_date('02-11-2002', 'dd-mm-yyyy'), 1623);
insert into MISSION (mdate, mid)
values (to_date('07-01-2021', 'dd-mm-yyyy'), 1624);
insert into MISSION (mdate, mid)
values (to_date('08-05-2006', 'dd-mm-yyyy'), 1625);
insert into MISSION (mdate, mid)
values (to_date('28-10-2004', 'dd-mm-yyyy'), 1626);
insert into MISSION (mdate, mid)
values (to_date('25-04-1997', 'dd-mm-yyyy'), 1627);
insert into MISSION (mdate, mid)
values (to_date('23-06-2021', 'dd-mm-yyyy'), 1628);
insert into MISSION (mdate, mid)
values (to_date('19-08-2005', 'dd-mm-yyyy'), 1629);
insert into MISSION (mdate, mid)
values (to_date('11-05-1995', 'dd-mm-yyyy'), 1630);
insert into MISSION (mdate, mid)
values (to_date('18-03-1999', 'dd-mm-yyyy'), 1631);
insert into MISSION (mdate, mid)
values (to_date('20-01-2010', 'dd-mm-yyyy'), 1632);
insert into MISSION (mdate, mid)
values (to_date('18-01-1994', 'dd-mm-yyyy'), 1633);
insert into MISSION (mdate, mid)
values (to_date('09-03-1991', 'dd-mm-yyyy'), 1634);
insert into MISSION (mdate, mid)
values (to_date('20-05-2004', 'dd-mm-yyyy'), 1635);
insert into MISSION (mdate, mid)
values (to_date('21-12-2008', 'dd-mm-yyyy'), 1636);
insert into MISSION (mdate, mid)
values (to_date('19-01-1992', 'dd-mm-yyyy'), 1637);
insert into MISSION (mdate, mid)
values (to_date('23-12-1995', 'dd-mm-yyyy'), 1638);
insert into MISSION (mdate, mid)
values (to_date('06-03-1992', 'dd-mm-yyyy'), 1639);
insert into MISSION (mdate, mid)
values (to_date('09-07-2008', 'dd-mm-yyyy'), 1640);
insert into MISSION (mdate, mid)
values (to_date('15-09-2014', 'dd-mm-yyyy'), 1641);
insert into MISSION (mdate, mid)
values (to_date('18-01-1999', 'dd-mm-yyyy'), 1642);
insert into MISSION (mdate, mid)
values (to_date('20-08-1998', 'dd-mm-yyyy'), 1643);
insert into MISSION (mdate, mid)
values (to_date('27-01-2001', 'dd-mm-yyyy'), 1644);
insert into MISSION (mdate, mid)
values (to_date('05-07-2000', 'dd-mm-yyyy'), 1645);
insert into MISSION (mdate, mid)
values (to_date('29-09-1996', 'dd-mm-yyyy'), 1646);
insert into MISSION (mdate, mid)
values (to_date('12-09-1998', 'dd-mm-yyyy'), 1647);
insert into MISSION (mdate, mid)
values (to_date('26-01-2017', 'dd-mm-yyyy'), 1648);
insert into MISSION (mdate, mid)
values (to_date('29-12-2013', 'dd-mm-yyyy'), 1649);
insert into MISSION (mdate, mid)
values (to_date('04-01-1997', 'dd-mm-yyyy'), 1650);
insert into MISSION (mdate, mid)
values (to_date('27-02-2001', 'dd-mm-yyyy'), 1651);
insert into MISSION (mdate, mid)
values (to_date('31-08-2003', 'dd-mm-yyyy'), 1652);
insert into MISSION (mdate, mid)
values (to_date('21-07-1991', 'dd-mm-yyyy'), 1653);
insert into MISSION (mdate, mid)
values (to_date('14-11-2016', 'dd-mm-yyyy'), 1654);
insert into MISSION (mdate, mid)
values (to_date('23-04-2009', 'dd-mm-yyyy'), 1655);
insert into MISSION (mdate, mid)
values (to_date('15-11-2021', 'dd-mm-yyyy'), 1656);
insert into MISSION (mdate, mid)
values (to_date('10-01-1991', 'dd-mm-yyyy'), 1657);
insert into MISSION (mdate, mid)
values (to_date('30-11-1991', 'dd-mm-yyyy'), 1658);
insert into MISSION (mdate, mid)
values (to_date('10-07-2003', 'dd-mm-yyyy'), 1659);
insert into MISSION (mdate, mid)
values (to_date('12-07-1992', 'dd-mm-yyyy'), 1660);
insert into MISSION (mdate, mid)
values (to_date('01-01-2000', 'dd-mm-yyyy'), 1661);
insert into MISSION (mdate, mid)
values (to_date('20-01-2020', 'dd-mm-yyyy'), 1662);
insert into MISSION (mdate, mid)
values (to_date('17-04-2011', 'dd-mm-yyyy'), 1663);
insert into MISSION (mdate, mid)
values (to_date('26-04-2011', 'dd-mm-yyyy'), 1664);
insert into MISSION (mdate, mid)
values (to_date('24-10-2015', 'dd-mm-yyyy'), 1665);
insert into MISSION (mdate, mid)
values (to_date('23-02-2017', 'dd-mm-yyyy'), 1666);
insert into MISSION (mdate, mid)
values (to_date('01-06-2008', 'dd-mm-yyyy'), 1667);
insert into MISSION (mdate, mid)
values (to_date('10-09-2017', 'dd-mm-yyyy'), 1668);
insert into MISSION (mdate, mid)
values (to_date('20-09-1996', 'dd-mm-yyyy'), 1669);
insert into MISSION (mdate, mid)
values (to_date('18-03-2015', 'dd-mm-yyyy'), 1670);
insert into MISSION (mdate, mid)
values (to_date('07-05-1997', 'dd-mm-yyyy'), 1671);
insert into MISSION (mdate, mid)
values (to_date('07-07-2019', 'dd-mm-yyyy'), 1672);
insert into MISSION (mdate, mid)
values (to_date('17-10-2017', 'dd-mm-yyyy'), 1673);
insert into MISSION (mdate, mid)
values (to_date('29-04-1999', 'dd-mm-yyyy'), 1674);
insert into MISSION (mdate, mid)
values (to_date('28-11-2022', 'dd-mm-yyyy'), 1675);
insert into MISSION (mdate, mid)
values (to_date('04-08-2004', 'dd-mm-yyyy'), 1676);
insert into MISSION (mdate, mid)
values (to_date('30-05-2016', 'dd-mm-yyyy'), 1677);
insert into MISSION (mdate, mid)
values (to_date('13-07-2002', 'dd-mm-yyyy'), 1678);
insert into MISSION (mdate, mid)
values (to_date('19-11-1992', 'dd-mm-yyyy'), 1679);
insert into MISSION (mdate, mid)
values (to_date('13-08-1998', 'dd-mm-yyyy'), 1680);
insert into MISSION (mdate, mid)
values (to_date('08-06-2005', 'dd-mm-yyyy'), 1681);
insert into MISSION (mdate, mid)
values (to_date('22-03-1998', 'dd-mm-yyyy'), 1682);
insert into MISSION (mdate, mid)
values (to_date('23-03-2004', 'dd-mm-yyyy'), 1683);
insert into MISSION (mdate, mid)
values (to_date('15-01-2011', 'dd-mm-yyyy'), 1684);
insert into MISSION (mdate, mid)
values (to_date('28-06-1990', 'dd-mm-yyyy'), 1685);
insert into MISSION (mdate, mid)
values (to_date('10-11-1995', 'dd-mm-yyyy'), 1686);
insert into MISSION (mdate, mid)
values (to_date('28-10-2002', 'dd-mm-yyyy'), 1687);
insert into MISSION (mdate, mid)
values (to_date('14-12-2014', 'dd-mm-yyyy'), 1688);
insert into MISSION (mdate, mid)
values (to_date('15-11-1990', 'dd-mm-yyyy'), 1689);
insert into MISSION (mdate, mid)
values (to_date('23-01-1995', 'dd-mm-yyyy'), 1690);
insert into MISSION (mdate, mid)
values (to_date('12-02-2022', 'dd-mm-yyyy'), 1691);
insert into MISSION (mdate, mid)
values (to_date('07-01-2016', 'dd-mm-yyyy'), 1692);
insert into MISSION (mdate, mid)
values (to_date('09-01-2011', 'dd-mm-yyyy'), 1693);
insert into MISSION (mdate, mid)
values (to_date('07-05-2022', 'dd-mm-yyyy'), 1694);
insert into MISSION (mdate, mid)
values (to_date('02-01-2010', 'dd-mm-yyyy'), 1695);
insert into MISSION (mdate, mid)
values (to_date('18-12-2009', 'dd-mm-yyyy'), 1696);
insert into MISSION (mdate, mid)
values (to_date('20-08-2015', 'dd-mm-yyyy'), 1697);
insert into MISSION (mdate, mid)
values (to_date('01-02-2021', 'dd-mm-yyyy'), 1698);
insert into MISSION (mdate, mid)
values (to_date('12-10-2010', 'dd-mm-yyyy'), 1699);
insert into MISSION (mdate, mid)
values (to_date('09-04-1999', 'dd-mm-yyyy'), 1700);
insert into MISSION (mdate, mid)
values (to_date('26-09-2002', 'dd-mm-yyyy'), 1701);
insert into MISSION (mdate, mid)
values (to_date('18-06-2000', 'dd-mm-yyyy'), 1702);
commit;
prompt 700 records committed...
insert into MISSION (mdate, mid)
values (to_date('14-02-1992', 'dd-mm-yyyy'), 1703);
insert into MISSION (mdate, mid)
values (to_date('18-12-2016', 'dd-mm-yyyy'), 1704);
insert into MISSION (mdate, mid)
values (to_date('05-06-2013', 'dd-mm-yyyy'), 1705);
insert into MISSION (mdate, mid)
values (to_date('22-06-1999', 'dd-mm-yyyy'), 1706);
insert into MISSION (mdate, mid)
values (to_date('27-04-2001', 'dd-mm-yyyy'), 1707);
insert into MISSION (mdate, mid)
values (to_date('24-09-2014', 'dd-mm-yyyy'), 1708);
insert into MISSION (mdate, mid)
values (to_date('20-01-1991', 'dd-mm-yyyy'), 1709);
insert into MISSION (mdate, mid)
values (to_date('15-04-1991', 'dd-mm-yyyy'), 1710);
insert into MISSION (mdate, mid)
values (to_date('01-04-1990', 'dd-mm-yyyy'), 1711);
insert into MISSION (mdate, mid)
values (to_date('17-09-2008', 'dd-mm-yyyy'), 1712);
insert into MISSION (mdate, mid)
values (to_date('19-12-2004', 'dd-mm-yyyy'), 1713);
insert into MISSION (mdate, mid)
values (to_date('06-07-1993', 'dd-mm-yyyy'), 1714);
insert into MISSION (mdate, mid)
values (to_date('28-10-2009', 'dd-mm-yyyy'), 1715);
insert into MISSION (mdate, mid)
values (to_date('11-12-2002', 'dd-mm-yyyy'), 862);
insert into MISSION (mdate, mid)
values (to_date('21-04-1997', 'dd-mm-yyyy'), 863);
insert into MISSION (mdate, mid)
values (to_date('18-04-1997', 'dd-mm-yyyy'), 864);
insert into MISSION (mdate, mid)
values (to_date('12-10-2002', 'dd-mm-yyyy'), 865);
insert into MISSION (mdate, mid)
values (to_date('22-11-2015', 'dd-mm-yyyy'), 866);
insert into MISSION (mdate, mid)
values (to_date('21-05-2006', 'dd-mm-yyyy'), 867);
insert into MISSION (mdate, mid)
values (to_date('11-04-2003', 'dd-mm-yyyy'), 868);
insert into MISSION (mdate, mid)
values (to_date('21-09-2006', 'dd-mm-yyyy'), 869);
insert into MISSION (mdate, mid)
values (to_date('09-08-2002', 'dd-mm-yyyy'), 870);
insert into MISSION (mdate, mid)
values (to_date('27-10-1994', 'dd-mm-yyyy'), 871);
insert into MISSION (mdate, mid)
values (to_date('25-03-1999', 'dd-mm-yyyy'), 872);
insert into MISSION (mdate, mid)
values (to_date('27-05-2010', 'dd-mm-yyyy'), 873);
insert into MISSION (mdate, mid)
values (to_date('19-10-2004', 'dd-mm-yyyy'), 874);
insert into MISSION (mdate, mid)
values (to_date('10-12-2004', 'dd-mm-yyyy'), 875);
insert into MISSION (mdate, mid)
values (to_date('28-03-2017', 'dd-mm-yyyy'), 876);
insert into MISSION (mdate, mid)
values (to_date('13-02-1994', 'dd-mm-yyyy'), 877);
insert into MISSION (mdate, mid)
values (to_date('11-02-2005', 'dd-mm-yyyy'), 878);
insert into MISSION (mdate, mid)
values (to_date('07-05-2017', 'dd-mm-yyyy'), 879);
insert into MISSION (mdate, mid)
values (to_date('30-03-1992', 'dd-mm-yyyy'), 880);
insert into MISSION (mdate, mid)
values (to_date('05-02-2015', 'dd-mm-yyyy'), 881);
insert into MISSION (mdate, mid)
values (to_date('14-03-2016', 'dd-mm-yyyy'), 882);
insert into MISSION (mdate, mid)
values (to_date('24-08-2006', 'dd-mm-yyyy'), 883);
insert into MISSION (mdate, mid)
values (to_date('17-09-2005', 'dd-mm-yyyy'), 884);
insert into MISSION (mdate, mid)
values (to_date('15-08-1996', 'dd-mm-yyyy'), 885);
insert into MISSION (mdate, mid)
values (to_date('15-10-1997', 'dd-mm-yyyy'), 886);
insert into MISSION (mdate, mid)
values (to_date('30-11-1994', 'dd-mm-yyyy'), 887);
insert into MISSION (mdate, mid)
values (to_date('26-11-2022', 'dd-mm-yyyy'), 888);
insert into MISSION (mdate, mid)
values (to_date('09-12-2020', 'dd-mm-yyyy'), 889);
insert into MISSION (mdate, mid)
values (to_date('27-09-2015', 'dd-mm-yyyy'), 890);
insert into MISSION (mdate, mid)
values (to_date('13-02-1995', 'dd-mm-yyyy'), 891);
insert into MISSION (mdate, mid)
values (to_date('02-11-2003', 'dd-mm-yyyy'), 892);
insert into MISSION (mdate, mid)
values (to_date('11-11-2015', 'dd-mm-yyyy'), 893);
insert into MISSION (mdate, mid)
values (to_date('08-05-2009', 'dd-mm-yyyy'), 894);
insert into MISSION (mdate, mid)
values (to_date('13-12-2008', 'dd-mm-yyyy'), 895);
insert into MISSION (mdate, mid)
values (to_date('05-06-2022', 'dd-mm-yyyy'), 896);
insert into MISSION (mdate, mid)
values (to_date('02-02-2010', 'dd-mm-yyyy'), 897);
insert into MISSION (mdate, mid)
values (to_date('23-07-1993', 'dd-mm-yyyy'), 898);
insert into MISSION (mdate, mid)
values (to_date('28-10-2020', 'dd-mm-yyyy'), 899);
insert into MISSION (mdate, mid)
values (to_date('11-06-2003', 'dd-mm-yyyy'), 900);
insert into MISSION (mdate, mid)
values (to_date('11-09-1995', 'dd-mm-yyyy'), 901);
insert into MISSION (mdate, mid)
values (to_date('09-09-2012', 'dd-mm-yyyy'), 902);
insert into MISSION (mdate, mid)
values (to_date('11-01-2004', 'dd-mm-yyyy'), 903);
insert into MISSION (mdate, mid)
values (to_date('13-03-2015', 'dd-mm-yyyy'), 904);
insert into MISSION (mdate, mid)
values (to_date('29-04-1995', 'dd-mm-yyyy'), 905);
insert into MISSION (mdate, mid)
values (to_date('18-12-1995', 'dd-mm-yyyy'), 906);
insert into MISSION (mdate, mid)
values (to_date('09-04-1996', 'dd-mm-yyyy'), 907);
insert into MISSION (mdate, mid)
values (to_date('11-03-2018', 'dd-mm-yyyy'), 908);
insert into MISSION (mdate, mid)
values (to_date('01-01-2016', 'dd-mm-yyyy'), 909);
insert into MISSION (mdate, mid)
values (to_date('29-11-2002', 'dd-mm-yyyy'), 910);
insert into MISSION (mdate, mid)
values (to_date('31-01-2013', 'dd-mm-yyyy'), 911);
insert into MISSION (mdate, mid)
values (to_date('25-01-1991', 'dd-mm-yyyy'), 912);
insert into MISSION (mdate, mid)
values (to_date('19-08-2008', 'dd-mm-yyyy'), 913);
insert into MISSION (mdate, mid)
values (to_date('11-05-2002', 'dd-mm-yyyy'), 914);
insert into MISSION (mdate, mid)
values (to_date('28-10-2004', 'dd-mm-yyyy'), 915);
insert into MISSION (mdate, mid)
values (to_date('30-07-2010', 'dd-mm-yyyy'), 916);
insert into MISSION (mdate, mid)
values (to_date('28-07-1993', 'dd-mm-yyyy'), 917);
insert into MISSION (mdate, mid)
values (to_date('11-09-2019', 'dd-mm-yyyy'), 918);
insert into MISSION (mdate, mid)
values (to_date('10-04-2005', 'dd-mm-yyyy'), 919);
insert into MISSION (mdate, mid)
values (to_date('05-07-2002', 'dd-mm-yyyy'), 920);
insert into MISSION (mdate, mid)
values (to_date('13-11-1992', 'dd-mm-yyyy'), 921);
insert into MISSION (mdate, mid)
values (to_date('11-07-2010', 'dd-mm-yyyy'), 922);
insert into MISSION (mdate, mid)
values (to_date('20-01-2001', 'dd-mm-yyyy'), 923);
insert into MISSION (mdate, mid)
values (to_date('10-09-2010', 'dd-mm-yyyy'), 924);
insert into MISSION (mdate, mid)
values (to_date('12-01-2012', 'dd-mm-yyyy'), 925);
insert into MISSION (mdate, mid)
values (to_date('24-12-2014', 'dd-mm-yyyy'), 926);
insert into MISSION (mdate, mid)
values (to_date('08-05-2016', 'dd-mm-yyyy'), 927);
insert into MISSION (mdate, mid)
values (to_date('19-07-1991', 'dd-mm-yyyy'), 928);
insert into MISSION (mdate, mid)
values (to_date('16-06-1992', 'dd-mm-yyyy'), 929);
insert into MISSION (mdate, mid)
values (to_date('20-03-2000', 'dd-mm-yyyy'), 930);
insert into MISSION (mdate, mid)
values (to_date('01-09-1991', 'dd-mm-yyyy'), 931);
insert into MISSION (mdate, mid)
values (to_date('30-10-1997', 'dd-mm-yyyy'), 932);
insert into MISSION (mdate, mid)
values (to_date('03-11-1993', 'dd-mm-yyyy'), 933);
insert into MISSION (mdate, mid)
values (to_date('16-12-1994', 'dd-mm-yyyy'), 934);
insert into MISSION (mdate, mid)
values (to_date('12-08-2000', 'dd-mm-yyyy'), 935);
insert into MISSION (mdate, mid)
values (to_date('05-07-2006', 'dd-mm-yyyy'), 936);
insert into MISSION (mdate, mid)
values (to_date('13-03-2016', 'dd-mm-yyyy'), 937);
insert into MISSION (mdate, mid)
values (to_date('15-01-2006', 'dd-mm-yyyy'), 938);
insert into MISSION (mdate, mid)
values (to_date('19-12-2003', 'dd-mm-yyyy'), 939);
insert into MISSION (mdate, mid)
values (to_date('28-11-2006', 'dd-mm-yyyy'), 940);
insert into MISSION (mdate, mid)
values (to_date('13-05-2001', 'dd-mm-yyyy'), 941);
insert into MISSION (mdate, mid)
values (to_date('12-05-2007', 'dd-mm-yyyy'), 942);
insert into MISSION (mdate, mid)
values (to_date('06-06-1998', 'dd-mm-yyyy'), 943);
insert into MISSION (mdate, mid)
values (to_date('09-08-2016', 'dd-mm-yyyy'), 944);
insert into MISSION (mdate, mid)
values (to_date('27-01-2001', 'dd-mm-yyyy'), 945);
insert into MISSION (mdate, mid)
values (to_date('02-09-2002', 'dd-mm-yyyy'), 946);
insert into MISSION (mdate, mid)
values (to_date('03-12-2006', 'dd-mm-yyyy'), 947);
insert into MISSION (mdate, mid)
values (to_date('07-09-1997', 'dd-mm-yyyy'), 948);
commit;
prompt 800 records committed...
insert into MISSION (mdate, mid)
values (to_date('23-12-2011', 'dd-mm-yyyy'), 949);
insert into MISSION (mdate, mid)
values (to_date('04-02-2007', 'dd-mm-yyyy'), 950);
insert into MISSION (mdate, mid)
values (to_date('19-04-1992', 'dd-mm-yyyy'), 951);
insert into MISSION (mdate, mid)
values (to_date('23-04-2017', 'dd-mm-yyyy'), 952);
insert into MISSION (mdate, mid)
values (to_date('10-03-2009', 'dd-mm-yyyy'), 953);
insert into MISSION (mdate, mid)
values (to_date('17-05-1998', 'dd-mm-yyyy'), 954);
insert into MISSION (mdate, mid)
values (to_date('08-10-2015', 'dd-mm-yyyy'), 955);
insert into MISSION (mdate, mid)
values (to_date('16-10-2014', 'dd-mm-yyyy'), 956);
insert into MISSION (mdate, mid)
values (to_date('08-04-1992', 'dd-mm-yyyy'), 957);
insert into MISSION (mdate, mid)
values (to_date('27-02-1996', 'dd-mm-yyyy'), 958);
insert into MISSION (mdate, mid)
values (to_date('03-07-2012', 'dd-mm-yyyy'), 959);
insert into MISSION (mdate, mid)
values (to_date('15-07-1997', 'dd-mm-yyyy'), 960);
insert into MISSION (mdate, mid)
values (to_date('16-09-1997', 'dd-mm-yyyy'), 961);
insert into MISSION (mdate, mid)
values (to_date('05-11-2006', 'dd-mm-yyyy'), 962);
insert into MISSION (mdate, mid)
values (to_date('01-03-2017', 'dd-mm-yyyy'), 963);
insert into MISSION (mdate, mid)
values (to_date('04-08-2011', 'dd-mm-yyyy'), 964);
insert into MISSION (mdate, mid)
values (to_date('14-04-2007', 'dd-mm-yyyy'), 965);
insert into MISSION (mdate, mid)
values (to_date('14-11-2008', 'dd-mm-yyyy'), 966);
insert into MISSION (mdate, mid)
values (to_date('22-04-1997', 'dd-mm-yyyy'), 967);
insert into MISSION (mdate, mid)
values (to_date('01-09-1999', 'dd-mm-yyyy'), 968);
insert into MISSION (mdate, mid)
values (to_date('28-11-2019', 'dd-mm-yyyy'), 969);
insert into MISSION (mdate, mid)
values (to_date('05-05-1996', 'dd-mm-yyyy'), 970);
insert into MISSION (mdate, mid)
values (to_date('11-12-2011', 'dd-mm-yyyy'), 971);
insert into MISSION (mdate, mid)
values (to_date('03-11-1997', 'dd-mm-yyyy'), 972);
insert into MISSION (mdate, mid)
values (to_date('28-10-2001', 'dd-mm-yyyy'), 973);
insert into MISSION (mdate, mid)
values (to_date('15-06-2008', 'dd-mm-yyyy'), 974);
insert into MISSION (mdate, mid)
values (to_date('16-09-2001', 'dd-mm-yyyy'), 975);
insert into MISSION (mdate, mid)
values (to_date('09-05-2008', 'dd-mm-yyyy'), 976);
insert into MISSION (mdate, mid)
values (to_date('02-04-1999', 'dd-mm-yyyy'), 977);
insert into MISSION (mdate, mid)
values (to_date('27-02-2014', 'dd-mm-yyyy'), 978);
insert into MISSION (mdate, mid)
values (to_date('23-05-2010', 'dd-mm-yyyy'), 979);
insert into MISSION (mdate, mid)
values (to_date('27-02-2016', 'dd-mm-yyyy'), 980);
insert into MISSION (mdate, mid)
values (to_date('01-11-2012', 'dd-mm-yyyy'), 981);
insert into MISSION (mdate, mid)
values (to_date('17-11-1991', 'dd-mm-yyyy'), 982);
insert into MISSION (mdate, mid)
values (to_date('13-10-1995', 'dd-mm-yyyy'), 983);
insert into MISSION (mdate, mid)
values (to_date('27-02-1998', 'dd-mm-yyyy'), 984);
insert into MISSION (mdate, mid)
values (to_date('19-07-2000', 'dd-mm-yyyy'), 985);
insert into MISSION (mdate, mid)
values (to_date('20-05-1991', 'dd-mm-yyyy'), 986);
insert into MISSION (mdate, mid)
values (to_date('11-02-2013', 'dd-mm-yyyy'), 987);
insert into MISSION (mdate, mid)
values (to_date('24-04-2013', 'dd-mm-yyyy'), 988);
insert into MISSION (mdate, mid)
values (to_date('31-10-2020', 'dd-mm-yyyy'), 989);
insert into MISSION (mdate, mid)
values (to_date('12-01-2006', 'dd-mm-yyyy'), 990);
insert into MISSION (mdate, mid)
values (to_date('23-07-2011', 'dd-mm-yyyy'), 991);
insert into MISSION (mdate, mid)
values (to_date('29-12-2007', 'dd-mm-yyyy'), 992);
insert into MISSION (mdate, mid)
values (to_date('05-03-2008', 'dd-mm-yyyy'), 993);
insert into MISSION (mdate, mid)
values (to_date('30-12-2019', 'dd-mm-yyyy'), 994);
insert into MISSION (mdate, mid)
values (to_date('20-06-2010', 'dd-mm-yyyy'), 995);
insert into MISSION (mdate, mid)
values (to_date('30-04-2002', 'dd-mm-yyyy'), 996);
insert into MISSION (mdate, mid)
values (to_date('28-05-2001', 'dd-mm-yyyy'), 997);
insert into MISSION (mdate, mid)
values (to_date('25-03-2009', 'dd-mm-yyyy'), 998);
insert into MISSION (mdate, mid)
values (to_date('21-06-2011', 'dd-mm-yyyy'), 999);
insert into MISSION (mdate, mid)
values (to_date('18-05-2011', 'dd-mm-yyyy'), 1000);
insert into MISSION (mdate, mid)
values (to_date('12-05-2003', 'dd-mm-yyyy'), 1001);
insert into MISSION (mdate, mid)
values (to_date('03-04-2013', 'dd-mm-yyyy'), 1002);
insert into MISSION (mdate, mid)
values (to_date('04-07-2000', 'dd-mm-yyyy'), 1003);
insert into MISSION (mdate, mid)
values (to_date('22-05-2020', 'dd-mm-yyyy'), 1004);
insert into MISSION (mdate, mid)
values (to_date('11-10-2011', 'dd-mm-yyyy'), 1005);
insert into MISSION (mdate, mid)
values (to_date('05-01-2007', 'dd-mm-yyyy'), 1006);
insert into MISSION (mdate, mid)
values (to_date('21-05-2006', 'dd-mm-yyyy'), 1007);
insert into MISSION (mdate, mid)
values (to_date('02-07-2011', 'dd-mm-yyyy'), 1008);
insert into MISSION (mdate, mid)
values (to_date('03-07-2010', 'dd-mm-yyyy'), 1009);
insert into MISSION (mdate, mid)
values (to_date('30-05-2003', 'dd-mm-yyyy'), 1010);
insert into MISSION (mdate, mid)
values (to_date('26-07-1992', 'dd-mm-yyyy'), 1011);
insert into MISSION (mdate, mid)
values (to_date('29-07-2014', 'dd-mm-yyyy'), 1012);
insert into MISSION (mdate, mid)
values (to_date('01-06-2015', 'dd-mm-yyyy'), 1013);
insert into MISSION (mdate, mid)
values (to_date('02-04-2000', 'dd-mm-yyyy'), 1014);
insert into MISSION (mdate, mid)
values (to_date('27-02-1994', 'dd-mm-yyyy'), 1015);
insert into MISSION (mdate, mid)
values (to_date('11-02-1998', 'dd-mm-yyyy'), 1016);
insert into MISSION (mdate, mid)
values (to_date('08-08-2013', 'dd-mm-yyyy'), 1017);
insert into MISSION (mdate, mid)
values (to_date('20-09-2020', 'dd-mm-yyyy'), 1018);
insert into MISSION (mdate, mid)
values (to_date('08-05-1996', 'dd-mm-yyyy'), 1019);
insert into MISSION (mdate, mid)
values (to_date('20-05-2018', 'dd-mm-yyyy'), 1020);
insert into MISSION (mdate, mid)
values (to_date('28-09-2005', 'dd-mm-yyyy'), 1021);
insert into MISSION (mdate, mid)
values (to_date('03-08-2009', 'dd-mm-yyyy'), 1022);
insert into MISSION (mdate, mid)
values (to_date('16-10-2015', 'dd-mm-yyyy'), 1023);
insert into MISSION (mdate, mid)
values (to_date('18-03-1997', 'dd-mm-yyyy'), 1024);
insert into MISSION (mdate, mid)
values (to_date('17-09-2006', 'dd-mm-yyyy'), 1025);
insert into MISSION (mdate, mid)
values (to_date('19-10-2015', 'dd-mm-yyyy'), 1026);
insert into MISSION (mdate, mid)
values (to_date('09-08-1996', 'dd-mm-yyyy'), 1027);
insert into MISSION (mdate, mid)
values (to_date('03-02-1992', 'dd-mm-yyyy'), 1028);
insert into MISSION (mdate, mid)
values (to_date('10-11-1999', 'dd-mm-yyyy'), 1029);
insert into MISSION (mdate, mid)
values (to_date('01-03-2011', 'dd-mm-yyyy'), 1030);
insert into MISSION (mdate, mid)
values (to_date('10-02-1999', 'dd-mm-yyyy'), 1031);
insert into MISSION (mdate, mid)
values (to_date('19-07-2015', 'dd-mm-yyyy'), 1032);
insert into MISSION (mdate, mid)
values (to_date('21-06-2013', 'dd-mm-yyyy'), 1033);
insert into MISSION (mdate, mid)
values (to_date('29-03-1990', 'dd-mm-yyyy'), 1034);
insert into MISSION (mdate, mid)
values (to_date('09-05-2012', 'dd-mm-yyyy'), 1035);
insert into MISSION (mdate, mid)
values (to_date('29-11-2019', 'dd-mm-yyyy'), 1036);
insert into MISSION (mdate, mid)
values (to_date('15-05-2001', 'dd-mm-yyyy'), 1037);
insert into MISSION (mdate, mid)
values (to_date('06-09-2014', 'dd-mm-yyyy'), 1038);
insert into MISSION (mdate, mid)
values (to_date('22-01-2017', 'dd-mm-yyyy'), 1039);
insert into MISSION (mdate, mid)
values (to_date('12-12-2011', 'dd-mm-yyyy'), 1040);
insert into MISSION (mdate, mid)
values (to_date('10-09-2009', 'dd-mm-yyyy'), 1041);
insert into MISSION (mdate, mid)
values (to_date('07-08-2005', 'dd-mm-yyyy'), 1042);
insert into MISSION (mdate, mid)
values (to_date('06-09-2009', 'dd-mm-yyyy'), 1043);
insert into MISSION (mdate, mid)
values (to_date('20-12-2005', 'dd-mm-yyyy'), 1044);
insert into MISSION (mdate, mid)
values (to_date('02-04-1998', 'dd-mm-yyyy'), 1045);
insert into MISSION (mdate, mid)
values (to_date('06-10-2019', 'dd-mm-yyyy'), 1046);
insert into MISSION (mdate, mid)
values (to_date('05-07-2003', 'dd-mm-yyyy'), 1047);
insert into MISSION (mdate, mid)
values (to_date('08-06-1994', 'dd-mm-yyyy'), 1048);
commit;
prompt 900 records committed...
insert into MISSION (mdate, mid)
values (to_date('12-01-2013', 'dd-mm-yyyy'), 1049);
insert into MISSION (mdate, mid)
values (to_date('24-08-2004', 'dd-mm-yyyy'), 1050);
insert into MISSION (mdate, mid)
values (to_date('11-02-1998', 'dd-mm-yyyy'), 1051);
insert into MISSION (mdate, mid)
values (to_date('02-02-1991', 'dd-mm-yyyy'), 1052);
insert into MISSION (mdate, mid)
values (to_date('13-10-1995', 'dd-mm-yyyy'), 1053);
insert into MISSION (mdate, mid)
values (to_date('22-08-2015', 'dd-mm-yyyy'), 1054);
insert into MISSION (mdate, mid)
values (to_date('18-08-2015', 'dd-mm-yyyy'), 1055);
insert into MISSION (mdate, mid)
values (to_date('10-03-2012', 'dd-mm-yyyy'), 1056);
insert into MISSION (mdate, mid)
values (to_date('07-09-2009', 'dd-mm-yyyy'), 1057);
insert into MISSION (mdate, mid)
values (to_date('19-12-2005', 'dd-mm-yyyy'), 1058);
insert into MISSION (mdate, mid)
values (to_date('06-07-2013', 'dd-mm-yyyy'), 1059);
insert into MISSION (mdate, mid)
values (to_date('24-05-2001', 'dd-mm-yyyy'), 1060);
insert into MISSION (mdate, mid)
values (to_date('22-07-2018', 'dd-mm-yyyy'), 1061);
insert into MISSION (mdate, mid)
values (to_date('15-02-1991', 'dd-mm-yyyy'), 1062);
insert into MISSION (mdate, mid)
values (to_date('17-11-2019', 'dd-mm-yyyy'), 1063);
insert into MISSION (mdate, mid)
values (to_date('16-04-2009', 'dd-mm-yyyy'), 1064);
insert into MISSION (mdate, mid)
values (to_date('05-03-2015', 'dd-mm-yyyy'), 1065);
insert into MISSION (mdate, mid)
values (to_date('05-11-2011', 'dd-mm-yyyy'), 1066);
insert into MISSION (mdate, mid)
values (to_date('27-07-2020', 'dd-mm-yyyy'), 1067);
insert into MISSION (mdate, mid)
values (to_date('19-09-2022', 'dd-mm-yyyy'), 1068);
insert into MISSION (mdate, mid)
values (to_date('12-07-2015', 'dd-mm-yyyy'), 1069);
insert into MISSION (mdate, mid)
values (to_date('05-12-2020', 'dd-mm-yyyy'), 1070);
insert into MISSION (mdate, mid)
values (to_date('26-06-1993', 'dd-mm-yyyy'), 1071);
insert into MISSION (mdate, mid)
values (to_date('15-04-2002', 'dd-mm-yyyy'), 1072);
insert into MISSION (mdate, mid)
values (to_date('13-03-2005', 'dd-mm-yyyy'), 1073);
insert into MISSION (mdate, mid)
values (to_date('22-06-1992', 'dd-mm-yyyy'), 1074);
insert into MISSION (mdate, mid)
values (to_date('11-11-1998', 'dd-mm-yyyy'), 1075);
insert into MISSION (mdate, mid)
values (to_date('28-10-2001', 'dd-mm-yyyy'), 1076);
insert into MISSION (mdate, mid)
values (to_date('20-02-1998', 'dd-mm-yyyy'), 1077);
insert into MISSION (mdate, mid)
values (to_date('11-04-1999', 'dd-mm-yyyy'), 1078);
insert into MISSION (mdate, mid)
values (to_date('18-07-2011', 'dd-mm-yyyy'), 1079);
insert into MISSION (mdate, mid)
values (to_date('01-08-2020', 'dd-mm-yyyy'), 1080);
insert into MISSION (mdate, mid)
values (to_date('11-07-2013', 'dd-mm-yyyy'), 1081);
insert into MISSION (mdate, mid)
values (to_date('28-06-2012', 'dd-mm-yyyy'), 1082);
insert into MISSION (mdate, mid)
values (to_date('09-06-2014', 'dd-mm-yyyy'), 1083);
insert into MISSION (mdate, mid)
values (to_date('18-06-2006', 'dd-mm-yyyy'), 1084);
insert into MISSION (mdate, mid)
values (to_date('05-07-2015', 'dd-mm-yyyy'), 1085);
insert into MISSION (mdate, mid)
values (to_date('26-10-2010', 'dd-mm-yyyy'), 1086);
insert into MISSION (mdate, mid)
values (to_date('22-08-2022', 'dd-mm-yyyy'), 1087);
insert into MISSION (mdate, mid)
values (to_date('18-08-2007', 'dd-mm-yyyy'), 1088);
insert into MISSION (mdate, mid)
values (to_date('21-12-2000', 'dd-mm-yyyy'), 1089);
insert into MISSION (mdate, mid)
values (to_date('15-10-2004', 'dd-mm-yyyy'), 1090);
insert into MISSION (mdate, mid)
values (to_date('30-12-2012', 'dd-mm-yyyy'), 1091);
insert into MISSION (mdate, mid)
values (to_date('11-03-2016', 'dd-mm-yyyy'), 1092);
insert into MISSION (mdate, mid)
values (to_date('07-09-1999', 'dd-mm-yyyy'), 1093);
insert into MISSION (mdate, mid)
values (to_date('23-11-2018', 'dd-mm-yyyy'), 1094);
insert into MISSION (mdate, mid)
values (to_date('21-01-2006', 'dd-mm-yyyy'), 1095);
insert into MISSION (mdate, mid)
values (to_date('02-12-2012', 'dd-mm-yyyy'), 1096);
insert into MISSION (mdate, mid)
values (to_date('01-06-1990', 'dd-mm-yyyy'), 1097);
insert into MISSION (mdate, mid)
values (to_date('07-09-2016', 'dd-mm-yyyy'), 1098);
insert into MISSION (mdate, mid)
values (to_date('21-08-1994', 'dd-mm-yyyy'), 1099);
insert into MISSION (mdate, mid)
values (to_date('24-01-2004', 'dd-mm-yyyy'), 1100);
insert into MISSION (mdate, mid)
values (to_date('07-12-2008', 'dd-mm-yyyy'), 1101);
insert into MISSION (mdate, mid)
values (to_date('23-01-1993', 'dd-mm-yyyy'), 1102);
insert into MISSION (mdate, mid)
values (to_date('17-07-2015', 'dd-mm-yyyy'), 1103);
insert into MISSION (mdate, mid)
values (to_date('30-10-2014', 'dd-mm-yyyy'), 1104);
insert into MISSION (mdate, mid)
values (to_date('26-11-2005', 'dd-mm-yyyy'), 1105);
insert into MISSION (mdate, mid)
values (to_date('13-05-2004', 'dd-mm-yyyy'), 1106);
insert into MISSION (mdate, mid)
values (to_date('11-02-2009', 'dd-mm-yyyy'), 1107);
insert into MISSION (mdate, mid)
values (to_date('30-01-2012', 'dd-mm-yyyy'), 1108);
insert into MISSION (mdate, mid)
values (to_date('22-02-2011', 'dd-mm-yyyy'), 1109);
insert into MISSION (mdate, mid)
values (to_date('27-12-2013', 'dd-mm-yyyy'), 1110);
insert into MISSION (mdate, mid)
values (to_date('18-08-2010', 'dd-mm-yyyy'), 1111);
insert into MISSION (mdate, mid)
values (to_date('25-03-2001', 'dd-mm-yyyy'), 1112);
insert into MISSION (mdate, mid)
values (to_date('16-10-2013', 'dd-mm-yyyy'), 1113);
insert into MISSION (mdate, mid)
values (to_date('28-08-2000', 'dd-mm-yyyy'), 1114);
insert into MISSION (mdate, mid)
values (to_date('28-09-2004', 'dd-mm-yyyy'), 1115);
insert into MISSION (mdate, mid)
values (to_date('30-06-2022', 'dd-mm-yyyy'), 1116);
insert into MISSION (mdate, mid)
values (to_date('29-03-1999', 'dd-mm-yyyy'), 1117);
insert into MISSION (mdate, mid)
values (to_date('06-08-1992', 'dd-mm-yyyy'), 1118);
insert into MISSION (mdate, mid)
values (to_date('12-07-2003', 'dd-mm-yyyy'), 1119);
insert into MISSION (mdate, mid)
values (to_date('07-12-2010', 'dd-mm-yyyy'), 1120);
insert into MISSION (mdate, mid)
values (to_date('23-12-1997', 'dd-mm-yyyy'), 1121);
insert into MISSION (mdate, mid)
values (to_date('17-02-1996', 'dd-mm-yyyy'), 1122);
insert into MISSION (mdate, mid)
values (to_date('10-10-1992', 'dd-mm-yyyy'), 1123);
insert into MISSION (mdate, mid)
values (to_date('27-11-2020', 'dd-mm-yyyy'), 1124);
insert into MISSION (mdate, mid)
values (to_date('06-09-2009', 'dd-mm-yyyy'), 1125);
insert into MISSION (mdate, mid)
values (to_date('02-08-1993', 'dd-mm-yyyy'), 1126);
insert into MISSION (mdate, mid)
values (to_date('30-07-1993', 'dd-mm-yyyy'), 1127);
insert into MISSION (mdate, mid)
values (to_date('15-12-2003', 'dd-mm-yyyy'), 1128);
insert into MISSION (mdate, mid)
values (to_date('01-03-2004', 'dd-mm-yyyy'), 1129);
insert into MISSION (mdate, mid)
values (to_date('18-06-1995', 'dd-mm-yyyy'), 1130);
insert into MISSION (mdate, mid)
values (to_date('02-06-1999', 'dd-mm-yyyy'), 1131);
insert into MISSION (mdate, mid)
values (to_date('03-03-2020', 'dd-mm-yyyy'), 1132);
insert into MISSION (mdate, mid)
values (to_date('15-01-2011', 'dd-mm-yyyy'), 1133);
insert into MISSION (mdate, mid)
values (to_date('19-03-2008', 'dd-mm-yyyy'), 1134);
insert into MISSION (mdate, mid)
values (to_date('04-04-2019', 'dd-mm-yyyy'), 1135);
insert into MISSION (mdate, mid)
values (to_date('31-07-2022', 'dd-mm-yyyy'), 1136);
insert into MISSION (mdate, mid)
values (to_date('20-03-2021', 'dd-mm-yyyy'), 1137);
insert into MISSION (mdate, mid)
values (to_date('05-03-2018', 'dd-mm-yyyy'), 1138);
insert into MISSION (mdate, mid)
values (to_date('08-05-2003', 'dd-mm-yyyy'), 1139);
insert into MISSION (mdate, mid)
values (to_date('15-02-2012', 'dd-mm-yyyy'), 1140);
insert into MISSION (mdate, mid)
values (to_date('06-08-1992', 'dd-mm-yyyy'), 1141);
insert into MISSION (mdate, mid)
values (to_date('03-06-2001', 'dd-mm-yyyy'), 1142);
insert into MISSION (mdate, mid)
values (to_date('05-10-1997', 'dd-mm-yyyy'), 1143);
insert into MISSION (mdate, mid)
values (to_date('28-03-2016', 'dd-mm-yyyy'), 1144);
insert into MISSION (mdate, mid)
values (to_date('20-07-1996', 'dd-mm-yyyy'), 1145);
insert into MISSION (mdate, mid)
values (to_date('23-08-2010', 'dd-mm-yyyy'), 1146);
insert into MISSION (mdate, mid)
values (to_date('05-11-1990', 'dd-mm-yyyy'), 1147);
insert into MISSION (mdate, mid)
values (to_date('16-02-2012', 'dd-mm-yyyy'), 1148);
commit;
prompt 1000 records committed...
insert into MISSION (mdate, mid)
values (to_date('21-01-2022', 'dd-mm-yyyy'), 1149);
insert into MISSION (mdate, mid)
values (to_date('07-04-2002', 'dd-mm-yyyy'), 1150);
insert into MISSION (mdate, mid)
values (to_date('21-02-2012', 'dd-mm-yyyy'), 1151);
insert into MISSION (mdate, mid)
values (to_date('18-03-1990', 'dd-mm-yyyy'), 1152);
insert into MISSION (mdate, mid)
values (to_date('12-08-2018', 'dd-mm-yyyy'), 1153);
insert into MISSION (mdate, mid)
values (to_date('08-06-1999', 'dd-mm-yyyy'), 1154);
insert into MISSION (mdate, mid)
values (to_date('10-06-1996', 'dd-mm-yyyy'), 1155);
insert into MISSION (mdate, mid)
values (to_date('27-05-1998', 'dd-mm-yyyy'), 1156);
insert into MISSION (mdate, mid)
values (to_date('08-04-2008', 'dd-mm-yyyy'), 1157);
insert into MISSION (mdate, mid)
values (to_date('20-08-2006', 'dd-mm-yyyy'), 1158);
insert into MISSION (mdate, mid)
values (to_date('04-01-1990', 'dd-mm-yyyy'), 1159);
insert into MISSION (mdate, mid)
values (to_date('12-02-2016', 'dd-mm-yyyy'), 1160);
insert into MISSION (mdate, mid)
values (to_date('26-05-2006', 'dd-mm-yyyy'), 1161);
insert into MISSION (mdate, mid)
values (to_date('13-12-1990', 'dd-mm-yyyy'), 1162);
insert into MISSION (mdate, mid)
values (to_date('04-03-1997', 'dd-mm-yyyy'), 1163);
insert into MISSION (mdate, mid)
values (to_date('16-03-2010', 'dd-mm-yyyy'), 1164);
insert into MISSION (mdate, mid)
values (to_date('23-01-1994', 'dd-mm-yyyy'), 1165);
insert into MISSION (mdate, mid)
values (to_date('03-05-2022', 'dd-mm-yyyy'), 1166);
insert into MISSION (mdate, mid)
values (to_date('18-10-1994', 'dd-mm-yyyy'), 1167);
insert into MISSION (mdate, mid)
values (to_date('30-03-2005', 'dd-mm-yyyy'), 1168);
insert into MISSION (mdate, mid)
values (to_date('23-01-1995', 'dd-mm-yyyy'), 1169);
insert into MISSION (mdate, mid)
values (to_date('21-05-2013', 'dd-mm-yyyy'), 1170);
insert into MISSION (mdate, mid)
values (to_date('09-05-1990', 'dd-mm-yyyy'), 1171);
insert into MISSION (mdate, mid)
values (to_date('20-10-2008', 'dd-mm-yyyy'), 1172);
insert into MISSION (mdate, mid)
values (to_date('04-02-2022', 'dd-mm-yyyy'), 1173);
insert into MISSION (mdate, mid)
values (to_date('08-06-1992', 'dd-mm-yyyy'), 1174);
insert into MISSION (mdate, mid)
values (to_date('30-07-2007', 'dd-mm-yyyy'), 1175);
insert into MISSION (mdate, mid)
values (to_date('08-09-2003', 'dd-mm-yyyy'), 1176);
insert into MISSION (mdate, mid)
values (to_date('17-07-1994', 'dd-mm-yyyy'), 1177);
insert into MISSION (mdate, mid)
values (to_date('03-01-2004', 'dd-mm-yyyy'), 1178);
insert into MISSION (mdate, mid)
values (to_date('12-12-1990', 'dd-mm-yyyy'), 1179);
insert into MISSION (mdate, mid)
values (to_date('02-04-1996', 'dd-mm-yyyy'), 1180);
insert into MISSION (mdate, mid)
values (to_date('23-10-2002', 'dd-mm-yyyy'), 1181);
insert into MISSION (mdate, mid)
values (to_date('11-12-1992', 'dd-mm-yyyy'), 1182);
insert into MISSION (mdate, mid)
values (to_date('20-06-1991', 'dd-mm-yyyy'), 1183);
insert into MISSION (mdate, mid)
values (to_date('10-04-2019', 'dd-mm-yyyy'), 1184);
insert into MISSION (mdate, mid)
values (to_date('23-04-2015', 'dd-mm-yyyy'), 1185);
insert into MISSION (mdate, mid)
values (to_date('23-09-2003', 'dd-mm-yyyy'), 1186);
insert into MISSION (mdate, mid)
values (to_date('27-06-2014', 'dd-mm-yyyy'), 1187);
insert into MISSION (mdate, mid)
values (to_date('30-12-1995', 'dd-mm-yyyy'), 1188);
insert into MISSION (mdate, mid)
values (to_date('03-06-2013', 'dd-mm-yyyy'), 1189);
insert into MISSION (mdate, mid)
values (to_date('23-10-2011', 'dd-mm-yyyy'), 1190);
insert into MISSION (mdate, mid)
values (to_date('25-07-2007', 'dd-mm-yyyy'), 1191);
insert into MISSION (mdate, mid)
values (to_date('29-04-2007', 'dd-mm-yyyy'), 1192);
insert into MISSION (mdate, mid)
values (to_date('12-02-1997', 'dd-mm-yyyy'), 1193);
insert into MISSION (mdate, mid)
values (to_date('03-01-1999', 'dd-mm-yyyy'), 1194);
insert into MISSION (mdate, mid)
values (to_date('20-07-2012', 'dd-mm-yyyy'), 1195);
insert into MISSION (mdate, mid)
values (to_date('16-04-1994', 'dd-mm-yyyy'), 1196);
insert into MISSION (mdate, mid)
values (to_date('24-12-2004', 'dd-mm-yyyy'), 1197);
insert into MISSION (mdate, mid)
values (to_date('21-03-2002', 'dd-mm-yyyy'), 1198);
insert into MISSION (mdate, mid)
values (to_date('20-06-2019', 'dd-mm-yyyy'), 1199);
insert into MISSION (mdate, mid)
values (to_date('28-03-2015', 'dd-mm-yyyy'), 1200);
insert into MISSION (mdate, mid)
values (to_date('16-11-2003', 'dd-mm-yyyy'), 1201);
insert into MISSION (mdate, mid)
values (to_date('24-01-2005', 'dd-mm-yyyy'), 1202);
insert into MISSION (mdate, mid)
values (to_date('24-10-1991', 'dd-mm-yyyy'), 1203);
insert into MISSION (mdate, mid)
values (to_date('01-06-2007', 'dd-mm-yyyy'), 1204);
insert into MISSION (mdate, mid)
values (to_date('30-06-2006', 'dd-mm-yyyy'), 1205);
insert into MISSION (mdate, mid)
values (to_date('16-03-2012', 'dd-mm-yyyy'), 1206);
insert into MISSION (mdate, mid)
values (to_date('11-05-2013', 'dd-mm-yyyy'), 1207);
insert into MISSION (mdate, mid)
values (to_date('06-11-1990', 'dd-mm-yyyy'), 1208);
insert into MISSION (mdate, mid)
values (to_date('09-07-1991', 'dd-mm-yyyy'), 1209);
insert into MISSION (mdate, mid)
values (to_date('25-05-1994', 'dd-mm-yyyy'), 1210);
insert into MISSION (mdate, mid)
values (to_date('23-08-2019', 'dd-mm-yyyy'), 1211);
insert into MISSION (mdate, mid)
values (to_date('20-09-2010', 'dd-mm-yyyy'), 1212);
insert into MISSION (mdate, mid)
values (to_date('11-02-2001', 'dd-mm-yyyy'), 1213);
insert into MISSION (mdate, mid)
values (to_date('03-08-1994', 'dd-mm-yyyy'), 1214);
insert into MISSION (mdate, mid)
values (to_date('17-08-2004', 'dd-mm-yyyy'), 1215);
insert into MISSION (mdate, mid)
values (to_date('19-08-2013', 'dd-mm-yyyy'), 1216);
insert into MISSION (mdate, mid)
values (to_date('03-01-2007', 'dd-mm-yyyy'), 1217);
insert into MISSION (mdate, mid)
values (to_date('10-08-2000', 'dd-mm-yyyy'), 1218);
insert into MISSION (mdate, mid)
values (to_date('15-04-2017', 'dd-mm-yyyy'), 1219);
insert into MISSION (mdate, mid)
values (to_date('19-06-1993', 'dd-mm-yyyy'), 1220);
insert into MISSION (mdate, mid)
values (to_date('21-05-2002', 'dd-mm-yyyy'), 1221);
insert into MISSION (mdate, mid)
values (to_date('17-03-1990', 'dd-mm-yyyy'), 1222);
insert into MISSION (mdate, mid)
values (to_date('01-02-1997', 'dd-mm-yyyy'), 1223);
insert into MISSION (mdate, mid)
values (to_date('18-09-1991', 'dd-mm-yyyy'), 1224);
insert into MISSION (mdate, mid)
values (to_date('30-04-1993', 'dd-mm-yyyy'), 1225);
insert into MISSION (mdate, mid)
values (to_date('25-07-2001', 'dd-mm-yyyy'), 1226);
insert into MISSION (mdate, mid)
values (to_date('05-08-2000', 'dd-mm-yyyy'), 1227);
insert into MISSION (mdate, mid)
values (to_date('01-07-2007', 'dd-mm-yyyy'), 1228);
insert into MISSION (mdate, mid)
values (to_date('19-07-2000', 'dd-mm-yyyy'), 1229);
insert into MISSION (mdate, mid)
values (to_date('23-06-1991', 'dd-mm-yyyy'), 1230);
insert into MISSION (mdate, mid)
values (to_date('20-09-1993', 'dd-mm-yyyy'), 1231);
insert into MISSION (mdate, mid)
values (to_date('04-09-2012', 'dd-mm-yyyy'), 1232);
insert into MISSION (mdate, mid)
values (to_date('10-08-1992', 'dd-mm-yyyy'), 1233);
insert into MISSION (mdate, mid)
values (to_date('06-11-2010', 'dd-mm-yyyy'), 1234);
insert into MISSION (mdate, mid)
values (to_date('21-04-2009', 'dd-mm-yyyy'), 1235);
insert into MISSION (mdate, mid)
values (to_date('16-09-2011', 'dd-mm-yyyy'), 1236);
insert into MISSION (mdate, mid)
values (to_date('05-12-2009', 'dd-mm-yyyy'), 1237);
insert into MISSION (mdate, mid)
values (to_date('30-03-2014', 'dd-mm-yyyy'), 1238);
insert into MISSION (mdate, mid)
values (to_date('10-01-1993', 'dd-mm-yyyy'), 1239);
insert into MISSION (mdate, mid)
values (to_date('15-03-1995', 'dd-mm-yyyy'), 1240);
insert into MISSION (mdate, mid)
values (to_date('02-04-2021', 'dd-mm-yyyy'), 1241);
insert into MISSION (mdate, mid)
values (to_date('13-07-2014', 'dd-mm-yyyy'), 1242);
insert into MISSION (mdate, mid)
values (to_date('02-12-2021', 'dd-mm-yyyy'), 1243);
insert into MISSION (mdate, mid)
values (to_date('01-05-2007', 'dd-mm-yyyy'), 1244);
insert into MISSION (mdate, mid)
values (to_date('10-05-2019', 'dd-mm-yyyy'), 1245);
insert into MISSION (mdate, mid)
values (to_date('22-12-2014', 'dd-mm-yyyy'), 1246);
insert into MISSION (mdate, mid)
values (to_date('25-11-2003', 'dd-mm-yyyy'), 1247);
insert into MISSION (mdate, mid)
values (to_date('05-07-1994', 'dd-mm-yyyy'), 1248);
commit;
prompt 1100 records committed...
insert into MISSION (mdate, mid)
values (to_date('04-03-2013', 'dd-mm-yyyy'), 1249);
insert into MISSION (mdate, mid)
values (to_date('03-04-2017', 'dd-mm-yyyy'), 1250);
insert into MISSION (mdate, mid)
values (to_date('12-02-2021', 'dd-mm-yyyy'), 1251);
insert into MISSION (mdate, mid)
values (to_date('14-01-2002', 'dd-mm-yyyy'), 1252);
insert into MISSION (mdate, mid)
values (to_date('01-09-2010', 'dd-mm-yyyy'), 1253);
insert into MISSION (mdate, mid)
values (to_date('01-04-2016', 'dd-mm-yyyy'), 1254);
insert into MISSION (mdate, mid)
values (to_date('26-01-2013', 'dd-mm-yyyy'), 1255);
insert into MISSION (mdate, mid)
values (to_date('11-08-2006', 'dd-mm-yyyy'), 1256);
insert into MISSION (mdate, mid)
values (to_date('23-01-1996', 'dd-mm-yyyy'), 1257);
insert into MISSION (mdate, mid)
values (to_date('20-08-1999', 'dd-mm-yyyy'), 1258);
insert into MISSION (mdate, mid)
values (to_date('24-09-2011', 'dd-mm-yyyy'), 1259);
insert into MISSION (mdate, mid)
values (to_date('09-11-2000', 'dd-mm-yyyy'), 1260);
insert into MISSION (mdate, mid)
values (to_date('11-04-2012', 'dd-mm-yyyy'), 1261);
insert into MISSION (mdate, mid)
values (to_date('20-07-2011', 'dd-mm-yyyy'), 1262);
insert into MISSION (mdate, mid)
values (to_date('22-02-2004', 'dd-mm-yyyy'), 1263);
insert into MISSION (mdate, mid)
values (to_date('18-05-1997', 'dd-mm-yyyy'), 1264);
insert into MISSION (mdate, mid)
values (to_date('24-09-2005', 'dd-mm-yyyy'), 1265);
insert into MISSION (mdate, mid)
values (to_date('15-12-2017', 'dd-mm-yyyy'), 1266);
insert into MISSION (mdate, mid)
values (to_date('18-04-1991', 'dd-mm-yyyy'), 1267);
insert into MISSION (mdate, mid)
values (to_date('20-11-1990', 'dd-mm-yyyy'), 1268);
insert into MISSION (mdate, mid)
values (to_date('14-10-2022', 'dd-mm-yyyy'), 1269);
insert into MISSION (mdate, mid)
values (to_date('20-05-2012', 'dd-mm-yyyy'), 1270);
insert into MISSION (mdate, mid)
values (to_date('23-02-1995', 'dd-mm-yyyy'), 1271);
insert into MISSION (mdate, mid)
values (to_date('07-06-1991', 'dd-mm-yyyy'), 1272);
insert into MISSION (mdate, mid)
values (to_date('11-07-2002', 'dd-mm-yyyy'), 1273);
insert into MISSION (mdate, mid)
values (to_date('18-03-2017', 'dd-mm-yyyy'), 1274);
insert into MISSION (mdate, mid)
values (to_date('25-02-2005', 'dd-mm-yyyy'), 1275);
insert into MISSION (mdate, mid)
values (to_date('02-11-2018', 'dd-mm-yyyy'), 1276);
insert into MISSION (mdate, mid)
values (to_date('03-09-2002', 'dd-mm-yyyy'), 1277);
insert into MISSION (mdate, mid)
values (to_date('17-09-2006', 'dd-mm-yyyy'), 1278);
insert into MISSION (mdate, mid)
values (to_date('09-09-1995', 'dd-mm-yyyy'), 1279);
insert into MISSION (mdate, mid)
values (to_date('27-10-2022', 'dd-mm-yyyy'), 1280);
insert into MISSION (mdate, mid)
values (to_date('11-10-2020', 'dd-mm-yyyy'), 1281);
insert into MISSION (mdate, mid)
values (to_date('05-06-2017', 'dd-mm-yyyy'), 1282);
insert into MISSION (mdate, mid)
values (to_date('19-02-2022', 'dd-mm-yyyy'), 1283);
insert into MISSION (mdate, mid)
values (to_date('24-05-1998', 'dd-mm-yyyy'), 1284);
insert into MISSION (mdate, mid)
values (to_date('17-01-2000', 'dd-mm-yyyy'), 1285);
insert into MISSION (mdate, mid)
values (to_date('08-09-1993', 'dd-mm-yyyy'), 1286);
insert into MISSION (mdate, mid)
values (to_date('27-08-2015', 'dd-mm-yyyy'), 1287);
insert into MISSION (mdate, mid)
values (to_date('18-07-2013', 'dd-mm-yyyy'), 1288);
insert into MISSION (mdate, mid)
values (to_date('21-06-2013', 'dd-mm-yyyy'), 444);
insert into MISSION (mdate, mid)
values (to_date('19-01-1992', 'dd-mm-yyyy'), 445);
insert into MISSION (mdate, mid)
values (to_date('05-01-2022', 'dd-mm-yyyy'), 446);
insert into MISSION (mdate, mid)
values (to_date('04-04-2017', 'dd-mm-yyyy'), 447);
insert into MISSION (mdate, mid)
values (to_date('26-06-1992', 'dd-mm-yyyy'), 448);
insert into MISSION (mdate, mid)
values (to_date('02-03-1992', 'dd-mm-yyyy'), 449);
insert into MISSION (mdate, mid)
values (to_date('17-10-2001', 'dd-mm-yyyy'), 450);
insert into MISSION (mdate, mid)
values (to_date('26-04-2005', 'dd-mm-yyyy'), 451);
insert into MISSION (mdate, mid)
values (to_date('03-09-2018', 'dd-mm-yyyy'), 452);
insert into MISSION (mdate, mid)
values (to_date('29-11-2010', 'dd-mm-yyyy'), 453);
insert into MISSION (mdate, mid)
values (to_date('03-08-2021', 'dd-mm-yyyy'), 454);
insert into MISSION (mdate, mid)
values (to_date('05-03-1994', 'dd-mm-yyyy'), 455);
insert into MISSION (mdate, mid)
values (to_date('06-05-1996', 'dd-mm-yyyy'), 456);
insert into MISSION (mdate, mid)
values (to_date('14-08-1994', 'dd-mm-yyyy'), 457);
insert into MISSION (mdate, mid)
values (to_date('21-10-1990', 'dd-mm-yyyy'), 458);
insert into MISSION (mdate, mid)
values (to_date('04-04-2003', 'dd-mm-yyyy'), 459);
insert into MISSION (mdate, mid)
values (to_date('03-07-1996', 'dd-mm-yyyy'), 460);
insert into MISSION (mdate, mid)
values (to_date('22-02-2023', 'dd-mm-yyyy'), 461);
insert into MISSION (mdate, mid)
values (to_date('30-04-2012', 'dd-mm-yyyy'), 462);
insert into MISSION (mdate, mid)
values (to_date('11-03-2008', 'dd-mm-yyyy'), 463);
insert into MISSION (mdate, mid)
values (to_date('17-04-2016', 'dd-mm-yyyy'), 464);
insert into MISSION (mdate, mid)
values (to_date('07-11-2022', 'dd-mm-yyyy'), 465);
insert into MISSION (mdate, mid)
values (to_date('19-07-1990', 'dd-mm-yyyy'), 466);
insert into MISSION (mdate, mid)
values (to_date('08-06-2001', 'dd-mm-yyyy'), 467);
insert into MISSION (mdate, mid)
values (to_date('19-07-2016', 'dd-mm-yyyy'), 468);
insert into MISSION (mdate, mid)
values (to_date('10-03-2020', 'dd-mm-yyyy'), 469);
insert into MISSION (mdate, mid)
values (to_date('16-10-2004', 'dd-mm-yyyy'), 470);
insert into MISSION (mdate, mid)
values (to_date('20-09-2004', 'dd-mm-yyyy'), 471);
insert into MISSION (mdate, mid)
values (to_date('10-06-1990', 'dd-mm-yyyy'), 472);
insert into MISSION (mdate, mid)
values (to_date('22-11-2006', 'dd-mm-yyyy'), 473);
insert into MISSION (mdate, mid)
values (to_date('14-09-1998', 'dd-mm-yyyy'), 474);
insert into MISSION (mdate, mid)
values (to_date('13-06-1992', 'dd-mm-yyyy'), 475);
insert into MISSION (mdate, mid)
values (to_date('16-09-1994', 'dd-mm-yyyy'), 476);
insert into MISSION (mdate, mid)
values (to_date('25-01-1992', 'dd-mm-yyyy'), 477);
insert into MISSION (mdate, mid)
values (to_date('27-12-1995', 'dd-mm-yyyy'), 478);
insert into MISSION (mdate, mid)
values (to_date('23-07-1999', 'dd-mm-yyyy'), 479);
insert into MISSION (mdate, mid)
values (to_date('28-06-2015', 'dd-mm-yyyy'), 480);
insert into MISSION (mdate, mid)
values (to_date('04-01-2009', 'dd-mm-yyyy'), 481);
insert into MISSION (mdate, mid)
values (to_date('13-12-2021', 'dd-mm-yyyy'), 482);
insert into MISSION (mdate, mid)
values (to_date('05-01-2016', 'dd-mm-yyyy'), 483);
insert into MISSION (mdate, mid)
values (to_date('08-02-1991', 'dd-mm-yyyy'), 484);
insert into MISSION (mdate, mid)
values (to_date('28-02-2023', 'dd-mm-yyyy'), 485);
insert into MISSION (mdate, mid)
values (to_date('30-06-2006', 'dd-mm-yyyy'), 486);
insert into MISSION (mdate, mid)
values (to_date('04-07-1992', 'dd-mm-yyyy'), 487);
insert into MISSION (mdate, mid)
values (to_date('02-11-2016', 'dd-mm-yyyy'), 488);
insert into MISSION (mdate, mid)
values (to_date('28-11-2001', 'dd-mm-yyyy'), 489);
insert into MISSION (mdate, mid)
values (to_date('31-08-2020', 'dd-mm-yyyy'), 490);
insert into MISSION (mdate, mid)
values (to_date('24-05-2018', 'dd-mm-yyyy'), 491);
insert into MISSION (mdate, mid)
values (to_date('22-03-2017', 'dd-mm-yyyy'), 492);
insert into MISSION (mdate, mid)
values (to_date('25-09-2007', 'dd-mm-yyyy'), 493);
insert into MISSION (mdate, mid)
values (to_date('23-09-2017', 'dd-mm-yyyy'), 494);
insert into MISSION (mdate, mid)
values (to_date('11-08-1993', 'dd-mm-yyyy'), 495);
insert into MISSION (mdate, mid)
values (to_date('06-09-2015', 'dd-mm-yyyy'), 496);
insert into MISSION (mdate, mid)
values (to_date('14-06-2014', 'dd-mm-yyyy'), 497);
insert into MISSION (mdate, mid)
values (to_date('16-09-1991', 'dd-mm-yyyy'), 498);
insert into MISSION (mdate, mid)
values (to_date('13-06-1994', 'dd-mm-yyyy'), 499);
insert into MISSION (mdate, mid)
values (to_date('09-02-1998', 'dd-mm-yyyy'), 500);
insert into MISSION (mdate, mid)
values (to_date('04-12-2004', 'dd-mm-yyyy'), 501);
insert into MISSION (mdate, mid)
values (to_date('19-04-2013', 'dd-mm-yyyy'), 502);
insert into MISSION (mdate, mid)
values (to_date('03-01-1992', 'dd-mm-yyyy'), 503);
commit;
prompt 1200 records committed...
insert into MISSION (mdate, mid)
values (to_date('18-04-2007', 'dd-mm-yyyy'), 504);
insert into MISSION (mdate, mid)
values (to_date('27-01-1999', 'dd-mm-yyyy'), 505);
insert into MISSION (mdate, mid)
values (to_date('06-05-2019', 'dd-mm-yyyy'), 506);
insert into MISSION (mdate, mid)
values (to_date('05-04-2004', 'dd-mm-yyyy'), 507);
insert into MISSION (mdate, mid)
values (to_date('11-09-1991', 'dd-mm-yyyy'), 508);
insert into MISSION (mdate, mid)
values (to_date('07-07-2009', 'dd-mm-yyyy'), 509);
insert into MISSION (mdate, mid)
values (to_date('27-06-2022', 'dd-mm-yyyy'), 510);
insert into MISSION (mdate, mid)
values (to_date('26-05-2003', 'dd-mm-yyyy'), 511);
insert into MISSION (mdate, mid)
values (to_date('14-06-1994', 'dd-mm-yyyy'), 512);
insert into MISSION (mdate, mid)
values (to_date('08-10-1998', 'dd-mm-yyyy'), 513);
insert into MISSION (mdate, mid)
values (to_date('10-05-2022', 'dd-mm-yyyy'), 514);
insert into MISSION (mdate, mid)
values (to_date('30-06-1996', 'dd-mm-yyyy'), 515);
insert into MISSION (mdate, mid)
values (to_date('07-04-2019', 'dd-mm-yyyy'), 516);
insert into MISSION (mdate, mid)
values (to_date('14-03-2022', 'dd-mm-yyyy'), 517);
insert into MISSION (mdate, mid)
values (to_date('29-11-1995', 'dd-mm-yyyy'), 518);
insert into MISSION (mdate, mid)
values (to_date('06-03-1992', 'dd-mm-yyyy'), 519);
insert into MISSION (mdate, mid)
values (to_date('06-12-2005', 'dd-mm-yyyy'), 520);
insert into MISSION (mdate, mid)
values (to_date('01-10-2001', 'dd-mm-yyyy'), 521);
insert into MISSION (mdate, mid)
values (to_date('07-03-2013', 'dd-mm-yyyy'), 522);
insert into MISSION (mdate, mid)
values (to_date('06-04-2016', 'dd-mm-yyyy'), 523);
insert into MISSION (mdate, mid)
values (to_date('01-02-2017', 'dd-mm-yyyy'), 524);
insert into MISSION (mdate, mid)
values (to_date('01-08-2011', 'dd-mm-yyyy'), 525);
insert into MISSION (mdate, mid)
values (to_date('17-03-2023', 'dd-mm-yyyy'), 526);
insert into MISSION (mdate, mid)
values (to_date('18-02-2008', 'dd-mm-yyyy'), 527);
insert into MISSION (mdate, mid)
values (to_date('13-03-1998', 'dd-mm-yyyy'), 528);
insert into MISSION (mdate, mid)
values (to_date('14-09-1993', 'dd-mm-yyyy'), 529);
insert into MISSION (mdate, mid)
values (to_date('24-03-2019', 'dd-mm-yyyy'), 530);
insert into MISSION (mdate, mid)
values (to_date('12-09-2015', 'dd-mm-yyyy'), 531);
insert into MISSION (mdate, mid)
values (to_date('29-01-2011', 'dd-mm-yyyy'), 532);
insert into MISSION (mdate, mid)
values (to_date('16-09-2005', 'dd-mm-yyyy'), 533);
insert into MISSION (mdate, mid)
values (to_date('25-12-2008', 'dd-mm-yyyy'), 534);
insert into MISSION (mdate, mid)
values (to_date('30-10-1993', 'dd-mm-yyyy'), 535);
insert into MISSION (mdate, mid)
values (to_date('22-02-2014', 'dd-mm-yyyy'), 536);
insert into MISSION (mdate, mid)
values (to_date('29-08-2003', 'dd-mm-yyyy'), 537);
insert into MISSION (mdate, mid)
values (to_date('27-04-2006', 'dd-mm-yyyy'), 538);
insert into MISSION (mdate, mid)
values (to_date('03-02-2015', 'dd-mm-yyyy'), 539);
insert into MISSION (mdate, mid)
values (to_date('27-08-2004', 'dd-mm-yyyy'), 540);
insert into MISSION (mdate, mid)
values (to_date('17-04-2007', 'dd-mm-yyyy'), 541);
insert into MISSION (mdate, mid)
values (to_date('29-09-1996', 'dd-mm-yyyy'), 542);
insert into MISSION (mdate, mid)
values (to_date('26-07-2010', 'dd-mm-yyyy'), 543);
insert into MISSION (mdate, mid)
values (to_date('11-01-2021', 'dd-mm-yyyy'), 544);
insert into MISSION (mdate, mid)
values (to_date('12-07-2007', 'dd-mm-yyyy'), 545);
insert into MISSION (mdate, mid)
values (to_date('01-04-2008', 'dd-mm-yyyy'), 546);
insert into MISSION (mdate, mid)
values (to_date('20-09-2002', 'dd-mm-yyyy'), 547);
insert into MISSION (mdate, mid)
values (to_date('17-09-2021', 'dd-mm-yyyy'), 548);
insert into MISSION (mdate, mid)
values (to_date('12-07-2004', 'dd-mm-yyyy'), 549);
insert into MISSION (mdate, mid)
values (to_date('16-01-2019', 'dd-mm-yyyy'), 550);
insert into MISSION (mdate, mid)
values (to_date('02-01-1999', 'dd-mm-yyyy'), 551);
insert into MISSION (mdate, mid)
values (to_date('25-06-2005', 'dd-mm-yyyy'), 552);
insert into MISSION (mdate, mid)
values (to_date('21-03-1995', 'dd-mm-yyyy'), 553);
insert into MISSION (mdate, mid)
values (to_date('17-06-2020', 'dd-mm-yyyy'), 554);
insert into MISSION (mdate, mid)
values (to_date('27-03-2015', 'dd-mm-yyyy'), 555);
insert into MISSION (mdate, mid)
values (to_date('21-09-1998', 'dd-mm-yyyy'), 556);
insert into MISSION (mdate, mid)
values (to_date('19-07-2009', 'dd-mm-yyyy'), 557);
insert into MISSION (mdate, mid)
values (to_date('25-09-2017', 'dd-mm-yyyy'), 558);
insert into MISSION (mdate, mid)
values (to_date('16-05-1992', 'dd-mm-yyyy'), 559);
insert into MISSION (mdate, mid)
values (to_date('24-08-2019', 'dd-mm-yyyy'), 560);
insert into MISSION (mdate, mid)
values (to_date('30-05-1997', 'dd-mm-yyyy'), 561);
insert into MISSION (mdate, mid)
values (to_date('14-11-1997', 'dd-mm-yyyy'), 562);
insert into MISSION (mdate, mid)
values (to_date('26-09-1990', 'dd-mm-yyyy'), 563);
insert into MISSION (mdate, mid)
values (to_date('25-11-2001', 'dd-mm-yyyy'), 564);
insert into MISSION (mdate, mid)
values (to_date('26-06-2022', 'dd-mm-yyyy'), 565);
insert into MISSION (mdate, mid)
values (to_date('29-04-2004', 'dd-mm-yyyy'), 566);
insert into MISSION (mdate, mid)
values (to_date('05-05-2000', 'dd-mm-yyyy'), 567);
insert into MISSION (mdate, mid)
values (to_date('29-06-2008', 'dd-mm-yyyy'), 568);
insert into MISSION (mdate, mid)
values (to_date('08-12-2003', 'dd-mm-yyyy'), 569);
insert into MISSION (mdate, mid)
values (to_date('07-10-1990', 'dd-mm-yyyy'), 570);
insert into MISSION (mdate, mid)
values (to_date('25-05-2006', 'dd-mm-yyyy'), 571);
insert into MISSION (mdate, mid)
values (to_date('09-08-2021', 'dd-mm-yyyy'), 572);
insert into MISSION (mdate, mid)
values (to_date('10-03-2023', 'dd-mm-yyyy'), 573);
insert into MISSION (mdate, mid)
values (to_date('25-06-2018', 'dd-mm-yyyy'), 574);
insert into MISSION (mdate, mid)
values (to_date('03-07-2005', 'dd-mm-yyyy'), 575);
insert into MISSION (mdate, mid)
values (to_date('10-03-1996', 'dd-mm-yyyy'), 576);
insert into MISSION (mdate, mid)
values (to_date('17-10-2011', 'dd-mm-yyyy'), 577);
insert into MISSION (mdate, mid)
values (to_date('25-11-2010', 'dd-mm-yyyy'), 578);
insert into MISSION (mdate, mid)
values (to_date('18-10-2016', 'dd-mm-yyyy'), 579);
insert into MISSION (mdate, mid)
values (to_date('11-10-2023', 'dd-mm-yyyy'), 580);
insert into MISSION (mdate, mid)
values (to_date('16-07-1990', 'dd-mm-yyyy'), 581);
insert into MISSION (mdate, mid)
values (to_date('26-08-2020', 'dd-mm-yyyy'), 582);
insert into MISSION (mdate, mid)
values (to_date('20-06-2004', 'dd-mm-yyyy'), 583);
insert into MISSION (mdate, mid)
values (to_date('19-08-2019', 'dd-mm-yyyy'), 584);
insert into MISSION (mdate, mid)
values (to_date('15-10-1998', 'dd-mm-yyyy'), 585);
insert into MISSION (mdate, mid)
values (to_date('03-09-2001', 'dd-mm-yyyy'), 586);
insert into MISSION (mdate, mid)
values (to_date('02-11-2010', 'dd-mm-yyyy'), 587);
insert into MISSION (mdate, mid)
values (to_date('04-07-2020', 'dd-mm-yyyy'), 588);
insert into MISSION (mdate, mid)
values (to_date('15-05-2017', 'dd-mm-yyyy'), 589);
insert into MISSION (mdate, mid)
values (to_date('27-10-1990', 'dd-mm-yyyy'), 590);
insert into MISSION (mdate, mid)
values (to_date('07-08-1991', 'dd-mm-yyyy'), 591);
insert into MISSION (mdate, mid)
values (to_date('15-02-2013', 'dd-mm-yyyy'), 592);
insert into MISSION (mdate, mid)
values (to_date('12-10-1992', 'dd-mm-yyyy'), 593);
insert into MISSION (mdate, mid)
values (to_date('31-05-2014', 'dd-mm-yyyy'), 594);
insert into MISSION (mdate, mid)
values (to_date('29-03-2009', 'dd-mm-yyyy'), 595);
insert into MISSION (mdate, mid)
values (to_date('16-10-2023', 'dd-mm-yyyy'), 596);
insert into MISSION (mdate, mid)
values (to_date('10-02-2011', 'dd-mm-yyyy'), 597);
insert into MISSION (mdate, mid)
values (to_date('04-05-1995', 'dd-mm-yyyy'), 598);
insert into MISSION (mdate, mid)
values (to_date('09-05-2021', 'dd-mm-yyyy'), 599);
insert into MISSION (mdate, mid)
values (to_date('14-02-2018', 'dd-mm-yyyy'), 600);
insert into MISSION (mdate, mid)
values (to_date('12-08-2015', 'dd-mm-yyyy'), 1);
insert into MISSION (mdate, mid)
values (to_date('10-08-1995', 'dd-mm-yyyy'), 2);
insert into MISSION (mdate, mid)
values (to_date('18-07-1991', 'dd-mm-yyyy'), 3);
commit;
prompt 1300 records committed...
insert into MISSION (mdate, mid)
values (to_date('31-01-2002', 'dd-mm-yyyy'), 4);
insert into MISSION (mdate, mid)
values (to_date('28-06-2018', 'dd-mm-yyyy'), 5);
insert into MISSION (mdate, mid)
values (to_date('25-03-1997', 'dd-mm-yyyy'), 6);
insert into MISSION (mdate, mid)
values (to_date('18-08-2004', 'dd-mm-yyyy'), 7);
insert into MISSION (mdate, mid)
values (to_date('02-06-2007', 'dd-mm-yyyy'), 8);
insert into MISSION (mdate, mid)
values (to_date('07-09-2012', 'dd-mm-yyyy'), 9);
insert into MISSION (mdate, mid)
values (to_date('17-04-1991', 'dd-mm-yyyy'), 10);
insert into MISSION (mdate, mid)
values (to_date('08-09-1994', 'dd-mm-yyyy'), 601);
insert into MISSION (mdate, mid)
values (to_date('05-01-2004', 'dd-mm-yyyy'), 602);
insert into MISSION (mdate, mid)
values (to_date('03-01-1992', 'dd-mm-yyyy'), 603);
insert into MISSION (mdate, mid)
values (to_date('07-12-1996', 'dd-mm-yyyy'), 604);
insert into MISSION (mdate, mid)
values (to_date('14-03-2000', 'dd-mm-yyyy'), 605);
insert into MISSION (mdate, mid)
values (to_date('11-11-2001', 'dd-mm-yyyy'), 606);
insert into MISSION (mdate, mid)
values (to_date('29-03-2010', 'dd-mm-yyyy'), 607);
insert into MISSION (mdate, mid)
values (to_date('09-01-1999', 'dd-mm-yyyy'), 608);
insert into MISSION (mdate, mid)
values (to_date('23-03-2012', 'dd-mm-yyyy'), 609);
insert into MISSION (mdate, mid)
values (to_date('05-12-1994', 'dd-mm-yyyy'), 610);
insert into MISSION (mdate, mid)
values (to_date('07-09-1991', 'dd-mm-yyyy'), 611);
insert into MISSION (mdate, mid)
values (to_date('29-08-1994', 'dd-mm-yyyy'), 612);
insert into MISSION (mdate, mid)
values (to_date('30-08-2009', 'dd-mm-yyyy'), 613);
insert into MISSION (mdate, mid)
values (to_date('08-03-2010', 'dd-mm-yyyy'), 614);
insert into MISSION (mdate, mid)
values (to_date('05-03-1999', 'dd-mm-yyyy'), 615);
insert into MISSION (mdate, mid)
values (to_date('16-08-1995', 'dd-mm-yyyy'), 616);
insert into MISSION (mdate, mid)
values (to_date('23-01-2016', 'dd-mm-yyyy'), 617);
insert into MISSION (mdate, mid)
values (to_date('25-04-2013', 'dd-mm-yyyy'), 618);
insert into MISSION (mdate, mid)
values (to_date('23-08-2016', 'dd-mm-yyyy'), 619);
insert into MISSION (mdate, mid)
values (to_date('26-09-1997', 'dd-mm-yyyy'), 620);
insert into MISSION (mdate, mid)
values (to_date('28-02-2020', 'dd-mm-yyyy'), 621);
insert into MISSION (mdate, mid)
values (to_date('18-11-2020', 'dd-mm-yyyy'), 622);
insert into MISSION (mdate, mid)
values (to_date('24-01-2021', 'dd-mm-yyyy'), 623);
insert into MISSION (mdate, mid)
values (to_date('06-08-2008', 'dd-mm-yyyy'), 624);
insert into MISSION (mdate, mid)
values (to_date('30-03-2005', 'dd-mm-yyyy'), 625);
insert into MISSION (mdate, mid)
values (to_date('11-08-1997', 'dd-mm-yyyy'), 626);
insert into MISSION (mdate, mid)
values (to_date('28-02-2003', 'dd-mm-yyyy'), 627);
insert into MISSION (mdate, mid)
values (to_date('14-12-2016', 'dd-mm-yyyy'), 628);
insert into MISSION (mdate, mid)
values (to_date('22-09-2016', 'dd-mm-yyyy'), 629);
insert into MISSION (mdate, mid)
values (to_date('20-08-2010', 'dd-mm-yyyy'), 630);
insert into MISSION (mdate, mid)
values (to_date('07-10-2018', 'dd-mm-yyyy'), 631);
insert into MISSION (mdate, mid)
values (to_date('21-08-2016', 'dd-mm-yyyy'), 632);
insert into MISSION (mdate, mid)
values (to_date('01-07-2007', 'dd-mm-yyyy'), 633);
insert into MISSION (mdate, mid)
values (to_date('25-09-1998', 'dd-mm-yyyy'), 634);
insert into MISSION (mdate, mid)
values (to_date('21-03-1998', 'dd-mm-yyyy'), 635);
insert into MISSION (mdate, mid)
values (to_date('28-03-2008', 'dd-mm-yyyy'), 636);
insert into MISSION (mdate, mid)
values (to_date('07-12-2000', 'dd-mm-yyyy'), 637);
insert into MISSION (mdate, mid)
values (to_date('05-11-2007', 'dd-mm-yyyy'), 638);
insert into MISSION (mdate, mid)
values (to_date('07-02-2006', 'dd-mm-yyyy'), 639);
insert into MISSION (mdate, mid)
values (to_date('28-11-2008', 'dd-mm-yyyy'), 640);
insert into MISSION (mdate, mid)
values (to_date('13-09-1997', 'dd-mm-yyyy'), 641);
insert into MISSION (mdate, mid)
values (to_date('02-06-2003', 'dd-mm-yyyy'), 642);
insert into MISSION (mdate, mid)
values (to_date('15-03-2002', 'dd-mm-yyyy'), 643);
insert into MISSION (mdate, mid)
values (to_date('08-01-2010', 'dd-mm-yyyy'), 644);
insert into MISSION (mdate, mid)
values (to_date('20-08-2017', 'dd-mm-yyyy'), 645);
insert into MISSION (mdate, mid)
values (to_date('24-05-1995', 'dd-mm-yyyy'), 646);
insert into MISSION (mdate, mid)
values (to_date('03-08-2010', 'dd-mm-yyyy'), 647);
insert into MISSION (mdate, mid)
values (to_date('20-07-1995', 'dd-mm-yyyy'), 648);
insert into MISSION (mdate, mid)
values (to_date('30-05-2016', 'dd-mm-yyyy'), 649);
insert into MISSION (mdate, mid)
values (to_date('10-11-1998', 'dd-mm-yyyy'), 650);
insert into MISSION (mdate, mid)
values (to_date('06-02-1995', 'dd-mm-yyyy'), 651);
insert into MISSION (mdate, mid)
values (to_date('19-05-2010', 'dd-mm-yyyy'), 652);
insert into MISSION (mdate, mid)
values (to_date('08-10-2018', 'dd-mm-yyyy'), 653);
insert into MISSION (mdate, mid)
values (to_date('07-09-2021', 'dd-mm-yyyy'), 654);
insert into MISSION (mdate, mid)
values (to_date('05-09-2001', 'dd-mm-yyyy'), 655);
insert into MISSION (mdate, mid)
values (to_date('24-12-2011', 'dd-mm-yyyy'), 656);
insert into MISSION (mdate, mid)
values (to_date('17-06-1993', 'dd-mm-yyyy'), 657);
insert into MISSION (mdate, mid)
values (to_date('02-09-2014', 'dd-mm-yyyy'), 658);
insert into MISSION (mdate, mid)
values (to_date('27-04-2014', 'dd-mm-yyyy'), 659);
insert into MISSION (mdate, mid)
values (to_date('11-01-2006', 'dd-mm-yyyy'), 660);
insert into MISSION (mdate, mid)
values (to_date('02-04-1993', 'dd-mm-yyyy'), 661);
insert into MISSION (mdate, mid)
values (to_date('07-01-1992', 'dd-mm-yyyy'), 662);
insert into MISSION (mdate, mid)
values (to_date('09-08-2002', 'dd-mm-yyyy'), 663);
insert into MISSION (mdate, mid)
values (to_date('19-01-2018', 'dd-mm-yyyy'), 664);
insert into MISSION (mdate, mid)
values (to_date('09-08-2002', 'dd-mm-yyyy'), 665);
insert into MISSION (mdate, mid)
values (to_date('27-02-2010', 'dd-mm-yyyy'), 666);
insert into MISSION (mdate, mid)
values (to_date('17-01-2020', 'dd-mm-yyyy'), 667);
insert into MISSION (mdate, mid)
values (to_date('04-02-2022', 'dd-mm-yyyy'), 668);
insert into MISSION (mdate, mid)
values (to_date('21-11-1999', 'dd-mm-yyyy'), 669);
insert into MISSION (mdate, mid)
values (to_date('04-04-1998', 'dd-mm-yyyy'), 670);
insert into MISSION (mdate, mid)
values (to_date('04-10-2022', 'dd-mm-yyyy'), 671);
insert into MISSION (mdate, mid)
values (to_date('25-12-2021', 'dd-mm-yyyy'), 672);
insert into MISSION (mdate, mid)
values (to_date('28-03-1990', 'dd-mm-yyyy'), 673);
insert into MISSION (mdate, mid)
values (to_date('27-11-2002', 'dd-mm-yyyy'), 674);
insert into MISSION (mdate, mid)
values (to_date('22-02-2010', 'dd-mm-yyyy'), 675);
insert into MISSION (mdate, mid)
values (to_date('23-09-1993', 'dd-mm-yyyy'), 676);
insert into MISSION (mdate, mid)
values (to_date('24-05-2004', 'dd-mm-yyyy'), 677);
insert into MISSION (mdate, mid)
values (to_date('01-11-1998', 'dd-mm-yyyy'), 678);
insert into MISSION (mdate, mid)
values (to_date('21-08-2008', 'dd-mm-yyyy'), 679);
insert into MISSION (mdate, mid)
values (to_date('10-02-2000', 'dd-mm-yyyy'), 680);
insert into MISSION (mdate, mid)
values (to_date('08-03-2001', 'dd-mm-yyyy'), 681);
insert into MISSION (mdate, mid)
values (to_date('01-09-2009', 'dd-mm-yyyy'), 682);
insert into MISSION (mdate, mid)
values (to_date('30-08-2021', 'dd-mm-yyyy'), 683);
insert into MISSION (mdate, mid)
values (to_date('03-07-2004', 'dd-mm-yyyy'), 684);
insert into MISSION (mdate, mid)
values (to_date('10-06-2015', 'dd-mm-yyyy'), 685);
insert into MISSION (mdate, mid)
values (to_date('15-01-2004', 'dd-mm-yyyy'), 686);
insert into MISSION (mdate, mid)
values (to_date('18-05-2011', 'dd-mm-yyyy'), 687);
insert into MISSION (mdate, mid)
values (to_date('18-06-2008', 'dd-mm-yyyy'), 688);
insert into MISSION (mdate, mid)
values (to_date('10-07-2010', 'dd-mm-yyyy'), 689);
insert into MISSION (mdate, mid)
values (to_date('31-07-1997', 'dd-mm-yyyy'), 690);
insert into MISSION (mdate, mid)
values (to_date('11-11-2018', 'dd-mm-yyyy'), 691);
insert into MISSION (mdate, mid)
values (to_date('27-08-1990', 'dd-mm-yyyy'), 692);
insert into MISSION (mdate, mid)
values (to_date('11-10-1991', 'dd-mm-yyyy'), 693);
commit;
prompt 1400 records committed...
insert into MISSION (mdate, mid)
values (to_date('20-08-2007', 'dd-mm-yyyy'), 694);
insert into MISSION (mdate, mid)
values (to_date('19-10-2009', 'dd-mm-yyyy'), 695);
insert into MISSION (mdate, mid)
values (to_date('20-02-1991', 'dd-mm-yyyy'), 696);
insert into MISSION (mdate, mid)
values (to_date('05-07-2021', 'dd-mm-yyyy'), 697);
insert into MISSION (mdate, mid)
values (to_date('05-09-2010', 'dd-mm-yyyy'), 698);
insert into MISSION (mdate, mid)
values (to_date('30-10-1997', 'dd-mm-yyyy'), 699);
insert into MISSION (mdate, mid)
values (to_date('06-02-2000', 'dd-mm-yyyy'), 700);
insert into MISSION (mdate, mid)
values (to_date('05-06-2015', 'dd-mm-yyyy'), 701);
insert into MISSION (mdate, mid)
values (to_date('19-10-1994', 'dd-mm-yyyy'), 702);
insert into MISSION (mdate, mid)
values (to_date('30-01-2016', 'dd-mm-yyyy'), 703);
insert into MISSION (mdate, mid)
values (to_date('03-07-2011', 'dd-mm-yyyy'), 704);
insert into MISSION (mdate, mid)
values (to_date('13-07-2000', 'dd-mm-yyyy'), 705);
insert into MISSION (mdate, mid)
values (to_date('28-09-2009', 'dd-mm-yyyy'), 706);
insert into MISSION (mdate, mid)
values (to_date('24-08-2010', 'dd-mm-yyyy'), 707);
insert into MISSION (mdate, mid)
values (to_date('21-04-2016', 'dd-mm-yyyy'), 708);
insert into MISSION (mdate, mid)
values (to_date('07-12-2004', 'dd-mm-yyyy'), 709);
insert into MISSION (mdate, mid)
values (to_date('08-05-1993', 'dd-mm-yyyy'), 710);
insert into MISSION (mdate, mid)
values (to_date('05-12-2001', 'dd-mm-yyyy'), 711);
insert into MISSION (mdate, mid)
values (to_date('10-03-2015', 'dd-mm-yyyy'), 712);
insert into MISSION (mdate, mid)
values (to_date('20-02-2012', 'dd-mm-yyyy'), 713);
insert into MISSION (mdate, mid)
values (to_date('05-06-2019', 'dd-mm-yyyy'), 714);
insert into MISSION (mdate, mid)
values (to_date('16-02-2010', 'dd-mm-yyyy'), 715);
insert into MISSION (mdate, mid)
values (to_date('07-12-2006', 'dd-mm-yyyy'), 716);
insert into MISSION (mdate, mid)
values (to_date('30-08-1991', 'dd-mm-yyyy'), 717);
insert into MISSION (mdate, mid)
values (to_date('23-04-2003', 'dd-mm-yyyy'), 718);
insert into MISSION (mdate, mid)
values (to_date('11-05-2008', 'dd-mm-yyyy'), 719);
insert into MISSION (mdate, mid)
values (to_date('01-12-2015', 'dd-mm-yyyy'), 720);
insert into MISSION (mdate, mid)
values (to_date('18-02-1993', 'dd-mm-yyyy'), 721);
insert into MISSION (mdate, mid)
values (to_date('24-09-2021', 'dd-mm-yyyy'), 722);
insert into MISSION (mdate, mid)
values (to_date('09-02-2010', 'dd-mm-yyyy'), 723);
insert into MISSION (mdate, mid)
values (to_date('02-05-1999', 'dd-mm-yyyy'), 724);
insert into MISSION (mdate, mid)
values (to_date('06-03-2002', 'dd-mm-yyyy'), 725);
insert into MISSION (mdate, mid)
values (to_date('01-10-2002', 'dd-mm-yyyy'), 726);
insert into MISSION (mdate, mid)
values (to_date('10-01-2010', 'dd-mm-yyyy'), 727);
insert into MISSION (mdate, mid)
values (to_date('17-02-2011', 'dd-mm-yyyy'), 728);
insert into MISSION (mdate, mid)
values (to_date('27-09-1990', 'dd-mm-yyyy'), 729);
insert into MISSION (mdate, mid)
values (to_date('09-10-1991', 'dd-mm-yyyy'), 730);
insert into MISSION (mdate, mid)
values (to_date('20-04-2000', 'dd-mm-yyyy'), 731);
insert into MISSION (mdate, mid)
values (to_date('21-10-2017', 'dd-mm-yyyy'), 732);
insert into MISSION (mdate, mid)
values (to_date('06-09-2008', 'dd-mm-yyyy'), 733);
insert into MISSION (mdate, mid)
values (to_date('31-12-1996', 'dd-mm-yyyy'), 734);
insert into MISSION (mdate, mid)
values (to_date('03-02-1996', 'dd-mm-yyyy'), 735);
insert into MISSION (mdate, mid)
values (to_date('09-06-1990', 'dd-mm-yyyy'), 736);
insert into MISSION (mdate, mid)
values (to_date('17-10-2006', 'dd-mm-yyyy'), 737);
insert into MISSION (mdate, mid)
values (to_date('08-11-2009', 'dd-mm-yyyy'), 738);
insert into MISSION (mdate, mid)
values (to_date('22-09-2011', 'dd-mm-yyyy'), 739);
insert into MISSION (mdate, mid)
values (to_date('23-09-2014', 'dd-mm-yyyy'), 740);
insert into MISSION (mdate, mid)
values (to_date('06-07-2013', 'dd-mm-yyyy'), 741);
insert into MISSION (mdate, mid)
values (to_date('12-02-2012', 'dd-mm-yyyy'), 742);
insert into MISSION (mdate, mid)
values (to_date('13-09-2003', 'dd-mm-yyyy'), 743);
insert into MISSION (mdate, mid)
values (to_date('11-11-2003', 'dd-mm-yyyy'), 744);
insert into MISSION (mdate, mid)
values (to_date('19-01-2009', 'dd-mm-yyyy'), 745);
insert into MISSION (mdate, mid)
values (to_date('21-11-2020', 'dd-mm-yyyy'), 746);
insert into MISSION (mdate, mid)
values (to_date('03-09-2002', 'dd-mm-yyyy'), 747);
insert into MISSION (mdate, mid)
values (to_date('12-06-1993', 'dd-mm-yyyy'), 748);
insert into MISSION (mdate, mid)
values (to_date('14-09-2003', 'dd-mm-yyyy'), 749);
insert into MISSION (mdate, mid)
values (to_date('07-09-1999', 'dd-mm-yyyy'), 750);
insert into MISSION (mdate, mid)
values (to_date('20-12-2004', 'dd-mm-yyyy'), 751);
insert into MISSION (mdate, mid)
values (to_date('28-11-1992', 'dd-mm-yyyy'), 752);
insert into MISSION (mdate, mid)
values (to_date('05-07-2010', 'dd-mm-yyyy'), 753);
insert into MISSION (mdate, mid)
values (to_date('02-02-2000', 'dd-mm-yyyy'), 754);
insert into MISSION (mdate, mid)
values (to_date('11-04-1994', 'dd-mm-yyyy'), 755);
insert into MISSION (mdate, mid)
values (to_date('05-01-1993', 'dd-mm-yyyy'), 756);
insert into MISSION (mdate, mid)
values (to_date('06-08-2006', 'dd-mm-yyyy'), 757);
insert into MISSION (mdate, mid)
values (to_date('12-12-2015', 'dd-mm-yyyy'), 758);
insert into MISSION (mdate, mid)
values (to_date('04-08-2010', 'dd-mm-yyyy'), 759);
insert into MISSION (mdate, mid)
values (to_date('18-06-2011', 'dd-mm-yyyy'), 760);
insert into MISSION (mdate, mid)
values (to_date('26-10-2018', 'dd-mm-yyyy'), 761);
insert into MISSION (mdate, mid)
values (to_date('23-12-1996', 'dd-mm-yyyy'), 762);
insert into MISSION (mdate, mid)
values (to_date('05-08-1993', 'dd-mm-yyyy'), 763);
insert into MISSION (mdate, mid)
values (to_date('18-09-2000', 'dd-mm-yyyy'), 764);
insert into MISSION (mdate, mid)
values (to_date('20-07-2015', 'dd-mm-yyyy'), 765);
insert into MISSION (mdate, mid)
values (to_date('20-03-2015', 'dd-mm-yyyy'), 766);
insert into MISSION (mdate, mid)
values (to_date('13-12-1993', 'dd-mm-yyyy'), 767);
insert into MISSION (mdate, mid)
values (to_date('18-06-2011', 'dd-mm-yyyy'), 768);
insert into MISSION (mdate, mid)
values (to_date('30-09-2020', 'dd-mm-yyyy'), 769);
insert into MISSION (mdate, mid)
values (to_date('02-10-1991', 'dd-mm-yyyy'), 770);
insert into MISSION (mdate, mid)
values (to_date('16-04-2001', 'dd-mm-yyyy'), 771);
insert into MISSION (mdate, mid)
values (to_date('05-06-1990', 'dd-mm-yyyy'), 772);
insert into MISSION (mdate, mid)
values (to_date('28-08-2016', 'dd-mm-yyyy'), 773);
insert into MISSION (mdate, mid)
values (to_date('17-08-2016', 'dd-mm-yyyy'), 774);
insert into MISSION (mdate, mid)
values (to_date('30-10-1998', 'dd-mm-yyyy'), 775);
insert into MISSION (mdate, mid)
values (to_date('31-05-2018', 'dd-mm-yyyy'), 776);
insert into MISSION (mdate, mid)
values (to_date('19-09-2001', 'dd-mm-yyyy'), 777);
insert into MISSION (mdate, mid)
values (to_date('27-11-1992', 'dd-mm-yyyy'), 778);
insert into MISSION (mdate, mid)
values (to_date('14-11-2004', 'dd-mm-yyyy'), 779);
insert into MISSION (mdate, mid)
values (to_date('09-10-2020', 'dd-mm-yyyy'), 780);
insert into MISSION (mdate, mid)
values (to_date('04-08-2017', 'dd-mm-yyyy'), 781);
insert into MISSION (mdate, mid)
values (to_date('11-03-2017', 'dd-mm-yyyy'), 782);
insert into MISSION (mdate, mid)
values (to_date('06-09-2001', 'dd-mm-yyyy'), 783);
insert into MISSION (mdate, mid)
values (to_date('17-09-2003', 'dd-mm-yyyy'), 784);
insert into MISSION (mdate, mid)
values (to_date('21-05-2000', 'dd-mm-yyyy'), 785);
insert into MISSION (mdate, mid)
values (to_date('14-03-2013', 'dd-mm-yyyy'), 786);
insert into MISSION (mdate, mid)
values (to_date('22-06-1990', 'dd-mm-yyyy'), 787);
insert into MISSION (mdate, mid)
values (to_date('07-02-1997', 'dd-mm-yyyy'), 788);
insert into MISSION (mdate, mid)
values (to_date('11-06-2012', 'dd-mm-yyyy'), 789);
insert into MISSION (mdate, mid)
values (to_date('20-02-2014', 'dd-mm-yyyy'), 790);
insert into MISSION (mdate, mid)
values (to_date('14-06-1990', 'dd-mm-yyyy'), 791);
insert into MISSION (mdate, mid)
values (to_date('06-10-2014', 'dd-mm-yyyy'), 792);
insert into MISSION (mdate, mid)
values (to_date('21-04-2000', 'dd-mm-yyyy'), 793);
commit;
prompt 1500 records committed...
insert into MISSION (mdate, mid)
values (to_date('07-12-2022', 'dd-mm-yyyy'), 794);
insert into MISSION (mdate, mid)
values (to_date('21-03-2006', 'dd-mm-yyyy'), 795);
insert into MISSION (mdate, mid)
values (to_date('14-04-2021', 'dd-mm-yyyy'), 796);
insert into MISSION (mdate, mid)
values (to_date('09-09-2014', 'dd-mm-yyyy'), 797);
insert into MISSION (mdate, mid)
values (to_date('18-08-2004', 'dd-mm-yyyy'), 798);
insert into MISSION (mdate, mid)
values (to_date('15-12-1995', 'dd-mm-yyyy'), 799);
insert into MISSION (mdate, mid)
values (to_date('10-12-2001', 'dd-mm-yyyy'), 800);
insert into MISSION (mdate, mid)
values (to_date('22-08-2021', 'dd-mm-yyyy'), 801);
insert into MISSION (mdate, mid)
values (to_date('08-07-2012', 'dd-mm-yyyy'), 802);
insert into MISSION (mdate, mid)
values (to_date('22-02-2013', 'dd-mm-yyyy'), 803);
insert into MISSION (mdate, mid)
values (to_date('13-04-2009', 'dd-mm-yyyy'), 804);
insert into MISSION (mdate, mid)
values (to_date('27-02-1993', 'dd-mm-yyyy'), 805);
insert into MISSION (mdate, mid)
values (to_date('21-09-1995', 'dd-mm-yyyy'), 806);
insert into MISSION (mdate, mid)
values (to_date('05-11-2009', 'dd-mm-yyyy'), 807);
insert into MISSION (mdate, mid)
values (to_date('01-05-2002', 'dd-mm-yyyy'), 808);
insert into MISSION (mdate, mid)
values (to_date('12-12-2016', 'dd-mm-yyyy'), 809);
insert into MISSION (mdate, mid)
values (to_date('21-05-1999', 'dd-mm-yyyy'), 810);
insert into MISSION (mdate, mid)
values (to_date('06-09-2018', 'dd-mm-yyyy'), 811);
insert into MISSION (mdate, mid)
values (to_date('06-08-1995', 'dd-mm-yyyy'), 812);
insert into MISSION (mdate, mid)
values (to_date('14-02-2008', 'dd-mm-yyyy'), 813);
insert into MISSION (mdate, mid)
values (to_date('04-09-1991', 'dd-mm-yyyy'), 814);
insert into MISSION (mdate, mid)
values (to_date('13-02-2020', 'dd-mm-yyyy'), 815);
insert into MISSION (mdate, mid)
values (to_date('18-04-2020', 'dd-mm-yyyy'), 816);
insert into MISSION (mdate, mid)
values (to_date('06-01-2000', 'dd-mm-yyyy'), 817);
insert into MISSION (mdate, mid)
values (to_date('11-03-2012', 'dd-mm-yyyy'), 818);
insert into MISSION (mdate, mid)
values (to_date('10-09-1997', 'dd-mm-yyyy'), 819);
insert into MISSION (mdate, mid)
values (to_date('20-06-2002', 'dd-mm-yyyy'), 820);
insert into MISSION (mdate, mid)
values (to_date('25-05-2019', 'dd-mm-yyyy'), 821);
insert into MISSION (mdate, mid)
values (to_date('30-07-1991', 'dd-mm-yyyy'), 822);
insert into MISSION (mdate, mid)
values (to_date('13-03-1999', 'dd-mm-yyyy'), 823);
insert into MISSION (mdate, mid)
values (to_date('16-11-2000', 'dd-mm-yyyy'), 824);
insert into MISSION (mdate, mid)
values (to_date('06-10-2011', 'dd-mm-yyyy'), 825);
insert into MISSION (mdate, mid)
values (to_date('05-05-2019', 'dd-mm-yyyy'), 826);
insert into MISSION (mdate, mid)
values (to_date('31-01-1997', 'dd-mm-yyyy'), 827);
insert into MISSION (mdate, mid)
values (to_date('05-12-2001', 'dd-mm-yyyy'), 828);
insert into MISSION (mdate, mid)
values (to_date('13-07-1993', 'dd-mm-yyyy'), 829);
insert into MISSION (mdate, mid)
values (to_date('05-04-1997', 'dd-mm-yyyy'), 830);
insert into MISSION (mdate, mid)
values (to_date('18-07-2009', 'dd-mm-yyyy'), 831);
insert into MISSION (mdate, mid)
values (to_date('17-12-1994', 'dd-mm-yyyy'), 832);
insert into MISSION (mdate, mid)
values (to_date('24-03-2022', 'dd-mm-yyyy'), 833);
insert into MISSION (mdate, mid)
values (to_date('26-10-1999', 'dd-mm-yyyy'), 834);
insert into MISSION (mdate, mid)
values (to_date('25-12-1994', 'dd-mm-yyyy'), 835);
insert into MISSION (mdate, mid)
values (to_date('21-08-2003', 'dd-mm-yyyy'), 836);
insert into MISSION (mdate, mid)
values (to_date('27-01-2013', 'dd-mm-yyyy'), 837);
insert into MISSION (mdate, mid)
values (to_date('21-07-1998', 'dd-mm-yyyy'), 838);
insert into MISSION (mdate, mid)
values (to_date('27-11-1997', 'dd-mm-yyyy'), 839);
insert into MISSION (mdate, mid)
values (to_date('21-04-2021', 'dd-mm-yyyy'), 840);
insert into MISSION (mdate, mid)
values (to_date('25-07-1999', 'dd-mm-yyyy'), 841);
insert into MISSION (mdate, mid)
values (to_date('30-04-1991', 'dd-mm-yyyy'), 842);
insert into MISSION (mdate, mid)
values (to_date('16-06-2009', 'dd-mm-yyyy'), 843);
insert into MISSION (mdate, mid)
values (to_date('22-07-2004', 'dd-mm-yyyy'), 844);
insert into MISSION (mdate, mid)
values (to_date('09-11-1991', 'dd-mm-yyyy'), 845);
insert into MISSION (mdate, mid)
values (to_date('25-10-2001', 'dd-mm-yyyy'), 846);
insert into MISSION (mdate, mid)
values (to_date('16-01-2004', 'dd-mm-yyyy'), 847);
insert into MISSION (mdate, mid)
values (to_date('07-05-2021', 'dd-mm-yyyy'), 848);
insert into MISSION (mdate, mid)
values (to_date('27-02-2014', 'dd-mm-yyyy'), 849);
insert into MISSION (mdate, mid)
values (to_date('06-10-2016', 'dd-mm-yyyy'), 850);
insert into MISSION (mdate, mid)
values (to_date('28-10-1994', 'dd-mm-yyyy'), 851);
insert into MISSION (mdate, mid)
values (to_date('01-06-1998', 'dd-mm-yyyy'), 852);
insert into MISSION (mdate, mid)
values (to_date('21-05-2019', 'dd-mm-yyyy'), 853);
insert into MISSION (mdate, mid)
values (to_date('29-10-2002', 'dd-mm-yyyy'), 854);
insert into MISSION (mdate, mid)
values (to_date('22-01-1992', 'dd-mm-yyyy'), 855);
insert into MISSION (mdate, mid)
values (to_date('04-11-2005', 'dd-mm-yyyy'), 856);
insert into MISSION (mdate, mid)
values (to_date('11-10-2014', 'dd-mm-yyyy'), 857);
insert into MISSION (mdate, mid)
values (to_date('27-12-2020', 'dd-mm-yyyy'), 858);
insert into MISSION (mdate, mid)
values (to_date('27-06-2020', 'dd-mm-yyyy'), 859);
insert into MISSION (mdate, mid)
values (to_date('03-01-2012', 'dd-mm-yyyy'), 860);
insert into MISSION (mdate, mid)
values (to_date('09-04-2014', 'dd-mm-yyyy'), 861);
insert into MISSION (mdate, mid)
values (to_date('20-02-2005', 'dd-mm-yyyy'), 307);
insert into MISSION (mdate, mid)
values (to_date('07-04-2001', 'dd-mm-yyyy'), 308);
insert into MISSION (mdate, mid)
values (to_date('01-08-2006', 'dd-mm-yyyy'), 309);
insert into MISSION (mdate, mid)
values (to_date('09-04-2016', 'dd-mm-yyyy'), 310);
insert into MISSION (mdate, mid)
values (to_date('07-10-1998', 'dd-mm-yyyy'), 11);
insert into MISSION (mdate, mid)
values (to_date('31-12-2006', 'dd-mm-yyyy'), 12);
insert into MISSION (mdate, mid)
values (to_date('12-09-1994', 'dd-mm-yyyy'), 13);
insert into MISSION (mdate, mid)
values (to_date('09-06-2017', 'dd-mm-yyyy'), 14);
insert into MISSION (mdate, mid)
values (to_date('17-01-2009', 'dd-mm-yyyy'), 15);
insert into MISSION (mdate, mid)
values (to_date('02-08-2008', 'dd-mm-yyyy'), 16);
insert into MISSION (mdate, mid)
values (to_date('05-09-2017', 'dd-mm-yyyy'), 17);
insert into MISSION (mdate, mid)
values (to_date('21-01-2023', 'dd-mm-yyyy'), 18);
insert into MISSION (mdate, mid)
values (to_date('05-05-2003', 'dd-mm-yyyy'), 19);
insert into MISSION (mdate, mid)
values (to_date('15-05-1994', 'dd-mm-yyyy'), 20);
insert into MISSION (mdate, mid)
values (to_date('02-09-2024', 'dd-mm-yyyy'), 21);
insert into MISSION (mdate, mid)
values (to_date('07-02-1991', 'dd-mm-yyyy'), 22);
insert into MISSION (mdate, mid)
values (to_date('20-02-2022', 'dd-mm-yyyy'), 23);
insert into MISSION (mdate, mid)
values (to_date('22-04-2012', 'dd-mm-yyyy'), 24);
insert into MISSION (mdate, mid)
values (to_date('04-04-1999', 'dd-mm-yyyy'), 25);
insert into MISSION (mdate, mid)
values (to_date('06-06-2019', 'dd-mm-yyyy'), 26);
insert into MISSION (mdate, mid)
values (to_date('25-11-2010', 'dd-mm-yyyy'), 27);
insert into MISSION (mdate, mid)
values (to_date('15-09-2001', 'dd-mm-yyyy'), 28);
insert into MISSION (mdate, mid)
values (to_date('19-05-2024', 'dd-mm-yyyy'), 29);
insert into MISSION (mdate, mid)
values (to_date('25-05-1996', 'dd-mm-yyyy'), 30);
insert into MISSION (mdate, mid)
values (to_date('30-05-1990', 'dd-mm-yyyy'), 31);
insert into MISSION (mdate, mid)
values (to_date('03-12-2012', 'dd-mm-yyyy'), 32);
insert into MISSION (mdate, mid)
values (to_date('11-02-2005', 'dd-mm-yyyy'), 33);
insert into MISSION (mdate, mid)
values (to_date('25-09-2014', 'dd-mm-yyyy'), 34);
insert into MISSION (mdate, mid)
values (to_date('23-10-1997', 'dd-mm-yyyy'), 35);
insert into MISSION (mdate, mid)
values (to_date('23-03-2015', 'dd-mm-yyyy'), 36);
insert into MISSION (mdate, mid)
values (to_date('31-10-1991', 'dd-mm-yyyy'), 37);
insert into MISSION (mdate, mid)
values (to_date('19-12-2007', 'dd-mm-yyyy'), 38);
commit;
prompt 1600 records committed...
insert into MISSION (mdate, mid)
values (to_date('28-02-1990', 'dd-mm-yyyy'), 39);
insert into MISSION (mdate, mid)
values (to_date('16-06-2007', 'dd-mm-yyyy'), 40);
insert into MISSION (mdate, mid)
values (to_date('07-10-2022', 'dd-mm-yyyy'), 41);
insert into MISSION (mdate, mid)
values (to_date('14-06-1993', 'dd-mm-yyyy'), 42);
insert into MISSION (mdate, mid)
values (to_date('19-04-2016', 'dd-mm-yyyy'), 43);
insert into MISSION (mdate, mid)
values (to_date('24-02-2000', 'dd-mm-yyyy'), 44);
insert into MISSION (mdate, mid)
values (to_date('29-06-2023', 'dd-mm-yyyy'), 45);
insert into MISSION (mdate, mid)
values (to_date('02-01-2005', 'dd-mm-yyyy'), 46);
insert into MISSION (mdate, mid)
values (to_date('04-06-1991', 'dd-mm-yyyy'), 47);
insert into MISSION (mdate, mid)
values (to_date('21-03-2006', 'dd-mm-yyyy'), 48);
insert into MISSION (mdate, mid)
values (to_date('06-08-1994', 'dd-mm-yyyy'), 49);
insert into MISSION (mdate, mid)
values (to_date('04-09-1996', 'dd-mm-yyyy'), 50);
insert into MISSION (mdate, mid)
values (to_date('07-08-1992', 'dd-mm-yyyy'), 51);
insert into MISSION (mdate, mid)
values (to_date('19-05-2011', 'dd-mm-yyyy'), 52);
insert into MISSION (mdate, mid)
values (to_date('10-09-1992', 'dd-mm-yyyy'), 53);
insert into MISSION (mdate, mid)
values (to_date('14-02-2008', 'dd-mm-yyyy'), 54);
insert into MISSION (mdate, mid)
values (to_date('06-03-2007', 'dd-mm-yyyy'), 55);
insert into MISSION (mdate, mid)
values (to_date('13-12-2008', 'dd-mm-yyyy'), 56);
insert into MISSION (mdate, mid)
values (to_date('04-08-2013', 'dd-mm-yyyy'), 57);
insert into MISSION (mdate, mid)
values (to_date('07-09-2015', 'dd-mm-yyyy'), 58);
insert into MISSION (mdate, mid)
values (to_date('05-10-1999', 'dd-mm-yyyy'), 59);
insert into MISSION (mdate, mid)
values (to_date('14-08-2017', 'dd-mm-yyyy'), 60);
insert into MISSION (mdate, mid)
values (to_date('26-02-2000', 'dd-mm-yyyy'), 61);
insert into MISSION (mdate, mid)
values (to_date('05-02-2022', 'dd-mm-yyyy'), 62);
insert into MISSION (mdate, mid)
values (to_date('05-04-2017', 'dd-mm-yyyy'), 63);
insert into MISSION (mdate, mid)
values (to_date('31-05-2009', 'dd-mm-yyyy'), 64);
insert into MISSION (mdate, mid)
values (to_date('27-03-1996', 'dd-mm-yyyy'), 65);
insert into MISSION (mdate, mid)
values (to_date('03-06-2001', 'dd-mm-yyyy'), 66);
insert into MISSION (mdate, mid)
values (to_date('28-02-1990', 'dd-mm-yyyy'), 67);
insert into MISSION (mdate, mid)
values (to_date('26-11-1998', 'dd-mm-yyyy'), 68);
insert into MISSION (mdate, mid)
values (to_date('26-09-2021', 'dd-mm-yyyy'), 69);
insert into MISSION (mdate, mid)
values (to_date('17-08-2024', 'dd-mm-yyyy'), 70);
insert into MISSION (mdate, mid)
values (to_date('28-12-2016', 'dd-mm-yyyy'), 71);
insert into MISSION (mdate, mid)
values (to_date('22-05-1993', 'dd-mm-yyyy'), 72);
insert into MISSION (mdate, mid)
values (to_date('08-08-2022', 'dd-mm-yyyy'), 73);
insert into MISSION (mdate, mid)
values (to_date('17-12-2024', 'dd-mm-yyyy'), 74);
insert into MISSION (mdate, mid)
values (to_date('17-09-2002', 'dd-mm-yyyy'), 75);
insert into MISSION (mdate, mid)
values (to_date('06-08-2002', 'dd-mm-yyyy'), 76);
insert into MISSION (mdate, mid)
values (to_date('20-05-2013', 'dd-mm-yyyy'), 77);
insert into MISSION (mdate, mid)
values (to_date('21-12-2000', 'dd-mm-yyyy'), 78);
insert into MISSION (mdate, mid)
values (to_date('09-06-2015', 'dd-mm-yyyy'), 79);
insert into MISSION (mdate, mid)
values (to_date('25-02-2000', 'dd-mm-yyyy'), 80);
insert into MISSION (mdate, mid)
values (to_date('16-08-2013', 'dd-mm-yyyy'), 81);
insert into MISSION (mdate, mid)
values (to_date('13-11-1993', 'dd-mm-yyyy'), 82);
insert into MISSION (mdate, mid)
values (to_date('24-09-2004', 'dd-mm-yyyy'), 83);
insert into MISSION (mdate, mid)
values (to_date('26-10-2017', 'dd-mm-yyyy'), 84);
insert into MISSION (mdate, mid)
values (to_date('25-03-2018', 'dd-mm-yyyy'), 85);
insert into MISSION (mdate, mid)
values (to_date('18-07-2024', 'dd-mm-yyyy'), 86);
insert into MISSION (mdate, mid)
values (to_date('28-05-2018', 'dd-mm-yyyy'), 87);
insert into MISSION (mdate, mid)
values (to_date('06-05-2002', 'dd-mm-yyyy'), 88);
insert into MISSION (mdate, mid)
values (to_date('23-07-2005', 'dd-mm-yyyy'), 89);
insert into MISSION (mdate, mid)
values (to_date('05-07-2009', 'dd-mm-yyyy'), 90);
insert into MISSION (mdate, mid)
values (to_date('13-07-1998', 'dd-mm-yyyy'), 91);
insert into MISSION (mdate, mid)
values (to_date('19-04-2018', 'dd-mm-yyyy'), 92);
insert into MISSION (mdate, mid)
values (to_date('29-11-1995', 'dd-mm-yyyy'), 93);
insert into MISSION (mdate, mid)
values (to_date('18-06-1998', 'dd-mm-yyyy'), 94);
insert into MISSION (mdate, mid)
values (to_date('11-02-1996', 'dd-mm-yyyy'), 95);
insert into MISSION (mdate, mid)
values (to_date('28-04-2024', 'dd-mm-yyyy'), 96);
insert into MISSION (mdate, mid)
values (to_date('21-08-2006', 'dd-mm-yyyy'), 97);
insert into MISSION (mdate, mid)
values (to_date('28-04-2000', 'dd-mm-yyyy'), 98);
insert into MISSION (mdate, mid)
values (to_date('28-08-2007', 'dd-mm-yyyy'), 99);
insert into MISSION (mdate, mid)
values (to_date('05-09-1998', 'dd-mm-yyyy'), 100);
insert into MISSION (mdate, mid)
values (to_date('21-01-2004', 'dd-mm-yyyy'), 101);
insert into MISSION (mdate, mid)
values (to_date('29-12-2002', 'dd-mm-yyyy'), 102);
insert into MISSION (mdate, mid)
values (to_date('11-07-2010', 'dd-mm-yyyy'), 103);
insert into MISSION (mdate, mid)
values (to_date('03-12-2008', 'dd-mm-yyyy'), 104);
insert into MISSION (mdate, mid)
values (to_date('26-11-1995', 'dd-mm-yyyy'), 105);
insert into MISSION (mdate, mid)
values (to_date('31-12-1995', 'dd-mm-yyyy'), 106);
insert into MISSION (mdate, mid)
values (to_date('07-11-2012', 'dd-mm-yyyy'), 107);
insert into MISSION (mdate, mid)
values (to_date('30-03-2004', 'dd-mm-yyyy'), 108);
insert into MISSION (mdate, mid)
values (to_date('21-12-1996', 'dd-mm-yyyy'), 109);
insert into MISSION (mdate, mid)
values (to_date('26-12-2023', 'dd-mm-yyyy'), 110);
insert into MISSION (mdate, mid)
values (to_date('31-05-2012', 'dd-mm-yyyy'), 111);
insert into MISSION (mdate, mid)
values (to_date('27-08-1992', 'dd-mm-yyyy'), 112);
insert into MISSION (mdate, mid)
values (to_date('28-03-1994', 'dd-mm-yyyy'), 113);
insert into MISSION (mdate, mid)
values (to_date('05-08-1992', 'dd-mm-yyyy'), 114);
insert into MISSION (mdate, mid)
values (to_date('10-09-2012', 'dd-mm-yyyy'), 115);
insert into MISSION (mdate, mid)
values (to_date('10-02-2014', 'dd-mm-yyyy'), 116);
insert into MISSION (mdate, mid)
values (to_date('09-07-2011', 'dd-mm-yyyy'), 117);
insert into MISSION (mdate, mid)
values (to_date('17-03-2007', 'dd-mm-yyyy'), 118);
insert into MISSION (mdate, mid)
values (to_date('29-01-2008', 'dd-mm-yyyy'), 119);
insert into MISSION (mdate, mid)
values (to_date('06-05-1994', 'dd-mm-yyyy'), 120);
insert into MISSION (mdate, mid)
values (to_date('30-07-1997', 'dd-mm-yyyy'), 121);
insert into MISSION (mdate, mid)
values (to_date('15-08-2003', 'dd-mm-yyyy'), 122);
insert into MISSION (mdate, mid)
values (to_date('23-11-1998', 'dd-mm-yyyy'), 123);
insert into MISSION (mdate, mid)
values (to_date('28-10-1992', 'dd-mm-yyyy'), 124);
insert into MISSION (mdate, mid)
values (to_date('24-02-2005', 'dd-mm-yyyy'), 125);
insert into MISSION (mdate, mid)
values (to_date('15-08-1993', 'dd-mm-yyyy'), 126);
insert into MISSION (mdate, mid)
values (to_date('01-10-2000', 'dd-mm-yyyy'), 127);
insert into MISSION (mdate, mid)
values (to_date('26-03-2002', 'dd-mm-yyyy'), 128);
insert into MISSION (mdate, mid)
values (to_date('22-04-2017', 'dd-mm-yyyy'), 129);
insert into MISSION (mdate, mid)
values (to_date('08-01-2017', 'dd-mm-yyyy'), 130);
insert into MISSION (mdate, mid)
values (to_date('03-05-2021', 'dd-mm-yyyy'), 131);
insert into MISSION (mdate, mid)
values (to_date('27-05-2005', 'dd-mm-yyyy'), 132);
insert into MISSION (mdate, mid)
values (to_date('04-03-2011', 'dd-mm-yyyy'), 133);
insert into MISSION (mdate, mid)
values (to_date('13-08-2020', 'dd-mm-yyyy'), 134);
insert into MISSION (mdate, mid)
values (to_date('19-09-2021', 'dd-mm-yyyy'), 135);
insert into MISSION (mdate, mid)
values (to_date('22-06-2024', 'dd-mm-yyyy'), 136);
insert into MISSION (mdate, mid)
values (to_date('07-11-2017', 'dd-mm-yyyy'), 137);
insert into MISSION (mdate, mid)
values (to_date('20-02-1998', 'dd-mm-yyyy'), 138);
commit;
prompt 1700 records committed...
insert into MISSION (mdate, mid)
values (to_date('02-10-1992', 'dd-mm-yyyy'), 139);
insert into MISSION (mdate, mid)
values (to_date('05-11-2010', 'dd-mm-yyyy'), 140);
insert into MISSION (mdate, mid)
values (to_date('28-02-2016', 'dd-mm-yyyy'), 141);
insert into MISSION (mdate, mid)
values (to_date('02-03-1999', 'dd-mm-yyyy'), 142);
insert into MISSION (mdate, mid)
values (to_date('09-02-2006', 'dd-mm-yyyy'), 143);
insert into MISSION (mdate, mid)
values (to_date('08-02-1993', 'dd-mm-yyyy'), 144);
insert into MISSION (mdate, mid)
values (to_date('12-06-1996', 'dd-mm-yyyy'), 145);
insert into MISSION (mdate, mid)
values (to_date('24-07-2008', 'dd-mm-yyyy'), 146);
insert into MISSION (mdate, mid)
values (to_date('13-02-2003', 'dd-mm-yyyy'), 147);
insert into MISSION (mdate, mid)
values (to_date('15-01-1999', 'dd-mm-yyyy'), 148);
insert into MISSION (mdate, mid)
values (to_date('08-08-2014', 'dd-mm-yyyy'), 149);
insert into MISSION (mdate, mid)
values (to_date('26-11-2021', 'dd-mm-yyyy'), 150);
insert into MISSION (mdate, mid)
values (to_date('11-05-2003', 'dd-mm-yyyy'), 151);
insert into MISSION (mdate, mid)
values (to_date('03-06-2011', 'dd-mm-yyyy'), 152);
insert into MISSION (mdate, mid)
values (to_date('10-02-1995', 'dd-mm-yyyy'), 153);
insert into MISSION (mdate, mid)
values (to_date('17-12-2020', 'dd-mm-yyyy'), 154);
insert into MISSION (mdate, mid)
values (to_date('20-09-2023', 'dd-mm-yyyy'), 155);
insert into MISSION (mdate, mid)
values (to_date('15-02-2016', 'dd-mm-yyyy'), 156);
insert into MISSION (mdate, mid)
values (to_date('05-09-1995', 'dd-mm-yyyy'), 157);
insert into MISSION (mdate, mid)
values (to_date('11-03-2017', 'dd-mm-yyyy'), 158);
insert into MISSION (mdate, mid)
values (to_date('21-05-2022', 'dd-mm-yyyy'), 159);
insert into MISSION (mdate, mid)
values (to_date('27-10-1999', 'dd-mm-yyyy'), 160);
insert into MISSION (mdate, mid)
values (to_date('15-10-2009', 'dd-mm-yyyy'), 161);
insert into MISSION (mdate, mid)
values (to_date('01-11-2024', 'dd-mm-yyyy'), 162);
insert into MISSION (mdate, mid)
values (to_date('04-12-2015', 'dd-mm-yyyy'), 163);
insert into MISSION (mdate, mid)
values (to_date('15-04-2008', 'dd-mm-yyyy'), 164);
insert into MISSION (mdate, mid)
values (to_date('10-04-2002', 'dd-mm-yyyy'), 165);
insert into MISSION (mdate, mid)
values (to_date('21-01-2009', 'dd-mm-yyyy'), 166);
insert into MISSION (mdate, mid)
values (to_date('15-06-2001', 'dd-mm-yyyy'), 167);
insert into MISSION (mdate, mid)
values (to_date('25-01-2000', 'dd-mm-yyyy'), 168);
insert into MISSION (mdate, mid)
values (to_date('09-09-2006', 'dd-mm-yyyy'), 169);
insert into MISSION (mdate, mid)
values (to_date('15-03-2003', 'dd-mm-yyyy'), 170);
insert into MISSION (mdate, mid)
values (to_date('09-08-2024', 'dd-mm-yyyy'), 171);
insert into MISSION (mdate, mid)
values (to_date('05-01-2009', 'dd-mm-yyyy'), 172);
insert into MISSION (mdate, mid)
values (to_date('22-02-2017', 'dd-mm-yyyy'), 173);
insert into MISSION (mdate, mid)
values (to_date('14-02-2003', 'dd-mm-yyyy'), 174);
insert into MISSION (mdate, mid)
values (to_date('10-09-2007', 'dd-mm-yyyy'), 175);
insert into MISSION (mdate, mid)
values (to_date('29-12-2017', 'dd-mm-yyyy'), 176);
insert into MISSION (mdate, mid)
values (to_date('25-10-2010', 'dd-mm-yyyy'), 177);
insert into MISSION (mdate, mid)
values (to_date('17-03-1990', 'dd-mm-yyyy'), 178);
insert into MISSION (mdate, mid)
values (to_date('23-04-2011', 'dd-mm-yyyy'), 179);
insert into MISSION (mdate, mid)
values (to_date('29-09-2004', 'dd-mm-yyyy'), 180);
insert into MISSION (mdate, mid)
values (to_date('24-04-1991', 'dd-mm-yyyy'), 181);
insert into MISSION (mdate, mid)
values (to_date('10-06-2023', 'dd-mm-yyyy'), 182);
insert into MISSION (mdate, mid)
values (to_date('04-05-2001', 'dd-mm-yyyy'), 183);
insert into MISSION (mdate, mid)
values (to_date('27-08-1999', 'dd-mm-yyyy'), 184);
insert into MISSION (mdate, mid)
values (to_date('02-09-2021', 'dd-mm-yyyy'), 185);
insert into MISSION (mdate, mid)
values (to_date('21-09-1999', 'dd-mm-yyyy'), 186);
insert into MISSION (mdate, mid)
values (to_date('15-01-2022', 'dd-mm-yyyy'), 187);
insert into MISSION (mdate, mid)
values (to_date('30-12-2003', 'dd-mm-yyyy'), 188);
insert into MISSION (mdate, mid)
values (to_date('02-08-2014', 'dd-mm-yyyy'), 189);
insert into MISSION (mdate, mid)
values (to_date('11-04-2020', 'dd-mm-yyyy'), 190);
insert into MISSION (mdate, mid)
values (to_date('28-08-2004', 'dd-mm-yyyy'), 191);
insert into MISSION (mdate, mid)
values (to_date('18-11-2010', 'dd-mm-yyyy'), 192);
insert into MISSION (mdate, mid)
values (to_date('02-03-2001', 'dd-mm-yyyy'), 193);
insert into MISSION (mdate, mid)
values (to_date('28-10-1999', 'dd-mm-yyyy'), 194);
insert into MISSION (mdate, mid)
values (to_date('20-10-2024', 'dd-mm-yyyy'), 195);
insert into MISSION (mdate, mid)
values (to_date('27-11-1994', 'dd-mm-yyyy'), 196);
insert into MISSION (mdate, mid)
values (to_date('04-05-1998', 'dd-mm-yyyy'), 197);
insert into MISSION (mdate, mid)
values (to_date('06-11-1998', 'dd-mm-yyyy'), 198);
insert into MISSION (mdate, mid)
values (to_date('13-07-2010', 'dd-mm-yyyy'), 199);
insert into MISSION (mdate, mid)
values (to_date('01-05-1990', 'dd-mm-yyyy'), 200);
insert into MISSION (mdate, mid)
values (to_date('14-09-2003', 'dd-mm-yyyy'), 201);
insert into MISSION (mdate, mid)
values (to_date('25-03-2003', 'dd-mm-yyyy'), 202);
insert into MISSION (mdate, mid)
values (to_date('14-10-2011', 'dd-mm-yyyy'), 203);
insert into MISSION (mdate, mid)
values (to_date('23-03-2001', 'dd-mm-yyyy'), 204);
insert into MISSION (mdate, mid)
values (to_date('02-06-1990', 'dd-mm-yyyy'), 205);
insert into MISSION (mdate, mid)
values (to_date('14-12-2018', 'dd-mm-yyyy'), 206);
insert into MISSION (mdate, mid)
values (to_date('04-10-2015', 'dd-mm-yyyy'), 207);
insert into MISSION (mdate, mid)
values (to_date('01-12-2020', 'dd-mm-yyyy'), 208);
insert into MISSION (mdate, mid)
values (to_date('15-06-1993', 'dd-mm-yyyy'), 209);
insert into MISSION (mdate, mid)
values (to_date('11-09-1993', 'dd-mm-yyyy'), 210);
insert into MISSION (mdate, mid)
values (to_date('28-03-2016', 'dd-mm-yyyy'), 211);
insert into MISSION (mdate, mid)
values (to_date('24-09-1991', 'dd-mm-yyyy'), 212);
insert into MISSION (mdate, mid)
values (to_date('11-04-2002', 'dd-mm-yyyy'), 213);
insert into MISSION (mdate, mid)
values (to_date('02-08-1995', 'dd-mm-yyyy'), 214);
insert into MISSION (mdate, mid)
values (to_date('13-01-2004', 'dd-mm-yyyy'), 215);
insert into MISSION (mdate, mid)
values (to_date('22-09-1999', 'dd-mm-yyyy'), 216);
insert into MISSION (mdate, mid)
values (to_date('24-10-2013', 'dd-mm-yyyy'), 217);
insert into MISSION (mdate, mid)
values (to_date('24-04-2003', 'dd-mm-yyyy'), 218);
insert into MISSION (mdate, mid)
values (to_date('21-01-2009', 'dd-mm-yyyy'), 219);
insert into MISSION (mdate, mid)
values (to_date('03-02-1993', 'dd-mm-yyyy'), 220);
insert into MISSION (mdate, mid)
values (to_date('07-04-2013', 'dd-mm-yyyy'), 221);
insert into MISSION (mdate, mid)
values (to_date('19-06-2000', 'dd-mm-yyyy'), 222);
insert into MISSION (mdate, mid)
values (to_date('13-08-2018', 'dd-mm-yyyy'), 223);
insert into MISSION (mdate, mid)
values (to_date('24-04-2001', 'dd-mm-yyyy'), 224);
insert into MISSION (mdate, mid)
values (to_date('26-01-2009', 'dd-mm-yyyy'), 225);
insert into MISSION (mdate, mid)
values (to_date('05-10-1990', 'dd-mm-yyyy'), 226);
insert into MISSION (mdate, mid)
values (to_date('16-01-1990', 'dd-mm-yyyy'), 227);
insert into MISSION (mdate, mid)
values (to_date('09-03-2021', 'dd-mm-yyyy'), 228);
insert into MISSION (mdate, mid)
values (to_date('25-02-2012', 'dd-mm-yyyy'), 229);
insert into MISSION (mdate, mid)
values (to_date('05-07-2014', 'dd-mm-yyyy'), 230);
insert into MISSION (mdate, mid)
values (to_date('02-09-2009', 'dd-mm-yyyy'), 231);
insert into MISSION (mdate, mid)
values (to_date('03-07-2004', 'dd-mm-yyyy'), 232);
insert into MISSION (mdate, mid)
values (to_date('23-03-1998', 'dd-mm-yyyy'), 233);
insert into MISSION (mdate, mid)
values (to_date('05-07-2010', 'dd-mm-yyyy'), 234);
insert into MISSION (mdate, mid)
values (to_date('31-10-1993', 'dd-mm-yyyy'), 235);
insert into MISSION (mdate, mid)
values (to_date('22-10-2005', 'dd-mm-yyyy'), 236);
insert into MISSION (mdate, mid)
values (to_date('09-10-2005', 'dd-mm-yyyy'), 237);
insert into MISSION (mdate, mid)
values (to_date('26-03-2006', 'dd-mm-yyyy'), 238);
commit;
prompt 1800 records committed...
insert into MISSION (mdate, mid)
values (to_date('27-04-2016', 'dd-mm-yyyy'), 239);
insert into MISSION (mdate, mid)
values (to_date('01-08-1997', 'dd-mm-yyyy'), 240);
insert into MISSION (mdate, mid)
values (to_date('05-01-2006', 'dd-mm-yyyy'), 241);
insert into MISSION (mdate, mid)
values (to_date('07-12-2007', 'dd-mm-yyyy'), 242);
insert into MISSION (mdate, mid)
values (to_date('23-07-2010', 'dd-mm-yyyy'), 243);
insert into MISSION (mdate, mid)
values (to_date('06-11-2023', 'dd-mm-yyyy'), 244);
insert into MISSION (mdate, mid)
values (to_date('04-12-1994', 'dd-mm-yyyy'), 245);
insert into MISSION (mdate, mid)
values (to_date('06-02-2021', 'dd-mm-yyyy'), 246);
insert into MISSION (mdate, mid)
values (to_date('17-05-2018', 'dd-mm-yyyy'), 247);
insert into MISSION (mdate, mid)
values (to_date('07-12-2006', 'dd-mm-yyyy'), 248);
insert into MISSION (mdate, mid)
values (to_date('24-02-1996', 'dd-mm-yyyy'), 249);
insert into MISSION (mdate, mid)
values (to_date('19-05-2010', 'dd-mm-yyyy'), 250);
insert into MISSION (mdate, mid)
values (to_date('26-02-1996', 'dd-mm-yyyy'), 251);
insert into MISSION (mdate, mid)
values (to_date('05-12-2000', 'dd-mm-yyyy'), 252);
insert into MISSION (mdate, mid)
values (to_date('29-05-2022', 'dd-mm-yyyy'), 253);
insert into MISSION (mdate, mid)
values (to_date('27-10-2001', 'dd-mm-yyyy'), 254);
insert into MISSION (mdate, mid)
values (to_date('27-09-2017', 'dd-mm-yyyy'), 255);
insert into MISSION (mdate, mid)
values (to_date('16-02-2014', 'dd-mm-yyyy'), 256);
insert into MISSION (mdate, mid)
values (to_date('06-09-2016', 'dd-mm-yyyy'), 257);
insert into MISSION (mdate, mid)
values (to_date('05-03-2014', 'dd-mm-yyyy'), 258);
insert into MISSION (mdate, mid)
values (to_date('14-05-2007', 'dd-mm-yyyy'), 259);
insert into MISSION (mdate, mid)
values (to_date('03-06-2001', 'dd-mm-yyyy'), 260);
insert into MISSION (mdate, mid)
values (to_date('14-04-2013', 'dd-mm-yyyy'), 261);
insert into MISSION (mdate, mid)
values (to_date('16-07-2004', 'dd-mm-yyyy'), 262);
insert into MISSION (mdate, mid)
values (to_date('10-07-1999', 'dd-mm-yyyy'), 263);
insert into MISSION (mdate, mid)
values (to_date('10-06-2006', 'dd-mm-yyyy'), 264);
insert into MISSION (mdate, mid)
values (to_date('17-08-1997', 'dd-mm-yyyy'), 265);
insert into MISSION (mdate, mid)
values (to_date('23-07-2022', 'dd-mm-yyyy'), 266);
insert into MISSION (mdate, mid)
values (to_date('16-06-2006', 'dd-mm-yyyy'), 267);
insert into MISSION (mdate, mid)
values (to_date('15-12-2021', 'dd-mm-yyyy'), 268);
insert into MISSION (mdate, mid)
values (to_date('17-04-2002', 'dd-mm-yyyy'), 269);
insert into MISSION (mdate, mid)
values (to_date('09-01-2006', 'dd-mm-yyyy'), 270);
insert into MISSION (mdate, mid)
values (to_date('27-10-2017', 'dd-mm-yyyy'), 271);
insert into MISSION (mdate, mid)
values (to_date('19-10-2020', 'dd-mm-yyyy'), 272);
insert into MISSION (mdate, mid)
values (to_date('14-09-2005', 'dd-mm-yyyy'), 273);
insert into MISSION (mdate, mid)
values (to_date('23-07-2024', 'dd-mm-yyyy'), 274);
insert into MISSION (mdate, mid)
values (to_date('01-08-2000', 'dd-mm-yyyy'), 275);
insert into MISSION (mdate, mid)
values (to_date('30-04-2023', 'dd-mm-yyyy'), 276);
insert into MISSION (mdate, mid)
values (to_date('24-06-2013', 'dd-mm-yyyy'), 277);
insert into MISSION (mdate, mid)
values (to_date('28-09-2001', 'dd-mm-yyyy'), 278);
insert into MISSION (mdate, mid)
values (to_date('21-03-2021', 'dd-mm-yyyy'), 279);
insert into MISSION (mdate, mid)
values (to_date('08-03-2006', 'dd-mm-yyyy'), 280);
insert into MISSION (mdate, mid)
values (to_date('28-04-2011', 'dd-mm-yyyy'), 281);
insert into MISSION (mdate, mid)
values (to_date('25-10-2019', 'dd-mm-yyyy'), 282);
insert into MISSION (mdate, mid)
values (to_date('16-11-1990', 'dd-mm-yyyy'), 283);
insert into MISSION (mdate, mid)
values (to_date('16-11-1990', 'dd-mm-yyyy'), 284);
insert into MISSION (mdate, mid)
values (to_date('31-12-2011', 'dd-mm-yyyy'), 285);
insert into MISSION (mdate, mid)
values (to_date('26-11-2009', 'dd-mm-yyyy'), 286);
insert into MISSION (mdate, mid)
values (to_date('04-12-2012', 'dd-mm-yyyy'), 287);
insert into MISSION (mdate, mid)
values (to_date('13-06-1994', 'dd-mm-yyyy'), 288);
insert into MISSION (mdate, mid)
values (to_date('24-09-2007', 'dd-mm-yyyy'), 289);
insert into MISSION (mdate, mid)
values (to_date('29-04-2019', 'dd-mm-yyyy'), 290);
insert into MISSION (mdate, mid)
values (to_date('04-02-2019', 'dd-mm-yyyy'), 301);
insert into MISSION (mdate, mid)
values (to_date('19-08-2001', 'dd-mm-yyyy'), 302);
insert into MISSION (mdate, mid)
values (to_date('12-03-1994', 'dd-mm-yyyy'), 303);
insert into MISSION (mdate, mid)
values (to_date('09-03-2011', 'dd-mm-yyyy'), 291);
insert into MISSION (mdate, mid)
values (to_date('05-04-2023', 'dd-mm-yyyy'), 292);
insert into MISSION (mdate, mid)
values (to_date('08-08-2000', 'dd-mm-yyyy'), 304);
insert into MISSION (mdate, mid)
values (to_date('29-01-2010', 'dd-mm-yyyy'), 305);
insert into MISSION (mdate, mid)
values (to_date('27-10-2007', 'dd-mm-yyyy'), 306);
insert into MISSION (mdate, mid)
values (to_date('10-02-1998', 'dd-mm-yyyy'), 293);
insert into MISSION (mdate, mid)
values (to_date('08-06-2016', 'dd-mm-yyyy'), 294);
insert into MISSION (mdate, mid)
values (to_date('24-08-2020', 'dd-mm-yyyy'), 295);
insert into MISSION (mdate, mid)
values (to_date('08-08-2019', 'dd-mm-yyyy'), 296);
insert into MISSION (mdate, mid)
values (to_date('04-05-1992', 'dd-mm-yyyy'), 297);
insert into MISSION (mdate, mid)
values (to_date('16-02-2022', 'dd-mm-yyyy'), 298);
insert into MISSION (mdate, mid)
values (to_date('20-07-2011', 'dd-mm-yyyy'), 299);
insert into MISSION (mdate, mid)
values (to_date('22-09-1994', 'dd-mm-yyyy'), 300);
insert into MISSION (mdate, mid)
values (to_date('19-01-2001', 'dd-mm-yyyy'), 311);
insert into MISSION (mdate, mid)
values (to_date('31-12-1990', 'dd-mm-yyyy'), 312);
insert into MISSION (mdate, mid)
values (to_date('15-11-1991', 'dd-mm-yyyy'), 313);
insert into MISSION (mdate, mid)
values (to_date('03-09-2020', 'dd-mm-yyyy'), 314);
insert into MISSION (mdate, mid)
values (to_date('15-10-2022', 'dd-mm-yyyy'), 315);
insert into MISSION (mdate, mid)
values (to_date('03-11-2017', 'dd-mm-yyyy'), 316);
insert into MISSION (mdate, mid)
values (to_date('19-03-1994', 'dd-mm-yyyy'), 317);
insert into MISSION (mdate, mid)
values (to_date('01-01-2012', 'dd-mm-yyyy'), 318);
insert into MISSION (mdate, mid)
values (to_date('24-10-2012', 'dd-mm-yyyy'), 319);
insert into MISSION (mdate, mid)
values (to_date('07-06-1995', 'dd-mm-yyyy'), 320);
insert into MISSION (mdate, mid)
values (to_date('30-01-2002', 'dd-mm-yyyy'), 321);
insert into MISSION (mdate, mid)
values (to_date('02-11-2019', 'dd-mm-yyyy'), 322);
insert into MISSION (mdate, mid)
values (to_date('17-08-2002', 'dd-mm-yyyy'), 323);
insert into MISSION (mdate, mid)
values (to_date('10-09-2000', 'dd-mm-yyyy'), 324);
insert into MISSION (mdate, mid)
values (to_date('05-09-2022', 'dd-mm-yyyy'), 325);
insert into MISSION (mdate, mid)
values (to_date('19-05-2020', 'dd-mm-yyyy'), 326);
insert into MISSION (mdate, mid)
values (to_date('13-09-2007', 'dd-mm-yyyy'), 327);
insert into MISSION (mdate, mid)
values (to_date('03-11-1992', 'dd-mm-yyyy'), 328);
insert into MISSION (mdate, mid)
values (to_date('26-08-2000', 'dd-mm-yyyy'), 329);
insert into MISSION (mdate, mid)
values (to_date('20-05-1995', 'dd-mm-yyyy'), 330);
insert into MISSION (mdate, mid)
values (to_date('12-12-1996', 'dd-mm-yyyy'), 331);
insert into MISSION (mdate, mid)
values (to_date('05-01-2007', 'dd-mm-yyyy'), 332);
insert into MISSION (mdate, mid)
values (to_date('20-04-2002', 'dd-mm-yyyy'), 333);
insert into MISSION (mdate, mid)
values (to_date('23-08-1992', 'dd-mm-yyyy'), 334);
insert into MISSION (mdate, mid)
values (to_date('19-04-2006', 'dd-mm-yyyy'), 335);
insert into MISSION (mdate, mid)
values (to_date('30-08-2014', 'dd-mm-yyyy'), 336);
insert into MISSION (mdate, mid)
values (to_date('18-03-1991', 'dd-mm-yyyy'), 337);
insert into MISSION (mdate, mid)
values (to_date('12-06-2013', 'dd-mm-yyyy'), 338);
insert into MISSION (mdate, mid)
values (to_date('15-07-1998', 'dd-mm-yyyy'), 339);
insert into MISSION (mdate, mid)
values (to_date('02-01-2011', 'dd-mm-yyyy'), 340);
insert into MISSION (mdate, mid)
values (to_date('19-07-1991', 'dd-mm-yyyy'), 341);
insert into MISSION (mdate, mid)
values (to_date('06-07-2002', 'dd-mm-yyyy'), 342);
commit;
prompt 1900 records committed...
insert into MISSION (mdate, mid)
values (to_date('07-12-1997', 'dd-mm-yyyy'), 343);
insert into MISSION (mdate, mid)
values (to_date('21-08-2014', 'dd-mm-yyyy'), 344);
insert into MISSION (mdate, mid)
values (to_date('12-12-2015', 'dd-mm-yyyy'), 345);
insert into MISSION (mdate, mid)
values (to_date('08-09-2020', 'dd-mm-yyyy'), 346);
insert into MISSION (mdate, mid)
values (to_date('25-10-2016', 'dd-mm-yyyy'), 347);
insert into MISSION (mdate, mid)
values (to_date('21-09-2012', 'dd-mm-yyyy'), 348);
insert into MISSION (mdate, mid)
values (to_date('14-04-1993', 'dd-mm-yyyy'), 349);
insert into MISSION (mdate, mid)
values (to_date('02-04-2009', 'dd-mm-yyyy'), 350);
insert into MISSION (mdate, mid)
values (to_date('24-08-2013', 'dd-mm-yyyy'), 351);
insert into MISSION (mdate, mid)
values (to_date('13-09-1995', 'dd-mm-yyyy'), 352);
insert into MISSION (mdate, mid)
values (to_date('01-03-2008', 'dd-mm-yyyy'), 353);
insert into MISSION (mdate, mid)
values (to_date('28-10-1990', 'dd-mm-yyyy'), 354);
insert into MISSION (mdate, mid)
values (to_date('01-09-1994', 'dd-mm-yyyy'), 355);
insert into MISSION (mdate, mid)
values (to_date('16-01-1996', 'dd-mm-yyyy'), 356);
insert into MISSION (mdate, mid)
values (to_date('27-07-2016', 'dd-mm-yyyy'), 357);
insert into MISSION (mdate, mid)
values (to_date('08-10-1996', 'dd-mm-yyyy'), 358);
insert into MISSION (mdate, mid)
values (to_date('18-10-2005', 'dd-mm-yyyy'), 359);
insert into MISSION (mdate, mid)
values (to_date('25-12-2019', 'dd-mm-yyyy'), 360);
insert into MISSION (mdate, mid)
values (to_date('16-05-2012', 'dd-mm-yyyy'), 361);
insert into MISSION (mdate, mid)
values (to_date('16-04-2005', 'dd-mm-yyyy'), 362);
insert into MISSION (mdate, mid)
values (to_date('17-10-2007', 'dd-mm-yyyy'), 363);
insert into MISSION (mdate, mid)
values (to_date('22-09-2007', 'dd-mm-yyyy'), 364);
insert into MISSION (mdate, mid)
values (to_date('21-02-1996', 'dd-mm-yyyy'), 365);
insert into MISSION (mdate, mid)
values (to_date('31-10-2012', 'dd-mm-yyyy'), 366);
insert into MISSION (mdate, mid)
values (to_date('16-04-2010', 'dd-mm-yyyy'), 367);
insert into MISSION (mdate, mid)
values (to_date('07-01-2000', 'dd-mm-yyyy'), 368);
insert into MISSION (mdate, mid)
values (to_date('28-01-1990', 'dd-mm-yyyy'), 369);
insert into MISSION (mdate, mid)
values (to_date('14-02-1996', 'dd-mm-yyyy'), 370);
insert into MISSION (mdate, mid)
values (to_date('30-10-1998', 'dd-mm-yyyy'), 371);
insert into MISSION (mdate, mid)
values (to_date('04-09-2017', 'dd-mm-yyyy'), 372);
insert into MISSION (mdate, mid)
values (to_date('02-06-2011', 'dd-mm-yyyy'), 373);
insert into MISSION (mdate, mid)
values (to_date('29-06-2006', 'dd-mm-yyyy'), 374);
insert into MISSION (mdate, mid)
values (to_date('10-06-2013', 'dd-mm-yyyy'), 375);
insert into MISSION (mdate, mid)
values (to_date('18-12-2018', 'dd-mm-yyyy'), 376);
insert into MISSION (mdate, mid)
values (to_date('20-02-1993', 'dd-mm-yyyy'), 377);
insert into MISSION (mdate, mid)
values (to_date('20-10-2000', 'dd-mm-yyyy'), 378);
insert into MISSION (mdate, mid)
values (to_date('13-12-1997', 'dd-mm-yyyy'), 379);
insert into MISSION (mdate, mid)
values (to_date('04-04-2002', 'dd-mm-yyyy'), 380);
insert into MISSION (mdate, mid)
values (to_date('12-04-2023', 'dd-mm-yyyy'), 381);
insert into MISSION (mdate, mid)
values (to_date('13-07-2007', 'dd-mm-yyyy'), 382);
insert into MISSION (mdate, mid)
values (to_date('14-06-1999', 'dd-mm-yyyy'), 383);
insert into MISSION (mdate, mid)
values (to_date('21-01-1990', 'dd-mm-yyyy'), 384);
insert into MISSION (mdate, mid)
values (to_date('29-10-1990', 'dd-mm-yyyy'), 385);
insert into MISSION (mdate, mid)
values (to_date('22-05-2011', 'dd-mm-yyyy'), 386);
insert into MISSION (mdate, mid)
values (to_date('18-03-2014', 'dd-mm-yyyy'), 387);
insert into MISSION (mdate, mid)
values (to_date('26-09-2012', 'dd-mm-yyyy'), 388);
insert into MISSION (mdate, mid)
values (to_date('06-05-2012', 'dd-mm-yyyy'), 389);
insert into MISSION (mdate, mid)
values (to_date('11-02-2002', 'dd-mm-yyyy'), 390);
insert into MISSION (mdate, mid)
values (to_date('01-07-2008', 'dd-mm-yyyy'), 391);
insert into MISSION (mdate, mid)
values (to_date('28-01-2015', 'dd-mm-yyyy'), 392);
insert into MISSION (mdate, mid)
values (to_date('29-05-1996', 'dd-mm-yyyy'), 393);
insert into MISSION (mdate, mid)
values (to_date('30-08-1995', 'dd-mm-yyyy'), 394);
insert into MISSION (mdate, mid)
values (to_date('08-06-2005', 'dd-mm-yyyy'), 395);
insert into MISSION (mdate, mid)
values (to_date('03-12-1990', 'dd-mm-yyyy'), 396);
insert into MISSION (mdate, mid)
values (to_date('05-12-2008', 'dd-mm-yyyy'), 397);
insert into MISSION (mdate, mid)
values (to_date('11-07-2014', 'dd-mm-yyyy'), 398);
insert into MISSION (mdate, mid)
values (to_date('03-07-2001', 'dd-mm-yyyy'), 399);
insert into MISSION (mdate, mid)
values (to_date('25-01-2014', 'dd-mm-yyyy'), 400);
insert into MISSION (mdate, mid)
values (to_date('13-06-2017', 'dd-mm-yyyy'), 401);
insert into MISSION (mdate, mid)
values (to_date('05-06-2022', 'dd-mm-yyyy'), 402);
insert into MISSION (mdate, mid)
values (to_date('10-10-1994', 'dd-mm-yyyy'), 403);
insert into MISSION (mdate, mid)
values (to_date('28-10-2011', 'dd-mm-yyyy'), 404);
insert into MISSION (mdate, mid)
values (to_date('14-08-2014', 'dd-mm-yyyy'), 405);
insert into MISSION (mdate, mid)
values (to_date('13-01-2021', 'dd-mm-yyyy'), 406);
insert into MISSION (mdate, mid)
values (to_date('14-06-2007', 'dd-mm-yyyy'), 407);
insert into MISSION (mdate, mid)
values (to_date('27-01-2020', 'dd-mm-yyyy'), 408);
insert into MISSION (mdate, mid)
values (to_date('10-09-1999', 'dd-mm-yyyy'), 409);
insert into MISSION (mdate, mid)
values (to_date('28-12-2014', 'dd-mm-yyyy'), 410);
insert into MISSION (mdate, mid)
values (to_date('09-11-1993', 'dd-mm-yyyy'), 411);
insert into MISSION (mdate, mid)
values (to_date('19-07-2001', 'dd-mm-yyyy'), 412);
insert into MISSION (mdate, mid)
values (to_date('23-06-2019', 'dd-mm-yyyy'), 413);
insert into MISSION (mdate, mid)
values (to_date('30-11-2001', 'dd-mm-yyyy'), 414);
insert into MISSION (mdate, mid)
values (to_date('19-05-2009', 'dd-mm-yyyy'), 415);
insert into MISSION (mdate, mid)
values (to_date('13-01-2017', 'dd-mm-yyyy'), 416);
insert into MISSION (mdate, mid)
values (to_date('13-07-2002', 'dd-mm-yyyy'), 417);
insert into MISSION (mdate, mid)
values (to_date('30-08-2016', 'dd-mm-yyyy'), 418);
insert into MISSION (mdate, mid)
values (to_date('06-08-2004', 'dd-mm-yyyy'), 419);
insert into MISSION (mdate, mid)
values (to_date('19-03-2018', 'dd-mm-yyyy'), 420);
insert into MISSION (mdate, mid)
values (to_date('12-11-2012', 'dd-mm-yyyy'), 421);
insert into MISSION (mdate, mid)
values (to_date('08-07-1995', 'dd-mm-yyyy'), 422);
insert into MISSION (mdate, mid)
values (to_date('02-01-2011', 'dd-mm-yyyy'), 423);
insert into MISSION (mdate, mid)
values (to_date('09-11-2000', 'dd-mm-yyyy'), 424);
insert into MISSION (mdate, mid)
values (to_date('16-03-1994', 'dd-mm-yyyy'), 425);
insert into MISSION (mdate, mid)
values (to_date('26-06-2016', 'dd-mm-yyyy'), 426);
insert into MISSION (mdate, mid)
values (to_date('16-08-1997', 'dd-mm-yyyy'), 427);
insert into MISSION (mdate, mid)
values (to_date('01-02-2008', 'dd-mm-yyyy'), 428);
insert into MISSION (mdate, mid)
values (to_date('20-11-2021', 'dd-mm-yyyy'), 429);
insert into MISSION (mdate, mid)
values (to_date('25-07-2018', 'dd-mm-yyyy'), 430);
insert into MISSION (mdate, mid)
values (to_date('03-12-2011', 'dd-mm-yyyy'), 431);
insert into MISSION (mdate, mid)
values (to_date('06-07-1991', 'dd-mm-yyyy'), 432);
insert into MISSION (mdate, mid)
values (to_date('08-07-2014', 'dd-mm-yyyy'), 433);
insert into MISSION (mdate, mid)
values (to_date('06-01-2015', 'dd-mm-yyyy'), 434);
insert into MISSION (mdate, mid)
values (to_date('15-04-2003', 'dd-mm-yyyy'), 435);
insert into MISSION (mdate, mid)
values (to_date('29-09-2022', 'dd-mm-yyyy'), 436);
insert into MISSION (mdate, mid)
values (to_date('20-06-2007', 'dd-mm-yyyy'), 437);
insert into MISSION (mdate, mid)
values (to_date('05-07-2022', 'dd-mm-yyyy'), 438);
insert into MISSION (mdate, mid)
values (to_date('26-06-1993', 'dd-mm-yyyy'), 439);
insert into MISSION (mdate, mid)
values (to_date('06-05-1996', 'dd-mm-yyyy'), 440);
insert into MISSION (mdate, mid)
values (to_date('05-04-1991', 'dd-mm-yyyy'), 441);
insert into MISSION (mdate, mid)
values (to_date('12-04-1990', 'dd-mm-yyyy'), 442);
commit;
prompt 2000 records committed...
insert into MISSION (mdate, mid)
values (to_date('11-05-2009', 'dd-mm-yyyy'), 443);
commit;
prompt 2001 records loaded
prompt Loading UNIT...
insert into UNIT (unid, uname, cid)
values (6, ' Ikvot HaBarzel', 356);
insert into UNIT (unid, uname, cid)
values (7, ' Bnei Or', 357);
insert into UNIT (unid, uname, cid)
values (8, ' Kiryati', 358);
insert into UNIT (unid, uname, cid)
values (9, ' Machatz', 359);
insert into UNIT (unid, uname, cid)
values (10, ' Ram', 360);
insert into UNIT (unid, uname, cid)
values (11, ' Iron Fist', 361);
insert into UNIT (unid, uname, cid)
values (12, ' Yiftach', 362);
insert into UNIT (unid, uname, cid)
values (13, ' Sinai', 363);
insert into UNIT (unid, uname, cid)
values (14, ' Harel', 364);
insert into UNIT (unid, uname, cid)
values (15, ' Kvir', 365);
insert into UNIT (unid, uname, cid)
values (16, ' Hazaken', 366);
insert into UNIT (unid, uname, cid)
values (17, ' Star of light', 367);
insert into UNIT (unid, uname, cid)
values (18, ' Yishai', 368);
insert into UNIT (unid, uname, cid)
values (19, ' Chariots of fire', 369);
insert into UNIT (unid, uname, cid)
values (20, ' Galloping Horse', 370);
insert into UNIT (unid, uname, cid)
values (21, ' Yerushalaim', 371);
insert into UNIT (unid, uname, cid)
values (22, ' Rays of fire', 372);
insert into UNIT (unid, uname, cid)
values (23, ' Oranim', 373);
insert into UNIT (unid, uname, cid)
values (24, ' Kela', 374);
insert into UNIT (unid, uname, cid)
values (25, ' Arrow', 375);
insert into UNIT (unid, uname, cid)
values (26, ' Bnei Reshef', 376);
insert into UNIT (unid, uname, cid)
values (27, ' Eshet', 377);
insert into UNIT (unid, uname, cid)
values (28, ' Lavi', 378);
insert into UNIT (unid, uname, cid)
values (29, ' Adirim', 379);
insert into UNIT (unid, uname, cid)
values (30, ' Shachar', 380);
insert into UNIT (unid, uname, cid)
values (31, ' Stars of fire', 381);
insert into UNIT (unid, uname, cid)
values (32, ' Netivei Esh', 382);
insert into UNIT (unid, uname, cid)
values (33, ' Etzion Gever', 383);
insert into UNIT (unid, uname, cid)
values (34, ' Hatzlicha', 384);
insert into UNIT (unid, uname, cid)
values (35, ' Tzavim', 385);
insert into UNIT (unid, uname, cid)
values (36, ' Bazka', 386);
insert into UNIT (unid, uname, cid)
values (37, ' Fist and spear', 387);
insert into UNIT (unid, uname, cid)
values (38, ' Mapatz', 388);
insert into UNIT (unid, uname, cid)
values (39, ' Hamud HaEsh', 389);
insert into UNIT (unid, uname, cid)
values (40, ' Lahavot HaEsh', 390);
insert into UNIT (unid, uname, cid)
values (41, ' Etgar', 391);
insert into UNIT (unid, uname, cid)
values (42, ' Gaash', 392);
insert into UNIT (unid, uname, cid)
values (43, ' Saar me-Golan 2th', 393);
insert into UNIT (unid, uname, cid)
values (44, ' Barak 2th', 394);
insert into UNIT (unid, uname, cid)
values (45, ' Iron tails 2th', 395);
insert into UNIT (unid, uname, cid)
values (46, ' Sons of light 2th', 396);
insert into UNIT (unid, uname, cid)
values (47, ' Utzvat HaPlada 2th', 397);
insert into UNIT (unid, uname, cid)
values (48, ' Ikvot HaBarzel 2th', 398);
insert into UNIT (unid, uname, cid)
values (49, ' Bnei Or 2th', 399);
insert into UNIT (unid, uname, cid)
values (50, ' Kiryati 2th', 400);
insert into UNIT (unid, uname, cid)
values (51, ' Machatz 2th', 401);
insert into UNIT (unid, uname, cid)
values (52, ' Ram 2th', 402);
insert into UNIT (unid, uname, cid)
values (53, ' Iron Fist 2th', 403);
insert into UNIT (unid, uname, cid)
values (54, ' Yiftach 2th', 404);
insert into UNIT (unid, uname, cid)
values (55, ' Sinai 2th', 405);
insert into UNIT (unid, uname, cid)
values (56, ' Harel 2th', 406);
insert into UNIT (unid, uname, cid)
values (57, ' Kvir 2th', 407);
insert into UNIT (unid, uname, cid)
values (58, ' Hazaken 2th', 408);
insert into UNIT (unid, uname, cid)
values (59, ' Star of light 2th', 409);
insert into UNIT (unid, uname, cid)
values (60, ' Yishai 2th', 410);
insert into UNIT (unid, uname, cid)
values (61, ' Fire''s Chariots  2', 411);
insert into UNIT (unid, uname, cid)
values (62, ' Galloping Horse 2', 412);
insert into UNIT (unid, uname, cid)
values (63, ' Yerushalaim 2', 413);
insert into UNIT (unid, uname, cid)
values (64, ' Rays of fire 2', 414);
insert into UNIT (unid, uname, cid)
values (65, ' Oranim 2', 415);
insert into UNIT (unid, uname, cid)
values (66, ' Kela 2', 416);
insert into UNIT (unid, uname, cid)
values (67, ' Arrow 2', 417);
insert into UNIT (unid, uname, cid)
values (68, ' Bnei Reshef 2', 418);
insert into UNIT (unid, uname, cid)
values (69, ' Eshet 2', 419);
insert into UNIT (unid, uname, cid)
values (70, ' Lavi 2', 420);
insert into UNIT (unid, uname, cid)
values (71, ' Adirim 2', 421);
insert into UNIT (unid, uname, cid)
values (72, ' Shachar 2', 422);
insert into UNIT (unid, uname, cid)
values (73, ' Stars of fire 2', 423);
insert into UNIT (unid, uname, cid)
values (74, ' Netivei Esh 2', 424);
insert into UNIT (unid, uname, cid)
values (75, ' Etzion Gever 2', 425);
insert into UNIT (unid, uname, cid)
values (76, ' Hatzlicha 2', 426);
insert into UNIT (unid, uname, cid)
values (77, ' Tzavim 2', 427);
insert into UNIT (unid, uname, cid)
values (78, ' Bazka 2', 428);
insert into UNIT (unid, uname, cid)
values (79, ' Fist and spear 2', 429);
insert into UNIT (unid, uname, cid)
values (80, ' Mapatz 2', 430);
insert into UNIT (unid, uname, cid)
values (81, ' Hamud HaEsh 2', 431);
insert into UNIT (unid, uname, cid)
values (82, ' Lahavot HaEsh 2', 432);
insert into UNIT (unid, uname, cid)
values (83, ' Etgar 2', 433);
insert into UNIT (unid, uname, cid)
values (84, ' Gaash 2', 434);
insert into UNIT (unid, uname, cid)
values (85, ' Saar me-Golan 3', 435);
insert into UNIT (unid, uname, cid)
values (86, ' Barak 3', 436);
insert into UNIT (unid, uname, cid)
values (87, ' Iron tails 3', 437);
insert into UNIT (unid, uname, cid)
values (88, ' Sons of light 3', 438);
insert into UNIT (unid, uname, cid)
values (89, ' Utzvat HaPlada 3', 439);
insert into UNIT (unid, uname, cid)
values (90, ' Ikvot HaBarzel 3', 440);
insert into UNIT (unid, uname, cid)
values (91, ' Bnei Or 3', 441);
insert into UNIT (unid, uname, cid)
values (92, ' Kiryati 3', 442);
insert into UNIT (unid, uname, cid)
values (93, ' Machatz 3', 443);
insert into UNIT (unid, uname, cid)
values (94, ' Ram 3', 444);
insert into UNIT (unid, uname, cid)
values (95, ' Iron Fist 3', 445);
insert into UNIT (unid, uname, cid)
values (96, ' Yiftach 3', 446);
insert into UNIT (unid, uname, cid)
values (97, ' Sinai 3', 447);
insert into UNIT (unid, uname, cid)
values (98, ' Harel 3', 448);
insert into UNIT (unid, uname, cid)
values (99, ' Kvir 3', 449);
insert into UNIT (unid, uname, cid)
values (100, ' Hazaken 3', 450);
insert into UNIT (unid, uname, cid)
values (101, ' Star of light 3', 451);
insert into UNIT (unid, uname, cid)
values (102, ' Yishai 3', 452);
insert into UNIT (unid, uname, cid)
values (103, ' Fire''s Chariots 3', 453);
insert into UNIT (unid, uname, cid)
values (104, ' Galloping Horse 3', 454);
insert into UNIT (unid, uname, cid)
values (105, ' Yerushalaim 3', 455);
commit;
prompt 100 records committed...
insert into UNIT (unid, uname, cid)
values (106, ' Rays of fire 3', 456);
insert into UNIT (unid, uname, cid)
values (107, ' Oranim 3', 457);
insert into UNIT (unid, uname, cid)
values (108, ' Kela 3', 458);
insert into UNIT (unid, uname, cid)
values (109, ' Arrow 3', 459);
insert into UNIT (unid, uname, cid)
values (110, ' Bnei Reshef 3', 460);
insert into UNIT (unid, uname, cid)
values (111, ' Eshet 3', 461);
insert into UNIT (unid, uname, cid)
values (112, ' Lavi 3', 462);
insert into UNIT (unid, uname, cid)
values (113, ' Adirim 3', 463);
insert into UNIT (unid, uname, cid)
values (114, ' Shachar 3', 464);
insert into UNIT (unid, uname, cid)
values (115, ' Stars of fire 3', 465);
insert into UNIT (unid, uname, cid)
values (116, ' Netivei Esh 3', 466);
insert into UNIT (unid, uname, cid)
values (117, ' Etzion Gever 3', 467);
insert into UNIT (unid, uname, cid)
values (118, ' Hatzlicha 3', 468);
insert into UNIT (unid, uname, cid)
values (119, ' Tzavim 3', 469);
insert into UNIT (unid, uname, cid)
values (120, ' Bazka 3', 470);
insert into UNIT (unid, uname, cid)
values (121, ' Fist and spear 3', 471);
insert into UNIT (unid, uname, cid)
values (122, ' Mapatz 3', 472);
insert into UNIT (unid, uname, cid)
values (123, ' Hamud HaEsh 3', 473);
insert into UNIT (unid, uname, cid)
values (124, ' Lahavot HaEsh 3', 474);
insert into UNIT (unid, uname, cid)
values (125, ' Etgar 3', 475);
insert into UNIT (unid, uname, cid)
values (126, ' Gaash 3', 476);
insert into UNIT (unid, uname, cid)
values (127, ' Saar me-Golan 4', 477);
insert into UNIT (unid, uname, cid)
values (128, ' Barak 4', 478);
insert into UNIT (unid, uname, cid)
values (129, ' Iron tails 4', 479);
insert into UNIT (unid, uname, cid)
values (130, ' Sons of light 4', 480);
insert into UNIT (unid, uname, cid)
values (131, ' Utzvat HaPlada 4', 481);
insert into UNIT (unid, uname, cid)
values (132, ' Ikvot HaBarzel 4', 482);
insert into UNIT (unid, uname, cid)
values (133, ' Bnei Or 4', 483);
insert into UNIT (unid, uname, cid)
values (134, ' Kiryati 4', 484);
insert into UNIT (unid, uname, cid)
values (135, ' Machatz 4', 485);
insert into UNIT (unid, uname, cid)
values (136, ' Ram 4', 486);
insert into UNIT (unid, uname, cid)
values (137, ' Iron Fist 4', 487);
insert into UNIT (unid, uname, cid)
values (138, ' Yiftach 4', 488);
insert into UNIT (unid, uname, cid)
values (139, ' Sinai 4', 489);
insert into UNIT (unid, uname, cid)
values (140, ' Harel 4', 490);
insert into UNIT (unid, uname, cid)
values (141, ' Kvir 4', 491);
insert into UNIT (unid, uname, cid)
values (142, ' Hazaken 4', 492);
insert into UNIT (unid, uname, cid)
values (143, ' Star of light 4', 493);
insert into UNIT (unid, uname, cid)
values (144, ' Yishai 4', 494);
insert into UNIT (unid, uname, cid)
values (145, ' Fire''s Chariots  4', 495);
insert into UNIT (unid, uname, cid)
values (146, ' Galloping Horse 4', 496);
insert into UNIT (unid, uname, cid)
values (147, ' Yerushalaim 4', 497);
insert into UNIT (unid, uname, cid)
values (148, ' Rays of fire 4', 498);
insert into UNIT (unid, uname, cid)
values (149, ' Oranim 4', 499);
insert into UNIT (unid, uname, cid)
values (150, ' Kela 4', 500);
insert into UNIT (unid, uname, cid)
values (151, ' Arrow 4', 501);
insert into UNIT (unid, uname, cid)
values (152, ' Bnei Reshef 4', 502);
insert into UNIT (unid, uname, cid)
values (153, ' Eshet 4', 503);
insert into UNIT (unid, uname, cid)
values (154, ' Lavi 4', 504);
insert into UNIT (unid, uname, cid)
values (155, ' Adirim 4', 505);
insert into UNIT (unid, uname, cid)
values (156, ' Shachar 4', 506);
insert into UNIT (unid, uname, cid)
values (157, ' Stars of fire 4', 507);
insert into UNIT (unid, uname, cid)
values (158, ' Netivei Esh 4', 508);
insert into UNIT (unid, uname, cid)
values (159, ' Etzion Gever 4', 509);
insert into UNIT (unid, uname, cid)
values (160, ' Hatzlicha 4', 510);
insert into UNIT (unid, uname, cid)
values (161, ' Tzavim 4', 511);
insert into UNIT (unid, uname, cid)
values (162, ' Bazka 4', 512);
insert into UNIT (unid, uname, cid)
values (163, ' Fist and spear 4', 513);
insert into UNIT (unid, uname, cid)
values (164, ' Mapatz 4', 514);
insert into UNIT (unid, uname, cid)
values (165, ' Hamud HaEsh 4', 515);
insert into UNIT (unid, uname, cid)
values (166, ' Lahavot HaEsh 4', 516);
insert into UNIT (unid, uname, cid)
values (167, ' Etgar 4', 517);
insert into UNIT (unid, uname, cid)
values (168, ' Gaash 4', 518);
insert into UNIT (unid, uname, cid)
values (169, ' Saar me-Golan 5', 519);
insert into UNIT (unid, uname, cid)
values (170, ' Barak 5', 520);
insert into UNIT (unid, uname, cid)
values (171, ' Iron tails 5', 521);
insert into UNIT (unid, uname, cid)
values (172, ' Sons of light 5', 522);
insert into UNIT (unid, uname, cid)
values (173, ' Utzvat HaPlada 5', 523);
insert into UNIT (unid, uname, cid)
values (174, ' Ikvot HaBarzel 5', 524);
insert into UNIT (unid, uname, cid)
values (175, ' Bnei Or 5', 525);
insert into UNIT (unid, uname, cid)
values (176, ' Kiryati 5', 526);
insert into UNIT (unid, uname, cid)
values (177, ' Machatz 5', 527);
insert into UNIT (unid, uname, cid)
values (178, ' Ram 5', 528);
insert into UNIT (unid, uname, cid)
values (179, ' Iron Fist 5', 529);
insert into UNIT (unid, uname, cid)
values (180, ' Yiftach 5', 530);
insert into UNIT (unid, uname, cid)
values (181, ' Sinai 5', 531);
insert into UNIT (unid, uname, cid)
values (182, ' Harel 5', 532);
insert into UNIT (unid, uname, cid)
values (183, ' Kvir 5', 533);
insert into UNIT (unid, uname, cid)
values (184, ' Hazaken 5', 534);
insert into UNIT (unid, uname, cid)
values (185, ' Star of light 5', 535);
insert into UNIT (unid, uname, cid)
values (186, ' Yishai 5', 536);
insert into UNIT (unid, uname, cid)
values (187, ' Fire''s Chariots  5', 537);
insert into UNIT (unid, uname, cid)
values (188, ' Galloping Horse 5', 538);
insert into UNIT (unid, uname, cid)
values (189, ' Yerushalaim 5', 539);
insert into UNIT (unid, uname, cid)
values (190, ' Rays of fire 5', 540);
insert into UNIT (unid, uname, cid)
values (191, ' Oranim 5', 541);
insert into UNIT (unid, uname, cid)
values (192, ' Kela 5', 542);
insert into UNIT (unid, uname, cid)
values (193, ' Arrow 5', 543);
insert into UNIT (unid, uname, cid)
values (194, ' Bnei Reshef 5', 544);
insert into UNIT (unid, uname, cid)
values (195, ' Eshet 5', 545);
insert into UNIT (unid, uname, cid)
values (196, ' Lavi 5', 546);
insert into UNIT (unid, uname, cid)
values (197, ' Adirim 5', 547);
insert into UNIT (unid, uname, cid)
values (198, ' Shachar 5', 548);
insert into UNIT (unid, uname, cid)
values (199, ' Stars of fire 5', 549);
insert into UNIT (unid, uname, cid)
values (200, ' Netivei Esh 5', 550);
insert into UNIT (unid, uname, cid)
values (201, ' Etzion Gever 5', 551);
insert into UNIT (unid, uname, cid)
values (202, ' Hatzlicha 5', 552);
insert into UNIT (unid, uname, cid)
values (203, ' Tzavim 5', 553);
insert into UNIT (unid, uname, cid)
values (204, ' Bazka 5', 554);
insert into UNIT (unid, uname, cid)
values (205, ' Fist and spear 5', 555);
commit;
prompt 200 records committed...
insert into UNIT (unid, uname, cid)
values (206, ' Mapatz 5', 556);
insert into UNIT (unid, uname, cid)
values (207, ' Hamud HaEsh 5', 557);
insert into UNIT (unid, uname, cid)
values (208, ' Lahavot HaEsh 5', 558);
insert into UNIT (unid, uname, cid)
values (209, ' Etgar 5', 559);
insert into UNIT (unid, uname, cid)
values (210, ' Gaash 5', 560);
insert into UNIT (unid, uname, cid)
values (211, ' Saar me-Golan 6', 561);
insert into UNIT (unid, uname, cid)
values (212, ' Barak 6', 562);
insert into UNIT (unid, uname, cid)
values (213, ' Iron tails 6', 563);
insert into UNIT (unid, uname, cid)
values (214, ' Sons of light 6', 564);
insert into UNIT (unid, uname, cid)
values (215, ' Utzvat HaPlada 6', 565);
insert into UNIT (unid, uname, cid)
values (216, ' Ikvot HaBarzel 6', 566);
insert into UNIT (unid, uname, cid)
values (217, ' Bnei Or 6', 567);
insert into UNIT (unid, uname, cid)
values (218, ' Kiryati 6', 568);
insert into UNIT (unid, uname, cid)
values (219, ' Machatz 6', 569);
insert into UNIT (unid, uname, cid)
values (220, ' Ram 6', 570);
insert into UNIT (unid, uname, cid)
values (221, ' Iron Fist 6', 571);
insert into UNIT (unid, uname, cid)
values (222, ' Yiftach 6', 572);
insert into UNIT (unid, uname, cid)
values (223, ' Sinai 6', 573);
insert into UNIT (unid, uname, cid)
values (224, ' Harel 6', 574);
insert into UNIT (unid, uname, cid)
values (225, ' Kvir 6', 575);
insert into UNIT (unid, uname, cid)
values (226, ' Hazaken 6', 576);
insert into UNIT (unid, uname, cid)
values (227, ' Star of light 6', 577);
insert into UNIT (unid, uname, cid)
values (228, ' Yishai 6', 578);
insert into UNIT (unid, uname, cid)
values (229, ' Fire''s Chariots  6', 579);
insert into UNIT (unid, uname, cid)
values (230, ' Galloping Horse 6', 580);
insert into UNIT (unid, uname, cid)
values (231, ' Yerushalaim 6', 581);
insert into UNIT (unid, uname, cid)
values (232, ' Rays of fire 6', 582);
insert into UNIT (unid, uname, cid)
values (233, ' Oranim 6', 583);
insert into UNIT (unid, uname, cid)
values (234, ' Kela 6', 584);
insert into UNIT (unid, uname, cid)
values (235, ' Arrow 6', 585);
insert into UNIT (unid, uname, cid)
values (236, ' Bnei Reshef 6', 586);
insert into UNIT (unid, uname, cid)
values (237, ' Eshet 6', 587);
insert into UNIT (unid, uname, cid)
values (238, ' Lavi 6', 588);
insert into UNIT (unid, uname, cid)
values (239, ' Adirim 6', 589);
insert into UNIT (unid, uname, cid)
values (240, ' Shachar 6', 590);
insert into UNIT (unid, uname, cid)
values (241, ' Stars of fire 6', 591);
insert into UNIT (unid, uname, cid)
values (242, ' Netivei Esh 6', 592);
insert into UNIT (unid, uname, cid)
values (243, ' Etzion Gever 6', 593);
insert into UNIT (unid, uname, cid)
values (244, ' Hatzlicha 6', 594);
insert into UNIT (unid, uname, cid)
values (245, ' Tzavim 6', 595);
insert into UNIT (unid, uname, cid)
values (246, ' Bazka 6', 596);
insert into UNIT (unid, uname, cid)
values (247, ' Fist and spear 6', 597);
insert into UNIT (unid, uname, cid)
values (248, ' Mapatz 6', 598);
insert into UNIT (unid, uname, cid)
values (249, ' Hamud HaEsh 6', 599);
insert into UNIT (unid, uname, cid)
values (250, ' Lahavot HaEsh 6', 600);
insert into UNIT (unid, uname, cid)
values (1, ' Saar me-Golan', 351);
insert into UNIT (unid, uname, cid)
values (2, ' Barak', 352);
insert into UNIT (unid, uname, cid)
values (3, ' Iron tails', 353);
insert into UNIT (unid, uname, cid)
values (4, ' Sons of light', 354);
insert into UNIT (unid, uname, cid)
values (5, ' Utzvat HaPlada', 355);
commit;
prompt 250 records loaded
prompt Loading PARTICIPATES...
insert into PARTICIPATES (mid, unid)
values (1, 60);
insert into PARTICIPATES (mid, unid)
values (1, 202);
insert into PARTICIPATES (mid, unid)
values (2, 81);
insert into PARTICIPATES (mid, unid)
values (2, 107);
insert into PARTICIPATES (mid, unid)
values (3, 128);
insert into PARTICIPATES (mid, unid)
values (3, 224);
insert into PARTICIPATES (mid, unid)
values (4, 117);
insert into PARTICIPATES (mid, unid)
values (4, 202);
insert into PARTICIPATES (mid, unid)
values (4, 220);
insert into PARTICIPATES (mid, unid)
values (5, 54);
insert into PARTICIPATES (mid, unid)
values (6, 33);
insert into PARTICIPATES (mid, unid)
values (6, 45);
insert into PARTICIPATES (mid, unid)
values (6, 187);
insert into PARTICIPATES (mid, unid)
values (7, 109);
insert into PARTICIPATES (mid, unid)
values (7, 173);
insert into PARTICIPATES (mid, unid)
values (8, 62);
insert into PARTICIPATES (mid, unid)
values (9, 51);
insert into PARTICIPATES (mid, unid)
values (10, 48);
insert into PARTICIPATES (mid, unid)
values (10, 134);
insert into PARTICIPATES (mid, unid)
values (11, 9);
insert into PARTICIPATES (mid, unid)
values (11, 148);
insert into PARTICIPATES (mid, unid)
values (12, 118);
insert into PARTICIPATES (mid, unid)
values (13, 99);
insert into PARTICIPATES (mid, unid)
values (13, 134);
insert into PARTICIPATES (mid, unid)
values (14, 125);
insert into PARTICIPATES (mid, unid)
values (15, 167);
insert into PARTICIPATES (mid, unid)
values (15, 198);
insert into PARTICIPATES (mid, unid)
values (16, 30);
insert into PARTICIPATES (mid, unid)
values (16, 97);
insert into PARTICIPATES (mid, unid)
values (17, 20);
insert into PARTICIPATES (mid, unid)
values (17, 32);
insert into PARTICIPATES (mid, unid)
values (17, 44);
insert into PARTICIPATES (mid, unid)
values (17, 174);
insert into PARTICIPATES (mid, unid)
values (18, 229);
insert into PARTICIPATES (mid, unid)
values (19, 186);
insert into PARTICIPATES (mid, unid)
values (19, 192);
insert into PARTICIPATES (mid, unid)
values (20, 8);
insert into PARTICIPATES (mid, unid)
values (20, 250);
insert into PARTICIPATES (mid, unid)
values (21, 241);
insert into PARTICIPATES (mid, unid)
values (21, 245);
insert into PARTICIPATES (mid, unid)
values (22, 71);
insert into PARTICIPATES (mid, unid)
values (22, 87);
insert into PARTICIPATES (mid, unid)
values (23, 39);
insert into PARTICIPATES (mid, unid)
values (24, 56);
insert into PARTICIPATES (mid, unid)
values (25, 26);
insert into PARTICIPATES (mid, unid)
values (25, 197);
insert into PARTICIPATES (mid, unid)
values (26, 14);
insert into PARTICIPATES (mid, unid)
values (27, 82);
insert into PARTICIPATES (mid, unid)
values (27, 107);
insert into PARTICIPATES (mid, unid)
values (27, 149);
insert into PARTICIPATES (mid, unid)
values (27, 206);
insert into PARTICIPATES (mid, unid)
values (28, 76);
insert into PARTICIPATES (mid, unid)
values (29, 79);
insert into PARTICIPATES (mid, unid)
values (29, 163);
insert into PARTICIPATES (mid, unid)
values (29, 178);
insert into PARTICIPATES (mid, unid)
values (30, 225);
insert into PARTICIPATES (mid, unid)
values (31, 12);
insert into PARTICIPATES (mid, unid)
values (31, 91);
insert into PARTICIPATES (mid, unid)
values (31, 112);
insert into PARTICIPATES (mid, unid)
values (31, 154);
insert into PARTICIPATES (mid, unid)
values (32, 115);
insert into PARTICIPATES (mid, unid)
values (32, 125);
insert into PARTICIPATES (mid, unid)
values (32, 172);
insert into PARTICIPATES (mid, unid)
values (32, 233);
insert into PARTICIPATES (mid, unid)
values (33, 91);
insert into PARTICIPATES (mid, unid)
values (34, 131);
insert into PARTICIPATES (mid, unid)
values (35, 96);
insert into PARTICIPATES (mid, unid)
values (36, 112);
insert into PARTICIPATES (mid, unid)
values (36, 157);
insert into PARTICIPATES (mid, unid)
values (37, 243);
insert into PARTICIPATES (mid, unid)
values (38, 110);
insert into PARTICIPATES (mid, unid)
values (38, 125);
insert into PARTICIPATES (mid, unid)
values (38, 140);
insert into PARTICIPATES (mid, unid)
values (39, 38);
insert into PARTICIPATES (mid, unid)
values (39, 200);
insert into PARTICIPATES (mid, unid)
values (40, 234);
insert into PARTICIPATES (mid, unid)
values (41, 49);
insert into PARTICIPATES (mid, unid)
values (41, 135);
insert into PARTICIPATES (mid, unid)
values (42, 25);
insert into PARTICIPATES (mid, unid)
values (42, 77);
insert into PARTICIPATES (mid, unid)
values (43, 63);
insert into PARTICIPATES (mid, unid)
values (43, 92);
insert into PARTICIPATES (mid, unid)
values (43, 227);
insert into PARTICIPATES (mid, unid)
values (43, 250);
insert into PARTICIPATES (mid, unid)
values (44, 76);
insert into PARTICIPATES (mid, unid)
values (44, 158);
insert into PARTICIPATES (mid, unid)
values (45, 130);
insert into PARTICIPATES (mid, unid)
values (46, 44);
insert into PARTICIPATES (mid, unid)
values (46, 208);
insert into PARTICIPATES (mid, unid)
values (47, 85);
insert into PARTICIPATES (mid, unid)
values (47, 221);
insert into PARTICIPATES (mid, unid)
values (48, 84);
insert into PARTICIPATES (mid, unid)
values (49, 82);
insert into PARTICIPATES (mid, unid)
values (49, 180);
insert into PARTICIPATES (mid, unid)
values (50, 108);
insert into PARTICIPATES (mid, unid)
values (50, 246);
insert into PARTICIPATES (mid, unid)
values (51, 132);
insert into PARTICIPATES (mid, unid)
values (51, 208);
insert into PARTICIPATES (mid, unid)
values (52, 60);
insert into PARTICIPATES (mid, unid)
values (53, 49);
commit;
prompt 100 records committed...
insert into PARTICIPATES (mid, unid)
values (53, 108);
insert into PARTICIPATES (mid, unid)
values (54, 176);
insert into PARTICIPATES (mid, unid)
values (55, 42);
insert into PARTICIPATES (mid, unid)
values (55, 102);
insert into PARTICIPATES (mid, unid)
values (55, 221);
insert into PARTICIPATES (mid, unid)
values (56, 71);
insert into PARTICIPATES (mid, unid)
values (56, 153);
insert into PARTICIPATES (mid, unid)
values (56, 162);
insert into PARTICIPATES (mid, unid)
values (56, 238);
insert into PARTICIPATES (mid, unid)
values (57, 72);
insert into PARTICIPATES (mid, unid)
values (57, 133);
insert into PARTICIPATES (mid, unid)
values (58, 41);
insert into PARTICIPATES (mid, unid)
values (58, 75);
insert into PARTICIPATES (mid, unid)
values (59, 44);
insert into PARTICIPATES (mid, unid)
values (60, 112);
insert into PARTICIPATES (mid, unid)
values (61, 106);
insert into PARTICIPATES (mid, unid)
values (62, 11);
insert into PARTICIPATES (mid, unid)
values (62, 35);
insert into PARTICIPATES (mid, unid)
values (62, 49);
insert into PARTICIPATES (mid, unid)
values (62, 155);
insert into PARTICIPATES (mid, unid)
values (62, 230);
insert into PARTICIPATES (mid, unid)
values (63, 35);
insert into PARTICIPATES (mid, unid)
values (64, 11);
insert into PARTICIPATES (mid, unid)
values (65, 130);
insert into PARTICIPATES (mid, unid)
values (65, 135);
insert into PARTICIPATES (mid, unid)
values (66, 52);
insert into PARTICIPATES (mid, unid)
values (66, 111);
insert into PARTICIPATES (mid, unid)
values (461, 92);
insert into PARTICIPATES (mid, unid)
values (462, 227);
insert into PARTICIPATES (mid, unid)
values (463, 31);
insert into PARTICIPATES (mid, unid)
values (463, 156);
insert into PARTICIPATES (mid, unid)
values (463, 245);
insert into PARTICIPATES (mid, unid)
values (464, 118);
insert into PARTICIPATES (mid, unid)
values (464, 136);
insert into PARTICIPATES (mid, unid)
values (465, 44);
insert into PARTICIPATES (mid, unid)
values (465, 173);
insert into PARTICIPATES (mid, unid)
values (466, 1);
insert into PARTICIPATES (mid, unid)
values (466, 69);
insert into PARTICIPATES (mid, unid)
values (466, 98);
insert into PARTICIPATES (mid, unid)
values (466, 146);
insert into PARTICIPATES (mid, unid)
values (467, 67);
insert into PARTICIPATES (mid, unid)
values (467, 90);
insert into PARTICIPATES (mid, unid)
values (468, 4);
insert into PARTICIPATES (mid, unid)
values (468, 89);
insert into PARTICIPATES (mid, unid)
values (469, 242);
insert into PARTICIPATES (mid, unid)
values (470, 43);
insert into PARTICIPATES (mid, unid)
values (470, 74);
insert into PARTICIPATES (mid, unid)
values (471, 168);
insert into PARTICIPATES (mid, unid)
values (472, 46);
insert into PARTICIPATES (mid, unid)
values (473, 93);
insert into PARTICIPATES (mid, unid)
values (474, 158);
insert into PARTICIPATES (mid, unid)
values (475, 204);
insert into PARTICIPATES (mid, unid)
values (476, 16);
insert into PARTICIPATES (mid, unid)
values (477, 103);
insert into PARTICIPATES (mid, unid)
values (478, 147);
insert into PARTICIPATES (mid, unid)
values (478, 217);
insert into PARTICIPATES (mid, unid)
values (479, 51);
insert into PARTICIPATES (mid, unid)
values (479, 237);
insert into PARTICIPATES (mid, unid)
values (480, 30);
insert into PARTICIPATES (mid, unid)
values (480, 243);
insert into PARTICIPATES (mid, unid)
values (481, 23);
insert into PARTICIPATES (mid, unid)
values (482, 180);
insert into PARTICIPATES (mid, unid)
values (483, 39);
insert into PARTICIPATES (mid, unid)
values (483, 62);
insert into PARTICIPATES (mid, unid)
values (484, 58);
insert into PARTICIPATES (mid, unid)
values (485, 54);
insert into PARTICIPATES (mid, unid)
values (485, 146);
insert into PARTICIPATES (mid, unid)
values (486, 157);
insert into PARTICIPATES (mid, unid)
values (487, 204);
insert into PARTICIPATES (mid, unid)
values (488, 218);
insert into PARTICIPATES (mid, unid)
values (489, 230);
insert into PARTICIPATES (mid, unid)
values (490, 141);
insert into PARTICIPATES (mid, unid)
values (491, 135);
insert into PARTICIPATES (mid, unid)
values (492, 129);
insert into PARTICIPATES (mid, unid)
values (493, 70);
insert into PARTICIPATES (mid, unid)
values (493, 120);
insert into PARTICIPATES (mid, unid)
values (494, 31);
insert into PARTICIPATES (mid, unid)
values (495, 135);
insert into PARTICIPATES (mid, unid)
values (496, 58);
insert into PARTICIPATES (mid, unid)
values (496, 177);
insert into PARTICIPATES (mid, unid)
values (496, 184);
insert into PARTICIPATES (mid, unid)
values (497, 88);
insert into PARTICIPATES (mid, unid)
values (498, 62);
insert into PARTICIPATES (mid, unid)
values (498, 171);
insert into PARTICIPATES (mid, unid)
values (499, 156);
insert into PARTICIPATES (mid, unid)
values (500, 64);
insert into PARTICIPATES (mid, unid)
values (500, 76);
insert into PARTICIPATES (mid, unid)
values (501, 33);
insert into PARTICIPATES (mid, unid)
values (501, 41);
insert into PARTICIPATES (mid, unid)
values (501, 54);
insert into PARTICIPATES (mid, unid)
values (501, 220);
insert into PARTICIPATES (mid, unid)
values (502, 12);
insert into PARTICIPATES (mid, unid)
values (502, 208);
insert into PARTICIPATES (mid, unid)
values (503, 51);
insert into PARTICIPATES (mid, unid)
values (504, 245);
insert into PARTICIPATES (mid, unid)
values (505, 217);
insert into PARTICIPATES (mid, unid)
values (505, 232);
insert into PARTICIPATES (mid, unid)
values (506, 36);
insert into PARTICIPATES (mid, unid)
values (506, 198);
insert into PARTICIPATES (mid, unid)
values (507, 8);
commit;
prompt 200 records committed...
insert into PARTICIPATES (mid, unid)
values (508, 185);
insert into PARTICIPATES (mid, unid)
values (509, 86);
insert into PARTICIPATES (mid, unid)
values (509, 90);
insert into PARTICIPATES (mid, unid)
values (509, 175);
insert into PARTICIPATES (mid, unid)
values (510, 141);
insert into PARTICIPATES (mid, unid)
values (511, 20);
insert into PARTICIPATES (mid, unid)
values (511, 125);
insert into PARTICIPATES (mid, unid)
values (511, 177);
insert into PARTICIPATES (mid, unid)
values (512, 107);
insert into PARTICIPATES (mid, unid)
values (512, 134);
insert into PARTICIPATES (mid, unid)
values (512, 165);
insert into PARTICIPATES (mid, unid)
values (513, 209);
insert into PARTICIPATES (mid, unid)
values (513, 244);
insert into PARTICIPATES (mid, unid)
values (514, 95);
insert into PARTICIPATES (mid, unid)
values (515, 200);
insert into PARTICIPATES (mid, unid)
values (516, 84);
insert into PARTICIPATES (mid, unid)
values (516, 191);
insert into PARTICIPATES (mid, unid)
values (517, 129);
insert into PARTICIPATES (mid, unid)
values (518, 142);
insert into PARTICIPATES (mid, unid)
values (519, 65);
insert into PARTICIPATES (mid, unid)
values (519, 158);
insert into PARTICIPATES (mid, unid)
values (520, 43);
insert into PARTICIPATES (mid, unid)
values (520, 106);
insert into PARTICIPATES (mid, unid)
values (521, 184);
insert into PARTICIPATES (mid, unid)
values (522, 226);
insert into PARTICIPATES (mid, unid)
values (523, 8);
insert into PARTICIPATES (mid, unid)
values (523, 25);
insert into PARTICIPATES (mid, unid)
values (523, 128);
insert into PARTICIPATES (mid, unid)
values (523, 136);
insert into PARTICIPATES (mid, unid)
values (523, 145);
insert into PARTICIPATES (mid, unid)
values (524, 60);
insert into PARTICIPATES (mid, unid)
values (525, 162);
insert into PARTICIPATES (mid, unid)
values (525, 185);
insert into PARTICIPATES (mid, unid)
values (526, 95);
insert into PARTICIPATES (mid, unid)
values (526, 176);
insert into PARTICIPATES (mid, unid)
values (526, 187);
insert into PARTICIPATES (mid, unid)
values (527, 218);
insert into PARTICIPATES (mid, unid)
values (528, 232);
insert into PARTICIPATES (mid, unid)
values (529, 37);
insert into PARTICIPATES (mid, unid)
values (529, 163);
insert into PARTICIPATES (mid, unid)
values (530, 21);
insert into PARTICIPATES (mid, unid)
values (530, 157);
insert into PARTICIPATES (mid, unid)
values (531, 22);
insert into PARTICIPATES (mid, unid)
values (531, 172);
insert into PARTICIPATES (mid, unid)
values (532, 37);
insert into PARTICIPATES (mid, unid)
values (533, 243);
insert into PARTICIPATES (mid, unid)
values (534, 54);
insert into PARTICIPATES (mid, unid)
values (535, 112);
insert into PARTICIPATES (mid, unid)
values (535, 135);
insert into PARTICIPATES (mid, unid)
values (536, 12);
insert into PARTICIPATES (mid, unid)
values (536, 81);
insert into PARTICIPATES (mid, unid)
values (537, 36);
insert into PARTICIPATES (mid, unid)
values (538, 38);
insert into PARTICIPATES (mid, unid)
values (538, 141);
insert into PARTICIPATES (mid, unid)
values (538, 170);
insert into PARTICIPATES (mid, unid)
values (538, 219);
insert into PARTICIPATES (mid, unid)
values (538, 244);
insert into PARTICIPATES (mid, unid)
values (539, 214);
insert into PARTICIPATES (mid, unid)
values (539, 236);
insert into PARTICIPATES (mid, unid)
values (540, 56);
insert into PARTICIPATES (mid, unid)
values (540, 209);
insert into PARTICIPATES (mid, unid)
values (541, 10);
insert into PARTICIPATES (mid, unid)
values (542, 184);
insert into PARTICIPATES (mid, unid)
values (543, 210);
insert into PARTICIPATES (mid, unid)
values (544, 63);
insert into PARTICIPATES (mid, unid)
values (544, 195);
insert into PARTICIPATES (mid, unid)
values (545, 63);
insert into PARTICIPATES (mid, unid)
values (545, 89);
insert into PARTICIPATES (mid, unid)
values (546, 139);
insert into PARTICIPATES (mid, unid)
values (547, 86);
insert into PARTICIPATES (mid, unid)
values (548, 11);
insert into PARTICIPATES (mid, unid)
values (548, 78);
insert into PARTICIPATES (mid, unid)
values (548, 98);
insert into PARTICIPATES (mid, unid)
values (548, 143);
insert into PARTICIPATES (mid, unid)
values (549, 49);
insert into PARTICIPATES (mid, unid)
values (549, 232);
insert into PARTICIPATES (mid, unid)
values (550, 114);
insert into PARTICIPATES (mid, unid)
values (551, 116);
insert into PARTICIPATES (mid, unid)
values (552, 241);
insert into PARTICIPATES (mid, unid)
values (553, 69);
insert into PARTICIPATES (mid, unid)
values (553, 125);
insert into PARTICIPATES (mid, unid)
values (553, 236);
insert into PARTICIPATES (mid, unid)
values (554, 5);
insert into PARTICIPATES (mid, unid)
values (554, 188);
insert into PARTICIPATES (mid, unid)
values (555, 133);
insert into PARTICIPATES (mid, unid)
values (556, 158);
insert into PARTICIPATES (mid, unid)
values (557, 241);
insert into PARTICIPATES (mid, unid)
values (558, 65);
insert into PARTICIPATES (mid, unid)
values (559, 228);
insert into PARTICIPATES (mid, unid)
values (560, 117);
insert into PARTICIPATES (mid, unid)
values (561, 157);
insert into PARTICIPATES (mid, unid)
values (561, 182);
insert into PARTICIPATES (mid, unid)
values (562, 154);
insert into PARTICIPATES (mid, unid)
values (562, 159);
insert into PARTICIPATES (mid, unid)
values (563, 19);
insert into PARTICIPATES (mid, unid)
values (563, 185);
insert into PARTICIPATES (mid, unid)
values (564, 83);
insert into PARTICIPATES (mid, unid)
values (565, 83);
insert into PARTICIPATES (mid, unid)
values (566, 160);
insert into PARTICIPATES (mid, unid)
values (567, 106);
commit;
prompt 300 records committed...
insert into PARTICIPATES (mid, unid)
values (568, 182);
insert into PARTICIPATES (mid, unid)
values (569, 139);
insert into PARTICIPATES (mid, unid)
values (569, 173);
insert into PARTICIPATES (mid, unid)
values (570, 44);
insert into PARTICIPATES (mid, unid)
values (570, 166);
insert into PARTICIPATES (mid, unid)
values (570, 172);
insert into PARTICIPATES (mid, unid)
values (571, 75);
insert into PARTICIPATES (mid, unid)
values (571, 148);
insert into PARTICIPATES (mid, unid)
values (572, 231);
insert into PARTICIPATES (mid, unid)
values (573, 60);
insert into PARTICIPATES (mid, unid)
values (574, 38);
insert into PARTICIPATES (mid, unid)
values (574, 64);
insert into PARTICIPATES (mid, unid)
values (574, 108);
insert into PARTICIPATES (mid, unid)
values (575, 28);
insert into PARTICIPATES (mid, unid)
values (575, 85);
insert into PARTICIPATES (mid, unid)
values (576, 245);
insert into PARTICIPATES (mid, unid)
values (577, 242);
insert into PARTICIPATES (mid, unid)
values (578, 61);
insert into PARTICIPATES (mid, unid)
values (579, 157);
insert into PARTICIPATES (mid, unid)
values (580, 115);
insert into PARTICIPATES (mid, unid)
values (581, 95);
insert into PARTICIPATES (mid, unid)
values (582, 109);
insert into PARTICIPATES (mid, unid)
values (582, 204);
insert into PARTICIPATES (mid, unid)
values (582, 225);
insert into PARTICIPATES (mid, unid)
values (583, 13);
insert into PARTICIPATES (mid, unid)
values (584, 7);
insert into PARTICIPATES (mid, unid)
values (584, 211);
insert into PARTICIPATES (mid, unid)
values (584, 244);
insert into PARTICIPATES (mid, unid)
values (585, 188);
insert into PARTICIPATES (mid, unid)
values (586, 235);
insert into PARTICIPATES (mid, unid)
values (588, 39);
insert into PARTICIPATES (mid, unid)
values (589, 77);
insert into PARTICIPATES (mid, unid)
values (590, 117);
insert into PARTICIPATES (mid, unid)
values (590, 155);
insert into PARTICIPATES (mid, unid)
values (590, 196);
insert into PARTICIPATES (mid, unid)
values (590, 221);
insert into PARTICIPATES (mid, unid)
values (591, 40);
insert into PARTICIPATES (mid, unid)
values (592, 173);
insert into PARTICIPATES (mid, unid)
values (593, 96);
insert into PARTICIPATES (mid, unid)
values (594, 210);
insert into PARTICIPATES (mid, unid)
values (595, 29);
insert into PARTICIPATES (mid, unid)
values (595, 89);
insert into PARTICIPATES (mid, unid)
values (595, 213);
insert into PARTICIPATES (mid, unid)
values (596, 16);
insert into PARTICIPATES (mid, unid)
values (596, 168);
insert into PARTICIPATES (mid, unid)
values (597, 42);
insert into PARTICIPATES (mid, unid)
values (597, 222);
insert into PARTICIPATES (mid, unid)
values (598, 71);
insert into PARTICIPATES (mid, unid)
values (599, 168);
insert into PARTICIPATES (mid, unid)
values (599, 217);
insert into PARTICIPATES (mid, unid)
values (600, 61);
insert into PARTICIPATES (mid, unid)
values (239, 27);
insert into PARTICIPATES (mid, unid)
values (239, 41);
insert into PARTICIPATES (mid, unid)
values (240, 96);
insert into PARTICIPATES (mid, unid)
values (240, 218);
insert into PARTICIPATES (mid, unid)
values (241, 116);
insert into PARTICIPATES (mid, unid)
values (242, 158);
insert into PARTICIPATES (mid, unid)
values (242, 166);
insert into PARTICIPATES (mid, unid)
values (243, 76);
insert into PARTICIPATES (mid, unid)
values (244, 81);
insert into PARTICIPATES (mid, unid)
values (245, 218);
insert into PARTICIPATES (mid, unid)
values (246, 141);
insert into PARTICIPATES (mid, unid)
values (246, 172);
insert into PARTICIPATES (mid, unid)
values (247, 8);
insert into PARTICIPATES (mid, unid)
values (247, 92);
insert into PARTICIPATES (mid, unid)
values (247, 216);
insert into PARTICIPATES (mid, unid)
values (247, 248);
insert into PARTICIPATES (mid, unid)
values (248, 37);
insert into PARTICIPATES (mid, unid)
values (249, 223);
insert into PARTICIPATES (mid, unid)
values (250, 85);
insert into PARTICIPATES (mid, unid)
values (251, 167);
insert into PARTICIPATES (mid, unid)
values (251, 235);
insert into PARTICIPATES (mid, unid)
values (252, 189);
insert into PARTICIPATES (mid, unid)
values (252, 243);
insert into PARTICIPATES (mid, unid)
values (253, 109);
insert into PARTICIPATES (mid, unid)
values (254, 49);
insert into PARTICIPATES (mid, unid)
values (255, 199);
insert into PARTICIPATES (mid, unid)
values (256, 103);
insert into PARTICIPATES (mid, unid)
values (256, 185);
insert into PARTICIPATES (mid, unid)
values (257, 173);
insert into PARTICIPATES (mid, unid)
values (257, 218);
insert into PARTICIPATES (mid, unid)
values (258, 60);
insert into PARTICIPATES (mid, unid)
values (259, 93);
insert into PARTICIPATES (mid, unid)
values (260, 126);
insert into PARTICIPATES (mid, unid)
values (261, 110);
insert into PARTICIPATES (mid, unid)
values (262, 69);
insert into PARTICIPATES (mid, unid)
values (262, 145);
insert into PARTICIPATES (mid, unid)
values (263, 135);
insert into PARTICIPATES (mid, unid)
values (263, 142);
insert into PARTICIPATES (mid, unid)
values (264, 105);
insert into PARTICIPATES (mid, unid)
values (264, 137);
insert into PARTICIPATES (mid, unid)
values (265, 129);
insert into PARTICIPATES (mid, unid)
values (265, 198);
insert into PARTICIPATES (mid, unid)
values (265, 221);
insert into PARTICIPATES (mid, unid)
values (266, 106);
insert into PARTICIPATES (mid, unid)
values (266, 153);
insert into PARTICIPATES (mid, unid)
values (267, 95);
insert into PARTICIPATES (mid, unid)
values (267, 138);
insert into PARTICIPATES (mid, unid)
values (268, 86);
insert into PARTICIPATES (mid, unid)
values (268, 204);
commit;
prompt 400 records committed...
insert into PARTICIPATES (mid, unid)
values (269, 21);
insert into PARTICIPATES (mid, unid)
values (270, 204);
insert into PARTICIPATES (mid, unid)
values (271, 48);
insert into PARTICIPATES (mid, unid)
values (271, 107);
insert into PARTICIPATES (mid, unid)
values (272, 247);
insert into PARTICIPATES (mid, unid)
values (273, 14);
insert into PARTICIPATES (mid, unid)
values (273, 22);
insert into PARTICIPATES (mid, unid)
values (274, 168);
insert into PARTICIPATES (mid, unid)
values (275, 47);
insert into PARTICIPATES (mid, unid)
values (275, 54);
insert into PARTICIPATES (mid, unid)
values (275, 104);
insert into PARTICIPATES (mid, unid)
values (275, 200);
insert into PARTICIPATES (mid, unid)
values (276, 26);
insert into PARTICIPATES (mid, unid)
values (276, 55);
insert into PARTICIPATES (mid, unid)
values (277, 129);
insert into PARTICIPATES (mid, unid)
values (277, 200);
insert into PARTICIPATES (mid, unid)
values (278, 206);
insert into PARTICIPATES (mid, unid)
values (279, 56);
insert into PARTICIPATES (mid, unid)
values (279, 74);
insert into PARTICIPATES (mid, unid)
values (280, 113);
insert into PARTICIPATES (mid, unid)
values (280, 120);
insert into PARTICIPATES (mid, unid)
values (280, 210);
insert into PARTICIPATES (mid, unid)
values (281, 31);
insert into PARTICIPATES (mid, unid)
values (282, 201);
insert into PARTICIPATES (mid, unid)
values (283, 11);
insert into PARTICIPATES (mid, unid)
values (284, 32);
insert into PARTICIPATES (mid, unid)
values (284, 53);
insert into PARTICIPATES (mid, unid)
values (285, 12);
insert into PARTICIPATES (mid, unid)
values (286, 127);
insert into PARTICIPATES (mid, unid)
values (287, 165);
insert into PARTICIPATES (mid, unid)
values (287, 193);
insert into PARTICIPATES (mid, unid)
values (287, 232);
insert into PARTICIPATES (mid, unid)
values (288, 204);
insert into PARTICIPATES (mid, unid)
values (289, 134);
insert into PARTICIPATES (mid, unid)
values (289, 151);
insert into PARTICIPATES (mid, unid)
values (290, 66);
insert into PARTICIPATES (mid, unid)
values (291, 48);
insert into PARTICIPATES (mid, unid)
values (291, 192);
insert into PARTICIPATES (mid, unid)
values (292, 176);
insert into PARTICIPATES (mid, unid)
values (293, 182);
insert into PARTICIPATES (mid, unid)
values (294, 9);
insert into PARTICIPATES (mid, unid)
values (295, 80);
insert into PARTICIPATES (mid, unid)
values (296, 128);
insert into PARTICIPATES (mid, unid)
values (296, 133);
insert into PARTICIPATES (mid, unid)
values (296, 149);
insert into PARTICIPATES (mid, unid)
values (297, 54);
insert into PARTICIPATES (mid, unid)
values (297, 200);
insert into PARTICIPATES (mid, unid)
values (298, 13);
insert into PARTICIPATES (mid, unid)
values (298, 122);
insert into PARTICIPATES (mid, unid)
values (298, 145);
insert into PARTICIPATES (mid, unid)
values (299, 152);
insert into PARTICIPATES (mid, unid)
values (300, 67);
insert into PARTICIPATES (mid, unid)
values (301, 51);
insert into PARTICIPATES (mid, unid)
values (302, 216);
insert into PARTICIPATES (mid, unid)
values (302, 240);
insert into PARTICIPATES (mid, unid)
values (303, 86);
insert into PARTICIPATES (mid, unid)
values (304, 55);
insert into PARTICIPATES (mid, unid)
values (304, 87);
insert into PARTICIPATES (mid, unid)
values (304, 232);
insert into PARTICIPATES (mid, unid)
values (305, 58);
insert into PARTICIPATES (mid, unid)
values (305, 211);
insert into PARTICIPATES (mid, unid)
values (306, 239);
insert into PARTICIPATES (mid, unid)
values (307, 28);
insert into PARTICIPATES (mid, unid)
values (307, 100);
insert into PARTICIPATES (mid, unid)
values (308, 29);
insert into PARTICIPATES (mid, unid)
values (308, 50);
insert into PARTICIPATES (mid, unid)
values (308, 140);
insert into PARTICIPATES (mid, unid)
values (309, 23);
insert into PARTICIPATES (mid, unid)
values (309, 68);
insert into PARTICIPATES (mid, unid)
values (309, 222);
insert into PARTICIPATES (mid, unid)
values (310, 156);
insert into PARTICIPATES (mid, unid)
values (311, 172);
insert into PARTICIPATES (mid, unid)
values (311, 192);
insert into PARTICIPATES (mid, unid)
values (312, 32);
insert into PARTICIPATES (mid, unid)
values (313, 220);
insert into PARTICIPATES (mid, unid)
values (313, 248);
insert into PARTICIPATES (mid, unid)
values (314, 150);
insert into PARTICIPATES (mid, unid)
values (315, 133);
insert into PARTICIPATES (mid, unid)
values (316, 129);
insert into PARTICIPATES (mid, unid)
values (316, 138);
insert into PARTICIPATES (mid, unid)
values (317, 41);
insert into PARTICIPATES (mid, unid)
values (317, 115);
insert into PARTICIPATES (mid, unid)
values (318, 144);
insert into PARTICIPATES (mid, unid)
values (319, 56);
insert into PARTICIPATES (mid, unid)
values (319, 149);
insert into PARTICIPATES (mid, unid)
values (320, 20);
insert into PARTICIPATES (mid, unid)
values (321, 18);
insert into PARTICIPATES (mid, unid)
values (321, 171);
insert into PARTICIPATES (mid, unid)
values (322, 197);
insert into PARTICIPATES (mid, unid)
values (323, 179);
insert into PARTICIPATES (mid, unid)
values (324, 83);
insert into PARTICIPATES (mid, unid)
values (325, 152);
insert into PARTICIPATES (mid, unid)
values (325, 166);
insert into PARTICIPATES (mid, unid)
values (326, 3);
insert into PARTICIPATES (mid, unid)
values (326, 154);
insert into PARTICIPATES (mid, unid)
values (327, 24);
insert into PARTICIPATES (mid, unid)
values (327, 43);
insert into PARTICIPATES (mid, unid)
values (327, 194);
insert into PARTICIPATES (mid, unid)
values (328, 120);
insert into PARTICIPATES (mid, unid)
values (329, 18);
commit;
prompt 500 records committed...
insert into PARTICIPATES (mid, unid)
values (330, 167);
insert into PARTICIPATES (mid, unid)
values (330, 220);
insert into PARTICIPATES (mid, unid)
values (331, 37);
insert into PARTICIPATES (mid, unid)
values (331, 178);
insert into PARTICIPATES (mid, unid)
values (332, 9);
insert into PARTICIPATES (mid, unid)
values (332, 160);
insert into PARTICIPATES (mid, unid)
values (333, 11);
insert into PARTICIPATES (mid, unid)
values (333, 106);
insert into PARTICIPATES (mid, unid)
values (333, 212);
insert into PARTICIPATES (mid, unid)
values (334, 130);
insert into PARTICIPATES (mid, unid)
values (334, 218);
insert into PARTICIPATES (mid, unid)
values (335, 107);
insert into PARTICIPATES (mid, unid)
values (336, 98);
insert into PARTICIPATES (mid, unid)
values (336, 198);
insert into PARTICIPATES (mid, unid)
values (337, 121);
insert into PARTICIPATES (mid, unid)
values (338, 81);
insert into PARTICIPATES (mid, unid)
values (338, 180);
insert into PARTICIPATES (mid, unid)
values (339, 11);
insert into PARTICIPATES (mid, unid)
values (340, 111);
insert into PARTICIPATES (mid, unid)
values (341, 70);
insert into PARTICIPATES (mid, unid)
values (342, 70);
insert into PARTICIPATES (mid, unid)
values (342, 155);
insert into PARTICIPATES (mid, unid)
values (342, 203);
insert into PARTICIPATES (mid, unid)
values (343, 152);
insert into PARTICIPATES (mid, unid)
values (343, 224);
insert into PARTICIPATES (mid, unid)
values (344, 3);
insert into PARTICIPATES (mid, unid)
values (344, 125);
insert into PARTICIPATES (mid, unid)
values (345, 152);
insert into PARTICIPATES (mid, unid)
values (345, 163);
insert into PARTICIPATES (mid, unid)
values (346, 54);
insert into PARTICIPATES (mid, unid)
values (346, 80);
insert into PARTICIPATES (mid, unid)
values (346, 247);
insert into PARTICIPATES (mid, unid)
values (347, 38);
insert into PARTICIPATES (mid, unid)
values (347, 249);
insert into PARTICIPATES (mid, unid)
values (348, 57);
insert into PARTICIPATES (mid, unid)
values (348, 97);
insert into PARTICIPATES (mid, unid)
values (349, 28);
insert into PARTICIPATES (mid, unid)
values (350, 60);
insert into PARTICIPATES (mid, unid)
values (350, 96);
insert into PARTICIPATES (mid, unid)
values (350, 115);
insert into PARTICIPATES (mid, unid)
values (350, 241);
insert into PARTICIPATES (mid, unid)
values (351, 197);
insert into PARTICIPATES (mid, unid)
values (351, 217);
insert into PARTICIPATES (mid, unid)
values (352, 46);
insert into PARTICIPATES (mid, unid)
values (352, 83);
insert into PARTICIPATES (mid, unid)
values (353, 21);
insert into PARTICIPATES (mid, unid)
values (353, 108);
insert into PARTICIPATES (mid, unid)
values (353, 145);
insert into PARTICIPATES (mid, unid)
values (354, 20);
insert into PARTICIPATES (mid, unid)
values (355, 26);
insert into PARTICIPATES (mid, unid)
values (355, 28);
insert into PARTICIPATES (mid, unid)
values (355, 68);
insert into PARTICIPATES (mid, unid)
values (355, 80);
insert into PARTICIPATES (mid, unid)
values (356, 14);
insert into PARTICIPATES (mid, unid)
values (356, 150);
insert into PARTICIPATES (mid, unid)
values (357, 51);
insert into PARTICIPATES (mid, unid)
values (358, 47);
insert into PARTICIPATES (mid, unid)
values (359, 147);
insert into PARTICIPATES (mid, unid)
values (359, 152);
insert into PARTICIPATES (mid, unid)
values (359, 154);
insert into PARTICIPATES (mid, unid)
values (360, 63);
insert into PARTICIPATES (mid, unid)
values (360, 250);
insert into PARTICIPATES (mid, unid)
values (361, 44);
insert into PARTICIPATES (mid, unid)
values (361, 103);
insert into PARTICIPATES (mid, unid)
values (361, 209);
insert into PARTICIPATES (mid, unid)
values (361, 242);
insert into PARTICIPATES (mid, unid)
values (362, 146);
insert into PARTICIPATES (mid, unid)
values (362, 147);
insert into PARTICIPATES (mid, unid)
values (363, 5);
insert into PARTICIPATES (mid, unid)
values (363, 20);
insert into PARTICIPATES (mid, unid)
values (364, 103);
insert into PARTICIPATES (mid, unid)
values (364, 133);
insert into PARTICIPATES (mid, unid)
values (364, 184);
insert into PARTICIPATES (mid, unid)
values (364, 239);
insert into PARTICIPATES (mid, unid)
values (365, 152);
insert into PARTICIPATES (mid, unid)
values (366, 97);
insert into PARTICIPATES (mid, unid)
values (366, 120);
insert into PARTICIPATES (mid, unid)
values (367, 53);
insert into PARTICIPATES (mid, unid)
values (367, 80);
insert into PARTICIPATES (mid, unid)
values (367, 131);
insert into PARTICIPATES (mid, unid)
values (368, 113);
insert into PARTICIPATES (mid, unid)
values (369, 93);
insert into PARTICIPATES (mid, unid)
values (370, 245);
insert into PARTICIPATES (mid, unid)
values (371, 158);
insert into PARTICIPATES (mid, unid)
values (372, 27);
insert into PARTICIPATES (mid, unid)
values (372, 233);
insert into PARTICIPATES (mid, unid)
values (373, 206);
insert into PARTICIPATES (mid, unid)
values (374, 93);
insert into PARTICIPATES (mid, unid)
values (375, 138);
insert into PARTICIPATES (mid, unid)
values (375, 207);
insert into PARTICIPATES (mid, unid)
values (376, 139);
insert into PARTICIPATES (mid, unid)
values (377, 83);
insert into PARTICIPATES (mid, unid)
values (377, 203);
insert into PARTICIPATES (mid, unid)
values (378, 115);
insert into PARTICIPATES (mid, unid)
values (379, 189);
insert into PARTICIPATES (mid, unid)
values (380, 155);
insert into PARTICIPATES (mid, unid)
values (380, 200);
insert into PARTICIPATES (mid, unid)
values (381, 194);
insert into PARTICIPATES (mid, unid)
values (382, 223);
insert into PARTICIPATES (mid, unid)
values (383, 159);
commit;
prompt 600 records committed...
insert into PARTICIPATES (mid, unid)
values (383, 244);
insert into PARTICIPATES (mid, unid)
values (384, 30);
insert into PARTICIPATES (mid, unid)
values (384, 222);
insert into PARTICIPATES (mid, unid)
values (384, 247);
insert into PARTICIPATES (mid, unid)
values (385, 104);
insert into PARTICIPATES (mid, unid)
values (386, 195);
insert into PARTICIPATES (mid, unid)
values (386, 230);
insert into PARTICIPATES (mid, unid)
values (387, 13);
insert into PARTICIPATES (mid, unid)
values (387, 126);
insert into PARTICIPATES (mid, unid)
values (387, 176);
insert into PARTICIPATES (mid, unid)
values (388, 109);
insert into PARTICIPATES (mid, unid)
values (388, 123);
insert into PARTICIPATES (mid, unid)
values (388, 201);
insert into PARTICIPATES (mid, unid)
values (389, 35);
insert into PARTICIPATES (mid, unid)
values (389, 91);
insert into PARTICIPATES (mid, unid)
values (390, 14);
insert into PARTICIPATES (mid, unid)
values (391, 33);
insert into PARTICIPATES (mid, unid)
values (391, 67);
insert into PARTICIPATES (mid, unid)
values (391, 179);
insert into PARTICIPATES (mid, unid)
values (391, 199);
insert into PARTICIPATES (mid, unid)
values (392, 146);
insert into PARTICIPATES (mid, unid)
values (393, 144);
insert into PARTICIPATES (mid, unid)
values (394, 72);
insert into PARTICIPATES (mid, unid)
values (394, 176);
insert into PARTICIPATES (mid, unid)
values (395, 129);
insert into PARTICIPATES (mid, unid)
values (396, 126);
insert into PARTICIPATES (mid, unid)
values (396, 148);
insert into PARTICIPATES (mid, unid)
values (396, 202);
insert into PARTICIPATES (mid, unid)
values (397, 24);
insert into PARTICIPATES (mid, unid)
values (397, 233);
insert into PARTICIPATES (mid, unid)
values (397, 237);
insert into PARTICIPATES (mid, unid)
values (398, 228);
insert into PARTICIPATES (mid, unid)
values (398, 242);
insert into PARTICIPATES (mid, unid)
values (399, 57);
insert into PARTICIPATES (mid, unid)
values (399, 225);
insert into PARTICIPATES (mid, unid)
values (400, 237);
insert into PARTICIPATES (mid, unid)
values (401, 135);
insert into PARTICIPATES (mid, unid)
values (402, 130);
insert into PARTICIPATES (mid, unid)
values (403, 1);
insert into PARTICIPATES (mid, unid)
values (403, 48);
insert into PARTICIPATES (mid, unid)
values (404, 49);
insert into PARTICIPATES (mid, unid)
values (404, 143);
insert into PARTICIPATES (mid, unid)
values (405, 115);
insert into PARTICIPATES (mid, unid)
values (405, 131);
insert into PARTICIPATES (mid, unid)
values (406, 110);
insert into PARTICIPATES (mid, unid)
values (407, 29);
insert into PARTICIPATES (mid, unid)
values (407, 157);
insert into PARTICIPATES (mid, unid)
values (408, 177);
insert into PARTICIPATES (mid, unid)
values (409, 163);
insert into PARTICIPATES (mid, unid)
values (409, 164);
insert into PARTICIPATES (mid, unid)
values (410, 67);
insert into PARTICIPATES (mid, unid)
values (410, 99);
insert into PARTICIPATES (mid, unid)
values (411, 146);
insert into PARTICIPATES (mid, unid)
values (411, 208);
insert into PARTICIPATES (mid, unid)
values (412, 207);
insert into PARTICIPATES (mid, unid)
values (412, 250);
insert into PARTICIPATES (mid, unid)
values (413, 136);
insert into PARTICIPATES (mid, unid)
values (413, 141);
insert into PARTICIPATES (mid, unid)
values (414, 51);
insert into PARTICIPATES (mid, unid)
values (414, 102);
insert into PARTICIPATES (mid, unid)
values (414, 149);
insert into PARTICIPATES (mid, unid)
values (415, 162);
insert into PARTICIPATES (mid, unid)
values (416, 27);
insert into PARTICIPATES (mid, unid)
values (416, 225);
insert into PARTICIPATES (mid, unid)
values (417, 2);
insert into PARTICIPATES (mid, unid)
values (417, 124);
insert into PARTICIPATES (mid, unid)
values (418, 234);
insert into PARTICIPATES (mid, unid)
values (419, 241);
insert into PARTICIPATES (mid, unid)
values (420, 190);
insert into PARTICIPATES (mid, unid)
values (421, 20);
insert into PARTICIPATES (mid, unid)
values (422, 168);
insert into PARTICIPATES (mid, unid)
values (423, 48);
insert into PARTICIPATES (mid, unid)
values (423, 162);
insert into PARTICIPATES (mid, unid)
values (423, 226);
insert into PARTICIPATES (mid, unid)
values (424, 49);
insert into PARTICIPATES (mid, unid)
values (425, 55);
insert into PARTICIPATES (mid, unid)
values (425, 232);
insert into PARTICIPATES (mid, unid)
values (426, 139);
insert into PARTICIPATES (mid, unid)
values (427, 98);
insert into PARTICIPATES (mid, unid)
values (427, 141);
insert into PARTICIPATES (mid, unid)
values (428, 129);
insert into PARTICIPATES (mid, unid)
values (428, 148);
insert into PARTICIPATES (mid, unid)
values (428, 173);
insert into PARTICIPATES (mid, unid)
values (429, 227);
insert into PARTICIPATES (mid, unid)
values (430, 64);
insert into PARTICIPATES (mid, unid)
values (431, 10);
insert into PARTICIPATES (mid, unid)
values (431, 20);
insert into PARTICIPATES (mid, unid)
values (432, 13);
insert into PARTICIPATES (mid, unid)
values (433, 179);
insert into PARTICIPATES (mid, unid)
values (434, 232);
insert into PARTICIPATES (mid, unid)
values (435, 192);
insert into PARTICIPATES (mid, unid)
values (435, 241);
insert into PARTICIPATES (mid, unid)
values (436, 36);
insert into PARTICIPATES (mid, unid)
values (436, 156);
insert into PARTICIPATES (mid, unid)
values (437, 243);
insert into PARTICIPATES (mid, unid)
values (438, 70);
insert into PARTICIPATES (mid, unid)
values (439, 129);
insert into PARTICIPATES (mid, unid)
values (440, 231);
insert into PARTICIPATES (mid, unid)
values (441, 174);
insert into PARTICIPATES (mid, unid)
values (441, 182);
commit;
prompt 700 records committed...
insert into PARTICIPATES (mid, unid)
values (441, 187);
insert into PARTICIPATES (mid, unid)
values (442, 100);
insert into PARTICIPATES (mid, unid)
values (443, 178);
insert into PARTICIPATES (mid, unid)
values (444, 71);
insert into PARTICIPATES (mid, unid)
values (444, 124);
insert into PARTICIPATES (mid, unid)
values (444, 156);
insert into PARTICIPATES (mid, unid)
values (445, 210);
insert into PARTICIPATES (mid, unid)
values (446, 98);
insert into PARTICIPATES (mid, unid)
values (447, 60);
insert into PARTICIPATES (mid, unid)
values (448, 138);
insert into PARTICIPATES (mid, unid)
values (449, 218);
insert into PARTICIPATES (mid, unid)
values (450, 244);
insert into PARTICIPATES (mid, unid)
values (451, 25);
insert into PARTICIPATES (mid, unid)
values (451, 130);
insert into PARTICIPATES (mid, unid)
values (452, 228);
insert into PARTICIPATES (mid, unid)
values (453, 118);
insert into PARTICIPATES (mid, unid)
values (453, 185);
insert into PARTICIPATES (mid, unid)
values (454, 154);
insert into PARTICIPATES (mid, unid)
values (455, 51);
insert into PARTICIPATES (mid, unid)
values (455, 122);
insert into PARTICIPATES (mid, unid)
values (456, 74);
insert into PARTICIPATES (mid, unid)
values (457, 28);
insert into PARTICIPATES (mid, unid)
values (458, 216);
insert into PARTICIPATES (mid, unid)
values (459, 212);
insert into PARTICIPATES (mid, unid)
values (460, 68);
insert into PARTICIPATES (mid, unid)
values (460, 98);
insert into PARTICIPATES (mid, unid)
values (460, 200);
insert into PARTICIPATES (mid, unid)
values (2001, 1);
insert into PARTICIPATES (mid, unid)
values (2001, 2);
insert into PARTICIPATES (mid, unid)
values (2001, 3);
insert into PARTICIPATES (mid, unid)
values (128, 74);
insert into PARTICIPATES (mid, unid)
values (128, 122);
insert into PARTICIPATES (mid, unid)
values (129, 113);
insert into PARTICIPATES (mid, unid)
values (130, 175);
insert into PARTICIPATES (mid, unid)
values (131, 34);
insert into PARTICIPATES (mid, unid)
values (131, 104);
insert into PARTICIPATES (mid, unid)
values (132, 64);
insert into PARTICIPATES (mid, unid)
values (132, 109);
insert into PARTICIPATES (mid, unid)
values (133, 22);
insert into PARTICIPATES (mid, unid)
values (133, 147);
insert into PARTICIPATES (mid, unid)
values (134, 11);
insert into PARTICIPATES (mid, unid)
values (135, 47);
insert into PARTICIPATES (mid, unid)
values (135, 67);
insert into PARTICIPATES (mid, unid)
values (136, 108);
insert into PARTICIPATES (mid, unid)
values (137, 226);
insert into PARTICIPATES (mid, unid)
values (137, 229);
insert into PARTICIPATES (mid, unid)
values (138, 143);
insert into PARTICIPATES (mid, unid)
values (139, 39);
insert into PARTICIPATES (mid, unid)
values (140, 162);
insert into PARTICIPATES (mid, unid)
values (141, 28);
insert into PARTICIPATES (mid, unid)
values (141, 82);
insert into PARTICIPATES (mid, unid)
values (142, 185);
insert into PARTICIPATES (mid, unid)
values (142, 214);
insert into PARTICIPATES (mid, unid)
values (143, 150);
insert into PARTICIPATES (mid, unid)
values (144, 78);
insert into PARTICIPATES (mid, unid)
values (145, 122);
insert into PARTICIPATES (mid, unid)
values (145, 192);
insert into PARTICIPATES (mid, unid)
values (146, 248);
insert into PARTICIPATES (mid, unid)
values (147, 76);
insert into PARTICIPATES (mid, unid)
values (147, 193);
insert into PARTICIPATES (mid, unid)
values (148, 2);
insert into PARTICIPATES (mid, unid)
values (149, 23);
insert into PARTICIPATES (mid, unid)
values (149, 178);
insert into PARTICIPATES (mid, unid)
values (149, 200);
insert into PARTICIPATES (mid, unid)
values (149, 229);
insert into PARTICIPATES (mid, unid)
values (150, 171);
insert into PARTICIPATES (mid, unid)
values (151, 92);
insert into PARTICIPATES (mid, unid)
values (151, 196);
insert into PARTICIPATES (mid, unid)
values (152, 117);
insert into PARTICIPATES (mid, unid)
values (152, 162);
insert into PARTICIPATES (mid, unid)
values (152, 242);
insert into PARTICIPATES (mid, unid)
values (153, 148);
insert into PARTICIPATES (mid, unid)
values (153, 169);
insert into PARTICIPATES (mid, unid)
values (154, 73);
insert into PARTICIPATES (mid, unid)
values (155, 75);
insert into PARTICIPATES (mid, unid)
values (156, 75);
insert into PARTICIPATES (mid, unid)
values (156, 88);
insert into PARTICIPATES (mid, unid)
values (157, 241);
insert into PARTICIPATES (mid, unid)
values (158, 179);
insert into PARTICIPATES (mid, unid)
values (158, 181);
insert into PARTICIPATES (mid, unid)
values (159, 140);
insert into PARTICIPATES (mid, unid)
values (160, 162);
insert into PARTICIPATES (mid, unid)
values (160, 191);
insert into PARTICIPATES (mid, unid)
values (161, 181);
insert into PARTICIPATES (mid, unid)
values (161, 246);
insert into PARTICIPATES (mid, unid)
values (162, 119);
insert into PARTICIPATES (mid, unid)
values (163, 139);
insert into PARTICIPATES (mid, unid)
values (163, 162);
insert into PARTICIPATES (mid, unid)
values (163, 189);
insert into PARTICIPATES (mid, unid)
values (164, 172);
insert into PARTICIPATES (mid, unid)
values (164, 175);
insert into PARTICIPATES (mid, unid)
values (164, 196);
insert into PARTICIPATES (mid, unid)
values (164, 228);
insert into PARTICIPATES (mid, unid)
values (165, 76);
insert into PARTICIPATES (mid, unid)
values (165, 83);
insert into PARTICIPATES (mid, unid)
values (166, 93);
insert into PARTICIPATES (mid, unid)
values (167, 235);
insert into PARTICIPATES (mid, unid)
values (168, 168);
insert into PARTICIPATES (mid, unid)
values (169, 227);
insert into PARTICIPATES (mid, unid)
values (170, 74);
commit;
prompt 800 records committed...
insert into PARTICIPATES (mid, unid)
values (170, 126);
insert into PARTICIPATES (mid, unid)
values (171, 163);
insert into PARTICIPATES (mid, unid)
values (172, 11);
insert into PARTICIPATES (mid, unid)
values (172, 186);
insert into PARTICIPATES (mid, unid)
values (173, 192);
insert into PARTICIPATES (mid, unid)
values (174, 145);
insert into PARTICIPATES (mid, unid)
values (174, 162);
insert into PARTICIPATES (mid, unid)
values (175, 168);
insert into PARTICIPATES (mid, unid)
values (176, 57);
insert into PARTICIPATES (mid, unid)
values (177, 118);
insert into PARTICIPATES (mid, unid)
values (178, 40);
insert into PARTICIPATES (mid, unid)
values (178, 60);
insert into PARTICIPATES (mid, unid)
values (179, 154);
insert into PARTICIPATES (mid, unid)
values (180, 236);
insert into PARTICIPATES (mid, unid)
values (181, 185);
insert into PARTICIPATES (mid, unid)
values (182, 236);
insert into PARTICIPATES (mid, unid)
values (182, 248);
insert into PARTICIPATES (mid, unid)
values (183, 96);
insert into PARTICIPATES (mid, unid)
values (183, 117);
insert into PARTICIPATES (mid, unid)
values (183, 197);
insert into PARTICIPATES (mid, unid)
values (184, 89);
insert into PARTICIPATES (mid, unid)
values (184, 178);
insert into PARTICIPATES (mid, unid)
values (185, 32);
insert into PARTICIPATES (mid, unid)
values (185, 86);
insert into PARTICIPATES (mid, unid)
values (186, 114);
insert into PARTICIPATES (mid, unid)
values (186, 219);
insert into PARTICIPATES (mid, unid)
values (187, 7);
insert into PARTICIPATES (mid, unid)
values (187, 106);
insert into PARTICIPATES (mid, unid)
values (187, 149);
insert into PARTICIPATES (mid, unid)
values (188, 218);
insert into PARTICIPATES (mid, unid)
values (189, 129);
insert into PARTICIPATES (mid, unid)
values (190, 192);
insert into PARTICIPATES (mid, unid)
values (191, 87);
insert into PARTICIPATES (mid, unid)
values (191, 109);
insert into PARTICIPATES (mid, unid)
values (192, 82);
insert into PARTICIPATES (mid, unid)
values (193, 92);
insert into PARTICIPATES (mid, unid)
values (194, 157);
insert into PARTICIPATES (mid, unid)
values (195, 153);
insert into PARTICIPATES (mid, unid)
values (195, 235);
insert into PARTICIPATES (mid, unid)
values (196, 87);
insert into PARTICIPATES (mid, unid)
values (197, 29);
insert into PARTICIPATES (mid, unid)
values (198, 65);
insert into PARTICIPATES (mid, unid)
values (198, 240);
insert into PARTICIPATES (mid, unid)
values (199, 208);
insert into PARTICIPATES (mid, unid)
values (200, 23);
insert into PARTICIPATES (mid, unid)
values (201, 44);
insert into PARTICIPATES (mid, unid)
values (202, 167);
insert into PARTICIPATES (mid, unid)
values (202, 172);
insert into PARTICIPATES (mid, unid)
values (203, 196);
insert into PARTICIPATES (mid, unid)
values (204, 159);
insert into PARTICIPATES (mid, unid)
values (204, 233);
insert into PARTICIPATES (mid, unid)
values (205, 52);
insert into PARTICIPATES (mid, unid)
values (205, 100);
insert into PARTICIPATES (mid, unid)
values (206, 61);
insert into PARTICIPATES (mid, unid)
values (207, 106);
insert into PARTICIPATES (mid, unid)
values (207, 225);
insert into PARTICIPATES (mid, unid)
values (208, 173);
insert into PARTICIPATES (mid, unid)
values (209, 12);
insert into PARTICIPATES (mid, unid)
values (209, 186);
insert into PARTICIPATES (mid, unid)
values (210, 126);
insert into PARTICIPATES (mid, unid)
values (211, 230);
insert into PARTICIPATES (mid, unid)
values (212, 114);
insert into PARTICIPATES (mid, unid)
values (213, 123);
insert into PARTICIPATES (mid, unid)
values (214, 36);
insert into PARTICIPATES (mid, unid)
values (214, 47);
insert into PARTICIPATES (mid, unid)
values (215, 71);
insert into PARTICIPATES (mid, unid)
values (216, 113);
insert into PARTICIPATES (mid, unid)
values (216, 183);
insert into PARTICIPATES (mid, unid)
values (217, 81);
insert into PARTICIPATES (mid, unid)
values (217, 210);
insert into PARTICIPATES (mid, unid)
values (218, 124);
insert into PARTICIPATES (mid, unid)
values (219, 230);
insert into PARTICIPATES (mid, unid)
values (219, 245);
insert into PARTICIPATES (mid, unid)
values (220, 176);
insert into PARTICIPATES (mid, unid)
values (221, 130);
insert into PARTICIPATES (mid, unid)
values (221, 165);
insert into PARTICIPATES (mid, unid)
values (222, 178);
insert into PARTICIPATES (mid, unid)
values (223, 195);
insert into PARTICIPATES (mid, unid)
values (224, 224);
insert into PARTICIPATES (mid, unid)
values (225, 211);
insert into PARTICIPATES (mid, unid)
values (225, 222);
insert into PARTICIPATES (mid, unid)
values (226, 112);
insert into PARTICIPATES (mid, unid)
values (226, 214);
insert into PARTICIPATES (mid, unid)
values (227, 11);
insert into PARTICIPATES (mid, unid)
values (227, 66);
insert into PARTICIPATES (mid, unid)
values (228, 70);
insert into PARTICIPATES (mid, unid)
values (229, 168);
insert into PARTICIPATES (mid, unid)
values (230, 78);
insert into PARTICIPATES (mid, unid)
values (230, 208);
insert into PARTICIPATES (mid, unid)
values (231, 5);
insert into PARTICIPATES (mid, unid)
values (231, 210);
insert into PARTICIPATES (mid, unid)
values (232, 137);
insert into PARTICIPATES (mid, unid)
values (232, 218);
insert into PARTICIPATES (mid, unid)
values (233, 221);
insert into PARTICIPATES (mid, unid)
values (234, 87);
insert into PARTICIPATES (mid, unid)
values (235, 46);
insert into PARTICIPATES (mid, unid)
values (235, 147);
insert into PARTICIPATES (mid, unid)
values (236, 240);
insert into PARTICIPATES (mid, unid)
values (237, 127);
insert into PARTICIPATES (mid, unid)
values (237, 138);
commit;
prompt 900 records committed...
insert into PARTICIPATES (mid, unid)
values (238, 45);
insert into PARTICIPATES (mid, unid)
values (238, 182);
insert into PARTICIPATES (mid, unid)
values (67, 230);
insert into PARTICIPATES (mid, unid)
values (68, 4);
insert into PARTICIPATES (mid, unid)
values (68, 66);
insert into PARTICIPATES (mid, unid)
values (68, 149);
insert into PARTICIPATES (mid, unid)
values (69, 249);
insert into PARTICIPATES (mid, unid)
values (70, 90);
insert into PARTICIPATES (mid, unid)
values (71, 128);
insert into PARTICIPATES (mid, unid)
values (72, 7);
insert into PARTICIPATES (mid, unid)
values (72, 53);
insert into PARTICIPATES (mid, unid)
values (72, 159);
insert into PARTICIPATES (mid, unid)
values (73, 240);
insert into PARTICIPATES (mid, unid)
values (74, 244);
insert into PARTICIPATES (mid, unid)
values (75, 58);
insert into PARTICIPATES (mid, unid)
values (76, 8);
insert into PARTICIPATES (mid, unid)
values (76, 162);
insert into PARTICIPATES (mid, unid)
values (77, 52);
insert into PARTICIPATES (mid, unid)
values (78, 149);
insert into PARTICIPATES (mid, unid)
values (79, 75);
insert into PARTICIPATES (mid, unid)
values (79, 114);
insert into PARTICIPATES (mid, unid)
values (80, 82);
insert into PARTICIPATES (mid, unid)
values (80, 125);
insert into PARTICIPATES (mid, unid)
values (81, 168);
insert into PARTICIPATES (mid, unid)
values (81, 200);
insert into PARTICIPATES (mid, unid)
values (82, 51);
insert into PARTICIPATES (mid, unid)
values (82, 142);
insert into PARTICIPATES (mid, unid)
values (83, 28);
insert into PARTICIPATES (mid, unid)
values (83, 186);
insert into PARTICIPATES (mid, unid)
values (84, 31);
insert into PARTICIPATES (mid, unid)
values (84, 132);
insert into PARTICIPATES (mid, unid)
values (85, 59);
insert into PARTICIPATES (mid, unid)
values (85, 67);
insert into PARTICIPATES (mid, unid)
values (85, 99);
insert into PARTICIPATES (mid, unid)
values (86, 154);
insert into PARTICIPATES (mid, unid)
values (86, 210);
insert into PARTICIPATES (mid, unid)
values (87, 75);
insert into PARTICIPATES (mid, unid)
values (88, 89);
insert into PARTICIPATES (mid, unid)
values (89, 140);
insert into PARTICIPATES (mid, unid)
values (89, 145);
insert into PARTICIPATES (mid, unid)
values (90, 86);
insert into PARTICIPATES (mid, unid)
values (91, 188);
insert into PARTICIPATES (mid, unid)
values (92, 222);
insert into PARTICIPATES (mid, unid)
values (93, 13);
insert into PARTICIPATES (mid, unid)
values (94, 225);
insert into PARTICIPATES (mid, unid)
values (95, 8);
insert into PARTICIPATES (mid, unid)
values (96, 5);
insert into PARTICIPATES (mid, unid)
values (96, 191);
insert into PARTICIPATES (mid, unid)
values (97, 40);
insert into PARTICIPATES (mid, unid)
values (97, 214);
insert into PARTICIPATES (mid, unid)
values (98, 21);
insert into PARTICIPATES (mid, unid)
values (98, 25);
insert into PARTICIPATES (mid, unid)
values (98, 127);
insert into PARTICIPATES (mid, unid)
values (98, 248);
insert into PARTICIPATES (mid, unid)
values (99, 12);
insert into PARTICIPATES (mid, unid)
values (99, 168);
insert into PARTICIPATES (mid, unid)
values (99, 201);
insert into PARTICIPATES (mid, unid)
values (100, 228);
insert into PARTICIPATES (mid, unid)
values (101, 37);
insert into PARTICIPATES (mid, unid)
values (101, 121);
insert into PARTICIPATES (mid, unid)
values (102, 204);
insert into PARTICIPATES (mid, unid)
values (103, 155);
insert into PARTICIPATES (mid, unid)
values (104, 7);
insert into PARTICIPATES (mid, unid)
values (104, 24);
insert into PARTICIPATES (mid, unid)
values (105, 151);
insert into PARTICIPATES (mid, unid)
values (106, 136);
insert into PARTICIPATES (mid, unid)
values (107, 182);
insert into PARTICIPATES (mid, unid)
values (107, 243);
insert into PARTICIPATES (mid, unid)
values (108, 46);
insert into PARTICIPATES (mid, unid)
values (109, 55);
insert into PARTICIPATES (mid, unid)
values (110, 110);
insert into PARTICIPATES (mid, unid)
values (111, 36);
insert into PARTICIPATES (mid, unid)
values (111, 46);
insert into PARTICIPATES (mid, unid)
values (112, 71);
insert into PARTICIPATES (mid, unid)
values (113, 9);
insert into PARTICIPATES (mid, unid)
values (113, 230);
insert into PARTICIPATES (mid, unid)
values (114, 140);
insert into PARTICIPATES (mid, unid)
values (114, 187);
insert into PARTICIPATES (mid, unid)
values (115, 32);
insert into PARTICIPATES (mid, unid)
values (115, 216);
insert into PARTICIPATES (mid, unid)
values (116, 18);
insert into PARTICIPATES (mid, unid)
values (116, 141);
insert into PARTICIPATES (mid, unid)
values (116, 155);
insert into PARTICIPATES (mid, unid)
values (116, 231);
insert into PARTICIPATES (mid, unid)
values (117, 174);
insert into PARTICIPATES (mid, unid)
values (117, 189);
insert into PARTICIPATES (mid, unid)
values (118, 235);
insert into PARTICIPATES (mid, unid)
values (119, 39);
insert into PARTICIPATES (mid, unid)
values (119, 184);
insert into PARTICIPATES (mid, unid)
values (120, 190);
insert into PARTICIPATES (mid, unid)
values (120, 232);
insert into PARTICIPATES (mid, unid)
values (121, 147);
insert into PARTICIPATES (mid, unid)
values (122, 243);
insert into PARTICIPATES (mid, unid)
values (123, 185);
insert into PARTICIPATES (mid, unid)
values (124, 121);
insert into PARTICIPATES (mid, unid)
values (125, 186);
insert into PARTICIPATES (mid, unid)
values (125, 229);
insert into PARTICIPATES (mid, unid)
values (126, 30);
insert into PARTICIPATES (mid, unid)
values (126, 137);
insert into PARTICIPATES (mid, unid)
values (127, 84);
commit;
prompt 1000 records loaded
prompt Loading TANK...
insert into TANK (tid, unid, cid)
values (103, 142, 103);
insert into TANK (tid, unid, cid)
values (104, 170, 104);
insert into TANK (tid, unid, cid)
values (105, 192, 105);
insert into TANK (tid, unid, cid)
values (106, 233, 106);
insert into TANK (tid, unid, cid)
values (107, 160, 107);
insert into TANK (tid, unid, cid)
values (108, 207, 108);
insert into TANK (tid, unid, cid)
values (109, 144, 109);
insert into TANK (tid, unid, cid)
values (110, 46, 110);
insert into TANK (tid, unid, cid)
values (111, 83, 111);
insert into TANK (tid, unid, cid)
values (112, 52, 112);
insert into TANK (tid, unid, cid)
values (113, 99, 113);
insert into TANK (tid, unid, cid)
values (114, 182, 114);
insert into TANK (tid, unid, cid)
values (115, 237, 115);
insert into TANK (tid, unid, cid)
values (116, 239, 116);
insert into TANK (tid, unid, cid)
values (117, 80, 117);
insert into TANK (tid, unid, cid)
values (118, 53, 118);
insert into TANK (tid, unid, cid)
values (119, 33, 119);
insert into TANK (tid, unid, cid)
values (120, 50, 120);
insert into TANK (tid, unid, cid)
values (121, 241, 121);
insert into TANK (tid, unid, cid)
values (122, 116, 122);
insert into TANK (tid, unid, cid)
values (123, 182, 123);
insert into TANK (tid, unid, cid)
values (124, 30, 124);
insert into TANK (tid, unid, cid)
values (125, 66, 125);
insert into TANK (tid, unid, cid)
values (126, 45, 126);
insert into TANK (tid, unid, cid)
values (127, 153, 127);
insert into TANK (tid, unid, cid)
values (128, 189, 128);
insert into TANK (tid, unid, cid)
values (129, 18, 129);
insert into TANK (tid, unid, cid)
values (130, 47, 130);
insert into TANK (tid, unid, cid)
values (131, 223, 131);
insert into TANK (tid, unid, cid)
values (132, 86, 132);
insert into TANK (tid, unid, cid)
values (133, 193, 133);
insert into TANK (tid, unid, cid)
values (134, 65, 134);
insert into TANK (tid, unid, cid)
values (135, 106, 135);
insert into TANK (tid, unid, cid)
values (136, 7, 136);
insert into TANK (tid, unid, cid)
values (137, 159, 137);
insert into TANK (tid, unid, cid)
values (138, 201, 138);
insert into TANK (tid, unid, cid)
values (139, 132, 139);
insert into TANK (tid, unid, cid)
values (140, 207, 140);
insert into TANK (tid, unid, cid)
values (141, 55, 141);
insert into TANK (tid, unid, cid)
values (142, 55, 142);
insert into TANK (tid, unid, cid)
values (143, 93, 143);
insert into TANK (tid, unid, cid)
values (144, 127, 144);
insert into TANK (tid, unid, cid)
values (145, 110, 145);
insert into TANK (tid, unid, cid)
values (146, 96, 146);
insert into TANK (tid, unid, cid)
values (147, 30, 147);
insert into TANK (tid, unid, cid)
values (148, 169, 148);
insert into TANK (tid, unid, cid)
values (149, 106, 149);
insert into TANK (tid, unid, cid)
values (150, 38, 150);
insert into TANK (tid, unid, cid)
values (151, 147, 151);
insert into TANK (tid, unid, cid)
values (152, 121, 152);
insert into TANK (tid, unid, cid)
values (153, 131, 153);
insert into TANK (tid, unid, cid)
values (154, 22, 154);
insert into TANK (tid, unid, cid)
values (155, 156, 155);
insert into TANK (tid, unid, cid)
values (156, 53, 156);
insert into TANK (tid, unid, cid)
values (157, 173, 157);
insert into TANK (tid, unid, cid)
values (158, 111, 158);
insert into TANK (tid, unid, cid)
values (159, 40, 159);
insert into TANK (tid, unid, cid)
values (160, 37, 160);
insert into TANK (tid, unid, cid)
values (161, 189, 161);
insert into TANK (tid, unid, cid)
values (162, 162, 162);
insert into TANK (tid, unid, cid)
values (163, 99, 163);
insert into TANK (tid, unid, cid)
values (164, 62, 164);
insert into TANK (tid, unid, cid)
values (165, 209, 165);
insert into TANK (tid, unid, cid)
values (166, 93, 166);
insert into TANK (tid, unid, cid)
values (167, 91, 167);
insert into TANK (tid, unid, cid)
values (168, 114, 168);
insert into TANK (tid, unid, cid)
values (169, 73, 169);
insert into TANK (tid, unid, cid)
values (170, 22, 170);
insert into TANK (tid, unid, cid)
values (171, 238, 171);
insert into TANK (tid, unid, cid)
values (172, 90, 172);
insert into TANK (tid, unid, cid)
values (173, 25, 173);
insert into TANK (tid, unid, cid)
values (174, 109, 174);
insert into TANK (tid, unid, cid)
values (175, 13, 175);
insert into TANK (tid, unid, cid)
values (176, 84, 176);
insert into TANK (tid, unid, cid)
values (177, 108, 177);
insert into TANK (tid, unid, cid)
values (178, 32, 178);
insert into TANK (tid, unid, cid)
values (179, 192, 179);
insert into TANK (tid, unid, cid)
values (180, 192, 180);
insert into TANK (tid, unid, cid)
values (181, 93, 181);
insert into TANK (tid, unid, cid)
values (182, 12, 182);
insert into TANK (tid, unid, cid)
values (183, 248, 183);
insert into TANK (tid, unid, cid)
values (184, 164, 184);
insert into TANK (tid, unid, cid)
values (185, 223, 185);
insert into TANK (tid, unid, cid)
values (186, 110, 186);
insert into TANK (tid, unid, cid)
values (187, 183, 187);
insert into TANK (tid, unid, cid)
values (188, 63, 188);
insert into TANK (tid, unid, cid)
values (189, 139, 189);
insert into TANK (tid, unid, cid)
values (190, 88, 190);
insert into TANK (tid, unid, cid)
values (191, 18, 191);
insert into TANK (tid, unid, cid)
values (192, 49, 192);
insert into TANK (tid, unid, cid)
values (193, 135, 193);
insert into TANK (tid, unid, cid)
values (194, 79, 194);
insert into TANK (tid, unid, cid)
values (195, 183, 195);
insert into TANK (tid, unid, cid)
values (196, 177, 196);
insert into TANK (tid, unid, cid)
values (197, 100, 197);
insert into TANK (tid, unid, cid)
values (198, 228, 198);
insert into TANK (tid, unid, cid)
values (199, 90, 199);
insert into TANK (tid, unid, cid)
values (200, 51, 200);
insert into TANK (tid, unid, cid)
values (201, 19, 201);
insert into TANK (tid, unid, cid)
values (202, 236, 202);
commit;
prompt 100 records committed...
insert into TANK (tid, unid, cid)
values (203, 23, 203);
insert into TANK (tid, unid, cid)
values (204, 21, 204);
insert into TANK (tid, unid, cid)
values (205, 171, 205);
insert into TANK (tid, unid, cid)
values (206, 56, 206);
insert into TANK (tid, unid, cid)
values (207, 77, 207);
insert into TANK (tid, unid, cid)
values (208, 142, 208);
insert into TANK (tid, unid, cid)
values (209, 2, 209);
insert into TANK (tid, unid, cid)
values (210, 201, 210);
insert into TANK (tid, unid, cid)
values (211, 144, 211);
insert into TANK (tid, unid, cid)
values (212, 126, 212);
insert into TANK (tid, unid, cid)
values (213, 215, 213);
insert into TANK (tid, unid, cid)
values (214, 106, 214);
insert into TANK (tid, unid, cid)
values (215, 245, 215);
insert into TANK (tid, unid, cid)
values (216, 194, 216);
insert into TANK (tid, unid, cid)
values (217, 96, 217);
insert into TANK (tid, unid, cid)
values (218, 32, 218);
insert into TANK (tid, unid, cid)
values (219, 65, 219);
insert into TANK (tid, unid, cid)
values (220, 146, 220);
insert into TANK (tid, unid, cid)
values (221, 210, 221);
insert into TANK (tid, unid, cid)
values (222, 174, 222);
insert into TANK (tid, unid, cid)
values (223, 244, 223);
insert into TANK (tid, unid, cid)
values (224, 178, 224);
insert into TANK (tid, unid, cid)
values (225, 146, 225);
insert into TANK (tid, unid, cid)
values (226, 46, 226);
insert into TANK (tid, unid, cid)
values (227, 36, 227);
insert into TANK (tid, unid, cid)
values (228, 234, 228);
insert into TANK (tid, unid, cid)
values (229, 50, 229);
insert into TANK (tid, unid, cid)
values (230, 145, 230);
insert into TANK (tid, unid, cid)
values (231, 153, 231);
insert into TANK (tid, unid, cid)
values (232, 171, 232);
insert into TANK (tid, unid, cid)
values (233, 46, 233);
insert into TANK (tid, unid, cid)
values (234, 224, 234);
insert into TANK (tid, unid, cid)
values (235, 99, 235);
insert into TANK (tid, unid, cid)
values (236, 70, 236);
insert into TANK (tid, unid, cid)
values (237, 29, 237);
insert into TANK (tid, unid, cid)
values (238, 123, 238);
insert into TANK (tid, unid, cid)
values (239, 18, 239);
insert into TANK (tid, unid, cid)
values (240, 72, 240);
insert into TANK (tid, unid, cid)
values (241, 151, 241);
insert into TANK (tid, unid, cid)
values (242, 50, 242);
insert into TANK (tid, unid, cid)
values (243, 5, 243);
insert into TANK (tid, unid, cid)
values (244, 175, 244);
insert into TANK (tid, unid, cid)
values (245, 125, 245);
insert into TANK (tid, unid, cid)
values (246, 117, 246);
insert into TANK (tid, unid, cid)
values (247, 119, 247);
insert into TANK (tid, unid, cid)
values (248, 208, 248);
insert into TANK (tid, unid, cid)
values (249, 33, 249);
insert into TANK (tid, unid, cid)
values (250, 103, 250);
insert into TANK (tid, unid, cid)
values (251, 144, 251);
insert into TANK (tid, unid, cid)
values (252, 139, 252);
insert into TANK (tid, unid, cid)
values (253, 52, 253);
insert into TANK (tid, unid, cid)
values (254, 15, 254);
insert into TANK (tid, unid, cid)
values (255, 19, 255);
insert into TANK (tid, unid, cid)
values (256, 121, 256);
insert into TANK (tid, unid, cid)
values (257, 7, 257);
insert into TANK (tid, unid, cid)
values (258, 122, 258);
insert into TANK (tid, unid, cid)
values (259, 103, 259);
insert into TANK (tid, unid, cid)
values (260, 160, 260);
insert into TANK (tid, unid, cid)
values (261, 153, 261);
insert into TANK (tid, unid, cid)
values (262, 95, 262);
insert into TANK (tid, unid, cid)
values (263, 150, 263);
insert into TANK (tid, unid, cid)
values (264, 12, 264);
insert into TANK (tid, unid, cid)
values (265, 130, 265);
insert into TANK (tid, unid, cid)
values (266, 63, 266);
insert into TANK (tid, unid, cid)
values (267, 64, 267);
insert into TANK (tid, unid, cid)
values (268, 164, 268);
insert into TANK (tid, unid, cid)
values (269, 107, 269);
insert into TANK (tid, unid, cid)
values (270, 3, 270);
insert into TANK (tid, unid, cid)
values (271, 183, 271);
insert into TANK (tid, unid, cid)
values (272, 158, 272);
insert into TANK (tid, unid, cid)
values (273, 105, 273);
insert into TANK (tid, unid, cid)
values (274, 152, 274);
insert into TANK (tid, unid, cid)
values (275, 117, 275);
insert into TANK (tid, unid, cid)
values (276, 191, 276);
insert into TANK (tid, unid, cid)
values (277, 67, 277);
insert into TANK (tid, unid, cid)
values (278, 220, 278);
insert into TANK (tid, unid, cid)
values (279, 230, 279);
insert into TANK (tid, unid, cid)
values (280, 215, 280);
insert into TANK (tid, unid, cid)
values (281, 100, 281);
insert into TANK (tid, unid, cid)
values (282, 137, 282);
insert into TANK (tid, unid, cid)
values (283, 42, 283);
insert into TANK (tid, unid, cid)
values (284, 176, 284);
insert into TANK (tid, unid, cid)
values (285, 246, 285);
insert into TANK (tid, unid, cid)
values (286, 222, 286);
insert into TANK (tid, unid, cid)
values (287, 6, 287);
insert into TANK (tid, unid, cid)
values (288, 67, 288);
insert into TANK (tid, unid, cid)
values (289, 209, 289);
insert into TANK (tid, unid, cid)
values (290, 180, 290);
insert into TANK (tid, unid, cid)
values (291, 125, 291);
insert into TANK (tid, unid, cid)
values (292, 122, 292);
insert into TANK (tid, unid, cid)
values (293, 68, 293);
insert into TANK (tid, unid, cid)
values (294, 194, 294);
insert into TANK (tid, unid, cid)
values (295, 78, 295);
insert into TANK (tid, unid, cid)
values (296, 46, 296);
insert into TANK (tid, unid, cid)
values (297, 53, 297);
insert into TANK (tid, unid, cid)
values (298, 53, 298);
insert into TANK (tid, unid, cid)
values (299, 88, 299);
insert into TANK (tid, unid, cid)
values (300, 104, 300);
insert into TANK (tid, unid, cid)
values (301, 35, 301);
insert into TANK (tid, unid, cid)
values (302, 11, 302);
commit;
prompt 200 records committed...
insert into TANK (tid, unid, cid)
values (303, 54, 303);
insert into TANK (tid, unid, cid)
values (304, 49, 304);
insert into TANK (tid, unid, cid)
values (305, 29, 305);
insert into TANK (tid, unid, cid)
values (306, 233, 306);
insert into TANK (tid, unid, cid)
values (307, 138, 307);
insert into TANK (tid, unid, cid)
values (308, 145, 308);
insert into TANK (tid, unid, cid)
values (309, 220, 309);
insert into TANK (tid, unid, cid)
values (310, 49, 310);
insert into TANK (tid, unid, cid)
values (311, 149, 311);
insert into TANK (tid, unid, cid)
values (312, 186, 312);
insert into TANK (tid, unid, cid)
values (313, 152, 313);
insert into TANK (tid, unid, cid)
values (314, 189, 314);
insert into TANK (tid, unid, cid)
values (315, 206, 315);
insert into TANK (tid, unid, cid)
values (316, 62, 316);
insert into TANK (tid, unid, cid)
values (317, 201, 317);
insert into TANK (tid, unid, cid)
values (318, 177, 318);
insert into TANK (tid, unid, cid)
values (319, 145, 319);
insert into TANK (tid, unid, cid)
values (320, 28, 320);
insert into TANK (tid, unid, cid)
values (321, 73, 321);
insert into TANK (tid, unid, cid)
values (322, 201, 322);
insert into TANK (tid, unid, cid)
values (323, 24, 323);
insert into TANK (tid, unid, cid)
values (324, 53, 324);
insert into TANK (tid, unid, cid)
values (325, 15, 325);
insert into TANK (tid, unid, cid)
values (326, 184, 326);
insert into TANK (tid, unid, cid)
values (327, 72, 327);
insert into TANK (tid, unid, cid)
values (328, 103, 328);
insert into TANK (tid, unid, cid)
values (329, 245, 329);
insert into TANK (tid, unid, cid)
values (330, 200, 330);
insert into TANK (tid, unid, cid)
values (331, 78, 331);
insert into TANK (tid, unid, cid)
values (332, 247, 332);
insert into TANK (tid, unid, cid)
values (333, 201, 333);
insert into TANK (tid, unid, cid)
values (334, 157, 334);
insert into TANK (tid, unid, cid)
values (335, 143, 335);
insert into TANK (tid, unid, cid)
values (336, 35, 336);
insert into TANK (tid, unid, cid)
values (337, 213, 337);
insert into TANK (tid, unid, cid)
values (338, 31, 338);
insert into TANK (tid, unid, cid)
values (339, 133, 339);
insert into TANK (tid, unid, cid)
values (340, 115, 340);
insert into TANK (tid, unid, cid)
values (341, 90, 341);
insert into TANK (tid, unid, cid)
values (342, 74, 342);
insert into TANK (tid, unid, cid)
values (343, 119, 343);
insert into TANK (tid, unid, cid)
values (344, 163, 344);
insert into TANK (tid, unid, cid)
values (345, 151, 345);
insert into TANK (tid, unid, cid)
values (346, 153, 346);
insert into TANK (tid, unid, cid)
values (347, 163, 347);
insert into TANK (tid, unid, cid)
values (348, 79, 348);
insert into TANK (tid, unid, cid)
values (349, 22, 349);
insert into TANK (tid, unid, cid)
values (350, 156, 350);
insert into TANK (tid, unid, cid)
values (1, 2, 1);
insert into TANK (tid, unid, cid)
values (2, 232, 2);
insert into TANK (tid, unid, cid)
values (3, 211, 3);
insert into TANK (tid, unid, cid)
values (4, 195, 4);
insert into TANK (tid, unid, cid)
values (5, 62, 5);
insert into TANK (tid, unid, cid)
values (6, 185, 6);
insert into TANK (tid, unid, cid)
values (7, 38, 7);
insert into TANK (tid, unid, cid)
values (8, 68, 8);
insert into TANK (tid, unid, cid)
values (9, 234, 9);
insert into TANK (tid, unid, cid)
values (10, 92, 10);
insert into TANK (tid, unid, cid)
values (11, 130, 11);
insert into TANK (tid, unid, cid)
values (12, 221, 12);
insert into TANK (tid, unid, cid)
values (13, 123, 13);
insert into TANK (tid, unid, cid)
values (14, 58, 14);
insert into TANK (tid, unid, cid)
values (15, 194, 15);
insert into TANK (tid, unid, cid)
values (16, 161, 16);
insert into TANK (tid, unid, cid)
values (17, 122, 17);
insert into TANK (tid, unid, cid)
values (18, 22, 18);
insert into TANK (tid, unid, cid)
values (19, 122, 19);
insert into TANK (tid, unid, cid)
values (20, 91, 20);
insert into TANK (tid, unid, cid)
values (21, 136, 21);
insert into TANK (tid, unid, cid)
values (22, 151, 22);
insert into TANK (tid, unid, cid)
values (23, 3, 23);
insert into TANK (tid, unid, cid)
values (24, 172, 24);
insert into TANK (tid, unid, cid)
values (25, 186, 25);
insert into TANK (tid, unid, cid)
values (26, 141, 26);
insert into TANK (tid, unid, cid)
values (27, 26, 27);
insert into TANK (tid, unid, cid)
values (28, 79, 28);
insert into TANK (tid, unid, cid)
values (29, 42, 29);
insert into TANK (tid, unid, cid)
values (30, 136, 30);
insert into TANK (tid, unid, cid)
values (31, 85, 31);
insert into TANK (tid, unid, cid)
values (32, 154, 32);
insert into TANK (tid, unid, cid)
values (33, 3, 33);
insert into TANK (tid, unid, cid)
values (34, 179, 34);
insert into TANK (tid, unid, cid)
values (35, 137, 35);
insert into TANK (tid, unid, cid)
values (36, 207, 36);
insert into TANK (tid, unid, cid)
values (37, 47, 37);
insert into TANK (tid, unid, cid)
values (38, 84, 38);
insert into TANK (tid, unid, cid)
values (39, 45, 39);
insert into TANK (tid, unid, cid)
values (40, 162, 40);
insert into TANK (tid, unid, cid)
values (41, 28, 41);
insert into TANK (tid, unid, cid)
values (42, 126, 42);
insert into TANK (tid, unid, cid)
values (43, 192, 43);
insert into TANK (tid, unid, cid)
values (44, 188, 44);
insert into TANK (tid, unid, cid)
values (45, 143, 45);
insert into TANK (tid, unid, cid)
values (46, 1, 46);
insert into TANK (tid, unid, cid)
values (47, 136, 47);
insert into TANK (tid, unid, cid)
values (48, 157, 48);
insert into TANK (tid, unid, cid)
values (49, 122, 49);
insert into TANK (tid, unid, cid)
values (50, 21, 50);
insert into TANK (tid, unid, cid)
values (51, 169, 51);
insert into TANK (tid, unid, cid)
values (52, 124, 52);
commit;
prompt 300 records committed...
insert into TANK (tid, unid, cid)
values (53, 75, 53);
insert into TANK (tid, unid, cid)
values (54, 130, 54);
insert into TANK (tid, unid, cid)
values (55, 45, 55);
insert into TANK (tid, unid, cid)
values (56, 192, 56);
insert into TANK (tid, unid, cid)
values (57, 222, 57);
insert into TANK (tid, unid, cid)
values (58, 189, 58);
insert into TANK (tid, unid, cid)
values (59, 78, 59);
insert into TANK (tid, unid, cid)
values (60, 236, 60);
insert into TANK (tid, unid, cid)
values (61, 240, 61);
insert into TANK (tid, unid, cid)
values (62, 239, 62);
insert into TANK (tid, unid, cid)
values (63, 179, 63);
insert into TANK (tid, unid, cid)
values (64, 239, 64);
insert into TANK (tid, unid, cid)
values (65, 120, 65);
insert into TANK (tid, unid, cid)
values (66, 189, 66);
insert into TANK (tid, unid, cid)
values (67, 74, 67);
insert into TANK (tid, unid, cid)
values (68, 195, 68);
insert into TANK (tid, unid, cid)
values (69, 171, 69);
insert into TANK (tid, unid, cid)
values (70, 31, 70);
insert into TANK (tid, unid, cid)
values (71, 46, 71);
insert into TANK (tid, unid, cid)
values (72, 28, 72);
insert into TANK (tid, unid, cid)
values (73, 33, 73);
insert into TANK (tid, unid, cid)
values (74, 189, 74);
insert into TANK (tid, unid, cid)
values (75, 242, 75);
insert into TANK (tid, unid, cid)
values (76, 71, 76);
insert into TANK (tid, unid, cid)
values (77, 162, 77);
insert into TANK (tid, unid, cid)
values (78, 205, 78);
insert into TANK (tid, unid, cid)
values (79, 154, 79);
insert into TANK (tid, unid, cid)
values (80, 92, 80);
insert into TANK (tid, unid, cid)
values (81, 127, 81);
insert into TANK (tid, unid, cid)
values (82, 112, 82);
insert into TANK (tid, unid, cid)
values (83, 214, 83);
insert into TANK (tid, unid, cid)
values (84, 126, 84);
insert into TANK (tid, unid, cid)
values (85, 206, 85);
insert into TANK (tid, unid, cid)
values (86, 201, 86);
insert into TANK (tid, unid, cid)
values (87, 131, 87);
insert into TANK (tid, unid, cid)
values (88, 68, 88);
insert into TANK (tid, unid, cid)
values (89, 77, 89);
insert into TANK (tid, unid, cid)
values (90, 103, 90);
insert into TANK (tid, unid, cid)
values (91, 90, 91);
insert into TANK (tid, unid, cid)
values (92, 36, 92);
insert into TANK (tid, unid, cid)
values (93, 92, 93);
insert into TANK (tid, unid, cid)
values (94, 5, 94);
insert into TANK (tid, unid, cid)
values (95, 186, 95);
insert into TANK (tid, unid, cid)
values (96, 144, 96);
insert into TANK (tid, unid, cid)
values (97, 207, 97);
insert into TANK (tid, unid, cid)
values (98, 218, 98);
insert into TANK (tid, unid, cid)
values (99, 215, 99);
insert into TANK (tid, unid, cid)
values (100, 101, 100);
insert into TANK (tid, unid, cid)
values (101, 94, 101);
insert into TANK (tid, unid, cid)
values (102, 218, 102);
commit;
prompt 350 records loaded
prompt Enabling foreign key constraints for COMMANDER...
alter table COMMANDER enable constraint SYS_C008381;
prompt Enabling foreign key constraints for CREWMATE...
alter table CREWMATE enable constraint SYS_C008386;
alter table CREWMATE enable constraint SYS_C008387;
prompt Enabling foreign key constraints for UNIT...
alter table UNIT enable constraint SYS_C008392;
prompt Enabling foreign key constraints for PARTICIPATES...
alter table PARTICIPATES enable constraint SYS_C008407;
alter table PARTICIPATES enable constraint SYS_C008408;
prompt Enabling foreign key constraints for TANK...
alter table TANK enable constraint SYS_C008397;
alter table TANK enable constraint SYS_C008398;
prompt Enabling triggers for SOLDIERS...
alter table SOLDIERS enable all triggers;
prompt Enabling triggers for COMMANDER...
alter table COMMANDER enable all triggers;
prompt Enabling triggers for CREWMATE...
alter table CREWMATE enable all triggers;
prompt Enabling triggers for MISSION...
alter table MISSION enable all triggers;
prompt Enabling triggers for UNIT...
alter table UNIT enable all triggers;
prompt Enabling triggers for PARTICIPATES...
alter table PARTICIPATES enable all triggers;
prompt Enabling triggers for TANK...
alter table TANK enable all triggers;

set feedback on
set define on
prompt Done
