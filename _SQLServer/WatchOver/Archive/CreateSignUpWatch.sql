--drop procedure SignUpBangOver;

create PROCEDURE SignUpBangOver
(
    @strUsername varchar(max),
	@strEmail varchar(max),
	@strPasscode varchar(max),

    @bitComedyM bit,
	@bitDramaM bit,
	@bitActionM bit,
	@bitHorrorM bit,

	@bitThrillerM bit,
	@bitScienceFictionM bit,
	@bitFantasyM bit,
	@bitWesternM bit,
	@bitMartialArtsM bit,
	@bitDocumentaryM bit,
	@bitMockumentaryM bit

)
AS
BEGIN
	-- COLLATE SQL_Latin1_General_CP1_CS_AS

	IF( (select count(*) from Users where Username = @strUsername) = 0)
	BEGIN
		INSERT INTO Users (Username, Email, Passcode, AdminLevel)
		VALUES ( @strUsername, @strEmail, @strPasscode, 0 );
	END

	IF( (select count(*) from Users, WatchOverUsers where Username = @strUsername and Users.Indext = UserIndex) = 0)
	BEGIN
		DECLARE @TargetUserIndex int = (select Indext from Users where Username = @strUsername);

		INSERT INTO WatchOverUsers (UserIndex, LoggedOn, ComedyM, DramaM, ActionM, HorrorM, ThrillerM, ScienceFictionM, FantasyM, WesternM, MartialArtsM, DocumentaryM, MockumentaryM) 
		VALUES ( @TargetUserIndex, 0, @bitComedyM, @bitDramaM, @bitActionM, @bitHorrorM, @bitThrillerM, @bitScienceFictionM, @bitFantasyM, @bitWesternM, @bitMartialArtsM, @bitDocumentaryM, @bitMockumentaryM );
	END
END