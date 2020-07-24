--drop table [HTKB].dbo.Users, [Over].dbo.Users, [Over].dbo.BangOverUsers, [Over].dbo.BoardOverUsers, [Over].dbo.PlayOverUsers, [Over].dbo.ShowOverUsers, [Over].dbo.WatchOverUsers, [BubbleUp].dbo.Users, [BubbleUp].dbo.Adverts, [BubbleUp].dbo.Boxes, [BubbleUp].dbo.Targets, [Shout].dbo.Users, [Mist].dbo.Users;

create table [HTKB].dbo.Users (
	UserIndex		bigint IDENTITY(0,1) PRIMARY KEY, 
	AdminLevel		int not null,
	Online			bit not null, 
	Username		varchar(max) not null, 
	Passcode		varchar(max) not null, 
	Email			varchar(max) not null
);

create table [Over].dbo.Users (
	UserIndex		bigint IDENTITY(0,1) PRIMARY KEY, 
	HTKBUserIndex	bigint not null, 
	AdminLevel		int not null,
	Online			bit not null
);

create table [Over].dbo.BangOverUsers (
	UserIndex		bigint IDENTITY(0,1) PRIMARY KEY, 
	OverUserIndex	bigint not null, 
	AdminLevel		int not null,
	Online			bit not null, 
	Memory			bit not null, 
	--Genders
	Women			bit not null, 
	Men				bit not null, 
	TransWomen		bit not null, 
	TransMen		bit not null
);

create table [Over].dbo.BoardOverUsers (
	UserIndex			bigint IDENTITY(0,1) PRIMARY KEY, 
	OverUserIndex		bigint not null, 
	AdminLevel			int not null,
	Online				bit not null, 
	Memory				bit not null, 
	--Genres
	DeckBuilding		bit not null, 
	FixedDeck			bit not null, 
	ConstructedDeck		bit not null, 
	Strategy			bit not null, 
	War					bit not null, 
	Economy				bit not null, 
	TableauBuilding		bit not null, 
	Coop				bit not null, 
	Mystery				bit not null, 
	SemiCoop			bit not null, 
	PPRPG				bit not null, 
	Bluffing			bit not null, 
	Puzzle				bit not null, 
	Dexterity			bit not null, 
	Party				bit not null
);

create table [Over].dbo.PlayOverUsers (
	UserIndex			bigint IDENTITY(0,1) PRIMARY KEY, 
	OverUserIndex		bigint not null, 
	AdminLevel			int not null,
	Online				bit not null, 
	Memory				bit not null, 
	--Genres
	TwoDP				bit not null, 
	ThreeDP				bit not null, 
	FPS					bit not null, 
	FPP					bit not null, 
	VPuzzle				bit not null, 
	Bulletstorm			bit not null, 
	Fighting			bit not null, 
	Stealth				bit not null, 
	Survival			bit not null, 
	VN					bit not null, 
	IM					bit not null, 
	RPG					bit not null, 
	TRPG				bit not null, 
	ARPG				bit not null, 
	Sports				bit not null, 
	Racing				bit not null, 
	RTS					bit not null, 
	TBS					bit not null, 
	VE					bit not null, 
	MMO					bit not null, 
	MOBA				bit not null,
	--Platforms
	PC					bit not null,
	Atari				bit not null,
	Commodore64			bit not null,
	FAMICOM				bit not null,
	NES					bit not null,
	SNES				bit not null,
	N64					bit not null,
	Gamecube			bit not null,
	Wii					bit not null,
	WiiU				bit not null,
	NintendoSwitch		bit not null,
	Gameboy				bit not null,
	VirtualBoy			bit not null,
	GBA					bit not null,
	DS					bit not null,
	ThreeDS				bit not null,
	SegaGenesis			bit not null,
	SegaCD				bit not null,
	SegaDreamcast		bit not null,
	PS1					bit not null,
	PS2					bit not null,
	PS3					bit not null,
	PS4					bit not null,
	PSP					bit not null,
	PSVita				bit not null,
	Xbox				bit not null,
	Xbox360				bit not null,
	XboxOne				bit not null,
	Ouya				bit not null,
	OculusRift			bit not null,
	Vive				bit not null,
	PSVR				bit not null
);

create table [Over].dbo.ShowOverUsers (
	UserIndex			bigint IDENTITY(0,1) PRIMARY KEY, 
	OverUserIndex		bigint not null, 
	AdminLevel			int not null,
	Online				bit not null, 
	Memory				bit not null, 
	--Genres
	Comedy				bit not null, 
	Drama				bit not null, 
	Action				bit not null, 
	Horror				bit not null, 
	Thriller			bit not null, 
	Mystery				bit not null, 
	Documentary			bit not null, 
	--Settings
	ScienceFiction		bit not null, 
	Fantasy				bit not null, 
	Western				bit not null, 
	MartialArts			bit not null, 
	Modern				bit not null, 
	Historic			bit not null, 
	Prehistoric			bit not null, 
	Comics				bit not null, 
	Period				bit not null
);

create table [Over].dbo.WatchOverUsers (
	UserIndex			bigint IDENTITY(0,1) PRIMARY KEY, 
	OverUserIndex		bigint not null, 
	AdminLevel			int not null,
	Online				bit not null, 
	Memory				bit not null, 
	--Genres
	Comedy				bit not null, 
	Drama				bit not null, 
	Action				bit not null, 
	Horror				bit not null, 
	Thriller			bit not null, 
	Mystery				bit not null, 
	Documentary			bit not null, 
	--Settings
	ScienceFiction		bit not null, 
	Fantasy				bit not null, 
	Western				bit not null, 
	MartialArts			bit not null, 
	Modern				bit not null, 
	Historic			bit not null, 
	Prehistoric			bit not null, 
	Comics				bit not null, 
	Period				bit not null
);

create table [BubbleUp].dbo.Users (
	UserIndex		bigint IDENTITY(0,1) PRIMARY KEY, 
	HTKBUserIndex	bigint not null, 
	AdminLevel		int not null,
	Online			bit not null
);

create table [BubbleUp].dbo.Adverts (
	AdvertIndex bigint IDENTITY(0,1) PRIMARY KEY, 
	Name 		varchar(50) not null, 
	Picture 	varchar(50) not null, 
	Link 		varchar(50) not null 
);

insert into [BubbleUp].dbo.Adverts (Name, Picture, Link) VALUES ('Roosterteeth 1', 'RoosterTeeth1.png', 'http://www.RoosterTeeth.com');
insert into [BubbleUp].dbo.Adverts (Name, Picture, Link) VALUES ('Roosterteeth 2', 'RoosterTeeth2.jpg', 'http://www.RoosterTeeth.com');
insert into [BubbleUp].dbo.Adverts (Name, Picture, Link) VALUES ('Roosterteeth 3', 'RoosterTeeth3.jpg', 'http://www.RoosterTeeth.com');
insert into [BubbleUp].dbo.Adverts (Name, Picture, Link) VALUES ('Roosterteeth 4', 'RoosterTeeth4.jpg', 'http://www.RoosterTeeth.com');
insert into [BubbleUp].dbo.Adverts (Name, Picture, Link) VALUES ('Roosterteeth 5', 'RoosterTeeth5.jpg', 'http://www.RoosterTeeth.com');
insert into [BubbleUp].dbo.Adverts (Name, Picture, Link) VALUES ('Roosterteeth 6', 'RoosterTeeth6.jpg', 'http://www.RoosterTeeth.com');

--drop table [BubbleUp].dbo.Boxes;
--drop table [BubbleUp].dbo.Targets;

create table [BubbleUp].dbo.Boxes (
	BoxIndex			bigint IDENTITY(0,1) PRIMARY KEY, 
	UserIndex			bigint not null, 
	Direction			varchar(max) NOT NULL CHECK (Direction IN('Horizontal', 'Vertical')),
	Label				varchar(max),
	ParentBoxIndex		bigint not null,
	Rank				int not null
);

create table [BubbleUp].dbo.Targets (
	TargetIndex			bigint IDENTITY(0,1) PRIMARY KEY, 
	UserIndex			bigint not null, 
	Label				varchar(max),
	ParentBoxIndex		bigint not null,
	Rank				int not null
);

create table [Shout].dbo.Users (
	UserIndex		bigint IDENTITY(0,1) PRIMARY KEY, 
	HTKBUserIndex	bigint not null, 
	AdminLevel		int not null,
	Online			bit not null
);

create table [Mist].dbo.Users (
	UserIndex		bigint IDENTITY(0,1) PRIMARY KEY, 
	HTKBUserIndex	bigint not null, 
	AdminLevel		int not null,
	Online			bit not null
);