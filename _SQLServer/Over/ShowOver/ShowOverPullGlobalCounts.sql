--drop PROCEDURE ShowOverPullGlobalCounts;

create PROCEDURE ShowOverPullGlobalCounts
AS
BEGIN
	select count(TargetIndex) as retNum from Shows
    UNION all
    select count(Genre) from Shows where Genre = 'Comedy'
    UNION all
    select count(Genre) from Shows where Genre = 'Drama'
    UNION all
    select count(Genre) from Shows where Genre = 'Action'
    UNION all
    select count(Genre) from Shows where Genre = 'Horror'
	UNION all
    select count(Genre) from Shows where Genre = 'Thriller'
	UNION all
    select count(Genre) from Shows where Genre = 'Mystery'
	UNION all
    select count(Genre) from Shows where Genre = 'Documentary'
	UNION all
    select count(Setting) from Shows where Setting = 'ScienceFiction'
	UNION all
    select count(Setting) from Shows where Setting = 'Fantasy'
	UNION all
    select count(Setting) from Shows where Setting = 'Western'
	UNION all
    select count(Setting) from Shows where Setting = 'MartialArts'
	UNION all
	select count(Setting) from Shows where Setting = 'Modern'
	UNION all
	select count(Setting) from Shows where Setting = 'Historic'
	UNION all
	select count(Setting) from Shows where Setting = 'PreHistoric'
	UNION all
	select count(Setting) from Shows where Setting = 'Comics'
	UNION all
	select count(Setting) from Shows where Setting = 'Period';
END