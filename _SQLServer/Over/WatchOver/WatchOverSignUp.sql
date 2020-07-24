--drop procedure WatchOverSignUp;

create PROCEDURE WatchOverSignUp(
    @strUsername		varchar(max),
	@strEmail			varchar(max),
	@strPasscode		varchar(max),
	--Genres
    @bitComedy			bit,
	@bitDrama			bit,
	@bitAction			bit,
	@bitHorror			bit,
	@bitThriller		bit,
	@bitMystery			bit,
	@bitDocumentary		bit,
	--Settings
	@bitScienceFiction bit,
	@bitFantasy			bit,
	@bitWestern			bit,
	@bitMartialArts		bit,
	@bitModern			bit,
	@bitHistoric		bit,
	@bitPrehistoric		bit,
	@bitComics			bit,
	@bitPeriod			bit
)
AS
BEGIN
	IF( (select count(*) from [HTKB].dbo.Users where Username = @strUsername) = 0)
	BEGIN
		INSERT INTO [HTKB].dbo.Users (
		AdminLevel, Online, Username, Passcode, Email
		) 
		VALUES ( 
		0, 0, @strUsername, @strPasscode, @strEmail 
		);

		--subsequent user records created by triggers

		Update U SET 
		--Genres
		U.Comedy			= @bitComedy, 
		U.Drama				= @bitDrama, 
		U.Action			= @bitAction, 
		U.Horror			= @bitHorror, 
		U.Thriller			= @bitThriller, 
		U.Mystery			= @bitMystery, 
		U.Documentary		= @bitDocumentary, 
		--Settings
		U.ScienceFiction 	= @bitScienceFiction, 
		U.Fantasy			= @bitFantasy, 
		U.Western			= @bitWestern, 
		U.MartialArts		= @bitMartialArts, 
		U.Modern			= @bitModern, 
		U.Historic			= @bitHistoric, 
		U.Prehistoric		= @bitPrehistoric, 
		U.Comics			= @bitComics, 
		U.Period			=  @bitPeriod
		
		FROM [Over].dbo.WatchOverUsers U
		JOIN [Over].dbo.Users O ON U.OverUserIndex = O.UserIndex
		JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
		WHERE H.Username = @strUsername;
	END
END