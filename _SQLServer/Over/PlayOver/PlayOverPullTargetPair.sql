--drop PROCEDURE PlayOverPullTargetPair;

create PROCEDURE PlayOverPullTargetPair
(
    @intUserIndex int        
)
AS
BEGIN
	DECLARE @UserCount int = 0;
	DECLARE @OrderCount int = 0;
	DECLARE @GlobalExclusionCount int = 0;
	DECLARE @TargetIndex int = 0;
	DECLARE @SavedOrder int = 0;

	--//request count of records related to user
	SET @UserCount = (select count(PlayOverUserIndex) from PlayOverLists where PlayOverUserIndex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked VideoGames from personal list
			--//adjust OrderCount to exclude (1's uplock and count's downlock only available)
		SET @OrderCount = (
		select count(ListIndex) from PlayOverLists where PlayOverUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
		and not ( OrderRank = 0 and UpLock = 0 and DownLock = 1 ) and not (OrderRank = (@UserCount-1) and UpLock = 1 and DownLock = 0)
		);
		SET @GlobalExclusionCount = (select count(VideoGames.TargetIndex) from VideoGames
			JOIN PlayOverUsers ON
			(
				(
					(VideoGames.Genre = 'TwoDP'				and PlayOverUsers.TwoDP = 1)		or 
					(VideoGames.Genre = 'ThreeDP'			and PlayOverUsers.ThreeDP = 1)		or 
					(VideoGames.Genre = 'FPS'				and PlayOverUsers.FPS = 1)			or 
					(VideoGames.Genre = 'FPP'				and PlayOverUsers.FPP = 1)			or 
					(VideoGames.Genre = 'VPuzzle'			and PlayOverUsers.VPuzzle = 1)		or 
					(VideoGames.Genre = 'Bulletstorm'		and PlayOverUsers.Bulletstorm = 1)	or 
					(VideoGames.Genre = 'Fighting'			and PlayOverUsers.Fighting = 1)		or 
					(VideoGames.Genre = 'Stealth'			and PlayOverUsers.Stealth = 1)		or 
					(VideoGames.Genre = 'Survival'			and PlayOverUsers.Survival = 1)		or 
					(VideoGames.Genre = 'VN'				and PlayOverUsers.VN = 1)			or 
					(VideoGames.Genre = 'IM'				and PlayOverUsers.IM = 1)			or 
					(VideoGames.Genre = 'RPG'				and PlayOverUsers.RPG = 1)			or 
					(VideoGames.Genre = 'TRPG'				and PlayOverUsers.TRPG = 1)			or 
					(VideoGames.Genre = 'ARPG'				and PlayOverUsers.ARPG = 1)			or 
					(VideoGames.Genre = 'Sports'			and PlayOverUsers.Sports = 1)		or 
					(VideoGames.Genre = 'Racing'			and PlayOverUsers.Racing = 1)		or 
					(VideoGames.Genre = 'RTS'				and PlayOverUsers.RTS = 1)			or 
					(VideoGames.Genre = 'TBS'				and PlayOverUsers.TBS = 1)			or 
					(VideoGames.Genre = 'VE'				and PlayOverUsers.VE = 1)			or 
					(VideoGames.Genre = 'MMO'				and PlayOverUsers.MMO = 1)			or
					(VideoGames.Genre = 'MOBA'				and PlayOverUsers.MOBA = 1)
				)
				and
				(
					(VideoGames.GamePlatform = 'PC'				and PlayOverUsers.PC = 1)				or 
					(VideoGames.GamePlatform = 'Atari'			and PlayOverUsers.Atari = 1)			or 
					(VideoGames.GamePlatform = 'Commodore64'	and PlayOverUsers.Commodore64 = 1)		or 
					(VideoGames.GamePlatform = 'FAMICOM'		and PlayOverUsers.FAMICOM = 1)			or 
					(VideoGames.GamePlatform = 'NES'			and PlayOverUsers.NES = 1)				or 
					(VideoGames.GamePlatform = 'SNES'			and PlayOverUsers.SNES = 1)				or 
					(VideoGames.GamePlatform = 'N64'			and PlayOverUsers.N64 = 1)				or 
					(VideoGames.GamePlatform = 'Gamecube'		and PlayOverUsers.Gamecube = 1)			or 
					(VideoGames.GamePlatform = 'Wii'			and PlayOverUsers.Wii = 1)				or 
					(VideoGames.GamePlatform = 'WiiU'			and PlayOverUsers.WiiU = 1)				or 
					(VideoGames.GamePlatform = 'NintendoSwitch'	and PlayOverUsers.NintendoSwitch = 1)	or 
					(VideoGames.GamePlatform = 'Gameboy'		and PlayOverUsers.Gameboy = 1)			or 
					(VideoGames.GamePlatform = 'VirtualBoy'		and PlayOverUsers.VirtualBoy = 1)		or 
					(VideoGames.GamePlatform = 'GBA'			and PlayOverUsers.GBA = 1)				or 
					(VideoGames.GamePlatform = 'DS'				and PlayOverUsers.DS = 1)				or 
					(VideoGames.GamePlatform = 'ThreeDS'		and PlayOverUsers.ThreeDS = 1)			or 
					(VideoGames.GamePlatform = 'SegaGenesis'	and PlayOverUsers.SegaGenesis = 1)		or 
					(VideoGames.GamePlatform = 'SegaCD'			and PlayOverUsers.SegaCD = 1)			or 
					(VideoGames.GamePlatform = 'SegaDreamcast'	and PlayOverUsers.SegaDreamcast = 1)	or 
					(VideoGames.GamePlatform = 'PS1'			and PlayOverUsers.PS1 = 1)				or
					(VideoGames.GamePlatform = 'PS2'			and PlayOverUsers.PS2 = 1)				or
					(VideoGames.GamePlatform = 'PS3'			and PlayOverUsers.PS3 = 1)				or
					(VideoGames.GamePlatform = 'PS4'			and PlayOverUsers.PS4 = 1)				or
					(VideoGames.GamePlatform = 'PSP'			and PlayOverUsers.PSP = 1)				or
					(VideoGames.GamePlatform = 'PSVita'			and PlayOverUsers.PSVita = 1)			or
					(VideoGames.GamePlatform = 'Xbox'			and PlayOverUsers.Xbox = 1)				or
					(VideoGames.GamePlatform = 'Xbox360'		and PlayOverUsers.Xbox360 = 1)			or
					(VideoGames.GamePlatform = 'XboxOne'		and PlayOverUsers.XboxOne = 1)			or
					(VideoGames.GamePlatform = 'Ouya'			and PlayOverUsers.Ouya = 1)				or
					(VideoGames.GamePlatform = 'OculusRift'		and PlayOverUsers.OculusRift = 1)		or
					(VideoGames.GamePlatform = 'Vive'			and PlayOverUsers.Vive = 1)				or
					(VideoGames.GamePlatform = 'PSVR'			and PlayOverUsers.PSVR = 1)
				)
			) 
			WHERE PlayOverUsers.PlayOverUserIndex = @intUserIndex
			and VideoGames.TargetIndex not in(
				select VideoGames.TargetIndex from VideoGames
				JOIN PlayOverLists ON
					VideoGames.TargetIndex = PlayOverLists.VideoGameIndex
				JOIN PlayOverUsers ON
					PlayOverLists.PlayOverUserIndex = PlayOverUsers.PlayOverUserIndex
				where PlayOverUsers.PlayOverUserIndex = @intUserIndex
			)
		);
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are VideoGames left in the global list
			IF( @GlobalExclusionCount > 0 )
			BEGIN
				--//request random non-locked Target from personal list
				SET @TargetIndex = (select top 1 ListIndex from PlayOverLists where PlayOverUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0) order by newid());
			END
			ELSE
			BEGIN
				--//request random non-locked Target from personal list
					--//exclude the first and last VideoGames
				SET @TargetIndex = (select top 1 ListIndex from PlayOverLists 
				where PlayOverUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
				and (OrderRank != 0 and OrderRank != @UserCount-1 ) order by newid());
			END


			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are VideoGames left in the global list
			if ( (select count(PlayOverUserIndex) from PlayOverLists 
			where (ListIndex = @TargetIndex and OrderRank = 0) or (ListIndex = @TargetIndex and OrderRank = @UserCount-1) ) > 0 
			and @GlobalExclusionCount > 0 )
			BEGIN    
				--//request @TargetIndex from personal list
				select VideoGames.TargetIndex, Name, Release, GamePlatform, Genre, Picture from PlayOverLists
				JOIN VideoGames ON
					PlayOverLists.VideoGameIndex = VideoGames.TargetIndex
				where PlayOverLists.ListIndex = @TargetIndex
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( 
					select Top 1 VideoGames.TargetIndex, Name, Release, GamePlatform, Genre, Picture from VideoGames
					JOIN PlayOverUsers ON
						(
							(
								(VideoGames.Genre = 'TwoDP'						and PlayOverUsers.TwoDP = 1)			or 
								(VideoGames.Genre = 'ThreeDP'					and PlayOverUsers.ThreeDP = 1)			or 
								(VideoGames.Genre = 'FPS'						and PlayOverUsers.FPS = 1)				or 
								(VideoGames.Genre = 'FPP'						and PlayOverUsers.FPP = 1)				or 
								(VideoGames.Genre = 'VPuzzle'					and PlayOverUsers.VPuzzle = 1)			or 
								(VideoGames.Genre = 'Bulletstorm'				and PlayOverUsers.Bulletstorm = 1)		or 
								(VideoGames.Genre = 'Fighting'					and PlayOverUsers.Fighting = 1)			or 
								(VideoGames.Genre = 'Stealth'					and PlayOverUsers.Stealth = 1)			or 
								(VideoGames.Genre = 'Survival'					and PlayOverUsers.Survival = 1)			or 
								(VideoGames.Genre = 'VN'						and PlayOverUsers.VN = 1)				or 
								(VideoGames.Genre = 'IM'						and PlayOverUsers.IM = 1)				or 
								(VideoGames.Genre = 'RPG'						and PlayOverUsers.RPG = 1)				or 
								(VideoGames.Genre = 'TRPG'						and PlayOverUsers.TRPG = 1)				or 
								(VideoGames.Genre = 'ARPG'						and PlayOverUsers.ARPG = 1)				or 
								(VideoGames.Genre = 'Sports'					and PlayOverUsers.Sports = 1)			or 
								(VideoGames.Genre = 'Racing'					and PlayOverUsers.Racing = 1)			or 
								(VideoGames.Genre = 'RTS'						and PlayOverUsers.RTS = 1)				or 
								(VideoGames.Genre = 'TBS'						and PlayOverUsers.TBS = 1)				or 
								(VideoGames.Genre = 'VE'						and PlayOverUsers.VE = 1)				or 
								(VideoGames.Genre = 'MMO'						and PlayOverUsers.MMO = 1)				or
								(VideoGames.Genre = 'MOBA'						and PlayOverUsers.MOBA = 1)
							)
							and
							(
								(GamePlatform = 'PC'				and PlayOverUsers.PC = 1)				or 
								(GamePlatform = 'Atari'				and PlayOverUsers.Atari = 1)			or 
								(GamePlatform = 'Commodore64'		and PlayOverUsers.Commodore64 = 1)		or 
								(GamePlatform = 'FAMICOM'			and PlayOverUsers.FAMICOM = 1)			or 
								(GamePlatform = 'NES'				and PlayOverUsers.NES = 1)				or 
								(GamePlatform = 'SNES'				and PlayOverUsers.SNES = 1)				or 
								(GamePlatform = 'N64'				and PlayOverUsers.N64 = 1)				or 
								(GamePlatform = 'Gamecube'			and PlayOverUsers.Gamecube = 1)			or 
								(GamePlatform = 'Wii'				and PlayOverUsers.Wii = 1)				or 
								(GamePlatform = 'WiiU'				and PlayOverUsers.WiiU = 1)				or 
								(GamePlatform = 'NintendoSwitch'	and PlayOverUsers.NintendoSwitch = 1)	or 
								(GamePlatform = 'Gameboy'			and PlayOverUsers.Gameboy = 1)			or 
								(GamePlatform = 'VirtualBoy'		and PlayOverUsers.VirtualBoy = 1)		or 
								(GamePlatform = 'GBA'				and PlayOverUsers.GBA = 1)				or 
								(GamePlatform = 'DS'				and PlayOverUsers.DS = 1)				or 
								(GamePlatform = 'ThreeDS'			and PlayOverUsers.ThreeDS = 1)			or 
								(GamePlatform = 'SegaGenesis'		and PlayOverUsers.SegaGenesis = 1)		or 
								(GamePlatform = 'SegaCD'			and PlayOverUsers.SegaCD = 1)			or 
								(GamePlatform = 'SegaDreamcast'		and PlayOverUsers.SegaDreamcast = 1)	or 
								(GamePlatform = 'PS1'				and PlayOverUsers.PS1 = 1)				or
								(GamePlatform = 'PS2'				and PlayOverUsers.PS2 = 1)				or
								(GamePlatform = 'PS3'				and PlayOverUsers.PS3 = 1)				or
								(GamePlatform = 'PS4'				and PlayOverUsers.PS4 = 1)				or
								(GamePlatform = 'PSP'				and PlayOverUsers.PSP = 1)				or
								(GamePlatform = 'PSVita'			and PlayOverUsers.PSVita = 1)			or
								(GamePlatform = 'Xbox'				and PlayOverUsers.Xbox = 1)				or
								(GamePlatform = 'Xbox360'			and PlayOverUsers.Xbox360 = 1)			or
								(GamePlatform = 'XboxOne'			and PlayOverUsers.XboxOne = 1)			or
								(GamePlatform = 'Ouya'				and PlayOverUsers.Ouya = 1)				or
								(GamePlatform = 'OculusRift'		and PlayOverUsers.OculusRift = 1)		or
								(GamePlatform = 'Vive'				and PlayOverUsers.Vive = 1)				or
								(GamePlatform = 'PSVR'				and PlayOverUsers.PSVR = 1)
							)
						) 
					WHERE PlayOverUsers.PlayOverUserIndex = @intUserIndex
					and VideoGames.TargetIndex not in(
						select VideoGames.TargetIndex from VideoGames
						JOIN PlayOverLists ON
							VideoGames.TargetIndex = PlayOverLists.VideoGameIndex
						JOIN PlayOverUsers ON
							PlayOverLists.PlayOverUserIndex = PlayOverUsers.PlayOverUserIndex
						where PlayOverUsers.PlayOverUserIndex = @intUserIndex
	   
					) order by newid() 
				) T1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select OrderRank from PlayOverLists where ListIndex = @TargetIndex);
				--//request @TargetIndex from personal list
				select VideoGames.TargetIndex, Name, Release, GamePlatform, Genre, Picture from VideoGames
				JOIN PlayOverLists ON
					VideoGames.TargetIndex = PlayOverLists.VideoGameIndex
				where PlayOverLists.ListIndex = @TargetIndex 
				UNION
				--//request adjacent non-locked Target from personal list
				select * from (
					select top 1 VideoGames.TargetIndex, Name, Release, GamePlatform, Genre, Picture from VideoGames
					JOIN PlayOverLists ON
						VideoGames.TargetIndex = PlayOverLists.VideoGameIndex
					where PlayOverUserIndex = @intUserIndex 
					and 
					(
						(OrderRank = @SavedOrder-1 and DownLock = 0) or 
						(OrderRank = @SavedOrder+1 and UpLock = 0) 
					) order by newid()
				) T2;
			END
		END                    
		--//else (there are no unlocked records)
		ELSE
		BEGIN
			--//there are VideoGames left in the global list
			IF( @GlobalExclusionCount > 0 )
			BEGIN
				--//request Order = 0 or Order = count from personal list
				select * from (
					select top 1 VideoGames.TargetIndex, Name, Release, GamePlatform, Genre, Picture from VideoGames
					JOIN PlayOverLists ON
						VideoGames.TargetIndex = PlayOverLists.VideoGameIndex
					where PlayOverUserIndex = @intUserIndex 
					and 
						( OrderRank = 0 or OrderRank = @UserCount-1 )
					order by newid() 
				) T3
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( 
					select Top 1 VideoGames.TargetIndex, Name, Release, GamePlatform, Genre, Picture from VideoGames
					JOIN PlayOverUsers ON
					(
						(
							(VideoGames.Genre = 'TwoDP'				and PlayOverUsers.TwoDP = 1)		or 
							(VideoGames.Genre = 'ThreeDP'			and PlayOverUsers.ThreeDP = 1)		or 
							(VideoGames.Genre = 'FPS'				and PlayOverUsers.FPS = 1)			or 
							(VideoGames.Genre = 'FPP'				and PlayOverUsers.FPP = 1)			or 
							(VideoGames.Genre = 'VPuzzle'			and PlayOverUsers.VPuzzle = 1)		or 
							(VideoGames.Genre = 'Bulletstorm'		and PlayOverUsers.Bulletstorm = 1)	or 
							(VideoGames.Genre = 'Fighting'			and PlayOverUsers.Fighting = 1)		or 
							(VideoGames.Genre = 'Stealth'			and PlayOverUsers.Stealth = 1)		or 
							(VideoGames.Genre = 'Survival'			and PlayOverUsers.Survival = 1)		or 
							(VideoGames.Genre = 'VN'				and PlayOverUsers.VN = 1)			or 
							(VideoGames.Genre = 'IM'				and PlayOverUsers.IM = 1)			or 
							(VideoGames.Genre = 'RPG'				and PlayOverUsers.RPG = 1)			or 
							(VideoGames.Genre = 'TRPG'				and PlayOverUsers.TRPG = 1)			or 
							(VideoGames.Genre = 'ARPG'				and PlayOverUsers.ARPG = 1)			or 
							(VideoGames.Genre = 'Sports'			and PlayOverUsers.Sports = 1)		or 
							(VideoGames.Genre = 'Racing'			and PlayOverUsers.Racing = 1)		or 
							(VideoGames.Genre = 'RTS'				and PlayOverUsers.RTS = 1)			or 
							(VideoGames.Genre = 'TBS'				and PlayOverUsers.TBS = 1)			or 
							(VideoGames.Genre = 'VE'				and PlayOverUsers.VE = 1)			or 
							(VideoGames.Genre = 'MMO'				and PlayOverUsers.MMO = 1)			or
							(VideoGames.Genre = 'MOBA'				and PlayOverUsers.MOBA = 1)
						)
						and
						(
							(VideoGames.GamePlatform = 'PC'				and PlayOverUsers.PC = 1)				or 
							(VideoGames.GamePlatform = 'Atari'			and PlayOverUsers.Atari = 1)			or 
							(VideoGames.GamePlatform = 'Commodore64'	and PlayOverUsers.Commodore64 = 1)		or 
							(VideoGames.GamePlatform = 'FAMICOM'		and PlayOverUsers.FAMICOM = 1)			or 
							(VideoGames.GamePlatform = 'NES'			and PlayOverUsers.NES = 1)				or 
							(VideoGames.GamePlatform = 'SNES'			and PlayOverUsers.SNES = 1)				or 
							(VideoGames.GamePlatform = 'N64'			and PlayOverUsers.N64 = 1)				or 
							(VideoGames.GamePlatform = 'Gamecube'		and PlayOverUsers.Gamecube = 1)			or 
							(VideoGames.GamePlatform = 'Wii'			and PlayOverUsers.Wii = 1)				or 
							(VideoGames.GamePlatform = 'WiiU'			and PlayOverUsers.WiiU = 1)				or 
							(VideoGames.GamePlatform = 'NintendoSwitch'	and PlayOverUsers.NintendoSwitch = 1)	or 
							(VideoGames.GamePlatform = 'Gameboy'		and PlayOverUsers.Gameboy = 1)			or 
							(VideoGames.GamePlatform = 'VirtualBoy'		and PlayOverUsers.VirtualBoy = 1)		or 
							(VideoGames.GamePlatform = 'GBA'			and PlayOverUsers.GBA = 1)				or 
							(VideoGames.GamePlatform = 'DS'				and PlayOverUsers.DS = 1)				or 
							(VideoGames.GamePlatform = 'ThreeDS'		and PlayOverUsers.ThreeDS = 1)			or 
							(VideoGames.GamePlatform = 'SegaGenesis'	and PlayOverUsers.SegaGenesis = 1)		or 
							(VideoGames.GamePlatform = 'SegaCD'			and PlayOverUsers.SegaCD = 1)			or 
							(VideoGames.GamePlatform = 'SegaDreamcast'	and PlayOverUsers.SegaDreamcast = 1)	or 
							(VideoGames.GamePlatform = 'PS1'			and PlayOverUsers.PS1 = 1)				or
							(VideoGames.GamePlatform = 'PS2'			and PlayOverUsers.PS2 = 1)				or
							(VideoGames.GamePlatform = 'PS3'			and PlayOverUsers.PS3 = 1)				or
							(VideoGames.GamePlatform = 'PS4'			and PlayOverUsers.PS4 = 1)				or
							(VideoGames.GamePlatform = 'PSP'			and PlayOverUsers.PSP = 1)				or
							(VideoGames.GamePlatform = 'PSVita'			and PlayOverUsers.PSVita = 1)			or
							(VideoGames.GamePlatform = 'Xbox'			and PlayOverUsers.Xbox = 1)				or
							(VideoGames.GamePlatform = 'Xbox360'		and PlayOverUsers.Xbox360 = 1)			or
							(VideoGames.GamePlatform = 'XboxOne'		and PlayOverUsers.XboxOne = 1)			or
							(VideoGames.GamePlatform = 'Ouya'			and PlayOverUsers.Ouya = 1)				or
							(VideoGames.GamePlatform = 'OculusRift'		and PlayOverUsers.OculusRift = 1)		or
							(VideoGames.GamePlatform = 'Vive'			and PlayOverUsers.Vive = 1)				or
							(VideoGames.GamePlatform = 'PSVR'			and PlayOverUsers.PSVR = 1)
						)
					)
					WHERE PlayOverUsers.PlayOverUserIndex = @intUserIndex
					and VideoGames.TargetIndex not in(
						select VideoGames.TargetIndex from VideoGames
						JOIN PlayOverLists ON
							VideoGames.TargetIndex = PlayOverLists.VideoGameIndex
						JOIN PlayOverUsers ON
							PlayOverLists.PlayOverUserIndex = PlayOverUsers.PlayOverUserIndex
						where PlayOverUsers.PlayOverUserIndex = @intUserIndex
					) order by newid() 
				) T4;
			END
			ELSE
			--//there are no selections left in the global list
				--//there are no unlocked records
			BEGIN
				--//return the top two records from personal list
				select top 2 VideoGames.TargetIndex, Name, Release, GamePlatform, Genre, Picture from VideoGames
				JOIN PlayOverLists ON
					VideoGames.TargetIndex = PlayOverLists.VideoGameIndex
				where PlayOverUserIndex = @intUserIndex
				and ( (OrderRank = 0) or (OrderRank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random VideoGames from global list
		select top 2 VideoGames.TargetIndex, Name, Picture, Release, GamePlatform, Genre from VideoGames
		JOIN PlayOverUsers ON
		(
			(
				(VideoGames.Genre = 'TwoDP'				and PlayOverUsers.TwoDP = 1)		or 
				(VideoGames.Genre = 'ThreeDP'			and PlayOverUsers.ThreeDP = 1)		or 
				(VideoGames.Genre = 'FPS'				and PlayOverUsers.FPS = 1)			or 
				(VideoGames.Genre = 'FPP'				and PlayOverUsers.FPP = 1)			or 
				(VideoGames.Genre = 'VPuzzle'			and PlayOverUsers.VPuzzle = 1)		or 
				(VideoGames.Genre = 'Bulletstorm'		and	PlayOverUsers.Bulletstorm = 1)	or 
				(VideoGames.Genre = 'Fighting'			and PlayOverUsers.Fighting = 1)		or 
				(VideoGames.Genre = 'Stealth'			and PlayOverUsers.Stealth = 1)		or 
				(VideoGames.Genre = 'Survival'			and PlayOverUsers.Survival = 1)		or 
				(VideoGames.Genre = 'VN'				and PlayOverUsers.VN = 1)			or 
				(VideoGames.Genre = 'IM'				and PlayOverUsers.IM = 1)			or 
				(VideoGames.Genre = 'RPG'				and PlayOverUsers.RPG = 1)			or 
				(VideoGames.Genre = 'TRPG'				and PlayOverUsers.TRPG = 1)			or 
				(VideoGames.Genre = 'ARPG'				and PlayOverUsers.ARPG = 1)			or 
				(VideoGames.Genre = 'Sports'			and PlayOverUsers.Sports = 1)		or 
				(VideoGames.Genre = 'Racing'			and PlayOverUsers.Racing = 1)		or 
				(VideoGames.Genre = 'RTS'				and PlayOverUsers.RTS = 1)			or 
				(VideoGames.Genre = 'TBS'				and PlayOverUsers.TBS = 1)			or 
				(VideoGames.Genre = 'VE'				and PlayOverUsers.VE = 1)			or 
				(VideoGames.Genre = 'MMO'				and PlayOverUsers.MMO = 1)			or
				(VideoGames.Genre = 'MOBA'				and PlayOverUsers.MOBA = 1)
			)
			and
			(
				(VideoGames.GamePlatform = 'PC'				and PlayOverUsers.PC = 1)				or 
				(VideoGames.GamePlatform = 'Atari'			and PlayOverUsers.Atari = 1)			or 
				(VideoGames.GamePlatform = 'Commodore64'	and PlayOverUsers.Commodore64 = 1)		or 
				(VideoGames.GamePlatform = 'FAMICOM'		and PlayOverUsers.FAMICOM = 1)			or 
				(VideoGames.GamePlatform = 'NES'			and PlayOverUsers.NES = 1)				or 
				(VideoGames.GamePlatform = 'SNES'			and PlayOverUsers.SNES = 1)				or 
				(VideoGames.GamePlatform = 'N64'			and PlayOverUsers.N64 = 1)				or 
				(VideoGames.GamePlatform = 'Gamecube'		and PlayOverUsers.Gamecube = 1)			or 
				(VideoGames.GamePlatform = 'Wii'			and PlayOverUsers.Wii = 1)				or 
				(VideoGames.GamePlatform = 'WiiU'			and PlayOverUsers.WiiU = 1)				or 
				(VideoGames.GamePlatform = 'NintendoSwitch'	and PlayOverUsers.NintendoSwitch = 1)	or 
				(VideoGames.GamePlatform = 'Gameboy'		and PlayOverUsers.Gameboy = 1)			or 
				(VideoGames.GamePlatform = 'VirtualBoy'		and PlayOverUsers.VirtualBoy = 1)		or 
				(VideoGames.GamePlatform = 'GBA'			and PlayOverUsers.GBA = 1)				or 
				(VideoGames.GamePlatform = 'DS'				and PlayOverUsers.DS = 1)				or 
				(VideoGames.GamePlatform = 'ThreeDS'		and PlayOverUsers.ThreeDS = 1)			or 
				(VideoGames.GamePlatform = 'SegaGenesis'	and PlayOverUsers.SegaGenesis = 1)		or 
				(VideoGames.GamePlatform = 'SegaCD'			and PlayOverUsers.SegaCD = 1)			or 
				(VideoGames.GamePlatform = 'SegaDreamcast'	and PlayOverUsers.SegaDreamcast = 1)	or 
				(VideoGames.GamePlatform = 'PS1'			and PlayOverUsers.PS1 = 1)				or
				(VideoGames.GamePlatform = 'PS2'			and PlayOverUsers.PS2 = 1)				or
				(VideoGames.GamePlatform = 'PS3'			and PlayOverUsers.PS3 = 1)				or
				(VideoGames.GamePlatform = 'PS4'			and PlayOverUsers.PS4 = 1)				or
				(VideoGames.GamePlatform = 'PSP'			and PlayOverUsers.PSP = 1)				or
				(VideoGames.GamePlatform = 'PSVita'			and PlayOverUsers.PSVita = 1)			or
				(VideoGames.GamePlatform = 'Xbox'			and PlayOverUsers.Xbox = 1)				or
				(VideoGames.GamePlatform = 'Xbox360'		and PlayOverUsers.Xbox360 = 1)			or
				(VideoGames.GamePlatform = 'XboxOne'		and PlayOverUsers.XboxOne = 1)			or
				(VideoGames.GamePlatform = 'Ouya'			and PlayOverUsers.Ouya = 1)				or
				(VideoGames.GamePlatform = 'OculusRift'		and PlayOverUsers.OculusRift = 1)		or
				(VideoGames.GamePlatform = 'Vive'			and PlayOverUsers.Vive = 1)				or
				(VideoGames.GamePlatform = 'PSVR'			and PlayOverUsers.PSVR = 1)
			)
		)
		where PlayOverUsers.PlayOverUserIndex = @intUserIndex order by newid();
	END
END