--drop PROCEDURE WatchOverPullPersonalList;

create PROCEDURE WatchOverPullPersonalList
(
	@intUserIndex int
)
AS
BEGIN
	select * from Movies, WatchOverLists where 
        WatchOverLists.UserIndex = @intUserIndex and WatchOverLists.MovieIndex = Movies.Indext 
		
    --sort by Order Ranking
    order by OrderRank        
    ;
        
END