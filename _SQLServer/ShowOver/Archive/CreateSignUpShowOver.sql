--drop procedure SignUpBangOver;

create PROCEDURE SignUpBangOver
(
    @strUsername varchar(max),
	@strEmail varchar(max),
	@strPasscode varchar(max),

    @bitComedyS bit,
	@bitDramaS bit,
	@bitActionS bit,
	@bitHorrorS bit,
	@bitThrillerS bit,
	@bitScienceFictionS bit,
	@bitFantasyS bit,
	@bitWesternS bit,
	@bitMartialArtsS bit,
	@bitDocumentaryS bit,
	@bitMockumentaryS bit

)
AS
BEGIN
	-- COLLATE SQL_Latin1_General_CP1_CS_AS

	IF( (select count(*) from Users where Username = @strUsername) = 0)
	BEGIN
		INSERT INTO Users (Username, Email, Passcode, AdminLevel)
		VALUES ( @strUsername, @strEmail, @strPasscode, 0 );
	END

	IF( (select count(*) from Users, ShowOverUsers where Username = @strUsername and Users.Indext = UserIndex) = 0)
	BEGIN
		DECLARE @TargetUserIndex int = (select Indext from Users where Username = @strUsername);

		INSERT INTO ShowOverUsers (UserIndex, LoggedOn, ComedyS, DramaS, ActionS, HorrorS, ThrillerS, ScienceFictionS, FantasyS, WesternS, MartialArtsS, DocumentaryS, MockumentaryS) 
		VALUES ( @TargetUserIndex, 0, @bitComedyS, @bitDramaS, @bitActionS, @bitHorrorS, @bitThrillerS, @bitScienceFictionS, @bitFantasyS, @bitWesternS, @bitMartialArtsS, @bitDocumentaryS, @bitMockumentaryS );
	END

END