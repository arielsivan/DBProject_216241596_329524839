
[General]
Version=1

[Preferences]
Username=
Password=2717
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=SOLDIERS
Count=10..20

[Record]
Name=SID
Type=NUMBER
Size=9
Data=Sequence(1)
Master=

[Record]
Name=FIRSTNAME
Type=VARCHAR2
Size=20
Data=FirstName
Master=

[Record]
Name=LASTNAME
Type=VARCHAR2
Size=20
Data=LastName
Master=

[Record]
Name=DRAFTDATE
Type=DATE
Size=
Data=random(01/01/2006,31/12/2006)
Master=

[Record]
Name=RELEASEDATE
Type=DATE
Size=
Data=random(01/01/2009,31/12/2009)
Master=

