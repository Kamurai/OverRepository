--drop PROCEDURE WatchOverGetValidUser;

create PROCEDURE WatchOverGetValidUser
(
	@strUserName varchar(max),
	@strPasscode varchar(max)
)
AS
BEGIN
	--if user does not exists
	IF( (select count(*) from Users where Username = @strUsername) = 1 )
	BEGIN
		
		--if user does not exist in Video Over table
		IF( (select count(*) from Users, WatchOverUsers where Username = @strUsername and Users.Indext = UserIndex) = 0)
		BEGIN
			--get UserIndex
			DECLARE @TargetUserIndex int = (select Indext from Users where Username = @strUsername);

			--create default user in Video Over table
			INSERT INTO WatchOverUsers (UserIndex, LoggedOn, ComedyM, DramaM, ActionM, HorrorM, ThrillerM, ScienceFictionM, FantasyM, WesternM, MartialArtsM, DocumentaryM, MockumentaryM )
		VALUES ( @TargetUserIndex, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 );
		END
	END
	
	select * from Users, WatchOverUsers where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS and Passcode = @strPasscode COLLATE SQL_Latin1_General_CP1_CS_AS
    and UserIndex = Users.Indext;
END