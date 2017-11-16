--drop PROCEDURE ShowOverPullGlobalListAll;

create PROCEDURE ShowOverPullGlobalListAll
AS
BEGIN
	select ShowIndex, Name, Picture, Release, Genre, avg(OrderRank)+1 as Ranking from ShowOverLists, Shows 
	where ShowIndex = Shows.Indext
	group by ShowIndex, Name, Picture, Release, Genre order by Ranking
	;
END