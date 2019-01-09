--drop PROCEDURE PlayOverPullPersonalList;

create PROCEDURE PlayOverPullPersonalList
(
	@intUserIndex int
)
AS
BEGIN
	select * from VideoGames JOIN PlayOverLists ON PlayOverLists.VideoGameIndex = VideoGames.TargetIndex
        WHERE PlayOverLists.MasterUserIndex = @intUserIndex
		
    --sort by Order Ranking
    order by OrderRank        
    ;
        
END