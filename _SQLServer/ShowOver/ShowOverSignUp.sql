--drop procedure ShowOverSignUp;

create PROCEDURE ShowOverSignUp
(
    @strUsername varchar(max),
	@strEmail varchar(max),
	@strPasscode varchar(max),
	--Genres
    @bitComedyS bit,
	@bitDramaS bit,
	@bitActionS bit,
	@bitHorrorS bit,
	@bitThrillerS bit,
	@bitMysteryS bit,
	@bitDocumentaryS bit,
	--Settings
	@bitScienceFictionS bit,
	@bitFantasyS bit,
	@bitWesternS bit,
	@bitMartialArtsS bit,
	@bitModernS bit,
	@bitHistoricS bit,
	@bitPrehistoricS bit,
	@bitComicsS bit,
	@bitPeriodS bit

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

		INSERT INTO ShowOverUsers ( UserIndex, LoggedOn, 
		--Genres
		ComedyS, 
		DramaS, 
		ActionS, 
		HorrorS, 
		ThrillerS, 
		MysteryS, 
		DocumentaryS, 
		--Settings
		ScienceFictionS, 
		FantasyS, 
		WesternS, 
		MartialArtsS, 
		ModernS, 
		HistoricS, 
		PrehistoricS, 
		ComicsS, 
		PeriodS )
		VALUES ( @TargetUserIndex, 0, 
		--Genres
		@bitComedyS, 
		@bitDramaS, 
		@bitActionS, 
		@bitHorrorS, 
		@bitThrillerS, 
		@bitMysteryS, 
		@bitDocumentaryS, 
		--Settings
		@bitScienceFictionS, 
		@bitFantasyS, 
		@bitWesternS, 
		@bitMartialArtsS, 
		@bitModernS, 
		@bitHistoricS, 
		@bitPrehistoricS, 
		@bitComicsS, 
		@bitPeriodS );
	END

END