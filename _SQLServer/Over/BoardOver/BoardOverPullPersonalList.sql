--drop PROCEDURE BoardOverPullPersonalList;

create PROCEDURE BoardOverPullPersonalList(
	@intUserIndex int
)
AS
BEGIN
	select * from BoardGames T
	JOIN BoardOverLists L ON L.TargetIndex = T.TargetIndex 
    WHERE L.UserIndex = @intUserIndex
    --sort by Order L.Ranking
    order by L.Rank        
    ;        
END