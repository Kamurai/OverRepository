--drop table Users, BangOverUsers, BoardOverUsers, PlayOverUsers, ShowOverUsers, WatchOverUsers;

create table Users (Indext bigint IDENTITY(0,1) PRIMARY KEY, 
	Username varchar(max) not null, 
	Passcode varchar(max) not null, 
	Email varchar(max) not null, 
	AdminLevel int not null);

create table BangOverUsers (Indext bigint IDENTITY(0,1) PRIMARY KEY, 
	UserIndex bigint not null, 
	LoggedOn bit not null, 
	--Genders
	Women bit not null, 
	Men bit not null, 
	TransWomen bit not null, 
	TransMen bit not null);

create table BoardOverUsers (Indext bigint IDENTITY(0,1) PRIMARY KEY, 
	UserIndex bigint not null, 
	LoggedOn bit not null, 
	--Genres
	DeckBuilding bit not null, 
	FixedDeck bit not null, 
	ConstructedDeck bit not null, 
	Strategy bit not null, 
	War bit not null, 
	Economy bit not null, 
	TableauBuilding bit not null, 
	Coop bit not null, 
	Mystery bit not null, 
	SemiCoop bit not null, 
	PPRPG bit not null, 
	Bluffing bit not null, 
	Puzzle bit not null, 
	Dexterity bit not null, 
	Party bit not null);

create table PlayOverUsers (Indext bigint IDENTITY(0,1) PRIMARY KEY, 
	UserIndex bigint not null, 
	LoggedOn bit not null, 
	--Genres
	TwoDP bit not null, 
	ThreeDP bit not null, 
	FPS bit not null, 
	FPP bit not null, 
	VPuzzle bit not null, 
	Bulletstorm bit not null, 
	Fighting bit not null, 
	Stealth bit not null, 
	Survival bit not null, 
	VN bit not null, 
	IM bit not null, 
	RPG bit not null, 
	TRPG bit not null, 
	ARPG bit not null, 
	Sports bit not null, 
	Racing bit not null, 
	RTS bit not null, 
	TBS bit not null, 
	VE bit not null, 
	MMO bit not null, 
	MOBA bit not null,
	--Platforms
	PC bit not null,
	Atari bit not null,
	Commodore64 bit not null,
	FAMICOM bit not null,
	NES bit not null,
	SNES bit not null,
	N64 bit not null,
	Gamecube bit not null,
	Wii bit not null,
	WiiU bit not null,
	NintendoSwitch bit not null,
	Gameboy bit not null,
	VirtualBoy bit not null,
	GBA bit not null,
	DS bit not null,
	ThreeDS bit not null,
	SegaGenesis bit not null,
	SegaCD bit not null,
	SegaDreamcast bit not null,
	PS1 bit not null,
	PS2 bit not null,
	PS3 bit not null,
	PS4 bit not null,
	PSP bit not null,
	PSVita bit not null,
	Xbox bit not null,
	Xbox360 bit not null,
	XboxOne bit not null,
	Ouya bit not null,
	OculusRift bit not null,
	Vive bit not null,
	PSVR bit not null
	);

create table ShowOverUsers (Indext bigint IDENTITY(0,1) PRIMARY KEY, 
	UserIndex bigint not null, 
	LoggedOn bit not null, 
	--Genres
	ComedyS bit not null, 
	DramaS bit not null, 
	ActionS bit not null, 
	HorrorS bit not null, 
	ThrillerS bit not null, 
	MysteryS bit not null, 
	DocumentaryS bit not null, 
	--Settings
	ScienceFictionS bit not null, 
	FantasyS bit not null, 
	WesternS bit not null, 
	MartialArtsS bit not null, 
	ModernS bit not null, 
	HistoricS bit not null, 
	PrehistoricS bit not null, 
	ComicsS bit not null, 
	PeriodS bit not null, 
	);

create table WatchOverUsers (Indext bigint IDENTITY(0,1) PRIMARY KEY, 
	UserIndex bigint not null, 
	LoggedOn bit not null, 
	--Genres
	ComedyM bit not null, 
	DramaM bit not null, 
	ActionM bit not null, 
	HorrorM bit not null, 
	ThrillerM bit not null, 
	MysteryM bit not null, 
	DocumentaryM bit not null, 
	--Settings
	ScienceFictionM bit not null, 
	FantasyM bit not null, 
	WesternM bit not null, 
	MartialArtsM bit not null, 
	ModernM bit not null, 
	HistoricM bit not null, 
	PrehistoricM bit not null, 
	ComicsM bit not null, 
	PeriodM bit not null, 
	);


INSERT INTO Users (Username, Passcode, Email, AdminLevel) VALUES ('Kamurai', 'green20', 'KamuraiBlue25@gmail.com', 2);
INSERT INTO Users (Username, Passcode, Email, AdminLevel) VALUES ('Aethenis', 'green20', 'KamuraiBlue25@gmail.com', 1);
INSERT INTO Users (Username, Passcode, Email, AdminLevel) VALUES ('Stevens', 'green20', 'KamuraiBlue25@gmail.com', 0);
INSERT INTO Users (Username, Passcode, Email, AdminLevel) VALUES ('JBaker', 'green20', 'JonathanLBaker@hotmail.com', 0);
INSERT INTO Users (Username, Passcode, Email, AdminLevel) VALUES ('MBaker', 'green20', 'JonathanLBaker@hotmail.com', 0);

--Kamurai
INSERT INTO BangOverUsers (UserIndex, LoggedOn, Women, Men, TransWomen, TransMen)
VALUES (0, 0, 
--Genders
1, 0, 1, 0);
INSERT INTO BoardOverUsers (UserIndex, LoggedOn, DeckBuilding, FixedDeck, ConstructedDeck, Strategy, War, Economy, TableauBuilding, Coop, Mystery, SemiCoop, PPRPG, Bluffing, Puzzle, Dexterity, Party)
VALUES (0, 0, 
--Genres
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1
	);
INSERT INTO PlayOverUsers (UserIndex, LoggedOn, /*Genres*/ TwoDP, ThreeDP, FPS, FPP, VPuzzle, Bulletstorm, Fighting, Stealth, Survival, VN, IM, RPG, TRPG, ARPG, Sports, Racing, RTS, TBS, VE, MMO, MOBA, /*Platforms*/ PC, Atari, Commodore64, FAMICOM, NES, SNES, N64, Gamecube, Wii, WiiU, NintendoSwitch, Gameboy, VirtualBoy, GBA, DS, ThreeDS, SegaGenesis, SegaCD, SegaDreamcast, PS1, PS2, PS3, PS4, PSP, PSVita, Xbox, Xbox360, XboxOne, Ouya, OculusRift, Vive, PSVR)
VALUES (0, 0,
	--Genres
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	--Platforms
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1,
	1,
	1,
	1
);
INSERT INTO ShowOverUsers (UserIndex, LoggedOn, /*Genres*/ ComedyS, DramaS, ActionS, HorrorS, ThrillerS, MysteryS, DocumentaryS,  /*Settings*/ ScienceFictionS, FantasyS, WesternS, MartialArtsS, /*Settings*/ ModernS, HistoricS, PrehistoricS, ComicsS, PeriodS)
VALUES (0, 0, 
	--Genres
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	--Settings
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1
);
INSERT INTO WatchOverUsers (UserIndex, LoggedOn, /*Genres*/ ComedyM, DramaM, ActionM, HorrorM, ThrillerM, MysteryM, DocumentaryM, /*Settings*/ ScienceFictionM, FantasyM, WesternM, MartialArtsM, ModernM, HistoricM, PrehistoricM, ComicsM, PeriodM) 
VALUES (0, 0, 
	--Genres
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	--Settings
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1, 
	1
);


--Aethenis
INSERT INTO BangOverUsers (UserIndex, LoggedOn, /*Genders*/ Women, Men, TransWomen, TransMen)
VALUES (1, 0, /*Genders*/ 1, 0, 1, 0);
INSERT INTO BoardOverUsers (UserIndex, LoggedOn, /*Genres*/ DeckBuilding, FixedDeck, ConstructedDeck, Strategy, War, Economy, TableauBuilding, Coop, Mystery, SemiCoop, PPRPG, Bluffing, Puzzle, Dexterity, Party)
VALUES (1, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO PlayOverUsers (UserIndex, LoggedOn, /*Genres*/ TwoDP, ThreeDP, FPS, FPP, VPuzzle, Bulletstorm, Fighting, Stealth, Survival, VN, IM, RPG, TRPG, ARPG, Sports, Racing, RTS, TBS, VE, MMO, MOBA, /*Platforms*/ PC, Atari, Commodore64, FAMICOM, NES, SNES, N64, Gamecube, Wii, WiiU, NintendoSwitch, Gameboy, VirtualBoy, GBA, DS, ThreeDS, SegaGenesis, SegaCD, SegaDreamcast, PS1, PS2, PS3, PS4, PSP, PSVita, Xbox, Xbox360, XboxOne, Ouya, OculusRift, Vive, PSVR )
VALUES (1, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, /*Platforms*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 );
INSERT INTO ShowOverUsers (UserIndex, LoggedOn, /*Genres*/ ComedyS, DramaS, ActionS, HorrorS, ThrillerS, MysteryS, DocumentaryS,  /*Settings*/ ScienceFictionS, FantasyS, WesternS, MartialArtsS, ModernS, HistoricS, PrehistoricS, ComicsS, PeriodS)
VALUES (1, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, /*Settings*/ 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO WatchOverUsers (UserIndex, LoggedOn, /*Genres*/ ComedyM, DramaM, ActionM, HorrorM, ThrillerM, MysteryM, DocumentaryM, /*Settings*/ ScienceFictionM, FantasyM, WesternM, MartialArtsM, ModernM, HistoricM, PrehistoricM, ComicsM, PeriodM) 
VALUES (1, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, /*Settings*/ 1, 1, 1, 1, 1, 1, 1, 1, 1);

--Stevens
INSERT INTO BangOverUsers (UserIndex, LoggedOn, /*Genders*/ Women, Men, TransWomen, TransMen)
VALUES (2, 0, /*Genders*/ 1, 0, 0, 0);
INSERT INTO BoardOverUsers (UserIndex, LoggedOn, /*Genres*/ DeckBuilding, FixedDeck, ConstructedDeck, Strategy, War, Economy, TableauBuilding, Coop, Mystery, SemiCoop, PPRPG, Bluffing, Puzzle, Dexterity, Party)
VALUES (2, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO PlayOverUsers (UserIndex, LoggedOn, /*Genres*/ TwoDP, ThreeDP, FPS, FPP, VPuzzle, Bulletstorm, Fighting, Stealth, Survival, VN, IM, RPG, TRPG, ARPG, Sports, Racing, RTS, TBS, VE, MMO, MOBA, /*Platforms*/ PC, Atari, Commodore64, FAMICOM, NES, SNES, N64, Gamecube, Wii, WiiU, NintendoSwitch, Gameboy, VirtualBoy, GBA, DS, ThreeDS, SegaGenesis, SegaCD, SegaDreamcast, PS1, PS2, PS3, PS4, PSP, PSVita, Xbox, Xbox360, XboxOne, Ouya, OculusRift, Vive, PSVR )
VALUES (2, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, /*Platforms*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 );
INSERT INTO ShowOverUsers (UserIndex, LoggedOn, /*Genres*/ ComedyS, DramaS, ActionS, HorrorS, ThrillerS, MysteryS, DocumentaryS,  /*Settings*/ ScienceFictionS, FantasyS, WesternS, MartialArtsS, ModernS, HistoricS, PrehistoricS, ComicsS, PeriodS)
VALUES (2, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, /*Settings*/ 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO WatchOverUsers (UserIndex, LoggedOn, /*Genres*/ ComedyM, DramaM, ActionM, HorrorM, ThrillerM, MysteryM, DocumentaryM, /*Settings*/ ScienceFictionM, FantasyM, WesternM, MartialArtsM, ModernM, HistoricM, PrehistoricM, ComicsM, PeriodM) 
VALUES (2, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, /*Settings*/ 1, 1, 1, 1, 1, 1, 1, 1, 1);

--JBaker
INSERT INTO BangOverUsers (UserIndex, LoggedOn, /*Genders*/ Women, Men, TransWomen, TransMen)
VALUES (3, 0, /*Genders*/ 1, 0, 0, 0);
INSERT INTO BoardOverUsers (UserIndex, LoggedOn, /*Genres*/ DeckBuilding, FixedDeck, ConstructedDeck, Strategy, War, Economy, TableauBuilding, Coop, Mystery, SemiCoop, PPRPG, Bluffing, Puzzle, Dexterity, Party)
VALUES (3, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO PlayOverUsers (UserIndex, LoggedOn, /*Genres*/ TwoDP, ThreeDP, FPS, FPP, VPuzzle, Bulletstorm, Fighting, Stealth, Survival, VN, IM, RPG, TRPG, ARPG, Sports, Racing, RTS, TBS, VE, MMO, MOBA, /*Platforms*/ PC, Atari, Commodore64, FAMICOM, NES, SNES, N64, Gamecube, Wii, WiiU, NintendoSwitch, Gameboy, VirtualBoy, GBA, DS, ThreeDS, SegaGenesis, SegaCD, SegaDreamcast, PS1, PS2, PS3, PS4, PSP, PSVita, Xbox, Xbox360, XboxOne, Ouya, OculusRift, Vive, PSVR )
VALUES (3, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, /*Platforms*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 );
INSERT INTO ShowOverUsers (UserIndex, LoggedOn, /*Genres*/ ComedyS, DramaS, ActionS, HorrorS, ThrillerS, MysteryS, DocumentaryS,  /*Settings*/ ScienceFictionS, FantasyS, WesternS, MartialArtsS, ModernS, HistoricS, PrehistoricS, ComicsS, PeriodS)
VALUES (3, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, /*Settings*/ 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO WatchOverUsers (UserIndex, LoggedOn, /*Genres*/ ComedyM, DramaM, ActionM, HorrorM, ThrillerM, MysteryM, DocumentaryM, /*Settings*/ ScienceFictionM, FantasyM, WesternM, MartialArtsM, ModernM, HistoricM, PrehistoricM, ComicsM, PeriodM) 
VALUES (3, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, /*Settings*/ 1, 1, 1, 1, 1, 1, 1, 1, 1);

--MBaker
INSERT INTO BangOverUsers (UserIndex, LoggedOn, /*Genders*/ Women, Men, TransWomen, TransMen)
VALUES (4, 0, /*Genders*/ 0, 1, 0, 0);
INSERT INTO BoardOverUsers (UserIndex, LoggedOn, /*Genres*/ DeckBuilding, FixedDeck, ConstructedDeck, Strategy, War, Economy, TableauBuilding, Coop, Mystery, SemiCoop, PPRPG, Bluffing, Puzzle, Dexterity, Party)
VALUES (4, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO PlayOverUsers (UserIndex, LoggedOn, /*Genres*/ TwoDP, ThreeDP, FPS, FPP, VPuzzle, Bulletstorm, Fighting, Stealth, Survival, VN, IM, RPG, TRPG, ARPG, Sports, Racing, RTS, TBS, VE, MMO, MOBA, /*Platforms*/ PC, Atari, Commodore64, FAMICOM, NES, SNES, N64, Gamecube, Wii, WiiU, NintendoSwitch, Gameboy, VirtualBoy, GBA, DS, ThreeDS, SegaGenesis, SegaCD, SegaDreamcast, PS1, PS2, PS3, PS4, PSP, PSVita, Xbox, Xbox360, XboxOne, Ouya, OculusRift, Vive, PSVR )
VALUES (4, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, /*Platforms*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 );
INSERT INTO ShowOverUsers (UserIndex, LoggedOn, /*Genres*/ ComedyS, DramaS, ActionS, HorrorS, ThrillerS, MysteryS, DocumentaryS,  /*Settings*/ ScienceFictionS, FantasyS, WesternS, MartialArtsS, ModernS, HistoricS, PrehistoricS, ComicsS, PeriodS)
VALUES (4, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, /*Settings*/ 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO WatchOverUsers (UserIndex, LoggedOn, /*Genres*/ ComedyM, DramaM, ActionM, HorrorM, ThrillerM, MysteryM, DocumentaryM, /*Settings*/ ScienceFictionM, FantasyM, WesternM, MartialArtsM, ModernM, HistoricM, PrehistoricM, ComicsM, PeriodM) 
VALUES (4, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, /*Settings*/ 1, 1, 1, 1, 1, 1, 1, 1, 1);

