--drop PROCEDURE BoardOverPullGlobalCounts;

create PROCEDURE BoardOverPullGlobalCounts
AS
BEGIN
	select count(TargetIndex) as retNum from BoardGames
    UNION all
    select count(Genre) from BoardGames where Genre = 'DeckBuilding'
    UNION all
    select count(Genre) from BoardGames where Genre = 'FixedDeck'
    UNION all
    select count(Genre) from BoardGames where Genre = 'ConstructedDeck'
    UNION all
    select count(Genre) from BoardGames where Genre = 'Strategy'
	UNION all
    select count(Genre) from BoardGames where Genre = 'War'
	UNION all
    select count(Genre) from BoardGames where Genre = 'Economy'
	UNION all
    select count(Genre) from BoardGames where Genre = 'TableauBuilding'
	UNION all
    select count(Genre) from BoardGames where Genre = 'Coop'
	UNION all
    select count(Genre) from BoardGames where Genre = 'Mystery'
	UNION all
    select count(Genre) from BoardGames where Genre = 'SemiCoop'
	UNION all
    select count(Genre) from BoardGames where Genre = 'PPRPG'
	UNION all
    select count(Genre) from BoardGames where Genre = 'Bluffing'
	UNION all
    select count(Genre) from BoardGames where Genre = 'Puzzle'
	UNION all
    select count(Genre) from BoardGames where Genre = 'Dexterity'
	UNION all
    select count(Genre) from BoardGames where Genre = 'Party';
END