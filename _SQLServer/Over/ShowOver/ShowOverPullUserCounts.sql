--drop PROCEDURE ShowOverPullUserCounts;

create PROCEDURE ShowOverPullUserCounts
AS
BEGIN
	select count(ShowOverAdminLevel) as retNum	from [Over].dbo.ShowOveUsers where ShowOverAdminLevel = 0
    UNION all
    select count(ShowOverAdminLevel)			from [Over].dbo.ShowOveUsers where ShowOverAdminLevel = 1
    UNION all
    select count(ShowOverAdminLevel)			from [Over].dbo.ShowOveUsers where ShowOverAdminLevel = 2
    UNION all
    select count(ShowOverAdminLevel)			from [Over].dbo.ShowOveUsers where ShowOverAdminLevel = 3
    UNION all
	select count(ComedyS)						from [Over].dbo.ShowOveUsers where ComedyS = 1
    UNION all
    select count(DramaS)						from [Over].dbo.ShowOveUsers where DramaS = 1
    UNION all
    select count(ActionS)						from [Over].dbo.ShowOveUsers where ActionS = 1
    UNION all
    select count(HorrorS)						from [Over].dbo.ShowOveUsers where HorrorS = 1
	UNION all
    select count(ThrillerS)						from [Over].dbo.ShowOveUsers where ThrillerS = 1
	UNION all
	select count(MysteryS)						from [Over].dbo.ShowOveUsers where MysteryS = 1
	UNION all
	select count(DocumentaryS)					from [Over].dbo.ShowOveUsers where DocumentaryS = 1
	UNION all
	select count(ScienceFictionS)				from [Over].dbo.ShowOveUsers where ScienceFictionS = 1
	UNION all
	select count(FantasyS)						from [Over].dbo.ShowOveUsers where FantasyS = 1
	UNION all
	select count(WesternS)						from [Over].dbo.ShowOveUsers where WesternS = 1
	UNION all
	select count(MartialArtsS)					from [Over].dbo.ShowOveUsers where MartialArtsS = 1
	UNION all
	select count(ModernS)						from [Over].dbo.ShowOveUsers where ModernS = 1
	UNION all
	select count(HistoricS)						from [Over].dbo.ShowOveUsers where HistoricS = 1
	UNION all
	select count(PreHistoricS)					from [Over].dbo.ShowOveUsers where PreHistoricS = 1
	UNION all
	select count(ComicsS)						from [Over].dbo.ShowOveUsers where ComicsS = 1
	UNION all
	select count(PeriodS)						from [Over].dbo.ShowOveUsers where PeriodS = 1
	UNION all
	select count(ShowOverOnline)				from [Over].dbo.ShowOveUsers where ShowOverOnline = 1;
END