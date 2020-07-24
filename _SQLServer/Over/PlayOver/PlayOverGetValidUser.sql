--drop PROCEDURE PlayOverGetValidUser;

create PROCEDURE PlayOverGetValidUser(
	@strUserName varchar(max),
	@strPasscode varchar(max)
)
AS
BEGIN
	--if user does exists in HTKB User Table
	if( (select count(*) from [HTKB].dbo.Users where Username = @strUsername) >= 1 )
	BEGIN
		--if user does not exist in Over User table
		if(
			(
				select count(*)
				from [HTKB].dbo.Users H
				JOIN [Over].dbo.Users O ON H.UserIndex = O.HTKBUserIndex
				where Username = @strUsername
			) < 1
		)
		BEGIN
			--get HTKBUserIndex
			DECLARE @HTKBUserIndex int = (
				select TOP 1 UserIndex 
				from [HTKB].dbo.Users 
				where Username = @strUsername
			);

			INSERT INTO [Over].dbo.Users (HTKBUserIndex, AdminLevel, Online) 
			VALUES (@HTKBUserIndex, 0, 0);
		END
		
		--if user does not exist in Bang Over User table
		if( 
			(
				select count(*)
				from [HTKB].dbo.Users H
				JOIN [Over].dbo.Users O ON H.UserIndex = O.HTKBUserIndex
				JOIN [Over].dbo.PlayOverUsers U ON U.OverUserIndex = O.UserIndex
				where Username = @strUsername
			) < 1
		)
		BEGIN
			--get UserIndex
			DECLARE @OverUserIndex int = (
				select TOP 1 O.UserIndex
				from [HTKB].dbo.Users H
				JOIN [Over].dbo.Users O ON H.UserIndex = O.HTKBUserIndex
				where Username = @strUsername
			);

			--create default user in Video Over table
			INSERT INTO PlayOverUsers (OverUserIndex, Online, Memory,
				/*Genres*/ 
				TwoDP, 
				ThreeDP, 
				FPS, 
				FPP, 
				VPuzzle, 
				Bulletstorm, 
				Fighting, 
				Stealth, 
				Survival, 
				VN, 
				IM, 
				RPG, 
				TRPG, 
				ARPG, 
				Sports, 
				Racing, 
				RTS, 
				TBS,
				VE, 
				MMO, 
				MOBA, 
				/*Platforms*/ 
				PC, 
				Atari, 
				Commodore64, 
				FAMICOM, 
				NES, 
				SNES, 
				N64, 
				Gamecube, 
				Wii, 
				WiiU,
				NintendoSwitch, 
				Gameboy, 
				VirtualBoy, 
				GBA, 
				DS, 
				ThreeDS, 
				SegaGenesis, 
				SegaCD, 
				SegaDreamcast, 
				PS1, 
				PS2, 
				PS3, 
				PS4, 
				PSP, 
				PSVita, 
				Xbox, 
				Xbox360, 
				XboxOne, 
				Ouya, 
				OculusRift, 
				Vive, 
				PSVR
			)
			VALUES ( @OverUserIndex, 0, 1,
			/*Genres*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
			/*Platforms*/ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
		END
	END
	
	select TOP 1 * 
	from [HTKB].dbo.Users H
	JOIN [Over].dbo.Users O ON H.UserIndex = O.HTKBUserIndex
	JOIN [Over].dbo.PlayOverUsers U ON U.OverUserIndex = O.UserIndex
	where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS and Passcode = @strPasscode COLLATE SQL_Latin1_General_CP1_CS_AS;
END