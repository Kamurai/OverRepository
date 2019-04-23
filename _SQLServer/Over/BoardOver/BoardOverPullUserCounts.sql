--drop PROCEDURE BoardOverPullUserCounts;

create PROCEDURE BoardOverPullUserCounts
AS
BEGIN
	select count(BoardOverAdminLevel) as retNum from [Over].dbo.BoardOverUsers where BoardOverAdminLevel = 0
    UNION all
    select count(BoardOverAdminLevel) from [Over].dbo.BoardOverUsers where BoardOverAdminLevel = 1
    UNION all
    select count(BoardOverAdminLevel) from [Over].dbo.BoardOverUsers where BoardOverAdminLevel = 2
    UNION all
    select count(BoardOverAdminLevel) from [Over].dbo.BoardOverUsers where BoardOverAdminLevel = 3
    UNION all
	select count(DeckBuilding) from [Over].dbo.BoardOveUsers where DeckBuilding = 1
    UNION all
    select count(FixedDeck) from [Over].dbo.BoardOveUsers where FixedDeck = 1
    UNION all
    select count(ConstructedDeck) from [Over].dbo.BoardOveUsers where ConstructedDeck = 1
    UNION all
    select count(Strategy) from [Over].dbo.BoardOveUsers where Strategy = 1
	UNION all
    select count(War) from [Over].dbo.BoardOveUsers where War = 1
	UNION all
	select count(Economy) from [Over].dbo.BoardOveUsers where Economy = 1
	UNION all
	select count(TableauBuilding) from [Over].dbo.BoardOveUsers where TableauBuilding = 1
	UNION all
	select count(Coop) from [Over].dbo.BoardOveUsers where Coop = 1
	UNION all
	select count(Mystery) from [Over].dbo.BoardOveUsers where Mystery = 1
	UNION all
	select count(SemiCoop) from [Over].dbo.BoardOveUsers where SemiCoop = 1
	UNION all
	select count(PPRPG) from [Over].dbo.BoardOveUsers where PPRPG = 1
	UNION all
	select count(Bluffing) from [Over].dbo.BoardOveUsers where Bluffing = 1
	UNION all
    select count(Puzzle) from [Over].dbo.BoardOveUsers where Puzzle = 1
	UNION all
    select count(Dexterity) from [Over].dbo.BoardOveUsers where Dexterity = 1
	UNION all
    select count(Party) from [Over].dbo.BoardOveUsers where Party = 1
    UNION all
    select count(BoardOverOnline) from [Over].dbo.BoardOveUsers where BoardOverOnline = 1;
END