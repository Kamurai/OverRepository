--drop procedure BoardOverSignUp;

create PROCEDURE BoardOverSignUp
(
    @strUsername varchar(max),
	@strEmail varchar(max),
	@strPasscode varchar(max),
	/*Genres*/
    @bitDeckBuilding bit,
	@bitFixedDeck bit,
	@bitConstructedDeck bit,
	@bitStrategy bit,
	@bitWar bit,
	@bitEconomy bit,
	@bitTableauBuilding bit,
	@bitCoop bit,
	@bitMystery bit,
	@bitSemiCoop bit,
	@bitPPRPG bit,
	@bitBluffing bit,
	@bitPuzzle bit,
	@bitDexterity bit,
	@bitParty bit
)
AS
BEGIN
	IF( (select count(*) from Users where Username = @strUsername) = 0)
	BEGIN
		INSERT INTO [HTKB].dbo.Users (
		HTKBAdminLevel, HTKBOnline, Username, Passcode, Email
		) 
		VALUES ( 
		0, 0, @strUsername, @strPasscode, @strEmail 
		);

		--subsequent user records created by triggers

		Update B SET 
		/*Genres*/ 
		DeckBuilding	= @bitDeckBuilding,
		FixedDeck		= @bitFixedDeck,
		ConstructedDeck = @bitConstructedDeck,
		Strategy		= @bitStrategy,
		War				= @bitWar,
		Economy			= @bitEconomy,
		TableauBuilding = @bitTableauBuilding,
		Coop			= @bitCoop,
		Mystery			= @bitMystery,
		SemiCoop		= @bitSemiCoop,
		PPRPG			= @bitPPRPG,
		Bluffing		= @bitBluffing,
		Puzzle			= @bitPuzzle,
		Dexterity		= @bitDexterity,
		Party			= @bitParty

		FROM [Over].dbo.BoardOverUsers B
		JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
		JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
		WHERE H.Username = @strUsername;
	END
END