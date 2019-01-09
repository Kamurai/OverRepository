--drop procedure BoardOverSignUp;

create PROCEDURE BoardOverSignUp
(
    @strUsername varchar(max),
	@strEmail varchar(max),
	@strPasscode varchar(max),

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
	-- COLLATE SQL_Latin1_General_CP1_CS_AS

	IF( (select count(*) from Users where Username = @strUsername) = 0)
	BEGIN
		INSERT INTO Users (Username, Email, Passcode, AdminLevel)
		VALUES ( @strUsername, @strEmail, @strPasscode, 0 );
	END

	IF( (select count(*) from Users JOIN BoardOverUsers ON Users.UserIndex = MasterUserIndex where Username = @strUsername) = 0)
	BEGIN
		DECLARE @TargetUserIndex int = (select UserIndex from Users where Username = @strUsername);

		INSERT INTO BoardOverUsers (MasterUserIndex, LoggedOn, DeckBuilding, FixedDeck, ConstructedDeck, Strategy, War, Economy, TableauBuilding, Coop, Mystery, SemiCoop, PPRPG, Bluffing, Puzzle, Dexterity, Party)
		VALUES ( @TargetUserIndex, 0, @bitDeckBuilding, @bitFixedDeck, @bitConstructedDeck, @bitStrategy, @bitWar, @bitEconomy, @bitTableauBuilding, @bitCoop, @bitMystery, @bitSemiCoop, @bitPPRPG, @bitBluffing, @bitPuzzle, @bitDexterity, @bitParty	 );
	END
END