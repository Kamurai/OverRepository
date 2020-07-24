--drop PROCEDURE BoardOverPullGlobalListAll;

create PROCEDURE BoardOverPullGlobalListAll
AS
BEGIN
	select L.TargetIndex, T.Name, T.Picture, T.Release, T.Genre, avg(L.Rank)+1 as Ranking 
	from BoardOverLists L
	JOIN BoardGames T ON L.TargetIndex = T.TargetIndex
	group by L.TargetIndex, T.Name, T.Picture, T.Release, T.Genre order by Ranking
	;
END