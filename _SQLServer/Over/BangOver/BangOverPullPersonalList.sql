--drop PROCEDURE BangOverPullPersonalList;

create PROCEDURE BangOverPullPersonalList
(
	@intUserIndex int
)
AS
BEGIN
	select * 
	from Celebrities 
	JOIN BangOverLists ON BangOverLists.CelebrityIndex = Celebrities.TargetIndex  
    WHERE BangOverLists.BangOverUserIndex = @intUserIndex
    --sort by Order Ranking
    order by OrderRank
    ;
END