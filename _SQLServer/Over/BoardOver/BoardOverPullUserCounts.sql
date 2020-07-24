--drop PROCEDURE BoardOverPullUserCounts;

create PROCEDURE BoardOverPullUserCounts
AS
BEGIN
	select count(AdminLevel) as retNum 	from [Over].dbo.BoardOverUsers where AdminLevel = 0
    UNION all
    select count(AdminLevel) 			from [Over].dbo.BoardOverUsers where AdminLevel = 1
    UNION all
    select count(AdminLevel) 			from [Over].dbo.BoardOverUsers where AdminLevel = 2
    UNION all
    select count(AdminLevel) 			from [Over].dbo.BoardOverUsers where AdminLevel = 3
    UNION all
	select count(DeckBuilding) 			from [Over].dbo.BoardOverUsers where DeckBuilding = 1
    UNION all
    select count(FixedDeck) 			from [Over].dbo.BoardOverUsers where FixedDeck = 1
    UNION all
    select count(ConstructedDeck) 		from [Over].dbo.BoardOverUsers where ConstructedDeck = 1
    UNION all
    select count(Strategy) 				from [Over].dbo.BoardOverUsers where Strategy = 1
	UNION all
    select count(War) 					from [Over].dbo.BoardOverUsers where War = 1
	UNION all
	select count(Economy) 				from [Over].dbo.BoardOverUsers where Economy = 1
	UNION all
	select count(TableauBuilding) 		from [Over].dbo.BoardOverUsers where TableauBuilding = 1
	UNION all
	select count(Coop) 					from [Over].dbo.BoardOverUsers where Coop = 1
	UNION all
	select count(Mystery) 				from [Over].dbo.BoardOverUsers where Mystery = 1
	UNION all
	select count(SemiCoop) 				from [Over].dbo.BoardOverUsers where SemiCoop = 1
	UNION all
	select count(PPRPG) 				from [Over].dbo.BoardOverUsers where PPRPG = 1
	UNION all
	select count(Bluffing) 				from [Over].dbo.BoardOverUsers where Bluffing = 1
	UNION all
    select count(Puzzle) 				from [Over].dbo.BoardOverUsers where Puzzle = 1
	UNION all
    select count(Dexterity) 			from [Over].dbo.BoardOverUsers where Dexterity = 1
	UNION all
    select count(Party) 				from [Over].dbo.BoardOverUsers where Party = 1
    UNION all
    select count(Online) 				from [Over].dbo.BoardOverUsers where Online = 1;
END