--drop PROCEDURE PlayOverPullGlobalListAll;

create PROCEDURE PlayOverPullGlobalListAll
AS
BEGIN
	select L.TargetIndex, T.Name, T.Picture, T.Release, T.GamePlatform, T.Genre, avg(L.Rank)+1 as Ranking from PlayOverLists L
	JOIN VideoGames T ON 
		L.TargetIndex = T.TargetIndex
	group by L.TargetIndex, T.Name, T.Picture, T.Release, T.GamePlatform, T.Genre order by Ranking
	;
END