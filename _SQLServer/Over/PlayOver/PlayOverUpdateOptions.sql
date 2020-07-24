--drop procedure PlayOverUpdateOptions;

create PROCEDURE PlayOverUpdateOptions(
    @intUserIndex		int,
	@bitMemory			bit,
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
	--//Update preferences to match check boxes (local variables)
	update PlayOverUsers set 
	Memory			= @bitMemory, 
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
	where UserIndex = @intUserIndex;

	--//Adjust Personal list to match new preferences
	delete from PlayOverLists where UserIndex = @intUserIndex and TargetIndex IN (
	select T.TargetIndex from VideoGames T JOIN PlayOverUsers U
		ON (
			(
				(T.Genre = 'TwoDP'					and U.TwoDP = 1)			or 
				(T.Genre = 'ThreeDP'				and U.ThreeDP = 1)			or 
				(T.Genre = 'FPS'					and U.FPS = 1)				or 
				(T.Genre = 'FPP'					and U.FPP = 1)				or 
				(T.Genre = 'VPuzzle'				and U.VPuzzle = 1)			or 
				(T.Genre = 'Bulletstorm'			and U.Bulletstorm = 1)		or 
				(T.Genre = 'Fighting'				and U.Fighting = 1)			or 
				(T.Genre = 'Stealth'				and U.Stealth = 1)			or 
				(T.Genre = 'Survival'				and U.Survival = 1)			or 
				(T.Genre = 'VN'						and U.VN = 1)				or 
				(T.Genre = 'IM'						and U.IM = 1)				or 
				(T.Genre = 'RPG'					and U.RPG = 1)				or 
				(T.Genre = 'TRPG'					and U.TRPG = 1)				or 
				(T.Genre = 'ARPG'					and U.ARPG = 1)				or 
				(T.Genre = 'Sports'					and U.Sports = 1)			or 
				(T.Genre = 'Racing'					and U.Racing = 1)			or 
				(T.Genre = 'RTS'					and U.RTS = 1)				or 
				(T.Genre = 'TBS'					and U.TBS = 1)				or 
				(T.Genre = 'VE'						and U.VE = 1)				or 
				(T.Genre = 'MMO'					and U.MMO = 1)				or
				(T.Genre = 'MOBA'					and U.MOBA = 1)
			)
			and
			(
				(T.GamePlatform = 'PC'				and U.PC = 1)				or 
				(T.GamePlatform = 'Atari'			and U.Atari = 1)			or 
				(T.GamePlatform = 'Commodore64'		and U.Commodore64 = 1)		or 
				(T.GamePlatform = 'FAMICOM'			and U.FAMICOM = 1)			or 
				(T.GamePlatform = 'NES'				and U.NES = 1)				or 
				(T.GamePlatform = 'SNES'			and U.SNES = 1)				or 
				(T.GamePlatform = 'N64'				and U.N64 = 1)				or 
				(T.GamePlatform = 'Gamecube'		and U.Gamecube = 1)			or 
				(T.GamePlatform = 'Wii'				and U.Wii = 1)				or 
				(T.GamePlatform = 'WiiU'			and U.WiiU = 1)				or 
				(T.GamePlatform = 'NintendoSwitch'	and U.NintendoSwitch = 1)	or 
				(T.GamePlatform = 'Gameboy'			and U.Gameboy = 1)			or 
				(T.GamePlatform = 'VirtualBoy'		and U.VirtualBoy = 1)		or 
				(T.GamePlatform = 'GBA'				and U.GBA = 1)				or 
				(T.GamePlatform = 'DS'				and U.DS = 1)				or 
				(T.GamePlatform = 'ThreeDS'			and U.ThreeDS = 1)			or 
				(T.GamePlatform = 'SegaGenesis'		and U.SegaGenesis = 1)		or 
				(T.GamePlatform = 'SegaCD'			and U.SegaCD = 1)			or 
				(T.GamePlatform = 'SegaDreamcast'	and U.SegaDreamcast = 1)	or 
				(T.GamePlatform = 'PS1'				and U.PS1 = 1)				or
				(T.GamePlatform = 'PS2'				and U.PS2 = 1)				or
				(T.GamePlatform = 'PS3'				and U.PS3 = 1)				or
				(T.GamePlatform = 'PS4'				and U.PS4 = 1)				or
				(T.GamePlatform = 'PSP'				and U.PSP = 1)				or
				(T.GamePlatform = 'PSVita'			and U.PSVita = 1)			or
				(T.GamePlatform = 'Xbox'			and U.Xbox = 1)				or
				(T.GamePlatform = 'Xbox360'			and U.Xbox360 = 1)			or
				(T.GamePlatform = 'XboxOne'			and U.XboxOne = 1)			or
				(T.GamePlatform = 'Ouya'			and U.Ouya = 1)				or
				(T.GamePlatform = 'OculusRift'		and U.OculusRift = 1)		or
				(T.GamePlatform = 'Vive'			and U.Vive = 1)				or
				(T.GamePlatform = 'PSVR'			and U.PSVR = 1)
			)
		) 
		where U.UserIndex = @intUserIndex
	);

	select *, ROW_NUMBER() Over(order by L.Rank) as RowNum INTO #NumOne from PlayOverLists L where L.UserIndex = @intUserIndex; 
	select *, ROW_NUMBER() Over(order by L.Rank) as RowNum INTO #NumTwo from PlayOverLists L where L.UserIndex = @intUserIndex; 
	
	--//Unlock records adacent to removed records
		--//Unlock L.DownLock for L.Rank+1 < 1
		Update PlayOverLists set DownLock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum + 1 = #NumTwo.RowNum and 
			#NumTwo.Rank - #NumOne.Rank > 1
		);
		
		--//Unlock L.UpLock for L.Rank-1 < 1
		Update PlayOverLists set UpLock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum - 1 = #NumTwo.RowNum and 
			#NumOne.Rank - #NumTwo.Rank > 1
		);

	drop table #NumOne;
	drop table #NumTwo;
	
	--//Reorder L.Rankings
	With cte As
	(
		SELECT *,
		ROW_NUMBER() OVER (ORDER BY Rank) AS RowNum
		FROM PlayOverLists where UserIndex = @intUserIndex
	)
	UPDATE cte SET Rank=RowNum-1
END

