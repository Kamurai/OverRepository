--DROP TRIGGER AfterNewOverUser

CREATE TRIGGER AfterNewOverUser
ON [Over].dbo.Users
AFTER Insert
AS
	--BangOver
	INSERT INTO [Over].dbo.BangOverUsers(
	OverUserIndex, AdminLevel, Online, Memory,
	/*Genders*/ Women, Men, TransWomen, TransMen
	) 
	VALUES (
	(SELECT TOP 1 inserted.UserIndex FROM inserted), (SELECT TOP 1 inserted.AdminLevel  FROM inserted), 0, 1, 
	/*Genders*/ 1, 0, 0, 0);
	--BoardOver
	INSERT INTO [Over].dbo.BoardOverUsers(
	OverUserIndex, AdminLevel, Online, Memory,
	/*Genres*/ DeckBuilding, FixedDeck, ConstructedDeck, Strategy, War, Economy, TableauBuilding, Coop, Mystery, SemiCoop, PPRPG, Bluffing, Puzzle, Dexterity, Party
	) 
	VALUES (
	(SELECT TOP 1 inserted.UserIndex FROM inserted), (SELECT TOP 1 inserted.AdminLevel  FROM inserted), 0, 1, 
	/*Genres*/ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	--PlayOver
	INSERT INTO [Over].dbo.PlayOverUsers(
	OverUserIndex, AdminLevel, Online, Memory,
	/*Genres*/ TwoDP, ThreeDP, FPS, FPP, VPuzzle, Bulletstorm, Fighting, Stealth, Survival, VN, IM, RPG, TRPG, ARPG, Sports, Racing, RTS, TBS, VE, MMO, MOBA, 
	/*Platforms*/ PC, Atari, Commodore64, FAMICOM, NES, SNES, N64, Gamecube, Wii, WiiU, NintendoSwitch, Gameboy, VirtualBoy, GBA, DS, ThreeDS, SegaGenesis, SegaCD, SegaDreamcast, PS1, PS2, PS3, PS4, PSP, PSVita, Xbox, Xbox360, XboxOne, Ouya, OculusRift, Vive, PSVR
	) 
	VALUES (
	(SELECT TOP 1 inserted.UserIndex FROM inserted), (SELECT TOP 1 inserted.AdminLevel  FROM inserted), 0, 1, 
	/*Genres*/ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
	/*Platforms*/ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	--ShowOver
	INSERT INTO [Over].dbo.ShowOverUsers(
	OverUserIndex, AdminLevel, Online, Memory,
	/*Genres*/ Comedy, Drama, Action, Horror, Thriller, Mystery, Documentary,  
	/*Settings*/ ScienceFiction, Fantasy, Western, MartialArts, Modern, Historic, Prehistoric, Comics, Period
	) 
	VALUES (
	(SELECT TOP 1 inserted.UserIndex FROM inserted), (SELECT TOP 1 inserted.AdminLevel  FROM inserted), 0, 1, 
	/*Genres*/ 1, 0, 0, 0, 0, 0, 0, 
	/*Settings*/ 1, 0, 0, 0, 0, 0, 0, 0, 0);
	--WatchOver
	INSERT INTO [Over].dbo.WatchOverUsers(
	OverUserIndex, AdminLevel, Online, Memory,
	/*Genres*/ Comedy, Drama, Action, Horror, Thriller, Mystery, Documentary, 
	/*Settings*/ ScienceFiction, Fantasy, Western, MartialArts, Modern, Historic, Prehistoric, Comics, Period
	) 
	VALUES (
	(SELECT TOP 1 inserted.UserIndex FROM inserted), (SELECT TOP 1 inserted.AdminLevel  FROM inserted), 0, 1, 
	/*Genres*/ 1, 0, 0, 0, 0, 0, 0, 
	/*Settings*/ 1, 0, 0, 0, 0, 0, 0, 0, 0);
GO