--drop table BoardOverAdverts, BoardOverLists, BoardOverMemories, BoardGames, BoardGameRequests;

create table BoardOverAdverts (AdvertIndex bigint IDENTITY(0,1) PRIMARY KEY, Name varchar(50) not null, Picture varchar(50) not null, Link varchar(50) not null );

create table BoardOverLists (ListIndex bigint IDENTITY(0,1) PRIMARY KEY, BoardOverUserIndex bigint not null, OrderRank bigint not null, BoardGameIndex bigint not null, UpLock bit not null default 0, DownLock bit not null default 0);

create table BoardOverMemories (MemoryIndex bigint IDENTITY(0,1) PRIMARY KEY, BoardGameIndex1 bigint not null, BoardGameIndex2 bigint not null );

create table BoardGames (TargetIndex bigint IDENTITY(0,1) PRIMARY KEY, Name varchar(50) not null, Release varchar(50) not null, Genre varchar(50) not null, Picture varchar(50) not null, UploadUserIndex bigint not null );

create table BoardGameRequests (RequestIndex bigint IDENTITY(0,1) PRIMARY KEY, Name varchar(50) not null, Release varchar(50) not null, Genre varchar(50) not null, Picture varchar(50) not null, UploadUserIndex bigint not null );

insert into BoardOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 1', 'RoosterTeeth1.png', 'http://www.RoosterTeeth.com');
insert into BoardOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 2', 'RoosterTeeth2.jpg', 'http://www.RoosterTeeth.com');
insert into BoardOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 3', 'RoosterTeeth3.jpg', 'http://www.RoosterTeeth.com');
insert into BoardOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 4', 'RoosterTeeth4.jpg', 'http://www.RoosterTeeth.com');
insert into BoardOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 5', 'RoosterTeeth5.jpg', 'http://www.RoosterTeeth.com');
insert into BoardOverAdverts (Name, Picture, Link) VALUES ('Roosterteeth 6', 'RoosterTeeth6.jpg', 'http://www.RoosterTeeth.com');


insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('7 Wonders Duel',									'2015', 'TableuBuilding',	'7WondersDuel_2015.jpg',							0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('The Castles of Burgundy',							'2011', 'Economy',			'CastlesOfBurgundyThe_2011.jpg',					0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Caverna: The Cave Farmers',						'2013', 'Economy',			'CavernaTheCaveFarmers_2013.jpg',					0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Eminent Domain',									'2011', 'DeckBuilding',		'EminentDomain_2011.jpg',							0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('EPIC Card Game',									'2015', 'ConstructedDeck',	'EPICCardGame_2015.jpg',							0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Last Night on Earth',								'2007', 'Strategy',			'LastNightOnEarth_2007.jpg',						0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Last Night on Earth: Timber Peak',					'2012', 'Strategy',			'LastNightOnEarthTimberPeak_2012.jpg',				0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Munchkin',											'2001', 'FixedDeck',		'Munchkin_2001.jpg',								0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Pandemic Legacy',									'2015', 'Coop',				'PandemicLegacy_2015.png',							0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Penny Arcade: Gamers vs Evil',						'2011', 'DeckBuilding',		'PennyArcadeGamersVsEvil_2011.jpg',					0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Penny Arcade: Rumble in R''Lyeh',					'2012', 'DeckBuilding',		'PennyArcadeRumbleInRLeyh_2012.jpg',				0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Puerto Rico',										'2002', 'Economy',			'PuertoRico_2002.jpg',								0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Risk Legacy',										'2011', 'Strategy',			'RiskLegacy_2011.png',								0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Scythe',											'2016', 'TableuBuilding',	'Scythe_2016.jpg',									0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('The Settlers of Catan',							'1995', 'Economy',			'SettlersOfCatanThe_1995.jpg',						0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Small World',										'2009', 'Economy',			'SmallWorld_2009.jpg',								0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Small World: Underground',							'2011', 'Economy',			'SmallWorldUnderground_2011.jpg',					0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('SPANC',											'2005', 'FixedDeck',		'SPANC_2005.jpg',									0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Star Realms: Colony Wars',							'2015', 'DeckBuilding',		'StarRealmsColonyWars_2015.jpg',					0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Star Wars: Rebellion',								'2016', 'Strategy',			'StarWarsRebellion_2016.png',						0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Super Dungeon Explore',							'2011', 'Strategy',			'SuperDungeonExplore_2011.jpg',						0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Super Dungeon Explore: Forgotten King',			'2015', 'Strategy',			'SuperDungeonExploreForgottenKing_2015.jpg',		0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Taboo',											'1989', 'Party',			'Taboo_1989.jpg',									0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Takenoko',											'2011', 'Economy',			'Takenoko_2011.jpg',								0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Tanto Cuore',										'2009', 'DeckBuilding',		'TantoCuore_2009.jpg',								0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Terra Mystica',									'2012', 'Strategy',			'TerraMystica_2012.jpg',							0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Through the Ages: A New Story of Civilization',	'2015', 'Economy',			'ThroughTheAgesANewStoryOfCivilization_2015.jpg',	0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Ticket to Ride',									'2004', 'Economy',			'TicketToRide_2004.jpg',							0);
insert into BoardGames (Name, Release, Genre, Picture, UploadUserIndex) VALUES ('Twilight Struggle',								'2005', 'Strategy',			'TwilightStruggle_2005.jpg',						0);
