--drop PROCEDURE ShowOverPullGlobalCounts;

create PROCEDURE ShowOverPullGlobalCounts
AS
BEGIN
	select count(Indext) as retNum from Shows
    UNION all
    select count(Genre) from Shows where Genre = 'ComedyS'
    UNION all
    select count(Genre) from Shows where Genre = 'DramaS'
    UNION all
    select count(Genre) from Shows where Genre = 'ActionS'
    UNION all
    select count(Genre) from Shows where Genre = 'HorrorS'
	UNION all
    select count(Genre) from Shows where Genre = 'ThrillerS'
	UNION all
    select count(Genre) from Shows where Genre = 'ScienceFictionS'
	UNION all
    select count(Genre) from Shows where Genre = 'FantasyS'
	UNION all
    select count(Genre) from Shows where Genre = 'WesternS'
	UNION all
    select count(Genre) from Shows where Genre = 'MartialArtsS'
	UNION all
    select count(Genre) from Shows where Genre = 'DocumentaryS'
	UNION all
    select count(Genre) from Shows where Genre = 'MockumentaryS';
END