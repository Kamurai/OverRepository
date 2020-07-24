--drop PROCEDURE WatchOverPullGlobalListAll;

create PROCEDURE WatchOverPullGlobalListAll
AS
BEGIN
	select L.TargetIndex, T.Name, T.Picture, T.Release, T.Genre, T.Setting, avg(L.Rank)+1 as Ranking 
	from WatchOverLists L
	JOIN Movies T ON L.TargetIndex = T.TargetIndex
	group by L.TargetIndex, T.Name, T.Picture, T.Release, T.Genre, T.Setting order by Ranking
	;
END