--drop PROCEDURE ShowOverPullUserCounts;

create PROCEDURE ShowOverPullUserCounts
AS
BEGIN
	select count(AdminLevel) as retNum from Users where AdminLevel = 0
    UNION all
    select count(AdminLevel) from Users where AdminLevel = 1
    UNION all
    select count(AdminLevel) from Users where AdminLevel = 2
    UNION all
	select count(ComedyS) from ShowOverUsers where ComedyS = 1
    UNION all
    select count(DramaS) from ShowOverUsers where DramaS = 1
    UNION all
    select count(ActionS) from ShowOverUsers where ActionS = 1
    UNION all
    select count(HorrorS) from ShowOverUsers where HorrorS = 1
	UNION all
    select count(ThrillerS) from ShowOverUsers where ThrillerS = 1
	UNION all
	select count(ScienceFictionS) from ShowOverUsers where ScienceFictionS = 1
	UNION all
	select count(FantasyS) from ShowOverUsers where FantasyS = 1
	UNION all
	select count(WesternS) from ShowOverUsers where WesternS = 1
	UNION all
	select count(MartialArtsS) from ShowOverUsers where MartialArtsS = 1
	UNION all
	select count(DocumentaryS) from ShowOverUsers where DocumentaryS = 1
	UNION all
	select count(MockumentaryS) from ShowOverUsers where MockumentaryS = 1
	UNION all
	select count(LoggedOn) from ShowOverUsers where LoggedOn = 1;
END