--drop PROCEDURE BubbleUpPullUserCounts;

create PROCEDURE BubbleUpPullUserCounts
AS
BEGIN
	select count(BubbleUpAdminLevel) as retNum from [BubbleUp].dbo.Users where BubbleUpAdminLevel = 0
    UNION all
    select count(BubbleUpAdminLevel)	from [BubbleUp].dbo.Users where BubbleUpAdminLevel = 1
    UNION all
    select count(BubbleUpAdminLevel)	from [BubbleUp].dbo.Users where BubbleUpAdminLevel = 2
    UNION all
    select count(BubbleUpAdminLevel)	from [BubbleUp].dbo.Users where BubbleUpAdminLevel = 3
    UNION all
    select count(BubbleUpOnline)		from [BubbleUp].dbo.Users where BubbleUpOnline = 1;
END