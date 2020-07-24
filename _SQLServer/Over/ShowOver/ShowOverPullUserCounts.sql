--drop PROCEDURE ShowOverPullUserCounts;

create PROCEDURE ShowOverPullUserCounts
AS
BEGIN
	select count(AdminLevel) as retNum			from [Over].dbo.ShowOverUsers where AdminLevel = 0
    UNION all
    select count(AdminLevel)					from [Over].dbo.ShowOverUsers where AdminLevel = 1
    UNION all
    select count(AdminLevel)					from [Over].dbo.ShowOverUsers where AdminLevel = 2
    UNION all
    select count(AdminLevel)					from [Over].dbo.ShowOverUsers where AdminLevel = 3
    UNION all
	select count(Comedy)						from [Over].dbo.ShowOverUsers where Comedy = 1
    UNION all
    select count(Drama)							from [Over].dbo.ShowOverUsers where Drama = 1
    UNION all
    select count(Action)						from [Over].dbo.ShowOverUsers where Action = 1
    UNION all
    select count(Horror)						from [Over].dbo.ShowOverUsers where Horror = 1
	UNION all
    select count(Thriller)						from [Over].dbo.ShowOverUsers where Thriller = 1
	UNION all
	select count(Mystery)						from [Over].dbo.ShowOverUsers where Mystery = 1
	UNION all
	select count(Documentary)					from [Over].dbo.ShowOverUsers where Documentary = 1
	UNION all
	select count(ScienceFiction)				from [Over].dbo.ShowOverUsers where ScienceFiction = 1
	UNION all
	select count(Fantasy)						from [Over].dbo.ShowOverUsers where Fantasy = 1
	UNION all
	select count(Western)						from [Over].dbo.ShowOverUsers where Western = 1
	UNION all
	select count(MartialArts)					from [Over].dbo.ShowOverUsers where MartialArts = 1
	UNION all
	select count(Modern)						from [Over].dbo.ShowOverUsers where Modern = 1
	UNION all
	select count(Historic)						from [Over].dbo.ShowOverUsers where Historic = 1
	UNION all
	select count(PreHistoric)					from [Over].dbo.ShowOverUsers where PreHistoric = 1
	UNION all
	select count(Comics)						from [Over].dbo.ShowOverUsers where Comics = 1
	UNION all
	select count(Period)						from [Over].dbo.ShowOverUsers where Period = 1
	UNION all
	select count(Online)						from [Over].dbo.ShowOverUsers where Online = 1;
END