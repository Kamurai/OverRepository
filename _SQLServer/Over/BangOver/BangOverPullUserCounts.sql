--drop PROCEDURE BangOverPullUserCounts;

create PROCEDURE BangOverPullUserCounts
AS
BEGIN
	select count(AdminLevel) as retNum 	from [Over].dbo.BangOverUsers where AdminLevel = 0
    UNION all
    select count(AdminLevel)			from [Over].dbo.BangOverUsers where AdminLevel = 1
    UNION all
    select count(AdminLevel)			from [Over].dbo.BangOverUsers where AdminLevel = 2
    UNION all
    select count(AdminLevel)			from [Over].dbo.BangOverUsers where AdminLevel = 3
    UNION all
    select count(Women)					from [Over].dbo.BangOverUsers where Women = 1
    UNION all
    select count(Men)					from [Over].dbo.BangOverUsers where Men = 1
    UNION all
    select count(TransWomen)			from [Over].dbo.BangOverUsers where TransWomen = 1
    UNION all
    select count(TransMen)				from [Over].dbo.BangOverUsers where TransMen = 1
    UNION all
    select count(Online)				from [Over].dbo.BangOverUsers where Online = 1;
END