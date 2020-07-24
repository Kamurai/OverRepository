--drop table WatchOverAdverts, WatchOverLists, WatchOverMemories, Movies, MovieRequests;

create table WatchOverAdverts (AdvertIndex bigint IDENTITY(0,1) PRIMARY KEY, Name varchar(50) not null, Picture varchar(50) not null, Link varchar(50) not null );

create table WatchOverLists (ListIndex bigint IDENTITY(0,1) PRIMARY KEY, UserIndex bigint not null, Rank bigint not null, TargetIndex bigint not null, UpLock bit not null default 0, DownLock bit not null default 0);

create table WatchOverMemories (MemoryIndex bigint IDENTITY(0,1) PRIMARY KEY, UserIndex bigint not null, TargetIndex1 bigint not null, TargetIndex2 bigint not null );

create table Movies (TargetIndex bigint IDENTITY(0,1) PRIMARY KEY, Name varchar(50) not null, Release varchar(50) not null, Genre varchar(50) not null, Setting varchar(50) not null, Picture varchar(50) not null, UploadUserIndex bigint not null );

create table MovieRequests (RequestIndex bigint IDENTITY(0,1) PRIMARY KEY, Name varchar(50) not null, Release varchar(50) not null, Genre varchar(50) not null, Setting varchar(50) not null, Picture varchar(50) not null, UploadUserIndex bigint not null );

insert into WatchOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 1', 'RoosterTeeth1.png', 'http://www.RoosterTeeth.com');
insert into WatchOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 2', 'RoosterTeeth2.jpg', 'http://www.RoosterTeeth.com');
insert into WatchOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 3', 'RoosterTeeth3.jpg', 'http://www.RoosterTeeth.com');
insert into WatchOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 4', 'RoosterTeeth4.jpg', 'http://www.RoosterTeeth.com');
insert into WatchOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 5', 'RoosterTeeth5.jpg', 'http://www.RoosterTeeth.com');
insert into WatchOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 6', 'RoosterTeeth6.jpg', 'http://www.RoosterTeeth.com');

insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Ant Man',								'2015', 'Action',	'Comics',			'AntMan_2015.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Avengers: Age of Ultron',				'2015', 'Action',	'Comics',			'AvengersAgeOfUltron_2015.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('The Avengers',						'2012', 'Action',	'Comics',			'AvengersThe_2012.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Captain America: Civil War',			'2012', 'Action',	'Comics',			'CaptainAmericaCivilWar_2016.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Captain America: The First Avenger',	'2012', 'Action',	'Comics',			'CaptainAmericaTheFirst Avenger_2011.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Captain America: The Winter Soldier',	'2012', 'Action',	'Comics',			'CaptainAmericaTheWinterSoldier_2014.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Doctor Strange',						'2012', 'Action',	'Comics',			'DoctorStrange_2016.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Guardians of the Galaxy',				'2012', 'Action',	'Comics',			'GuardiansOfTheGalaxy_2014.png', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Guardians of the Galaxy Vol 2',		'2012', 'Action',	'Comics',			'GuardiansOfTheGalaxy2_2017.png', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('The Hulk',							'2012', 'Action',	'Comics',			'HulkThe_2003.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('I, FL.Rankenstein',						'2012', 'Action',	'ScienceFiction',	'IFL.Rankenstein_2014.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('The Incredible Hulk',					'2012', 'Action',	'Comics',			'IncredibleHulkThe_2008.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Iron Man',							'2012', 'Action',	'Comics',			'IronMan_2008.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Iron Man 2',							'2012', 'Action',	'Comics',			'IronMan2_2010.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Iron Man 3',							'2012', 'Action',	'Comics',			'IronMan3_2013.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Snowpiercer',							'2012', 'Action',	'ScienceFiction',	'SnowPiercer_2013.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Thor',								'2012', 'Action',	'Comics',			'Thor_2011.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Thor: The Dark World',				'2012', 'Action',	'Comics',			'ThorTheDarkWorld_2013.png', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Transendence',						'2012', 'Drama',	'ScienceFiction',	'Transcendence_2014.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('V for Vendetta',						'2012', 'Drama',	'Comics',			'VForVendetta_2005.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Wanted',								'2012', 'Action',	'Comics',			'Wanted_2008.jpg', 0);
insert into Movies (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Watchmen',							'2012', 'Drama',	'Comics',			'Watchmen_2009.jpg', 0);