--drop PROCEDURE PlayOverPullTargetPair;

create PROCEDURE PlayOverPullTargetPair(
    @intUserIndex int        
)
AS
BEGIN
	DECLARE @UserCount 			int = 0;
	DECLARE @OrderCount 		int = 0;
	DECLARE @GlobalCount 		int = 0;
	DECLARE @ListIndex 			int = 0;
	DECLARE @SecondListIndex 	int = 0;
	DECLARE @SavedOrder 		int = 0;

	--//request count of records related to user
	SET @UserCount = (select count(L.UserIndex) from PlayOverLists L where L.UserIndex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked Video Games from personal list
		IF( (SELECT TOP 1 U.Memory FROM PlayOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
		BEGIN
			SET @OrderCount = (
				SELECT count(L1.ListIndex) FROM PlayOverLists L1
				JOIN PlayOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
				JOIN PlayOverUsers U ON L1.UserIndex = U.UserIndex
				WHERE L1.UserIndex = @intUserIndex
				AND(
					 L1.TargetIndex NOT IN(
						SELECT M.TargetIndex1 FROM PlayOverMemories M
						WHERE L1.TargetIndex = M.TargetIndex1
						AND L2.TargetIndex = M.TargetIndex2
						UNION
						SELECT M.TargetIndex2 FROM PlayOverMemories M
						WHERE L1.TargetIndex = M.TargetIndex2
						AND L2.TargetIndex = M.TargetIndex1
					) OR (
						U.Memory = 0
					)				
				)
			);
		END
		ELSE
		BEGIN
			--//adjust OrderCount to exclude (1's L.UpLock and count's L.DownLock only available)
			SET @OrderCount = (
				select count(L.ListIndex) from PlayOverLists L where L.UserIndex = @intUserIndex 
				and (
					L.UpLock = 0 or L.DownLock = 0
				)and not (
					L.Rank = 0 and L.UpLock = 0 and L.DownLock = 1 
				) and not (
					L.Rank = (@UserCount-1) and L.UpLock = 1 and L.DownLock = 0
				)
			);		
		END
		
		SET @GlobalCount = (select count(T.TargetIndex) from VideoGames T
			JOIN PlayOverUsers U ON
			(
				(
					(T.Genre = 'TwoDP'					and U.TwoDP = 1)		or 
					(T.Genre = 'ThreeDP'				and U.ThreeDP = 1)		or 
					(T.Genre = 'FPS'					and U.FPS = 1)			or 
					(T.Genre = 'FPP'					and U.FPP = 1)			or 
					(T.Genre = 'VPuzzle'				and U.VPuzzle = 1)		or 
					(T.Genre = 'Bulletstorm'			and U.Bulletstorm = 1)	or 
					(T.Genre = 'Fighting'				and U.Fighting = 1)		or 
					(T.Genre = 'Stealth'				and U.Stealth = 1)		or 
					(T.Genre = 'Survival'				and U.Survival = 1)		or 
					(T.Genre = 'VN'						and U.VN = 1)			or 
					(T.Genre = 'IM'						and U.IM = 1)			or 
					(T.Genre = 'RPG'					and U.RPG = 1)			or 
					(T.Genre = 'TRPG'					and U.TRPG = 1)			or 
					(T.Genre = 'ARPG'					and U.ARPG = 1)			or 
					(T.Genre = 'Sports'					and U.Sports = 1)		or 
					(T.Genre = 'Racing'					and U.Racing = 1)		or 
					(T.Genre = 'RTS'					and U.RTS = 1)			or 
					(T.Genre = 'TBS'					and U.TBS = 1)			or 
					(T.Genre = 'VE'						and U.VE = 1)			or 
					(T.Genre = 'MMO'					and U.MMO = 1)			or
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
			WHERE U.UserIndex = @intUserIndex
			and T.TargetIndex not in(
				select T2.TargetIndex from VideoGames T2
				JOIN PlayOverLists L2 ON
					T2.TargetIndex = L2.TargetIndex
				JOIN PlayOverUsers U2 ON
					L2.UserIndex = U2.UserIndex
				where U2.UserIndex = @intUserIndex
			)
		);
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are VideoGames left in the global list
			IF( @GlobalCount > 0 )
			BEGIN
				IF( (SELECT TOP 1 U.Memory FROM PlayOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = 
					(
						SELECT top 1 L1.ListIndex FROM PlayOverLists L1
						JOIN PlayOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
						JOIN PlayOverUsers U ON L1.UserIndex = U.UserIndex
						WHERE L1.UserIndex = @intUserIndex
						AND(
							 L1.TargetIndex NOT IN(
								SELECT M.TargetIndex1 FROM PlayOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex1
								AND L2.TargetIndex = M.TargetIndex2
								UNION
								SELECT M.TargetIndex2 FROM PlayOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex2
								AND L2.TargetIndex = M.TargetIndex1
							) OR (
								U.Memory = 0
							)				
						)
						order by newid()
					);
				END
				ELSE
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = (select top 1 L.ListIndex from PlayOverLists L where L.UserIndex = @intUserIndex and (L.UpLock = 0 or L.DownLock = 0) order by newid());
				END	
			END
			ELSE
			BEGIN
				IF( (SELECT TOP 1 U.Memory FROM PlayOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = 
					(
						SELECT top 1 L1.ListIndex FROM PlayOverLists L1
						JOIN PlayOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
						JOIN PlayOverUsers U ON L1.UserIndex = U.UserIndex
						WHERE L1.UserIndex = @intUserIndex
						AND(
							 L1.TargetIndex NOT IN(
								SELECT M.TargetIndex1 FROM PlayOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex1
								AND L2.TargetIndex = M.TargetIndex2
								UNION
								SELECT M.TargetIndex2 FROM PlayOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex2
								AND L2.TargetIndex = M.TargetIndex1
							) OR (
								U.Memory = 0
							)
						)
						--//exclude the first and last Video Games
						and (L1.Rank != 0 and L1.Rank != @UserCount-1 )
						order by newid()
					);
				END
				ELSE
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = (select top 1 L.ListIndex from PlayOverLists L
					where L.UserIndex = @intUserIndex and (L.UpLock = 0 or L.DownLock = 0)
					--//exclude the first and last VideoGames
					and (L.Rank != 0 and L.Rank != @UserCount-1 ) order by newid());
				END
			END


			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are VideoGames left in the global list
			if (
				(
					select count(L.UserIndex) from PlayOverLists L
					where (L.ListIndex = @ListIndex and L.Rank = 0)
					or (L.ListIndex = @ListIndex and L.Rank = @UserCount-1) 
				) > 0 
				and @GlobalCount > 0 )
			BEGIN    
				--//request @ListIndex from personal list
				select T.TargetIndex, Name, Release, GamePlatform, Genre, Picture from PlayOverLists L
				JOIN VideoGames T ON
					L.TargetIndex = T.TargetIndex
				where L.ListIndex = @ListIndex
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( 
					select Top 1 T.TargetIndex, Name, Release, GamePlatform, Genre, Picture from VideoGames T
					JOIN PlayOverUsers U ON
						(
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
					WHERE U.UserIndex = @intUserIndex
					and T.TargetIndex not in(
						select T2.TargetIndex from VideoGames T2
						JOIN PlayOverLists L2 ON
							T2.TargetIndex = L2.TargetIndex
						JOIN PlayOverUsers U2 ON
							L2.UserIndex = U2.UserIndex
						where U2.UserIndex = @intUserIndex
	   
					) order by newid() 
				) AS TABLE1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select L.Rank from PlayOverLists L where L.ListIndex = @ListIndex);
				
				IF( (SELECT TOP 1 U.Memory FROM PlayOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
				BEGIN
					SET @SecondListIndex = (

						SELECT top 1 L2.ListIndex FROM PlayOverLists L1
						JOIN PlayOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
						JOIN PlayOverUsers U ON L1.UserIndex = U.UserIndex
						WHERE L1.UserIndex = @intUserIndex
						AND L1.ListIndex = @ListIndex
						AND(
							 L1.TargetIndex NOT IN(
								SELECT M.TargetIndex1 FROM PlayOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex1
								AND L2.TargetIndex = M.TargetIndex2
								UNION
								SELECT M.TargetIndex2 FROM PlayOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex2
								AND L2.TargetIndex = M.TargetIndex1
							) OR (
								U.Memory = 0
							)				
						)
						order by newid()
					);
				END
				ELSE
				BEGIN
					if( (SELECT L.UpLock FROM PlayOverLists L WHERE L.Rank = @SavedOrder) = 0 )
					BEGIN
						SET @SecondListIndex = (SELECT L.ListIndex FROM PlayOverLists L WHERE L.Rank = @SavedOrder-1);
					END
					else if( (SELECT L.DownLock FROM PlayOverLists L WHERE L.Rank = @SavedOrder) = 0 )
					BEGIN
						SET @SecondListIndex = (SELECT L.ListIndex FROM PlayOverLists L WHERE L.Rank = @SavedOrder+1);
					END
				END

				--//request @ListIndex from personal list
				(select T.TargetIndex, Name, Release, GamePlatform, Genre, Picture from VideoGames T
				JOIN PlayOverLists L ON
					T.TargetIndex = L.TargetIndex
				where L.ListIndex = @ListIndex 
				UNION
				select T.TargetIndex, Name, Release, GamePlatform, Genre, Picture from VideoGames T
				JOIN PlayOverLists L ON
					T.TargetIndex = L.TargetIndex
				where L.ListIndex = @SecondListIndex
				);
			END
		END                    
		--//else (there are no unlocked records)
		ELSE
		BEGIN
			--//there are VideoGames left in the global list
			IF( @GlobalCount > 0 )
			BEGIN
				--//request Order = 0 or Order = count from personal list
				select * from (
					select top 1 T.TargetIndex, Name, Release, GamePlatform, Genre, Picture from VideoGames T
					JOIN PlayOverLists L ON
						T.TargetIndex = L.TargetIndex
					where L.UserIndex = @intUserIndex 
					and 
						( L.Rank = 0 or L.Rank = @UserCount-1 )
					order by newid() 
				) AS TABLE2
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( 
					select Top 1 T.TargetIndex, Name, Release, GamePlatform, Genre, Picture from VideoGames T
					JOIN PlayOverUsers U ON
					(
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
					WHERE U.UserIndex = @intUserIndex
					and T.TargetIndex not in(
						select T2.TargetIndex from VideoGames T2
						JOIN PlayOverLists L2 ON
							T2.TargetIndex = L2.TargetIndex
						JOIN PlayOverUsers U2 ON
							L2.UserIndex = U2.UserIndex
						where U2.UserIndex = @intUserIndex
					) order by newid() 
				) AS TABLE3;
			END
			ELSE
			--//there are no selections left in the global list
				--//there are no unlocked records
			BEGIN
				--//return the top two records from personal list
				select top 2 T.TargetIndex, Name, Release, GamePlatform, Genre, Picture from VideoGames T
				JOIN PlayOverLists L ON
					T.TargetIndex = L.TargetIndex
				where L.UserIndex = @intUserIndex
				and ( (L.Rank = 0) or (L.Rank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random VideoGames from global list
		select top 2 T.TargetIndex, Name, Picture, Release, GamePlatform, Genre from VideoGames T
		JOIN PlayOverUsers U ON
		(
			(
				(T.Genre = 'TwoDP'					and U.TwoDP = 1)			or 
				(T.Genre = 'ThreeDP'				and U.ThreeDP = 1)			or 
				(T.Genre = 'FPS'					and U.FPS = 1)				or 
				(T.Genre = 'FPP'					and U.FPP = 1)				or 
				(T.Genre = 'VPuzzle'				and U.VPuzzle = 1)			or 
				(T.Genre = 'Bulletstorm'			and	U.Bulletstorm = 1)		or 
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
		where U.UserIndex = @intUserIndex order by newid();
	END
END