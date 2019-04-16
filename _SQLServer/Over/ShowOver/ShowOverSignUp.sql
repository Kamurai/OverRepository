--drop procedure ShowOverSignUp;

create PROCEDURE ShowOverSignUp
(
    @strUsername		varchar(max),
	@strEmail			varchar(max),
	@strPasscode		varchar(max),
	--Genres
    @bitComedyS			bit,
	@bitDramaS			bit,
	@bitActionS			bit,
	@bitHorrorS			bit,
	@bitThrillerS		bit,
	@bitMysteryS		bit,
	@bitDocumentaryS	bit,
	--Settings
	@bitScienceFictionS bit,
	@bitFantasyS		bit,
	@bitWesternS		bit,
	@bitMartialArtsS	bit,
	@bitModernS			bit,
	@bitHistoricS		bit,
	@bitPrehistoricS	bit,
	@bitComicsS			bit,
	@bitPeriodS			bit

)
AS
BEGIN
	IF( (select count(*) from [HTKB].dbo.Users where Username = @strUsername) = 0)
	BEGIN
		INSERT INTO [HTKB].dbo.Users (
		HTKBAdminLevel, HTKBOnline, Username, Passcode, Email
		) 
		VALUES ( 
		0, 0, @strUsername, @strPasscode, @strEmail 
		);

		--subsequent user records created by triggers

		Update S SET 
		--Genres
		ComedyS			= @bitComedyS, 
		DramaS			= @bitDramaS, 
		ActionS			= @bitActionS, 
		HorrorS			= @bitHorrorS, 
		ThrillerS		= @bitThrillerS, 
		MysteryS		= @bitMysteryS, 
		DocumentaryS	= @bitDocumentaryS, 
		--Settings
		ScienceFictionS = @bitScienceFictionS, 
		FantasyS		= @bitFantasyS, 
		WesternS		= @bitWesternS, 
		MartialArtsS	= @bitMartialArtsS, 
		ModernS			= @bitModernS, 
		HistoricS		= @bitHistoricS, 
		PrehistoricS	= @bitPrehistoricS, 
		ComicsS			= @bitComicsS, 
		PeriodS			=  @bitPeriodS
		
		FROM [Over].dbo.ShowOverUsers S
		JOIN [Over].dbo.Users O ON S.OverUserIndex = O.OverUserIndex
		JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
		WHERE H.Username = @strUsername;
	END
END