--drop PROCEDURE WatchOverGetValidUser;

create PROCEDURE WatchOverGetValidUser(
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
				JOIN [Over].dbo.BangOverUsers U ON U.OverUserIndex = O.UserIndex
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

			--create default user in Watch Over table
			INSERT INTO WatchOverUsers (OverUserIndex, Online, Memory,
				/*Genres*/ 
				Comedy, 
				Drama, 
				Action, 
				Horror, 
				Thriller, 
				Mystery, 
				Documentary, 
				/*Settings*/ 
				ScienceFiction, 
				Fantasy, 
				Western, 
				MartialArts, 
				Modern, 
				Historic, 
				Prehistoric, 
				Comics, 
				Period 
			)
			VALUES ( @OverUserIndex, 0, 1, 
				/*Genres*/ 1, 1, 1, 1, 1, 1, 1, 
				/*Settings*/ 1, 1, 1, 1, 1, 1, 1, 1, 1
			);
		END
	END
	
	select TOP 1 * 
	from [HTKB].dbo.Users H
	JOIN [Over].dbo.Users O ON H.UserIndex = O.HTKBUserIndex
	JOIN [Over].dbo.WatchOverUsers U ON U.OverUserIndex = O.UserIndex
	where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS and Passcode = @strPasscode COLLATE SQL_Latin1_General_CP1_CS_AS;
END