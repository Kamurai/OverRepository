--drop PROCEDURE BangOverPullUserCounts;

create PROCEDURE BangOverPullUserCounts
AS
BEGIN
	select count(AdminLevel) as retNum from Users where AdminLevel = 0
    UNION all
    select count(AdminLevel) from Users where AdminLevel = 1
    UNION all
    select count(AdminLevel) from Users where AdminLevel = 2
    UNION all
    select count(Women) from BangOverUsers where Women = 1
    UNION all
    select count(Men) from BangOverUsers where Men = 1
    UNION all
    select count(TransWomen) from BangOverUsers where TransWomen = 1
    UNION all
    select count(TransMen) from BangOverUsers where TransMen = 1
    UNION all
    select count(LoggedOn) from BangOverUsers where LoggedOn = 1;
END