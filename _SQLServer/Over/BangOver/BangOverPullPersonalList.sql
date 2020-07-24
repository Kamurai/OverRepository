--drop PROCEDURE BangOverPullPersonalList;

create PROCEDURE BangOverPullPersonalList(
	@intUserIndex int
)
AS
BEGIN
	select * 
	from Celebrities T
	JOIN BangOverLists L ON L.TargetIndex = T.TargetIndex  
    WHERE L.UserIndex = @intUserIndex
    --sort by Order L.Ranking
    order by L.Rank
    ;
END