/* ======================================================
   ⚽ football league management system (lowercase version)
   ====================================================== */

create database footballleague;
go
use footballleague;
go

/* ===================== league ===================== */
create table league (
    leagueid int identity primary key,
    leaguename nvarchar(100) not null unique,
    country nvarchar(100) not null,
    season nvarchar(20) not null,
    startdate date not null,
    enddate date not null,
    constraint chk_leaguedates check (startdate < enddate)
);

/* ===================== team ===================== */
create table team (
    teamid int identity primary key,
    leagueid int not null,
    teamname nvarchar(100) not null,
    city nvarchar(100),
    coach nvarchar(100),
    foundedyear int check (foundedyear between 1800 and year(getdate())),
    constraint fk_team_league foreign key (leagueid) references league(leagueid)
);

/* ===================== player ===================== */
create table player (
    playerid int identity primary key,
    teamid int not null,
    firstname nvarchar(50) not null,
    lastname nvarchar(50) not null,
    position nvarchar(10) check (position in ('gk','df','mf','fw')),
    shirtnumber int not null check (shirtnumber between 1 and 99),
    birthdate date,
    nationality nvarchar(50),
    constraint fk_player_team foreign key (teamid) references team(teamid),
    constraint uq_player_shirt unique (teamid, shirtnumber)
);

/* ===================== referee ===================== */
create table referee (
    refereeid int identity primary key,
    refereename nvarchar(100) not null,
    nationality nvarchar(50),
    experienceyears int check (experienceyears between 0 and 40)
);

/* ===================== match ===================== */
create table match (
    matchid int identity primary key,
    leagueid int not null,
    matchdate date not null,
    matchtime time(0) not null,
    stadium nvarchar(100),
    attendance int check (attendance >= 0),
    constraint fk_match_league foreign key (leagueid) references league(leagueid)
);

/* ===================== subscribe ===================== */
create table subscribe (
    matchid int not null,
    teamid int not null,
    teamside nvarchar(10) check (teamside in ('home','away')),
    primary key (matchid, teamid),
    constraint fk_subscribe_match foreign key (matchid) references match(matchid),
    constraint fk_subscribe_team foreign key (teamid) references team(teamid),
    constraint uq_subscribe_side unique (matchid, teamside)
);

/* ===================== arbitration ===================== */
create table arbitration (
    matchid int not null,
    refereeid int not null,
    role nvarchar(50) check (role in ('main','assistant','var','fourth')),
    primary key (matchid, refereeid),
    constraint fk_arb_match foreign key (matchid) references match(matchid),
    constraint fk_arb_ref foreign key (refereeid) references referee(refereeid)
);

/* ===================== team match stats ===================== */
create table teammatchstats (
    matchid int not null,
    teamid int not null,
    possession decimal(5,2) check (possession between 0 and 100),
    shots int check (shots >= 0),
    shotsontarget int check (shotsontarget >= 0),
    fouls int check (fouls >= 0),
    corners int check (corners >= 0),
    primary key (matchid, teamid),
    constraint fk_tms_sub foreign key (matchid, teamid) references subscribe(matchid, teamid)
);

/* ===================== goal ===================== */
create table goal (
    goalid int identity primary key,
    matchid int not null,
    teamid int not null,
    playerid int not null,
    goalminute int check (goalminute between 1 and 120),
    goaltype nvarchar(20) check (goaltype in ('normal','penalty','own goal','freekick')),
    constraint fk_goal_match foreign key (matchid) references match(matchid),
    constraint fk_goal_team foreign key (teamid) references team(teamid),
    constraint fk_goal_player foreign key (playerid) references player(playerid)
);

/* ===================== match result ===================== */
create table matchresult (
    matchid int not null,
    teamid int not null,
    goalsscored int default 0,
    points int default 0 check (points between 0 and 3),
    primary key (matchid, teamid),
    constraint fk_result_sub foreign key (matchid, teamid) references subscribe(matchid, teamid)
); 
go


/* ===================== leagues ===================== */
insert into league (leaguename, country, season, startdate, enddate)
values
('premier league', 'england', '2025/26', '2025-08-01', '2026-05-25'),
('la liga', 'spain', '2025/26', '2025-08-10', '2026-05-30');
go

/* ===================== teams ===================== */
insert into team (leagueid, teamname, city, coach, foundedyear)
values
(1,'manchester united','manchester','erik ten hag',1878),
(1,'liverpool','liverpool','jurgen klopp',1892),
(1,'arsenal','london','mikel arteta',1886),
(1,'chelsea','london','mauricio pochettino',1905),
(1,'manchester city','manchester','pep guardiola',1880),
(1,'tottenham hotspur','london','ange postecoglou',1882),

(2,'real madrid','madrid','carlo ancelotti',1902),
(2,'fc barcelona','barcelona','hansi flick',1899),
(2,'atletico madrid','madrid','diego simeone',1903),
(2,'sevilla fc','sevilla','quique sánchez flores',1890);
go

/* ===================== players ===================== */
insert into player (teamid, firstname, lastname, position, shirtnumber, birthdate, nationality)
values
(1,'marcus','rashford','fw',10,'1997-10-31','england'),
(1,'bruno','fernandes','mf',8,'1994-09-08','portugal'),
(2,'mohamed','salah','fw',11,'1992-06-15','egypt'),
(2,'darwin','nunez','fw',9,'1999-06-24','uruguay'),
(3,'bukayo','saka','fw',7,'2001-09-05','england'),
(3,'declan','rice','mf',41,'1999-01-14','england'),
(4,'raheem','sterling','fw',17,'1994-12-08','england'),
(4,'enzo','fernandez','mf',8,'2001-01-17','argentina'),
(5,'erling','haaland','fw',9,'2000-07-21','norway'),
(5,'kevin','de bruyne','mf',17,'1991-06-28','belgium'),
(6,'son','heung-min','fw',7,'1992-07-08','south korea'),
(6,'james','maddison','mf',10,'1996-11-23','england'),

(7,'jude','bellingham','mf',5,'2003-06-29','england'),
(7,'vinicius','junior','fw',7,'2000-07-12','brazil'),
(8,'robert','lewandowski','fw',9,'1988-08-21','poland'),
(8,'pedri','gonzález','mf',8,'2002-11-25','spain'),
(9,'antoine','griezmann','fw',7,'1991-03-21','france'),
(9,'koke','resurrección','mf',6,'1992-01-08','spain'),
(10,'youssef','en-nesyri','fw',15,'1997-06-01','morocco'),
(10,'sergio','ramos','df',4,'1986-03-30','spain');
go

/* ===================== referees ===================== */
insert into referee (refereename, nationality, experienceyears)
values
('michael oliver','england',12),
('anthony taylor','england',10),
('antonio mateu lahoz','spain',15),
('carlos del cerro grande','spain',13),
('jesus gil manzano','spain',11),
('darren england','england',8),
('ricardo de burgos','spain',9);
go

/* ===================== matches ===================== */

insert into match (leagueid, matchdate, matchtime, stadium, attendance)
values
-- premier league
(1,'2025-08-01','18:00:00','old trafford',75000),
(1,'2025-08-08','20:00:00','anfield',54000),
(1,'2025-08-15','19:00:00','etihad stadium',62000),

-- la liga
(2,'2025-08-10','21:00:00','santiago bernabéu',81000),
(2,'2025-08-17','22:00:00','camp nou',98000),
(2,'2025-08-24','21:30:00','metropolitano',67000),

-- extra premier league matches
(1,'2025-08-22','18:30:00','tottenham stadium',60000),
(1,'2025-08-29','21:00:00','stamford bridge',52000),
(1,'2025-09-05','19:00:00','emirates stadium',61000),
(1,'2025-09-12','20:30:00','etihad stadium',63000),
(1,'2025-09-19','18:00:00','anfield',55000),

-- extra la liga matches
(2,'2025-08-31','22:00:00','ramon sanchez pizjuan',48000),
(2,'2025-09-07','21:00:00','camp nou',96000),
(2,'2025-09-14','20:00:00','madrid arena',70000),
(2,'2025-09-21','22:30:00','metropolitano',68000),
(2,'2025-09-28','21:00:00','santiago bernabéu',82000);
go

/* ===================== subscribe ===================== */
insert into subscribe (matchid, teamid, teamside) values
(1,1,'home'),(1,2,'away'),
(2,3,'home'),(2,4,'away'),
(3,5,'home'),(3,6,'away'),

(4,7,'home'),(4,8,'away'),
(5,9,'home'),(5,10,'away'),
(6,8,'home'),(6,9,'away'),

-- extra pl
(7,6,'home'),(7,2,'away'),
(8,4,'home'),(8,1,'away'),
(9,3,'home'),(9,5,'away'),
(10,5,'home'),(10,2,'away'),
(11,1,'home'),(11,6,'away'),

-- extra la liga
(12,10,'home'),(12,7,'away'),
(13,8,'home'),(13,9,'away'),
(14,7,'home'),(14,10,'away'),
(15,9,'home'),(15,8,'away'),
(16,8,'home'),(16,7,'away');
go

/* ===================== arbitration ===================== */
insert into arbitration (matchid, refereeid, role) values
(1,1,'main'),(1,6,'assistant'),(1,2,'var'),
(2,2,'main'),(2,1,'assistant'),(2,6,'var'),
(3,6,'main'),(3,1,'assistant'),(3,2,'var'),

(4,3,'main'),(4,7,'assistant'),(4,4,'var'),
(5,4,'main'),(5,3,'assistant'),(5,5,'var'),
(6,5,'main'),(6,3,'assistant'),(6,4,'var'),

-- extra pl
(7,1,'main'),(7,2,'assistant'),(7,6,'var'),
(8,6,'main'),(8,1,'assistant'),(8,2,'var'),
(9,2,'main'),(9,6,'assistant'),(9,1,'var'),
(10,1,'main'),(10,2,'assistant'),(10,6,'var'),
(11,6,'main'),(11,1,'assistant'),(11,2,'var'),

-- extra la liga
(12,3,'main'),(12,4,'assistant'),(12,7,'var'),
(13,4,'main'),(13,3,'assistant'),(13,5,'var'),
(14,7,'main'),(14,5,'assistant'),(14,4,'var'),
(15,5,'main'),(15,3,'assistant'),(15,7,'var'),
(16,3,'main'),(16,4,'assistant'),(16,5,'var');
go

/* ===================== goals ===================== */
insert into goal (matchid, teamid, playerid, goalminute, goaltype) values
(1,1,1,23,'normal'),
(1,2,3,45,'penalty'),
(1,1,2,71,'normal'),
(2,3,5,18,'normal'),
(2,3,6,69,'freekick'),
(2,4,7,82,'penalty'),
(3,5,9,33,'normal'),
(3,5,10,66,'freekick'),
(3,6,11,75,'normal'),

(4,7,13,24,'normal'),
(4,8,15,41,'penalty'),
(4,7,14,65,'normal'),
(5,9,17,28,'normal'),
(5,10,19,64,'penalty'),
(5,9,18,77,'freekick'),
(6,8,15,33,'freekick'),
(6,9,17,48,'normal'),
(6,8,14,85,'normal'),

-- extra pl
(7,6,11,22,'normal'),
(7,2,3,59,'normal'),

(8,4,7,19,'penalty'),
(8,1,2,71,'freekick'),

(9,3,5,28,'normal'),
(9,5,9,54,'normal'),

(10,5,10,17,'normal'),
(10,2,4,65,'normal'),

(11,1,1,11,'normal'),
(11,6,12,78,'normal'),

-- extra la liga
(12,10,20,55,'normal'),
(12,7,13,61,'freekick'),

(13,8,15,28,'normal'),
(13,9,17,70,'normal'),

(14,7,14,22,'normal'),
(14,10,20,52,'normal'),

(15,9,18,19,'normal'),
(15,8,15,85,'freekick'),

(16,8,14,33,'normal'),
(16,7,13,57,'normal');
go

/* ===================== match results ===================== */
insert into matchresult (matchid, teamid, goalsscored, points) values
(1,1,2,3),(1,2,1,0),
(2,3,2,1),(2,4,2,1),
(3,5,2,0),(3,6,1,3),

(4,7,2,3),(4,8,1,0),
(5,9,1,1),(5,10,1,1),
(6,8,2,3),(6,9,1,0),

-- extra pl
(7,6,1,1),(7,2,1,1),
(8,4,1,1),(8,1,1,1),
(9,3,1,0),(9,5,1,3),
(10,5,1,0),(10,2,1,3),
(11,1,1,1),(11,6,1,1),

-- extra la liga
(12,10,1,1),(12,7,1,1),
(13,8,1,1),(13,9,1,1),
(14,7,1,3),(14,10,1,0),
(15,9,1,0),(15,8,1,3),
(16,8,1,1),(16,7,1,1);
go

/* ===================== team match stats ===================== */
insert into teammatchstats (matchid, teamid, possession, shots, shotsontarget, fouls, corners) values
(1,1,55.5,14,7,10,6),(1,2,44.5,9,4,12,4),
(2,3,60.0,15,8,7,8),(2,4,40.0,7,3,9,3),
(3,5,58.0,13,6,6,5),(3,6,42.0,9,3,10,4),

(4,7,40.0,16,9,8,7),(4,8,60.0,11,6,11,5),
(5,9,55.5,14,6,10,6),(5,10,44.5,10,5,12,4),
(6,8,52.0,13,7,8,6),(6,9,48.0,12,5,9,5),

-- extra pl
(7,6,51.0,12,6,10,5),(7,2,49.0,11,4,8,4),
(8,4,47.0,9,3,12,3),(8,1,53.0,14,7,9,6),
(9,3,52.0,11,5,7,5),(9,5,48.0,10,4,12,4),
(10,5,49.0,10,4,10,4),(10,2,51.0,12,6,8,5),
(11,1,56.0,15,8,9,6),(11,6,44.0,10,4,11,3),

-- extra la liga
(12,10,46.0,9,4,11,4),(12,7,54.0,12,6,10,6),
(13,8,58.0,14,7,8,5),(13,9,42.0,10,4,9,4),
(14,7,55.0,13,6,7,7),(14,10,45.0,9,3,12,3),
(15,9,48.0,10,5,9,4),(15,8,52.0,12,6,8,5),
(16,8,53.0,12,5,7,6),(16,7,47.0,10,4,11,4);
go