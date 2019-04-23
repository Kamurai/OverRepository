--drop PROCEDURE BangOverPullUserCounts;

create PROCEDURE BangOverPullUserCounts
AS
BEGIN
	select count(BangOverAdminLevel) as retNum from [Over].dbo.BangOveUsers where BangOverAdminLevel = 0
    UNION all
    select count(BangOverAdminLevel)	from [Over].dbo.BangOveUsers where BangOverAdminLevel = 1
    UNION all
    select count(BangOverAdminLevel)	from [Over].dbo.BangOveUsers where BangOverAdminLevel = 2
    UNION all
    select count(BangOverAdminLevel)	from [Over].dbo.BangOveUsers where BangOverAdminLevel = 3
    UNION all
    select count(Women)					from [Over].dbo.BangOveUsers where Women = 1
    UNION all
    select count(Men)					from [Over].dbo.BangOveUsers where Men = 1
    UNION all
    select count(TransWomen)			from [Over].dbo.BangOveUsers where TransWomen = 1
    UNION all
    select count(TransMen)				from [Over].dbo.BangOveUsers where TransMen = 1
    UNION all
    select count(BangOverOnline)		from [Over].dbo.BangOverUsers where BangOverOnline = 1;
END