--drop PROCEDURE PlayOverPullPersonalList;

create PROCEDURE PlayOverPullPersonalList
(
	@intUserIndex int
)
AS
BEGIN
	select * from VideoGames, PlayOverLists where 
        PlayOverLists.UserIndex = @intUserIndex and PlayOverLists.VideoGameIndex = VideoGames.Indext 
		
    --sort by Order Ranking
    order by OrderRank        
    ;
        
END