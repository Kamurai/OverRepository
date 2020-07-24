--drop procedure PlayOverSignUp;

create PROCEDURE PlayOverSignUp(
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
		AdminLevel, Online, Username, Passcode, Email
		) 
		VALUES ( 
		0, 0, @strUsername, @strPasscode, @strEmail 
		);

		--subsequent user records created by triggers

		Update U SET
		--Genres
		U.TwoDP				= @bitTwoDP, 
		U.ThreeDP			= @bitThreeDP, 
		U.FPS				= @bitFPS, 
		U.FPP				= @bitFPP, 
		U.VPuzzle			= @bitVPuzzle, 
		U.Bulletstorm		= @bitBulletstorm, 
		U.Fighting			= @bitFighting, 
		U.Stealth			= @bitStealth, 
		U.Survival			= @bitSurvival, 
		U.VN				= @bitVN, 
		U.IM				= @bitIM, 
		U.RPG				= @bitRPG, 
		U.TRPG				= @bitTRPG, 
		U.ARPG				= @bitARPG, 
		U.Sports			= @bitSports,	
		U.Racing			= @bitRacing, 
		U.RTS				= @bitRTS, 
		U.TBS				= @bitTBS, 
		U.VE				= @bitVE, 
		U.MMO				= @bitMMO, 
		U.MOBA				= @bitMOBA, 
		--Platforms
		U.PC				= @bitPC, 
		U.Atari				= @bitAtari, 
		U.Commodore64		= @bitCommodore64, 
		U.FAMICOM			= @bitFAMICOM, 
		U.NES				= @bitNES, 
		U.SNES				= @bitSNES, 
		U.N64				= @bitN64, 
		U.Gamecube			= @bitGamecube, 
		U.Wii				= @bitWii, 
		U.WiiU				= @bitWiiU, 
		U.NintendoSwitch	= @bitNintendoSwitch, 
		U.Gameboy			= @bitGameboy, 
		U.VirtualBoy		= @bitVirtualBoy, 
		U.GBA				= @bitGBA, 
		U.DS				= @bitDS, 
		U.ThreeDS			= @bitThreeDS, 
		U.SegaGenesis		= @bitSegaGenesis, 
		U.SegaCD			= @bitSegaCD, 
		U.SegaDreamcast		= @bitSegaDreamcast, 
		U.PS1				= @bitPS1, 
		U.PS2				= @bitPS2, 
		U.PS3				= @bitPS3, 
		U.PS4				= @bitPS4, 
		U.PSP				= @bitPSP, 
		U.PSVita			= @bitPSVita, 
		U.Xbox				= @bitXbox, 
		U.Xbox360			= @bitXbox360, 
		U.XboxOne			= @bitXboxOne, 
		U.Ouya				= @bitOuya,
		U.OculusRift		= @bitOculusRift,
		U.Vive				= @bitVive,
		U.PSVR				= @bitPSVR

		FROM [Over].dbo.PlayOverUsers U
		JOIN [Over].dbo.Users O ON U.OverUserIndex = O.UserIndex
		JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
		WHERE H.Username = @strUsername;
	END
END