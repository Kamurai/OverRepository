--drop PROCEDURE PullGlobalCounts;

create PROCEDURE BangOverPullGlobalCounts
AS
BEGIN
	select count(TargetIndex) as retNum from Celebrities
    UNION all
    select count(Sex) from celebrities where Sex = 'F'
    UNION all
    select count(Sex) from celebrities where  Sex = 'M'
    UNION all
    select count(Sex) from celebrities where  Sex = 'W'
    UNION all
    select count(Sex) from celebrities where  Sex = 'T';
END