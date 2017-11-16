--drop PROCEDURE WatchOverPullUserCounts;

create PROCEDURE WatchOverPullUserCounts
AS
BEGIN
	select count(AdminLevel) as retNum from Users where AdminLevel = 0
    UNION all
    select count(AdminLevel) from Users where AdminLevel = 1
    UNION all
    select count(AdminLevel) from Users where AdminLevel = 2
    UNION all
	select count(ComedyM) from WatchOverUsers where ComedyM = 1
    UNION all
    select count(DramaM) from WatchOverUsers where DramaM = 1
    UNION all
    select count(ActionM) from WatchOverUsers where ActionM = 1
    UNION all
    select count(HorrorM) from WatchOverUsers where HorrorM = 1
	UNION all
    select count(ThrillerM) from WatchOverUsers where ThrillerM = 1
	UNION all
	select count(ScienceFictionM) from WatchOverUsers where ScienceFictionM = 1
	UNION all
	select count(FantasyM) from WatchOverUsers where FantasyM = 1
	UNION all
	select count(WesternM) from WatchOverUsers where WesternM = 1
	UNION all
	select count(MartialArtsM) from WatchOverUsers where MartialArtsM = 1
	UNION all
	select count(DocumentaryM) from WatchOverUsers where DocumentaryM = 1
	UNION all
	select count(MockumentaryM) from WatchOverUsers where MockumentaryM = 1
	UNION all
	select count(LoggedOn) from ShowOverUsers where LoggedOn = 1;
END