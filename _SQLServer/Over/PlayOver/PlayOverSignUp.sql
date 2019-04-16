--drop procedure PlayOverSignUp;

create PROCEDURE PlayOverSignUp
(
    @strUsername		varchar(max),
	@strEmail			varchar(max),
	@strPasscode		varchar(max),
	--Genres
	@bitTwoDP			bit, 
	@bitThreeDP			bit, 
	@bitFPS				bit, 
	@bitFPP				bit, 
	@bitVPuzzle			bit, 
	@bitBulletstorm		bit, 
	@bitFighting		bit, 
	@bitStealth			bit, 
	@bitSurvival		bit, 
	@bitVN				bit, 
	@bitIM				bit, 
	@bitRPG				bit, 
	@bitTRPG			bit, 
	@bitARPG			bit, 
	@bitSports			bit, 
	@bitRacing			bit, 
	@bitRTS				bit, 
	@bitTBS				bit, 
	@bitVE				bit, 
	@bitMMO				bit, 
	@bitMOBA			bit,
	--Platforms
	@bitPC				bit,
	@bitAtari			bit,
	@bitCommodore64		bit,
	@bitFAMICOM			bit,
	@bitNES				bit,
	@bitSNES			bit,
	@bitN64				bit,
	@bitGamecube		bit,
	@bitWii				bit,
	@bitWiiU			bit,
	@bitNintendoSwitch	bit,
	@bitGameboy			bit,
	@bitVirtualBoy		bit,
	@bitGBA				bit,
	@bitDS				bit,
	@bitThreeDS			bit,
	@bitSegaGenesis		bit,
	@bitSegaCD			bit,
	@bitSegaDreamcast	bit,
	@bitPS1				bit,
	@bitPS2				bit,
	@bitPS3				bit,
	@bitPS4				bit,
	@bitPSP				bit,
	@bitPSVita			bit,
	@bitXbox			bit,
	@bitXbox360			bit,
	@bitXboxOne			bit,
	@bitOuya			bit, 
	@bitOculusRift		bit, 
	@bitVive			bit, 
	@bitPSVR			bit
)
AS
BEGIN
	IF( (select count(*) from [HTKB].dbo.Users where Username = @strUsername) = 0)
	BEGIN
		INSERT INTO [HTKB].dbo.Users (
		HTKBAdminLevel, HTKBOnline, Username, Passcode, Email
		) 
		VALUES ( 
		0, 0, @strUsername, @strPasscode, @strEmail 
		);

		--subsequent user records created by triggers

		Update P SET
		--Genres
		TwoDP			= @bitTwoDP, 
		ThreeDP			= @bitThreeDP, 
		FPS				= @bitFPS, 
		FPP				= @bitFPP, 
		VPuzzle			= @bitVPuzzle, 
		Bulletstorm		= @bitBulletstorm, 
		Fighting		= @bitFighting, 
		Stealth			= @bitStealth, 
		Survival		= @bitSurvival, 
		VN				= @bitVN, 
		IM				= @bitIM, 
		RPG				= @bitRPG, 
		TRPG			= @bitTRPG, 
		ARPG			= @bitARPG, 
		Sports			= @bitSports,	
		Racing			= @bitRacing, 
		RTS				= @bitRTS, 
		TBS				= @bitTBS, 
		VE				= @bitVE, 
		MMO				= @bitMMO, 
		MOBA			= @bitMOBA, 
		--Platforms
		PC				= @bitPC, 
		Atari			= @bitAtari, 
		Commodore64		= @bitCommodore64, 
		FAMICOM			= @bitFAMICOM, 
		NES				= @bitNES, 
		SNES			= @bitSNES, 
		N64				= @bitN64, 
		Gamecube		= @bitGamecube, 
		Wii				= @bitWii, 
		WiiU			= @bitWiiU, 
		NintendoSwitch	= @bitNintendoSwitch, 
		Gameboy			= @bitGameboy, 
		VirtualBoy		= @bitVirtualBoy, 
		GBA				= @bitGBA, 
		DS				= @bitDS, 
		ThreeDS			= @bitThreeDS, 
		SegaGenesis		= @bitSegaGenesis, 
		SegaCD			= @bitSegaCD, 
		SegaDreamcast	= @bitSegaDreamcast, 
		PS1				= @bitPS1, 
		PS2				= @bitPS2, 
		PS3				= @bitPS3, 
		PS4				= @bitPS4, 
		PSP				= @bitPSP, 
		PSVita			= @bitPSVita, 
		Xbox			= @bitXbox, 
		Xbox360			= @bitXbox360, 
		XboxOne			= @bitXboxOne, 
		Ouya			= @bitOuya,
		OculusRift		= @bitOculusRift,
		Vive			= @bitVive,
		PSVR			= @bitPSVR

		FROM [Over].dbo.PlayOverUsers P
		JOIN [Over].dbo.Users O ON P.OverUserIndex = O.OverUserIndex
		JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
		WHERE H.Username = @strUsername;
	END
END