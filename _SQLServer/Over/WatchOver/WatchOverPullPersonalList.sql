--drop PROCEDURE WatchOverPullPersonalList;

create PROCEDURE WatchOverPullPersonalList(
	@intUserIndex int
)
AS
BEGIN
	select * 
	from Movies T
	JOIN WatchOverLists L ON L.TargetIndex = T.TargetIndex 
    WHERE L.UserIndex = @intUserIndex
    --sort by Order L.Ranking
    order by L.Rank        
    ;
END