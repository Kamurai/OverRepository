--drop PROCEDURE BangOverPullGlobalListSpecific;

create PROCEDURE BangOverPullGlobalListSpecific
(
    @intUserIndex int        
)
AS
BEGIN
	select CelebrityIndex, Name, Picture, Sex, avg(OrderRank)+1 as Ranking from BangOverLists, Celebrities, BangOverUsers 
	where BangOverLists.UserIndex = BangOverUsers.UserIndex
	and (
	( sex = 'F' and BangOverUsers.Women = 1 )
	or ( sex = 'M' and BangOverUsers.Men = 1 )
	or ( sex = 'W' and BangOverUsers.TransWomen = 1 )
	or ( sex = 'T' and BangOverUsers.TransMen = 1 )
	)
	and CelebrityIndex = Celebrities.Indext
	group by CelebrityIndex, Name, Picture, Sex order by Ranking
	;
END