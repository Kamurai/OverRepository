--drop PROCEDURE BoardOverPullPersonalList;

create PROCEDURE BoardOverPullPersonalList
(
	@intUserIndex int
)
AS
BEGIN
	select * from BoardGames, BoardOverLists where 
        BoardOverLists.UserIndex = @intUserIndex and BoardOverLists.BoardGameIndex = BoardGames.Indext 
		
    --sort by Order Ranking
    order by OrderRank        
    ;
        
END