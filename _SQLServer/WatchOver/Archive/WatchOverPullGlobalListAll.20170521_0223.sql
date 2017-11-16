--drop PROCEDURE WatchOverPullGlobalListAll;

create PROCEDURE WatchOverPullGlobalListAll
AS
BEGIN
	select MovieIndex, Name, Picture, Release, Genre, avg(OrderRank)+1 as Ranking from WatchOverLists, Movies 
	where MovieIndex = Movies.Indext
	group by MovieIndex, Name, Picture, Release, Genre order by Ranking
	;
END