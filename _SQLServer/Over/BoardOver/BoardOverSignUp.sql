--drop procedure BoardOverSignUp;

create PROCEDURE BoardOverSignUp(
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
		/*Genres*/ 
		U.DeckBuilding		= @bitDeckBuilding,
		U.FixedDeck			= @bitFixedDeck,
		U.ConstructedDeck	= @bitConstructedDeck,
		U.Strategy			= @bitStrategy,
		U.War				= @bitWar,
		U.Economy			= @bitEconomy,
		U.TableauBuilding	= @bitTableauBuilding,
		U.Coop				= @bitCoop,
		U.Mystery			= @bitMystery,
		U.SemiCoop			= @bitSemiCoop,
		U.PPRPG				= @bitPPRPG,
		U.Bluffing			= @bitBluffing,
		U.Puzzle			= @bitPuzzle,
		U.Dexterity			= @bitDexterity,
		U.Party				= @bitParty

		FROM [Over].dbo.BoardOverUsers U
		JOIN [Over].dbo.Users O ON U.OverUserIndex = O.UserIndex
		JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
		WHERE H.Username = @strUsername;
	END
END