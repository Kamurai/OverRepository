--drop PROCEDURE BangOverGetValidUser;

create PROCEDURE BangOverGetValidUser
(
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
				JOIN [Over].dbo.Users O ON H.HTKBUserIndex = O.HTKBUserIndex
				where Username = @strUsername
			) < 1
		)
		BEGIN
			--get HTKBUserIndex
			DECLARE @HTKBUserIndex int = (
				select TOP 1 HTKBUserIndex 
				from [HTKB].dbo.Users 
				where Username = @strUsername
			);

			INSERT INTO [Over].dbo.Users (HTKBUserIndex, OverAdminLevel, OverOnline) 
			VALUES (@HTKBUserIndex, 0, 0);
		END
		
		--if user does not exist in Bang Over User table
		if( 
			(
				select count(*)
				from [HTKB].dbo.Users H
				JOIN [Over].dbo.Users O ON H.HTKBUserIndex = O.HTKBUserIndex
				JOIN [Over].dbo.BangOverUsers B ON B.OverUserIndex = O.OverUserIndex
				where Username = @strUsername
			) < 1
		)
		BEGIN
			--get UserIndex
			DECLARE @OverUserIndex int = (
				select TOP 1 OverUserIndex
				from [HTKB].dbo.Users H
				JOIN [Over].dbo.Users O ON H.HTKBUserIndex = O.HTKBUserIndex
				where Username = @strUsername
			);

			--create default user in Bang Over User table
			INSERT INTO BangOverUsers (OverUserIndex, BangOverOnline, 
				Women, 
				Men, 
				TransWomen, 
				TransMen
			)
			VALUES ( @OverUserIndex, 0, 1, 0, 0, 0 );
		END
	END
		
	select TOP 1 * 
	from [HTKB].dbo.Users H
	JOIN [Over].dbo.Users O ON H.HTKBUserIndex = O.HTKBUserIndex
	JOIN [Over].dbo.BangOverUsers B ON B.OverUserIndex = O.OverUserIndex
	where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS and Passcode = @strPasscode COLLATE SQL_Latin1_General_CP1_CS_AS;
END