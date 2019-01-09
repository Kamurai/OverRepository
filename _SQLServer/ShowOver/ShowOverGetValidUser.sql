--drop PROCEDURE ShowOverGetValidUser;

create PROCEDURE ShowOverGetValidUser
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
		IF( (select count(*) from Users JOIN ShowOverUsers ON Users.UserIndex = MasterUserIndex where Username = @strUsername) = 0)
		BEGIN
			--get MasterUserIndex
			DECLARE @TargetUserIndex int = (select UserIndex from Users where Username = @strUsername);

			--create default user in Video Over table
			INSERT INTO ShowOverUsers (MasterUserIndex, LoggedOn, /*Genres*/ ComedyS, DramaS, ActionS, HorrorS, ThrillerS, MysteryS, DocumentaryS, /*Settings*/ ScienceFictionS, FantasyS, WesternS, MartialArtsS, ModernS, HistoricS, PrehistoricS, ComicsS, PeriodS)
		VALUES ( @TargetUserIndex, 0, /*Genres*/ 1, 1, 1, 1, 1, 1, 1, /*Settings*/ 1, 1, 1, 1, 1, 1, 1, 1, 1);
		END
	END
	
	select * from Users JOIN ShowOverUsers ON MasterUserIndex = Users.UserIndex where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS and Passcode = @strPasscode COLLATE SQL_Latin1_General_CP1_CS_AS;
END