--drop PROCEDURE PlayOverPullGlobalListAll;

create PROCEDURE PlayOverPullGlobalListAll
AS
BEGIN
	select VideoGameIndex, Name, Picture, Release, GamePlatform, Genre, avg(OrderRank)+1 as Ranking from PlayOverLists 
	JOIN VideoGames ON 
		VideoGameIndex = VideoGames.TargetIndex
	group by VideoGameIndex, Name, Picture, Release, GamePlatform, Genre order by Ranking
	;
END