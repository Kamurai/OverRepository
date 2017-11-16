--drop PROCEDURE BoardOverGetValidUser;

create PROCEDURE BoardOverGetValidUser
(
	@strUserName varchar(max),
	@strPasscode varchar(max)
)
AS
BEGIN
	--if user does not exists
	IF( (select count(*) from Users where Username = @strUsername) = 1 )
	BEGIN
		
		--if user does not exist in Board Over table
		IF( (select count(*) from Users, BoardOverUsers where Username = @strUsername and Users.Indext = UserIndex) = 0)
		BEGIN
			--get UserIndex
			DECLARE @TargetUserIndex int = (select Indext from Users where Username = @strUsername);

			--create default user in Board Over table
			INSERT INTO BoardOverUsers (UserIndex, LoggedOn, DeckBuilding, FixedDeck, ConstructedDeck, Strategy, War, Economy, TableauBuilding, Coop, Mystery, SemiCoop, PPRPG, Bluffing, Puzzle, Dexterity, Party)
		VALUES ( @TargetUserIndex, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 );
		END
	END
	
	select * from Users, BoardOverUsers where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS and Passcode = @strPasscode COLLATE SQL_Latin1_General_CP1_CS_AS
    and UserIndex = Users.Indext;
END