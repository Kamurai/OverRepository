--drop PROCEDURE ShowOverPullPersonalList;

create PROCEDURE ShowOverPullPersonalList
(
	@intUserIndex int
)
AS
BEGIN
	select * from Shows JOIN ShowOverLists ON ShowOverLists.ShowIndex = Shows.TargetIndex 
        WHERE ShowOverLists.MasterUserIndex = @intUserIndex
		
    --sort by Order Ranking
    order by OrderRank        
    ;
        
END