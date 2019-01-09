--drop PROCEDURE BoardOverPullGlobalListAll;

create PROCEDURE BoardOverPullGlobalListAll
AS
BEGIN
	select BoardGameIndex, Name, Picture, Release, Genre, avg(OrderRank)+1 as Ranking from BoardOverLists JOIN BoardGames 
	ON BoardGameIndex = BoardGames.TargetIndex
	group by BoardGameIndex, Name, Picture, Release, Genre order by Ranking
	;
END