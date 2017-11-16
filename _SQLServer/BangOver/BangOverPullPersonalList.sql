--drop PROCEDURE BangOverPullPersonalList;

create PROCEDURE BangOverPullPersonalList
(
	@intUserIndex int
)
AS
BEGIN
	select * from Celebrities, BangOverLists where 
        BangOverLists.UserIndex = @intUserIndex and BangOverLists.CelebrityIndex = Celebrities.Indext 
		
    --sort by Order Ranking
    order by OrderRank        
    ;
        
END