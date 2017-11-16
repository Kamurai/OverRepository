--drop PROCEDURE ShowOverPullPersonalList;

create PROCEDURE ShowOverPullPersonalList
(
	@intUserIndex int
)
AS
BEGIN
	select * from Shows, ShowOverLists where 
        ShowOverLists.UserIndex = @intUserIndex and ShowOverLists.ShowIndex = Shows.Indext 
		
    --sort by Order Ranking
    order by OrderRank        
    ;
        
END