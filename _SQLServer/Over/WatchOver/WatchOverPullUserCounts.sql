--drop PROCEDURE WatchOverPullUserCounts;

create PROCEDURE WatchOverPullUserCounts
AS
BEGIN
	select count(AdminLevel) as retNum			from [Over].dbo.WatchOverUsers where AdminLevel = 0
    UNION all
    select count(AdminLevel)					from [Over].dbo.WatchOverUsers where AdminLevel = 1
    UNION all
    select count(AdminLevel)					from [Over].dbo.WatchOverUsers where AdminLevel = 2
    UNION all
    select count(AdminLevel)					from [Over].dbo.WatchOverUsers where AdminLevel = 3
    UNION all
	select count(Comedy)						from [Over].dbo.WatchOverUsers where Comedy = 1
    UNION all
    select count(Drama)							from [Over].dbo.WatchOverUsers where Drama = 1
    UNION all
    select count(Action)						from [Over].dbo.WatchOverUsers where Action = 1
    UNION all
    select count(Horror)						from [Over].dbo.WatchOverUsers where Horror = 1
	UNION all
    select count(Thriller)						from [Over].dbo.WatchOverUsers where Thriller = 1
	UNION all
	select count(Mystery)						from [Over].dbo.WatchOverUsers where Mystery = 1
	UNION all
	select count(Documentary)					from [Over].dbo.WatchOverUsers where Documentary = 1
	UNION all
	select count(ScienceFiction)				from [Over].dbo.WatchOverUsers where ScienceFiction = 1
	UNION all
	select count(Fantasy)						from [Over].dbo.WatchOverUsers where Fantasy = 1
	UNION all
	select count(Western)						from [Over].dbo.WatchOverUsers where Western = 1
	UNION all
	select count(MartialArts)					from [Over].dbo.WatchOverUsers where MartialArts = 1
	UNION all
	select count(Modern)						from [Over].dbo.WatchOverUsers where Modern = 1
	UNION all
	select count(Historic)						from [Over].dbo.WatchOverUsers where Historic = 1
	UNION all
	select count(PreHistoric)					from [Over].dbo.WatchOverUsers where PreHistoric = 1
	UNION all
	select count(Comics)						from [Over].dbo.WatchOverUsers where Comics = 1
	UNION all
	select count(Period)						from [Over].dbo.WatchOverUsers where Period = 1
	UNION all
	select count(Online)						from [Over].dbo.WatchOverUsers where Online = 1;
END