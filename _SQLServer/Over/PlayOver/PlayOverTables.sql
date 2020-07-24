--drop table PlayOverAdverts, PlayOverLists, PlayOverMemories, VideoGames, VideoGameRequests;

create table PlayOverAdverts (AdvertIndex bigint IDENTITY(0,1) PRIMARY KEY, Name varchar(50) not null, Picture varchar(50) not null, Link varchar(50) not null );

create table PlayOverLists (ListIndex bigint IDENTITY(0,1) PRIMARY KEY, UserIndex bigint not null, Rank bigint not null, TargetIndex bigint not null, UpLock bit not null default 0, DownLock bit not null default 0);

create table PlayOverMemories (MemoryIndex bigint IDENTITY(0,1) PRIMARY KEY, UserIndex bigint not null, TargetIndex1 bigint not null, TargetIndex2 bigint not null );

create table VideoGames (TargetIndex bigint IDENTITY(0,1) PRIMARY KEY, Name varchar(50) not null, Release varchar(50) not null, GamePlatform varchar(50) not null, Genre varchar(50) not null, Picture varchar(50) not null, UploadUserIndex bigint not null );

create table VideoGameRequests (RequestIndex bigint IDENTITY(0,1) PRIMARY KEY, Name varchar(50) not null, Release varchar(50) not null, GamePlatform varchar(50) not null, Genre varchar(50) not null, Picture varchar(50) not null, UploadUserIndex bigint not null );

insert into PlayOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 1', 'RoosterTeeth1.png', 'http://www.RoosterTeeth.com');
insert into PlayOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 2', 'RoosterTeeth2.jpg', 'http://www.RoosterTeeth.com');
insert into PlayOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 3', 'RoosterTeeth3.jpg', 'http://www.RoosterTeeth.com');
insert into PlayOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 4', 'RoosterTeeth4.jpg', 'http://www.RoosterTeeth.com');
insert into PlayOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 5', 'RoosterTeeth5.jpg', 'http://www.RoosterTeeth.com');
insert into PlayOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 6', 'RoosterTeeth6.jpg', 'http://www.RoosterTeeth.com');

insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy',									'1990', 'NES',		'RPG',		'FinalFantasy_1990.png',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 2',								'1988', 'FAMICOM',	'RPG',		'FinalFantasy2_1988.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 3',								'1990', 'FAMICOM',	'RPG',		'FinalFantasy3_1990.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 4',								'1991', 'SNES',		'RPG',		'FinalFantasy4_2010.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 5',								'1992', 'SNES',		'RPG',		'FinalFantasy5_1992.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 6',								'1994', 'SNES',		'RPG',		'FinalFantasy6_1994.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 7',								'1997', 'PS1',		'RPG',		'FinalFantasy7_1997.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 8',								'1999', 'PS1',		'RPG',		'FinalFantasy8_1999.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 9',								'2000', 'PS1',		'RPG',		'FinalFantasy9_2000.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 10',								'2001', 'PS2',		'RPG',		'FinalFantasy10_2001.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 11',								'2002', 'PC',		'MMO',		'FinalFantasy11_2002.png',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 12',								'2006', 'PS2',		'RPG',		'FinalFantasy12_2006.png',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 13',								'2009', 'PS3',		'RPG',		'FinalFantasy13_2009.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 14',								'2010', 'PC',		'MMO',		'FinalFantasy14_2010.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy 15',								'2016', 'PS4',		'RPG',		'FinalFantasy15_2016.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Halo: Combat Evolved',							'2001', 'Xbox',		'RPG',		'HaloCombatEvolved_2001.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Halo 2',											'2004', 'Xbox',		'RPG',		'Halo2_2004.png',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Halo 3',											'2007', 'Xbox360',	'RPG',		'Halo3_2007.JPG',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Halo 3: ODST',									'2009', 'Xbox360',	'RPG',		'Halo3ODST_2009.png',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Halo 4',											'2012', 'NES',		'XboOne',	'Halo4_2012.png',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Halo 5: Guardians',								'2015', 'XboOne',	'RPG',		'Halo5Guardians_2015.png',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy Tactics',							'1998', 'PS1',		'RPG',		'FinalFantasyTactics_1998.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy Tactics Advanced',					'2003', 'GBA',		'RPG',		'FinalFantasyTacticsAdvance_2003.jpg',							0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Final Fantasy Tactics A2: Grimoire of the Rift', '2008', 'DS',		'RPG',		'FinalFantasyTacticsA2GrimoireOfTheRift_2008.jpg',	0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Disgaea: Hour of Darkness',						'2003', 'PS2',		'TRPG',		'DisgaeaHourOfDarkness_2003.jpg',					0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Disgaea 2: Cursed Memories',						'2006', 'PS2',		'TRPG',		'Disgaea2CursedMemories_2006.jpg',					0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Disgaea 3: Absence of Justice',					'2008', 'PS3',		'TRPG',		'Disgaea3AbsenceOfJustice_2008.jpg',				0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Disgaea 4: A Promise Unforgotten',				'2011', 'PS3',		'TRPG',		'Disgaea4APromiseUnforgotten_2011.jpg',				0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Disgaea D2: A Brighter Darkness',				'2013', 'PS3',		'TRPG',		'DisgaeaD2ABrighterDarkness_2013.jpg',				0);
insert into VideoGames (Name, Release, GamePlatform, Genre, Picture, UploadUserIndex) VALUES ('Disgaea 5: Alliance of Vengeance',				'2015', 'PS4',		'TRPG',		'Disgaea5AllianceOfVengeance_2015.png',				0);