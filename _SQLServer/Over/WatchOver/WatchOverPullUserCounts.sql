--drop PROCEDURE WatchOverPullUserCounts;

create PROCEDURE WatchOverPullUserCounts
AS
BEGIN
	select count(WatchOverAdminLevel) as retNum	from [Over].dbo.WatchOveUsers where WatchOverAdminLevel = 0
    UNION all
    select count(WatchOverAdminLevel)			from [Over].dbo.WatchOveUsers where WatchOverAdminLevel = 1
    UNION all
    select count(WatchOverAdminLevel)			from [Over].dbo.WatchOveUsers where WatchOverAdminLevel = 2
    UNION all
    select count(WatchOverAdminLevel)			from [Over].dbo.WatchOveUsers where WatchOverAdminLevel = 3
    UNION all
	select count(ComedyM)						from [Over].dbo.WatchOveUsers where ComedyM = 1
    UNION all
    select count(DramaM)						from [Over].dbo.WatchOveUsers where DramaM = 1
    UNION all
    select count(ActionM)						from [Over].dbo.WatchOveUsers where ActionM = 1
    UNION all
    select count(HorrorM)						from [Over].dbo.WatchOveUsers where HorrorM = 1
	UNION all
    select count(ThrillerM)						from [Over].dbo.WatchOveUsers where ThrillerM = 1
	UNION all
	select count(MysteryM)						from [Over].dbo.WatchOveUsers where MysteryM = 1
	UNION all
	select count(DocumentaryM)					from [Over].dbo.WatchOveUsers where DocumentaryM = 1
	UNION all
	select count(ScienceFictionM)				from [Over].dbo.WatchOveUsers where ScienceFictionM = 1
	UNION all
	select count(FantasyM)						from [Over].dbo.WatchOveUsers where FantasyM = 1
	UNION all
	select count(WesternM)						from [Over].dbo.WatchOveUsers where WesternM = 1
	UNION all
	select count(MartialArtsM)					from [Over].dbo.WatchOveUsers where MartialArtsM = 1
	UNION all
	select count(ModernM)						from [Over].dbo.WatchOveUsers where ModernM = 1
	UNION all
	select count(HistoricM)						from [Over].dbo.WatchOveUsers where HistoricM = 1
	UNION all
	select count(PreHistoricM)					from [Over].dbo.WatchOveUsers where PreHistoricM = 1
	UNION all
	select count(ComicsM)						from [Over].dbo.WatchOveUsers where ComicsM = 1
	UNION all
	select count(PeriodM)						from [Over].dbo.WatchOveUsers where PeriodM = 1
	UNION all
	select count(WatchOverOnline)				from [Over].dbo.WatchOveUsers where WatchOverOnline = 1;
END