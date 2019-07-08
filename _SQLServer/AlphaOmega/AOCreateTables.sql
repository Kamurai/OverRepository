--drop table [HTKB].dbo.Users, [Over].dbo.Users, [Over].dbo.BangOverUsers, [Over].dbo.BoardOverUsers, [Over].dbo.PlayOverUsers, [Over].dbo.ShowOverUsers, [Over].dbo.WatchOverUsers, [BubbleUp].dbo.Users, [BubbleUp].dbo.Boxes, [BubbleUp].dbo.Targets, [Shout].dbo.Users, [Mist].dbo.Users;


create table [HTKB].dbo.Users (
	HTKBUserIndex	bigint IDENTITY(0,1) PRIMARY KEY, 
	HTKBAdminLevel	int not null,
	HTKBOnline		bit not null, 
	Username		varchar(max) not null, 
	Passcode		varchar(max) not null, 
	Email			varchar(max) not null
);

create table [Over].dbo.Users (
	OverUserIndex	bigint IDENTITY(0,1) PRIMARY KEY, 
	HTKBUserIndex	bigint not null, 
	OverAdminLevel	int not null,
	OverOnline		bit not null
);

create table [Over].dbo.BangOverUsers (
	BangOverUserIndex	bigint IDENTITY(0,1) PRIMARY KEY, 
	OverUserIndex		bigint not null, 
	BangOverAdminLevel	int not null,
	BangOverOnline		bit not null, 
	--Genders
	Women				bit not null, 
	Men					bit not null, 
	TransWomen			bit not null, 
	TransMen			bit not null
);

create table [Over].dbo.BoardOverUsers (
	BoardOverUserIndex	bigint IDENTITY(0,1) PRIMARY KEY, 
	OverUserIndex		bigint not null, 
	BoardOverAdminLevel	int not null,
	BoardOverOnline		bit not null, 
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
	PlayOverUserIndex	bigint IDENTITY(0,1) PRIMARY KEY, 
	OverUserIndex		bigint not null, 
	PlayOverAdminLevel	int not null,
	PlayOverOnline		bit not null, 
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
	ShowOverUserIndex	bigint IDENTITY(0,1) PRIMARY KEY, 
	OverUserIndex		bigint not null, 
	ShowOverAdminLevel	int not null,
	ShowOverOnline		bit not null, 
	--Genres
	ComedyS				bit not null, 
	DramaS				bit not null, 
	ActionS				bit not null, 
	HorrorS				bit not null, 
	ThrillerS			bit not null, 
	MysteryS			bit not null, 
	DocumentaryS		bit not null, 
	--Settings
	ScienceFictionS		bit not null, 
	FantasyS			bit not null, 
	WesternS			bit not null, 
	MartialArtsS		bit not null, 
	ModernS				bit not null, 
	HistoricS			bit not null, 
	PrehistoricS		bit not null, 
	ComicsS				bit not null, 
	PeriodS				bit not null
);

create table [Over].dbo.WatchOverUsers (
	WatchOverUserIndex	bigint IDENTITY(0,1) PRIMARY KEY, 
	OverUserIndex		bigint not null, 
	WatchOverAdminLevel	int not null,
	WatchOverOnline		bit not null, 
	--Genres
	ComedyM				bit not null, 
	DramaM				bit not null, 
	ActionM				bit not null, 
	HorrorM				bit not null, 
	ThrillerM			bit not null, 
	MysteryM			bit not null, 
	DocumentaryM		bit not null, 
	--Settings
	ScienceFictionM		bit not null, 
	FantasyM			bit not null, 
	WesternM			bit not null, 
	MartialArtsM		bit not null, 
	ModernM				bit not null, 
	HistoricM			bit not null, 
	PrehistoricM		bit not null, 
	ComicsM				bit not null, 
	PeriodM				bit not null
);

create table [BubbleUp].dbo.Users (
	BubbleUpUserIndex	bigint IDENTITY(0,1) PRIMARY KEY, 
	HTKBUserIndex		bigint not null, 
	BubbleUpAdminLevel	int not null,
	BubbleUpOnline		bit not null
);

create table [BubbleUp].dbo.Adverts (
	AdvertIndex bigint IDENTITY(0,1) PRIMARY KEY, 
	Name varchar(50) not null, 
	Picture varchar(50) not null, 
	Link varchar(50) not null 
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
	BubbleUpUserIndex	bigint not null, 
	Direction			varchar(max) NOT NULL CHECK (Direction IN('Horizontal', 'Vertical')),
	Label				varchar(max),
	ParentBoxIndex		bigint not null,
	OrderRank			int not null
);

create table [BubbleUp].dbo.Targets (
	TargetIndex			bigint IDENTITY(0,1) PRIMARY KEY, 
	BubbleUpUserIndex	bigint not null, 
	Label				varchar(max),
	ParentBoxIndex		bigint not null,
	OrderRank			int not null
);

create table [Shout].dbo.Users (
	ShoutUserIndex	bigint IDENTITY(0,1) PRIMARY KEY, 
	HTKBUserIndex	bigint not null, 
	ShoutAdminLevel	int not null,
	ShoutOnline		bit not null
);

create table [Mist].dbo.Users (
	MistUserIndex	bigint IDENTITY(0,1) PRIMARY KEY, 
	HTKBUserIndex	bigint not null, 
	MistAdminLevel	int not null,
	MistOnline		bit not null
);