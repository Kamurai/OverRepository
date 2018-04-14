--drop PROCEDURE GetValidPlayOverUser;

create PROCEDURE GetValidPlayOverUser
(
	@strUserName varchar(max),
	@strPasscode varchar(max)
)
AS
BEGIN
	--if user does not exists
	IF( (select count(*) from Users where Username = @strUsername) = 1 )
	BEGIN
		
		--if user does not exist in Play Over table
		IF( (select count(*) from Users, PlayOverUsers where Username = @strUsername and Users.Indext = UserIndex) = 0)
		BEGIN
			--get UserIndex
			DECLARE @TargetUserIndex int = (select Indext from Users where Username = @strUsername);

			--create default user in Play Over table
			INSERT INTO PlayOverUsers ( UserIndex, LoggedOn, TwoDP, ThreeDP, FPS, FPP, VPuzzle, Bulletstorm, Fighting, Stealth, Survival, VN, IM, RPG, TRPG, ARPG, Sports, Racing, RTS, TBS, VE, MMO )
			VALUES ( @TargetUserIndex, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 );
		END
	END
	
	select * from Users, PlayOverUsers where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS and Passcode = @strPasscode COLLATE SQL_Latin1_General_CP1_CS_AS
    and UserIndex = Users.Indext;
END