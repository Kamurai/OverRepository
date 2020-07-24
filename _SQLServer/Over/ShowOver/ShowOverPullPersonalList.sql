--drop PROCEDURE ShowOverPullPersonalList;

create PROCEDURE ShowOverPullPersonalList(
	@intUserIndex int
)
AS
BEGIN
	select * 
	from Shows T
	JOIN ShowOverLists L ON L.TargetIndex = T.TargetIndex 
    WHERE L.UserIndex = @intUserIndex
    --sort by Order L.Ranking
    order by L.Rank        
    ;
END