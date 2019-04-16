--drop PROCEDURE WatchOverPullGlobalListAll;

create PROCEDURE WatchOverPullGlobalListAll
AS
BEGIN
	select MovieIndex, Name, Picture, Release, Genre, Setting, avg(OrderRank)+1 as Ranking 
	from WatchOverLists 
	JOIN Movies ON WatchOverLists.MovieIndex = Movies.TargetIndex
	group by MovieIndex, Name, Picture, Release, Genre, Setting order by Ranking
	;
END