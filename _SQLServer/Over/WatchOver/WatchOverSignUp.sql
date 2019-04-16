--drop procedure WatchOverSignUp;

create PROCEDURE WatchOverSignUp
(
    @strUsername		varchar(max),
	@strEmail			varchar(max),
	@strPasscode		varchar(max),
	--Genres
    @bitComedyM			bit,
	@bitDramaM			bit,
	@bitActionM			bit,
	@bitHorrorM			bit,
	@bitThrillerM		bit,
	@bitMysteryM		bit,
	@bitDocumentaryM	bit,
	--Settings
	@bitScienceFictionM bit,
	@bitFantasyM		bit,
	@bitWesternM		bit,
	@bitMartialArtsM	bit,
	@bitModernM			bit,
	@bitHistoricM		bit,
	@bitPrehistoricM	bit,
	@bitComicsM			bit,
	@bitPeriodM			bit
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

		Update W SET 
		--Genres
		ComedyM			= @bitComedyM, 
		DramaM			= @bitDramaM, 
		ActionM			= @bitActionM, 
		HorrorM			= @bitHorrorM, 
		ThrillerM		= @bitThrillerM, 
		MysteryM		= @bitMysteryM, 
		DocumentaryM	= @bitDocumentaryM, 
		--Settings
		ScienceFictionM = @bitScienceFictionM, 
		FantasyM		= @bitFantasyM, 
		WesternM		= @bitWesternM, 
		MartialArtsM	= @bitMartialArtsM, 
		ModernM			= @bitModernM, 
		HistoricM		= @bitHistoricM, 
		PrehistoricM	= @bitPrehistoricM, 
		ComicsM			= @bitComicsM, 
		PeriodM			=  @bitPeriodM
		
		FROM [Over].dbo.WatchOverUsers W
		JOIN [Over].dbo.Users O ON W.OverUserIndex = O.OverUserIndex
		JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
		WHERE H.Username = @strUsername;
	END
END