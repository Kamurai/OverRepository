--drop PROCEDURE WatchOverPullGlobalCounts;

create PROCEDURE WatchOverPullGlobalCounts
AS
BEGIN
	select count(Indext) as retNum from Movies
    UNION all
    select count(Genre) from Movies where Genre = 'ComedyM'
    UNION all
    select count(Genre) from Movies where Genre = 'DramaM'
    UNION all
    select count(Genre) from Movies where Genre = 'ActionM'
    UNION all
    select count(Genre) from Movies where Genre = 'HorrorM'
	UNION all
    select count(Genre) from Movies where Genre = 'ThrillerM'
	UNION all
    select count(Genre) from Movies where Genre = 'ScienceFictionM'
	UNION all
    select count(Genre) from Movies where Genre = 'FantasyM'
	UNION all
    select count(Genre) from Movies where Genre = 'WesternM'
	UNION all
    select count(Genre) from Movies where Genre = 'MartialArtsM'
	UNION all
    select count(Genre) from Movies where Genre = 'DocumentaryM'
	UNION all
    select count(Genre) from Movies where Genre = 'MockumentaryM';
END