--drop PROCEDURE BoardOverPullUserCounts;

create PROCEDURE BoardOverPullUserCounts
AS
BEGIN
	select count(AdminLevel) as retNum from Users where AdminLevel = 0
    UNION all
    select count(AdminLevel) from Users where AdminLevel = 1
    UNION all
    select count(AdminLevel) from Users where AdminLevel = 2
    UNION all
	select count(DeckBuilding) from BoardOverUsers where DeckBuilding = 1
    UNION all
    select count(FixedDeck) from BoardOverUsers where FixedDeck = 1
    UNION all
    select count(ConstructedDeck) from BoardOverUsers where ConstructedDeck = 1
    UNION all
    select count(Strategy) from BoardOverUsers where Strategy = 1
	UNION all
    select count(War) from BoardOverUsers where War = 1
	UNION all
	select count(Economy) from BoardOverUsers where Economy = 1
	UNION all
	select count(TableauBuilding) from BoardOverUsers where TableauBuilding = 1
	UNION all
	select count(Coop) from BoardOverUsers where Coop = 1
	UNION all
	select count(Mystery) from BoardOverUsers where Mystery = 1
	UNION all
	select count(SemiCoop) from BoardOverUsers where SemiCoop = 1
	UNION all
	select count(PPRPG) from BoardOverUsers where PPRPG = 1
	UNION all
	select count(Bluffing) from BoardOverUsers where Bluffing = 1
	UNION all
    select count(Puzzle) from BoardOverUsers where Puzzle = 1
	UNION all
    select count(Dexterity) from BoardOverUsers where Dexterity = 1
	UNION all
    select count(Party) from BoardOverUsers where Party = 1
    UNION all
    select count(LoggedOn) from BoardOverUsers where LoggedOn = 1;
END