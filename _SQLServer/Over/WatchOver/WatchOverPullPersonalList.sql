--drop PROCEDURE WatchOverPullPersonalList;

create PROCEDURE WatchOverPullPersonalList
(
	@intUserIndex int
)
AS
BEGIN
	select * 
	from Movies 
	JOIN WatchOverLists ON WatchOverLists.MovieIndex = Movies.TargetIndex 
    WHERE WatchOverLists.WatchOverUserIndex = @intUserIndex
    --sort by Order Ranking
    order by OrderRank        
    ;
END