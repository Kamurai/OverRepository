--drop PROCEDURE PlayOverPullPersonalList;

create PROCEDURE PlayOverPullPersonalList(
	@intUserIndex int
)
AS
BEGIN
	select * 
	from VideoGames T
	JOIN PlayOverLists L ON L.TargetIndex = T.TargetIndex
    WHERE L.UserIndex = @intUserIndex
    --sort by Order L.Ranking
    order by L.Rank        
    ;
END