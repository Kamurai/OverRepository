--drop PROCEDURE WatchOverPullGlobalCounts;

create PROCEDURE WatchOverPullGlobalCounts
AS
BEGIN
	select count(Indext) as retNum from Movies
    UNION all
    select count(Genre) from Movies where Genre = 'Comedy'
    UNION all
    select count(Genre) from Movies where Genre = 'Drama'
    UNION all
    select count(Genre) from Movies where Genre = 'Action'
    UNION all
    select count(Genre) from Movies where Genre = 'Horror'
	UNION all
    select count(Genre) from Movies where Genre = 'Thriller'
	UNION all
    select count(Genre) from Movies where Genre = 'Mystery'
	UNION all
    select count(Genre) from Movies where Genre = 'Documentary'
	UNION all
    select count(Setting) from Movies where Setting = 'ScienceFiction'
	UNION all
    select count(Setting) from Movies where Setting = 'Fantasy'
	UNION all
    select count(Setting) from Movies where Setting = 'Western'
	UNION all
    select count(Setting) from Movies where Setting = 'MartialArts'
	UNION all
	select count(Setting) from Movies where Setting = 'Modern'
	UNION all
	select count(Setting) from Movies where Setting = 'Historic'
	UNION all
	select count(Setting) from Movies where Setting = 'PreHistoric'
	UNION all
	select count(Setting) from Movies where Setting = 'Comics'
	UNION all
	select count(Setting) from Movies where Setting = 'Period';
END