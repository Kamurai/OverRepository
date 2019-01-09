--drop PROCEDURE ShowOverPullGlobalListAll;

create PROCEDURE ShowOverPullGlobalListAll
AS
BEGIN
	select ShowIndex, Name, Picture, Release, Genre, avg(OrderRank)+1 as Ranking from ShowOverLists JOIN Shows 
	ON ShowIndex = Shows.TargetIndex
	group by ShowIndex, Name, Picture, Release, Genre order by Ranking
	;
END