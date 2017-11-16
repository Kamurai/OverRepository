--drop PROCEDURE BangOverPullTargetSinglePersonal;

create PROCEDURE BangOverPullTargetSinglePersonal
(
	@intUserIndex int
)
AS
BEGIN
	select top 1 * from Celebrities, BangOverLists where 
        BangOverLists.UserIndex = @intUserIndex and BangOverLists.CelebrityIndex = Celebrities.Indext 
		
    --order by
    order by newid()        
    ;
        
END