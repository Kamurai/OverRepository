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
	SET @UserCount = (select count(UserIndex) from PlayOverLists where userindex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked VideoGames from personal list
			--//adjust OrderCount to exclude (1's uplock and count's downlock only available)
		SET @OrderCount = (
		select count(Indext) from PlayOverLists where UserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
		and not ( OrderRank = 0 and UpLock = 0 and DownLock = 1 ) and not (OrderRank = (@UserCount-1) and UpLock = 1 and DownLock = 0)
		);
		SET @GlobalExclusionCount = (select count(VideoGames.Indext) from VideoGames, PlayOverUsers
			where (
				(
					(Genre = 'TwoDP'		and TwoDP = 1)				or 
					(Genre = 'ThreeDP'		and ThreeDP = 1)			or 
					(Genre = 'FPS'			and FPS = 1)				or 
					(Genre = 'FPP'			and FPP = 1)				or 
					(Genre = 'VPuzzle'		and VPuzzle = 1)			or 
					(Genre = 'Bulletstorm'	and Bulletstorm = 1)		or 
					(Genre = 'Fighting'		and Fighting = 1)			or 
					(Genre = 'Stealth'		and Stealth = 1)			or 
					(Genre = 'Survival'		and Survival = 1)			or 
					(Genre = 'VN'			and VN = 1)					or 
					(Genre = 'IM'			and IM = 1)					or 
					(Genre = 'RPG'			and RPG = 1)				or 
					(Genre = 'TRPG'			and TRPG = 1)				or 
					(Genre = 'ARPG'			and ARPG = 1)				or 
					(Genre = 'Sports'		and Sports = 1)				or 
					(Genre = 'Racing'		and Racing = 1)				or 
					(Genre = 'RTS'			and RTS = 1)				or 
					(Genre = 'TBS'			and TBS = 1)				or 
					(Genre = 'VE'			and VE = 1)					or 
					(Genre = 'MMO'			and MMO = 1)				or
					(Genre = 'MOBA'			and MOBA = 1)
				)
				and
				(
					(Genre = 'PC'				and PC = 1)				or 
					(Genre = 'Atari'			and Atari = 1)			or 
					(Genre = 'Commodore64'		and Commodore64 = 1)	or 
					(Genre = 'FAMICOM'			and FAMICOM = 1)		or 
					(Genre = 'NES'				and NES = 1)			or 
					(Genre = 'SNES'				and SNES = 1)			or 
					(Genre = 'N64'				and N64 = 1)			or 
					(Genre = 'Gamecube'			and Gamecube = 1)		or 
					(Genre = 'Wii'				and Wii = 1)			or 
					(Genre = 'WiiU'				and WiiU = 1)			or 
					(Genre = 'NintendoSwitch'	and NintendoSwitch = 1)	or 
					(Genre = 'Gameboy'			and Gameboy = 1)		or 
					(Genre = 'VirtualBoy'		and VirtualBoy = 1)		or 
					(Genre = 'GBA'				and GBA = 1)			or 
					(Genre = 'DS'				and DS = 1)				or 
					(Genre = 'ThreeDS'			and ThreeDS = 1)		or 
					(Genre = 'SegaGenesis'		and SegaGenesis = 1)	or 
					(Genre = 'SegaCD'			and SegaCD = 1)			or 
					(Genre = 'SegaDreamcast'	and SegaDreamcast = 1)	or 
					(Genre = 'PS1'				and PS1 = 1)			or
					(Genre = 'PS2'				and PS2 = 1)			or
					(Genre = 'PS3'				and PS3 = 1)			or
					(Genre = 'PS4'				and PS4 = 1)			or
					(Genre = 'PSP'				and PSP = 1)			or
					(Genre = 'PSVita'			and PSVita = 1)			or
					(Genre = 'Xbox'				and Xbox = 1)			or
					(Genre = 'Xbox360'			and Xbox360 = 1)		or
					(Genre = 'XboxOne'			and XboxOne = 1)		or
					(Genre = 'Ouya'				and Ouya = 1)			or
					(Genre = 'OculusRift'		and OculusRift = 1)		or
					(Genre = 'Vive'				and Vive = 1)			or
					(Genre = 'PSVR'				and PSVR = 1)
					
				)
			) 
			and PlayOverUsers.UserIndex = @intUserIndex
			and VideoGames.Indext not in(
			select VideoGames.Indext from VideoGames, PlayOverLists, PlayOverUsers
			where PlayOverUsers.UserIndex = @intUserIndex and PlayOverLists.UserIndex = PlayOverUsers.UserIndex and VideoGameIndex = VideoGames.Indext
			));
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are VideoGames left in the global list
			IF( @GlobalExclusionCount > 0 )
			BEGIN
				--//request random non-locked Target from personal list
				SET @TargetIndex = (select top 1 Indext from PlayOverLists where UserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0) order by newid());
			END
			ELSE
			BEGIN
				--//request random non-locked Target from personal list
					--//exclude the first and last VideoGames
				SET @TargetIndex = (select top 1 Indext from PlayOverLists 
				where UserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
				and (OrderRank != 0 and OrderRank != @UserCount-1 ) order by newid());
			END


			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are VideoGames left in the global list
			if ( (select count(UserIndex) from PlayOverLists 
			where (Indext = @TargetIndex and OrderRank = 0) or (Indext = @TargetIndex and OrderRank = @UserCount-1) ) > 0 
			and @GlobalExclusionCount > 0 )
			BEGIN    
				--//request @TargetIndex from personal list
				select VideoGames.Indext, Name, Release, GamePlatform, Genre, Picture from PlayOverLists, VideoGames where PlayOverLists.Indext = @TargetIndex and VideoGameIndex = VideoGames.Indext
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( select Top 1 VideoGames.Indext, Name, Release, GamePlatform, Genre, Picture from VideoGames, PlayOverUsers
				where (
					(
						(Genre = 'TwoDP'		and TwoDP = 1)				or 
						(Genre = 'ThreeDP'		and ThreeDP = 1)			or 
						(Genre = 'FPS'			and FPS = 1)				or 
						(Genre = 'FPP'			and FPP = 1)				or 
						(Genre = 'VPuzzle'		and VPuzzle = 1)			or 
						(Genre = 'Bulletstorm'	and Bulletstorm = 1)		or 
						(Genre = 'Fighting'		and Fighting = 1)			or 
						(Genre = 'Stealth'		and Stealth = 1)			or 
						(Genre = 'Survival'		and Survival = 1)			or 
						(Genre = 'VN'			and VN = 1)					or 
						(Genre = 'IM'			and IM = 1)					or 
						(Genre = 'RPG'			and RPG = 1)				or 
						(Genre = 'TRPG'			and TRPG = 1)				or 
						(Genre = 'ARPG'			and ARPG = 1)				or 
						(Genre = 'Sports'		and Sports = 1)				or 
						(Genre = 'Racing'		and Racing = 1)				or 
						(Genre = 'RTS'			and RTS = 1)				or 
						(Genre = 'TBS'			and TBS = 1)				or 
						(Genre = 'VE'			and VE = 1)					or 
						(Genre = 'MMO'			and MMO = 1)				or
						(Genre = 'MOBA'			and MOBA = 1)
					)
					and
					(
						(Genre = 'PC'				and PC = 1)				or 
						(Genre = 'Atari'			and Atari = 1)			or 
						(Genre = 'Commodore64'		and Commodore64 = 1)	or 
						(Genre = 'FAMICOM'			and FAMICOM = 1)		or 
						(Genre = 'NES'				and NES = 1)			or 
						(Genre = 'SNES'				and SNES = 1)			or 
						(Genre = 'N64'				and N64 = 1)			or 
						(Genre = 'Gamecube'			and Gamecube = 1)		or 
						(Genre = 'Wii'				and Wii = 1)			or 
						(Genre = 'WiiU'				and WiiU = 1)			or 
						(Genre = 'NintendoSwitch'	and NintendoSwitch = 1)	or 
						(Genre = 'Gameboy'			and Gameboy = 1)		or 
						(Genre = 'VirtualBoy'		and VirtualBoy = 1)		or 
						(Genre = 'GBA'				and GBA = 1)			or 
						(Genre = 'DS'				and DS = 1)				or 
						(Genre = 'ThreeDS'			and ThreeDS = 1)		or 
						(Genre = 'SegaGenesis'		and SegaGenesis = 1)	or 
						(Genre = 'SegaCD'			and SegaCD = 1)			or 
						(Genre = 'SegaDreamcast'	and SegaDreamcast = 1)	or 
						(Genre = 'PS1'				and PS1 = 1)			or
						(Genre = 'PS2'				and PS2 = 1)			or
						(Genre = 'PS3'				and PS3 = 1)			or
						(Genre = 'PS4'				and PS4 = 1)			or
						(Genre = 'PSP'				and PSP = 1)			or
						(Genre = 'PSVita'			and PSVita = 1)			or
						(Genre = 'Xbox'				and Xbox = 1)			or
						(Genre = 'Xbox360'			and Xbox360 = 1)		or
						(Genre = 'XboxOne'			and XboxOne = 1)		or
						(Genre = 'Ouya'				and Ouya = 1)			or
						(Genre = 'OculusRift'		and OculusRift = 1)		or
						(Genre = 'Vive'				and Vive = 1)			or
						(Genre = 'PSVR'				and PSVR = 1)
					)
				) 
				and PlayOverUsers.UserIndex = @intUserIndex
				and VideoGames.Indext not in(
				select VideoGames.Indext from VideoGames, PlayOverLists, PlayOverUsers
				where PlayOverUsers.UserIndex = @intUserIndex and PlayOverUsers.UserIndex = PlayOverUsers.UserIndex and VideoGameIndex = VideoGames.Indext
				) order by newid() ) T1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select OrderRank from PlayOverLists where Indext = @TargetIndex);
				--//request @TargetIndex from personal list
				select VideoGames.Indext, Name, Release, GamePlatform, Genre, Picture from  VideoGames, PlayOverLists where PlayOverLists.Indext = @TargetIndex and VideoGameIndex = VideoGames.Indext
				UNION
				--//request adjacent non-locked Target from personal list
				select * from (
					select top 1 VideoGames.Indext, Name, Release, GamePlatform, Genre, Picture from VideoGames, PlayOverLists where UserIndex = @intUserIndex and VideoGames.Indext = VideoGameIndex and ( (OrderRank = @SavedOrder-1 and DownLock = 0) or (OrderRank = @SavedOrder+1 and UpLock = 0) ) order by newid()
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
				select top 1 VideoGames.Indext, Name, Release, GamePlatform, Genre, Picture from VideoGames, PlayOverLists where UserIndex = @intUserIndex and VideoGameIndex = VideoGames.Indext and ( OrderRank = 0 or OrderRank = @UserCount-1 )
				order by newid() ) T3
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( select Top 1 VideoGames.Indext, Name, Release, GamePlatform, Genre, Picture from VideoGames, PlayOverUsers
				where (
					(
						(Genre = 'TwoDP'		and TwoDP = 1)				or 
						(Genre = 'ThreeDP'		and ThreeDP = 1)			or 
						(Genre = 'FPS'			and FPS = 1)				or 
						(Genre = 'FPP'			and FPP = 1)				or 
						(Genre = 'VPuzzle'		and VPuzzle = 1)			or 
						(Genre = 'Bulletstorm'	and Bulletstorm = 1)		or 
						(Genre = 'Fighting'		and Fighting = 1)			or 
						(Genre = 'Stealth'		and Stealth = 1)			or 
						(Genre = 'Survival'		and Survival = 1)			or 
						(Genre = 'VN'			and VN = 1)					or 
						(Genre = 'IM'			and IM = 1)					or 
						(Genre = 'RPG'			and RPG = 1)				or 
						(Genre = 'TRPG'			and TRPG = 1)				or 
						(Genre = 'ARPG'			and ARPG = 1)				or 
						(Genre = 'Sports'		and Sports = 1)				or 
						(Genre = 'Racing'		and Racing = 1)				or 
						(Genre = 'RTS'			and RTS = 1)				or 
						(Genre = 'TBS'			and TBS = 1)				or 
						(Genre = 'VE'			and VE = 1)					or 
						(Genre = 'MMO'			and MMO = 1)				or
						(Genre = 'MOBA'			and MOBA = 1)
					)
					and
					(
						(Genre = 'PC'				and PC = 1)				or 
						(Genre = 'Atari'			and Atari = 1)			or 
						(Genre = 'Commodore64'		and Commodore64 = 1)	or 
						(Genre = 'FAMICOM'			and FAMICOM = 1)		or 
						(Genre = 'NES'				and NES = 1)			or 
						(Genre = 'SNES'				and SNES = 1)			or 
						(Genre = 'N64'				and N64 = 1)			or 
						(Genre = 'Gamecube'			and Gamecube = 1)		or 
						(Genre = 'Wii'				and Wii = 1)			or 
						(Genre = 'WiiU'				and WiiU = 1)			or 
						(Genre = 'NintendoSwitch'	and NintendoSwitch = 1)	or 
						(Genre = 'Gameboy'			and Gameboy = 1)		or 
						(Genre = 'VirtualBoy'		and VirtualBoy = 1)		or 
						(Genre = 'GBA'				and GBA = 1)			or 
						(Genre = 'DS'				and DS = 1)				or 
						(Genre = 'ThreeDS'			and ThreeDS = 1)		or 
						(Genre = 'SegaGenesis'		and SegaGenesis = 1)	or 
						(Genre = 'SegaCD'			and SegaCD = 1)			or 
						(Genre = 'SegaDreamcast'	and SegaDreamcast = 1)	or 
						(Genre = 'PS1'				and PS1 = 1)			or
						(Genre = 'PS2'				and PS2 = 1)			or
						(Genre = 'PS3'				and PS3 = 1)			or
						(Genre = 'PS4'				and PS4 = 1)			or
						(Genre = 'PSP'				and PSP = 1)			or
						(Genre = 'PSVita'			and PSVita = 1)			or
						(Genre = 'Xbox'				and Xbox = 1)			or
						(Genre = 'Xbox360'			and Xbox360 = 1)		or
						(Genre = 'XboxOne'			and XboxOne = 1)		or
						(Genre = 'Ouya'				and Ouya = 1)			or
						(Genre = 'OculusRift'		and OculusRift = 1)		or
						(Genre = 'Vive'				and Vive = 1)			or
						(Genre = 'PSVR'				and PSVR = 1)
					)
				) 
				and PlayOverUsers.UserIndex = @intUserIndex
				and VideoGames.Indext not in(
				select VideoGames.Indext from VideoGames, PlayOverLists, Users
				where PlayOverUsers.UserIndex = @intUserIndex and PlayOverLists.UserIndex = PlayOverUsers.UserIndex and VideoGameIndex = VideoGames.Indext
				) order by newid() ) T4;
			END
			ELSE
			--//there are no selections left in the global list
				--//there are no unlocked records
			BEGIN
				--//return the top two records from personal list
				select top 2 VideoGames.Indext, Name, Release, GamePlatform, Genre, Picture from VideoGames, PlayOverLists where UserIndex = @intUserIndex
				and VideoGameIndex = VideoGames.Indext
				and ( (OrderRank = 0) or (OrderRank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random VideoGames from global list
		select top 2 VideoGames.Indext, Name, Picture, Release, GamePlatform, Genre from VideoGames, PlayOverUsers where PlayOverUsers.UserIndex = @intUserIndex and 
		(
			(
				(Genre = 'TwoDP'		and TwoDP = 1)				or 
				(Genre = 'ThreeDP'		and ThreeDP = 1)			or 
				(Genre = 'FPS'			and FPS = 1)				or 
				(Genre = 'FPP'			and FPP = 1)				or 
				(Genre = 'VPuzzle'		and VPuzzle = 1)			or 
				(Genre = 'Bulletstorm'	and Bulletstorm = 1)		or 
				(Genre = 'Fighting'		and Fighting = 1)			or 
				(Genre = 'Stealth'		and Stealth = 1)			or 
				(Genre = 'Survival'		and Survival = 1)			or 
				(Genre = 'VN'			and VN = 1)					or 
				(Genre = 'IM'			and IM = 1)					or 
				(Genre = 'RPG'			and RPG = 1)				or 
				(Genre = 'TRPG'			and TRPG = 1)				or 
				(Genre = 'ARPG'			and ARPG = 1)				or 
				(Genre = 'Sports'		and Sports = 1)				or 
				(Genre = 'Racing'		and Racing = 1)				or 
				(Genre = 'RTS'			and RTS = 1)				or 
				(Genre = 'TBS'			and TBS = 1)				or 
				(Genre = 'VE'			and VE = 1)					or 
				(Genre = 'MMO'			and MMO = 1)				or
				(Genre = 'MOBA'			and MOBA = 1)
			)
			and
			(
				(Genre = 'PC'				and PC = 1)				or 
				(Genre = 'Atari'			and Atari = 1)			or 
				(Genre = 'Commodore64'		and Commodore64 = 1)	or 
				(Genre = 'FAMICOM'			and FAMICOM = 1)		or 
				(Genre = 'NES'				and NES = 1)			or 
				(Genre = 'SNES'				and SNES = 1)			or 
				(Genre = 'N64'				and N64 = 1)			or 
				(Genre = 'Gamecube'			and Gamecube = 1)		or 
				(Genre = 'Wii'				and Wii = 1)			or 
				(Genre = 'WiiU'				and WiiU = 1)			or 
				(Genre = 'NintendoSwitch'	and NintendoSwitch = 1)	or 
				(Genre = 'Gameboy'			and Gameboy = 1)		or 
				(Genre = 'VirtualBoy'		and VirtualBoy = 1)		or 
				(Genre = 'GBA'				and GBA = 1)			or 
				(Genre = 'DS'				and DS = 1)				or 
				(Genre = 'ThreeDS'			and ThreeDS = 1)		or 
				(Genre = 'SegaGenesis'		and SegaGenesis = 1)	or 
				(Genre = 'SegaCD'			and SegaCD = 1)			or 
				(Genre = 'SegaDreamcast'	and SegaDreamcast = 1)	or 
				(Genre = 'PS1'				and PS1 = 1)			or
				(Genre = 'PS2'				and PS2 = 1)			or
				(Genre = 'PS3'				and PS3 = 1)			or
				(Genre = 'PS4'				and PS4 = 1)			or
				(Genre = 'PSP'				and PSP = 1)			or
				(Genre = 'PSVita'			and PSVita = 1)			or
				(Genre = 'Xbox'				and Xbox = 1)			or
				(Genre = 'Xbox360'			and Xbox360 = 1)		or
				(Genre = 'XboxOne'			and XboxOne = 1)		or
				(Genre = 'Ouya'				and Ouya = 1)			or
				(Genre = 'OculusRift'		and OculusRift = 1)		or
				(Genre = 'Vive'				and Vive = 1)			or
				(Genre = 'PSVR'				and PSVR = 1)
			)
		) order by newid();
	END

END