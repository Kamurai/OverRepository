--drop PROCEDURE BangOverPullGlobalCounts;

create PROCEDURE BangOverPullGlobalCounts
AS
BEGIN
	select count(Indext) as retNum from celebrities
    UNION all
    select count(Sex) from celebrities where Sex = 'F'
    UNION all
    select count(Sex) from celebrities where  Sex = 'M'
    UNION all
    select count(Sex) from celebrities where  Sex = 'W'
    UNION all
    select count(Sex) from celebrities where  Sex = 'T';
END