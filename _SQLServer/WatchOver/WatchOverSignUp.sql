--drop procedure WatchOverSignUp;

create PROCEDURE WatchOverSignUp
(
    @strUsername varchar(max),
	@strEmail varchar(max),
	@strPasscode varchar(max),
	--Genres
    @bitComedyM bit,
	@bitDramaM bit,
	@bitActionM bit,
	@bitHorrorM bit,
	@bitThrillerM bit,
	@bitMysteryM bit,
	@bitDocumentaryM bit,
	--Settings
	@bitScienceFictionM bit,
	@bitFantasyM bit,
	@bitWesternM bit,
	@bitMartialArtsM bit,
	@bitModernM bit,
	@bitHistoricM bit,
	@bitPrehistoricM bit,
	@bitComicsM bit,
	@bitPeriodM bit
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

		INSERT INTO WatchOverUsers ( UserIndex, LoggedOn, 
		--Genres
		ComedyM, 
		DramaM, 
		ActionM, 
		HorrorM, 
		ThrillerM, 
		MysteryM, 
		DocumentaryM, 
		--Settings
		ScienceFictionM, 
		FantasyM, 
		WesternM, 
		MartialArtsM, 
		ModernM, 
		HistoricM, 
		PrehistoricM, 
		ComicsM, 
		PeriodM )
		VALUES ( @TargetUserIndex, 0, 
		--Genres
		@bitComedyM, 
		@bitDramaM, 
		@bitActionM, 
		@bitHorrorM, 
		@bitThrillerM, 
		@bitMysteryM, 
		@bitDocumentaryM, 
		--Settings
		@bitScienceFictionM, 
		@bitFantasyM, 
		@bitWesternM, 
		@bitMartialArtsM, 
		@bitModernM, 
		@bitHistoricM, 
		@bitPrehistoricM, 
		@bitComicsM, 
		@bitPeriodM );
	END

END