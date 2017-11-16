--drop PROCEDURE BangOverPullCelebritySingleGlobal;

create PROCEDURE BangOverPullCelebritySingleGlobal
(
	@intUserIndex int
)
AS
BEGIN

	select top 1 * from Celebrities, BangOverUsers where BangOverUsers.UserIndex = @intUserIndex and 
        (
			( BangOverUsers.Women = 1 and Celebrities.Sex = 'F' ) or
			( BangOverUsers.Men = 1 and Celebrities.Sex = 'M' ) or
			( BangOverUsers.TransWomen = 1 and Celebrities.Sex = 'T' ) or
			( BangOverUsers.TransMen = 1 and Celebrities.Sex = 'W' )
		)
		
    --order by
    order by newid()        
    ;
        
END