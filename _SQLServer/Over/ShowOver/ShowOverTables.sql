--drop table ShowOverAdverts, ShowOverLists, Shows, ShowRequests;

create table ShowOverAdverts (AdvertIndex bigint IDENTITY(0,1) PRIMARY KEY, Name varchar(max) not null, Picture varchar(max) not null, Link varchar(max) not null );

create table ShowOverLists (ListIndex bigint IDENTITY(0,1) PRIMARY KEY, ShowOverUserIndex bigint not null, OrderRank bigint not null, ShowIndex bigint not null, UpLock bit not null default 0, DownLock bit not null default 0);

create table Shows (TargetIndex bigint IDENTITY(0,1) PRIMARY KEY, Name varchar(max) not null, Release varchar(50) not null, Genre varchar(50) not null, Setting varchar(50) not null, Picture varchar(max) not null, UploadUserIndex bigint not null );

create table ShowRequests (RequestIndex bigint IDENTITY(0,1) PRIMARY KEY, Name varchar(max) not null, Release varchar(50) not null, Genre varchar(50) not null, Setting varchar(50) not null, Picture varchar(max) not null, UploadUserIndex bigint not null );

insert into ShowOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 1', 'RoosterTeeth1.png', 'http://www.RoosterTeeth.com');
insert into ShowOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 2', 'RoosterTeeth2.jpg', 'http://www.RoosterTeeth.com');
insert into ShowOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 3', 'RoosterTeeth3.jpg', 'http://www.RoosterTeeth.com');
insert into ShowOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 4', 'RoosterTeeth4.jpg', 'http://www.RoosterTeeth.com');
insert into ShowOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 5', 'RoosterTeeth5.jpg', 'http://www.RoosterTeeth.com');
insert into ShowOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 6', 'RoosterTeeth6.jpg', 'http://www.RoosterTeeth.com');

insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('The Big Bang Theory',	'2007', 'Comedy',	'Modern',			'BigBangTheoryThe_2007.jpg',	0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Bob''s Burgers',		'2011', 'Comedy',	'Modern',			'BobsBurgers_2011.jpg',			0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Colony',				'2016', 'Drama',	'ScienceFiction',	'Colony_2016.jpg',				0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Defiance',				'2013', 'Drama',	'ScienceFiction',	'Defiance_2013.jpg',			0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Elementary',			'2012', 'Mystery',	'Modern',			'Elementary_2012.jpg',			0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Emerald City',			'2016', 'Drama',	'Fantasy',			'EmeraldCity_2016.jpg',			0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Falling Skies',		'2011', 'Action',	'ScienceFiction',	'FallingSkies_2011.jpg',		0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Family Guy',			'1999', 'Comedy',	'Modern',			'FamilyGuy_1999.jpg',			0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Friends',				'1994', 'Comedy',	'Modern',			'Friends_1994.jpg',				0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Grimm',				'2011', 'Mystery',	'Modern',			'Grimm_2011.jpg',				0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('How I Met Your Mother','2005', 'Comedy',	'Modern',			'HowIMetYourMother_2005.jpg',	0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Joey',					'2004', 'Comedy',	'Modern',			'Joey_2004.jpg',				0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Kevin Can Wait',		'2016', 'Comedy',	'Modern',			'KevinCanWait_2016.jpg',		0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Last Man Standing',	'2011', 'Comedy',	'Modern',			'LastManStanding_2011.jpg',		0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Man with a Plan',		'2016', 'Comedy',	'Modern',			'ManWithAPlan_2016.jpg',		0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('The Middle',			'2009', 'Comedy',	'Modern',			'MiddleThe_2009.jpg',			0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Modern Family',		'2009', 'Comedy',	'Modern',			'ModernFamily_2009.jpg',		0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Once Upon a Time',		'2011', 'Drama',	'Modern',			'OnceUponATime_2011.jpg',		0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Seinfeld',				'1989', 'Comedy',	'Modern',			'Seinfeld_1989.jpg',			0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('The Simpsons',			'1989', 'Comedy',	'Modern',			'SimpsonsThe_1989.jpg',			0);
insert into Shows (Name, Release, Genre, Setting, Picture, UploadUserIndex) VALUES ('Southpark',			'1997', 'Comedy',	'Modern',			'SouthPark_1997.jpg',			0);
