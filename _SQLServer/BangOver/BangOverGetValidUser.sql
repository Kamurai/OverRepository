--drop PROCEDURE BangOverGetValidUser;

create PROCEDURE BangOverGetValidUser
(
	@strUserName varchar(max),
	@strPasscode varchar(max)
)
AS
BEGIN
	--if user does not exists
	if( (select count(*) from Users where Username = @strUsername) = 1 )
	BEGIN
		
		--if user does not exist in Bang Over table
		if( (select count(*) from Users JOIN BangOverUsers Users.UserIndex = MasterUserIndex where Username = @strUsername) = 0)
		BEGIN
			--get MasterUserIndex
			DECLARE @TargetUserIndex int = (select UserIndex from Users where Username = @strUsername);

			--create default user in Bang Over table
			INSERT INTO BangOverUsers (MasterUserIndex, LoggedOn, Women, Men, TransWomen, TransMen)
			VALUES ( @TargetUserIndex, 0, 1, 0, 0, 0 );
		END
	END
	
	select * from Users JOIN BangOverUsers ON MasterUserIndex = Users.UserIndex where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS and Passcode = @strPasscode COLLATE SQL_Latin1_General_CP1_CS_AS;
END