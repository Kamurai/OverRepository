--drop PROCEDURE BangOverPullGlobalCounts;

create PROCEDURE BangOverPullGlobalCounts
AS
BEGIN
	select count(TargetIndex) as retNum from Celebrities
    UNION all
    select count(Gender) from celebrities where Gender = 'F'
    UNION all
    select count(Gender) from celebrities where  Gender = 'M'
    UNION all
    select count(Gender) from celebrities where  Gender = 'W'
    UNION all
    select count(Gender) from celebrities where  Gender = 'T';
END