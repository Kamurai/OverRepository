--drop PROCEDURE ShowOverPullGlobalListAll;

create PROCEDURE ShowOverPullGlobalListAll
AS
BEGIN
	select L.TargetIndex, T.Name, T.Picture, T.Release, T.Genre, T.Setting, avg(L.Rank)+1 as Ranking 
	from ShowOverLists L
	JOIN Shows T ON L.TargetIndex = T.TargetIndex
	group by L.TargetIndex, T.Name, T.Picture, T.Release, T.Genre, T.Setting order by Ranking
	;
END