--drop PROCEDURE PlayOverPullGlobalListAll;

create PROCEDURE PlayOverPullGlobalListAll
AS
BEGIN
	select VideoGameIndex, Name, Picture, Release, Genre, avg(OrderRank)+1 as Ranking from PlayOverLists, VideoGames 
	where VideoGameIndex = VideoGames.Indext
	group by VideoGameIndex, Name, Picture, Release, Genre order by Ranking
	;
END