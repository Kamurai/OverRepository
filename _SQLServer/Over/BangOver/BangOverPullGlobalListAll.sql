--drop PROCEDURE BangOverPullGlobalListAll;

create PROCEDURE BangOverPullGlobalListAll
AS
BEGIN
	select L.TargetIndex, T.Name, T.Picture, T.Gender, avg(L.Rank)+1 as Ranking 
	from BangOverLists L
	JOIN Celebrities T ON L.TargetIndex = T.TargetIndex
	group by L.TargetIndex, T.Name, T.Picture, T.Gender order by Ranking
	;
END