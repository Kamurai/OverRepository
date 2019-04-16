--drop PROCEDURE ShowOverPullGlobalListAll;

create PROCEDURE ShowOverPullGlobalListAll
AS
BEGIN
	select ShowIndex, Name, Picture, Release, Genre, Setting, avg(OrderRank)+1 as Ranking 
	from ShowOverLists 
	JOIN Shows ON ShowOverLists.ShowIndex = Shows.TargetIndex
	group by ShowIndex, Name, Picture, Release, Genre, Setting order by Ranking
	;
END