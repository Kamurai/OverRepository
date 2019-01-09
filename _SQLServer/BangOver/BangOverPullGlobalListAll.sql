--drop PROCEDURE BangOverPullGlobalListAll;

create PROCEDURE BangOverPullGlobalListAll
AS
BEGIN
	select CelebrityIndex, Name, Picture, Sex, avg(OrderRank)+1 as Ranking from BangOverLists JOIN Celebrities 
	ON CelebrityIndex = Celebrities.TargetIndex
	group by CelebrityIndex, Name, Picture, Sex order by Ranking
	;
END