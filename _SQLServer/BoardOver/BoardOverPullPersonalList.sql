--drop PROCEDURE BoardOverPullPersonalList;

create PROCEDURE BoardOverPullPersonalList
(
	@intUserIndex int
)
AS
BEGIN
	select * from BoardGames JOIN BoardOverLists ON BoardOverLists.BoardGameIndex = BoardGames.TargetIndex 
        WHERE BoardOverLists.MasterUserIndex = @intUserIndex
		
    --sort by Order Ranking
    order by OrderRank        
    ;
        
END