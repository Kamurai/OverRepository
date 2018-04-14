--drop procedure PlayOverSignUp;

create PROCEDURE PlayOverSignUp
(
    @strUsername varchar(max),
	@strEmail varchar(max),
	@strPasscode varchar(max),
	--Genres
	@bitTwoDP bit, 
	@bitThreeDP bit, 
	@bitFPS bit, 
	@bitFPP bit, 
	@bitVPuzzle bit, 
	@bitBulletstorm bit, 
	@bitFighting bit, 
	@bitStealth bit, 
	@bitSurvival bit, 
	@bitVN bit, 
	@bitIM bit, 
	@bitRPG bit, 
	@bitTRPG bit, 
	@bitARPG bit, 
	@bitSports bit, 
	@bitRacing bit, 
	@bitRTS bit, 
	@bitTBS bit, 
	@bitVE bit, 
	@bitMMO bit, 
	@bitMOBA bit,
	--Platforms
	@bitPC bit,
	@bitAtari bit,
	@bitCommodore64 bit,
	@bitFAMICOM bit,
	@bitNES bit,
	@bitSNES bit,
	@bitN64 bit,
	@bitGamecube bit,
	@bitWii bit,
	@bitWiiU bit,
	@bitNintendoSwitch bit,
	@bitGameboy bit,
	@bitVirtualBoy bit,
	@bitGBA bit,
	@bitDS bit,
	@bitThreeDS bit,
	@bitSegaGenesis bit,
	@bitSegaCD bit,
	@bitSegaDreamcast bit,
	@bitPS1 bit,
	@bitPS2 bit,
	@bitPS3 bit,
	@bitPS4 bit,
	@bitPSP bit,
	@bitPSVita bit,
	@bitXbox bit,
	@bitXbox360 bit,
	@bitXboxOne bit,
	@bitOuya bit, 
	@bitOculusRift bit, 
	@bitVive bit, 
	@bitPSVR bit
)
AS
BEGIN
	-- COLLATE SQL_Latin1_General_CP1_CS_AS

	IF( (select count(*) from Users where Username = @strUsername) = 0)
	BEGIN
		INSERT INTO Users (Username, Email, Passcode, AdminLevel)
		VALUES ( @strUsername, @strEmail, @strPasscode, 0 );
	END

	IF( (select count(*) from Users, PlayOverUsers where Username = @strUsername and Users.Indext = UserIndex) = 0)
	BEGIN
		DECLARE @TargetUserIndex int = (select Indext from Users where Username = @strUsername);

		INSERT INTO PlayOverUsers (UserIndex, LoggedOn, /*Genres*/ TwoDP, ThreeDP, FPS, FPP, VPuzzle, Bulletstorm, Fighting, Stealth, Survival, VN, IM, RPG, TRPG, ARPG, Sports, Racing, RTS, TBS, VE, MMO, MOBA, /*Platforms*/ PC, Atari, Commodore64, FAMICOM, NES, SNES, N64, Gamecube, Wii, WiiU, NintendoSwitch, Gameboy, VirtualBoy, GBA, DS, ThreeDS, SegaGenesis, SegaCD, SegaDreamcast, PS1, PS2, PS3, PS4, PSP, PSVita, Xbox, Xbox360, XboxOne, Ouya, OculusRift, Vive, PSVR)
		VALUES ( @TargetUserIndex, 0, 
		--Genres
		@bitTwoDP, 
		@bitThreeDP, 
		@bitFPS, 
		@bitFPP, 
		@bitVPuzzle, 
		@bitBulletstorm, 
		@bitFighting, 
		@bitStealth, 
		@bitSurvival, 
		@bitVN, 
		@bitIM, 
		@bitRPG, 
		@bitTRPG, 
		@bitARPG, 
		@bitSports,	
		@bitRacing, 
		@bitRTS, 
		@bitTBS, 
		@bitVE, 
		@bitMMO, 
		@bitMOBA, 
		--Platforms
		@bitPC, 
		@bitAtari, 
		@bitCommodore64, 
		@bitFAMICOM, 
		@bitNES, 
		@bitSNES, 
		@bitN64, 
		@bitGamecube, 
		@bitWii, 
		@bitWiiU, 
		@bitNintendoSwitch, 
		@bitGameboy, 
		@bitVirtualBoy, 
		@bitGBA, 
		@bitDS, 
		@bitThreeDS, 
		@bitSegaGenesis, 
		@bitSegaCD, 
		@bitSegaDreamcast, 
		@bitPS1, 
		@bitPS2, 
		@bitPS3, 
		@bitPS4, 
		@bitPSP, 
		@bitPSVita, 
		@bitXbox, 
		@bitXbox360, 
		@bitXboxOne, 
		@bitOuya,
		@bitOculusRift,
		@bitVive,
		@bitPSVR
		);
	END

END