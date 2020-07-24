--drop PROCEDURE BubbleUpPullUserCounts;

create PROCEDURE BubbleUpPullUserCounts
AS
BEGIN
	select count(AdminLevel) as retNum from [BubbleUp].dbo.Users where AdminLevel = 0
    UNION all
    select count(AdminLevel)	from [BubbleUp].dbo.Users where AdminLevel = 1
    UNION all
    select count(AdminLevel)	from [BubbleUp].dbo.Users where AdminLevel = 2
    UNION all
    select count(AdminLevel)	from [BubbleUp].dbo.Users where AdminLevel = 3
    UNION all
    select count(Online)		from [BubbleUp].dbo.Users where Online = 1;
END