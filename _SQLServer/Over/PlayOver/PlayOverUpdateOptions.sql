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
	PlayOverMemory	= @bitMemory, 
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
	where PlayOverUsers.PlayOverUserIndex = @intUserIndex;

	--//Adjust Personal list to match new preferences
	delete from PlayOverLists where PlayOverUserIndex = @intUserIndex and VideoGameIndex IN (
	select VideoGames.TargetIndex from VideoGames JOIN PlayOverUsers 
		ON (
			(
				(Genre = 'TwoDP'					and TwoDP = 1)			or 
				(Genre = 'ThreeDP'					and ThreeDP = 1)		or 
				(Genre = 'FPS'						and FPS = 1)			or 
				(Genre = 'FPP'						and FPP = 1)			or 
				(Genre = 'VPuzzle'					and VPuzzle = 1)		or 
				(Genre = 'Bulletstorm'				and Bulletstorm = 1)	or 
				(Genre = 'Fighting'					and Fighting = 1)		or 
				(Genre = 'Stealth'					and Stealth = 1)		or 
				(Genre = 'Survival'					and Survival = 1)		or 
				(Genre = 'VN'						and VN = 1)				or 
				(Genre = 'IM'						and IM = 1)				or 
				(Genre = 'RPG'						and RPG = 1)			or 
				(Genre = 'TRPG'						and TRPG = 1)			or 
				(Genre = 'ARPG'						and ARPG = 1)			or 
				(Genre = 'Sports'					and Sports = 1)			or 
				(Genre = 'Racing'					and Racing = 1)			or 
				(Genre = 'RTS'						and RTS = 1)			or 
				(Genre = 'TBS'						and TBS = 1)			or 
				(Genre = 'VE'						and VE = 1)				or 
				(Genre = 'MMO'						and MMO = 1)			or
				(Genre = 'MOBA'						and MOBA = 1)
			)
			and
			(
				(GamePlatform = 'PC'				and PC = 1)				or 
				(GamePlatform = 'Atari'				and Atari = 1)			or 
				(GamePlatform = 'Commodore64'		and Commodore64 = 1)	or 
				(GamePlatform = 'FAMICOM'			and FAMICOM = 1)		or 
				(GamePlatform = 'NES'				and NES = 1)			or 
				(GamePlatform = 'SNES'				and SNES = 1)			or 
				(GamePlatform = 'N64'				and N64 = 1)			or 
				(GamePlatform = 'Gamecube'			and Gamecube = 1)		or 
				(GamePlatform = 'Wii'				and Wii = 1)			or 
				(GamePlatform = 'WiiU'				and WiiU = 1)			or 
				(GamePlatform = 'NintendoSwitch'	and NintendoSwitch = 1)	or 
				(GamePlatform = 'Gameboy'			and Gameboy = 1)		or 
				(GamePlatform = 'VirtualBoy'		and VirtualBoy = 1)		or 
				(GamePlatform = 'GBA'				and GBA = 1)			or 
				(GamePlatform = 'DS'				and DS = 1)				or 
				(GamePlatform = 'ThreeDS'			and ThreeDS = 1)		or 
				(GamePlatform = 'SegaGenesis'		and SegaGenesis = 1)	or 
				(GamePlatform = 'SegaCD'			and SegaCD = 1)			or 
				(GamePlatform = 'SegaDreamcast'		and SegaDreamcast = 1)	or 
				(GamePlatform = 'PS1'				and PS1 = 1)			or
				(GamePlatform = 'PS2'				and PS2 = 1)			or
				(GamePlatform = 'PS3'				and PS3 = 1)			or
				(GamePlatform = 'PS4'				and PS4 = 1)			or
				(GamePlatform = 'PSP'				and PSP = 1)			or
				(GamePlatform = 'PSVita'			and PSVita = 1)			or
				(GamePlatform = 'Xbox'				and Xbox = 1)			or
				(GamePlatform = 'Xbox360'			and Xbox360 = 1)		or
				(GamePlatform = 'XboxOne'			and XboxOne = 1)		or
				(GamePlatform = 'Ouya'				and Ouya = 1)			or
				(GamePlatform = 'OculusRift'		and OculusRift = 1)		or
				(GamePlatform = 'Vive'				and Vive = 1)			or
				(GamePlatform = 'PSVR'				and PSVR = 1)
			)
		) 
		where PlayOverUsers.PlayOverUserIndex = @intUserIndex
	);

	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumOne from PlayOverLists where PlayOverUserIndex = @intUserIndex; 
	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumTwo from PlayOverLists where PlayOverUserIndex = @intUserIndex; 
	
	--//Unlock records adacent to removed records
		--//Unlock DownLock for OrderRank+1 < 1
		Update PlayOverLists set Downlock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum + 1 = #NumTwo.RowNum and 
			#NumTwo.OrderRank - #NumOne.OrderRank > 1
		);
		
		--//Unlock UpLock for OrderRank-1 < 1
		Update PlayOverLists set Uplock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum - 1 = #NumTwo.RowNum and 
			#NumOne.OrderRank - #NumTwo.OrderRank > 1
		);

	drop table #NumOne;
	drop table #NumTwo;
	
	--//Reorder rankings
	With cte As
	(
		SELECT *,
		ROW_NUMBER() OVER (ORDER BY OrderRank) AS RowNum
		FROM PlayOverLists where PlayOverUserIndex = @intUserIndex
	)
	UPDATE cte SET OrderRank=RowNum-1
END

