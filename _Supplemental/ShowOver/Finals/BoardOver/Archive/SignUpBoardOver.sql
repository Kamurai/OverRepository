DECLARE @strUsername varchar(max) = 'TestBob';
DECLARE @strEmail varchar(max) = 'TestBob@htkb.com';
DECLARE @strPasscode varchar(max) = 'green20';

DECLARE @bitDeckBuilding bit = 1;
DECLARE @bitFixedDeck bit = 0;
DECLARE @bitConstructedDeck bit = 0;
DECLARE @bitStrategy bit = 0;
DECLARE @bitWar bit = 0;
DECLARE @bitEconomy bit = 0;
DECLARE @bitTableauBuilding bit = 0;
DECLARE @bitCoop bit = 0;
DECLARE @bitMystery bit = 0;
DECLARE @bitSemiCoop bit = 0;
DECLARE @bitPPRPG bit = 0;
DECLARE @bitBluffing bit = 0;
DECLARE @bitPuzzle bit = 0;
DECLARE @bitDexterity bit = 0;
DECLARE @bitParty bit = 0;


if( (select count(*) from Users where Username = @strUsername) = 0)
BEGIN
	INSERT INTO Users (Username, Email, Passcode, AdminLevel)
	VALUES ( @strUsername, @strEmail, @strPasscode, 0 );
END

if( (select count(*) from Users, BoardOverUsers where Username = @strUsername and Users.Indext = UserIndex) = 0)
BEGIN
	DECLARE @TargetUserIndex int = (select Indext from Users where Username = @strUsername);

	insert into BoardOverUsers (UserIndex, LoggedOn, DeckBuilding, FixedDeck, ConstructedDeck, Strategy, War, Economy, TableauBuilding, Coop, Mystery, SemiCoop, PPRPG, Bluffing, Puzzle, Dexterity, Party)
	VALUES ( @TargetUserIndex, 0, @bitDeckBuilding, @bitFixedDeck, @bitConstructedDeck, @bitStrategy, @bitWar, @bitEconomy, @bitTableauBuilding, @bitCoop, @bitMystery, @bitSemiCoop, @bitPPRPG, @bitBluffing, @bitPuzzle, @bitDexterity, @bitParty	 );
END


select * from Users;

delete from Users where Indext = 6;












