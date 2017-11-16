--drop procedure ShowOverUpdateOptions;

create PROCEDURE ShowOverUpdateOptions
(
    @intUserIndex int,
	--Genres
    @bitComedyS bit,
	@bitDramaS bit,
	@bitActionS bit,
	@bitHorrorS bit,
	@bitThrillerS bit,
	@bitMysteryS bit,
	@bitDocumentaryS bit,
	--Settings
	@bitScienceFictionS bit,
	@bitFantasyS bit,
	@bitWesternS bit,
	@bitMartialArtsS bit,
	@bitModernS bit,
	@bitHistoricS bit,
	@bitPrehistoricS bit,
	@bitComicsS bit,
	@bitPeriodS bit
)
AS
BEGIN
	--//Update preferences to match check boxes (local variables)
	--Genres
    ComedyS				= @bitComedyS, 
	DramaS				= @bitDramaS, 
	ActionS				= @bitActionS, 
	HorrorS				= @bitHorrorS, 
	ThrillerS			= @bitThrillerS, 
	MysteryS			= @bitMysteryS, 
	DocumentaryS		= @bitDocumentaryS, 
	--Settings
	ScienceFictionS		= @bitScienceFictionS, 
	FantasyS			= @bitFantasyS, 
	WesternS			= @bitWesternS, 
	MartialArtsS		= @bitMartialArtsS, 
	ModernS				= @bitModernS, 
	HistoricS			= @bitHistoricS, 
	PreHistoricS		= @bitPreHistoricS, 
	ComicsS				= @bitComicsS, 
	PeriodS				= @bitPeriodS

	where ShowOverUsers.UserIndex = @intUserIndex;

	--select * from Users where Indext = @intUserIndex;
		
	--//Adjust Personal list to match new preferences
	delete from ShowOverLists where UserIndex = @intUserIndex and ShowIndex IN (
	select Shows.Indext from Shows, ShowOverUsers where ShowOverUsers.UserIndex = @intUserIndex
		and (
				(
					( Genre = 'ComedyS'				and WatchOverUsers.ComedyS			= 0 )	or 
					( Genre = 'DramaS'				and WatchOverUsers.DramaS			= 0 )	or 
					( Genre = 'ActionS'				and WatchOverUsers.ActionS			= 0 )	or 
					( Genre = 'HorrorS'				and WatchOverUsers.HorrorS			= 0 )	or
					( Genre = 'ThrillerS'			and WatchOverUsers.ThrillerS		= 0 )	or
					( Genre = 'MysteryS'			and WatchOverUsers.MysteryS			= 0 )	or
					( Genre = 'DocumentaryS'		and WatchOverUsers.DocumentaryS		= 0 )
				) 
				and
				(
					( Setting = 'ScienceFictionS'	and WatchOverUsers.ScienceFictionS	= 0 )	or
					( Setting = 'FantasyS'			and WatchOverUsers.FantasyS			= 0 )	or
					( Setting = 'WesternS'			and WatchOverUsers.WesternS			= 0 )	or
					( Setting = 'MartialArtsS'		and WatchOverUsers.MartialArtsS		= 0 )	or
					( Setting = 'ModernS'			and WatchOverUsers.ModernS			= 0 )	or
					( Setting = 'HistoricS'			and WatchOverUsers.HistoricS		= 0 )	or
					( Setting = 'PrehistoricS'		and WatchOverUsers.PrehistoricS		= 0 )	or
					( Setting = 'ComicsS'			and WatchOverUsers.ComicsS			= 0 )	or
					( Setting = 'PeriodS'			and WatchOverUsers.PeriodS			= 0 )
				)
			)
	);

	--select * from Shows, ShowOverLists where Shows.Indext = ShowOverLists.ShowIndex and ShowOverLists.UserIndex = 0 order by OrderRank;


	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumOne from ShowOverLists where UserIndex = 0; 
	--select * from #NumOne;

	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumTwo from ShowOverLists where UserIndex = 0; 
	--select * from #NumTwo;

	--//Unlock records adacent to removed records
		--//Unlock DownLock for OrderRank+1 < 1
		Update ShowOverLists set Downlock = 0 where 
		Indext IN(
			select #NumOne.Indext from #NumOne, #NumTwo where 
			#NumOne.RowNum + 1 = #NumTwo.RowNum and 
			#NumTwo.OrderRank - #NumOne.OrderRank > 1
		);
		
		--//Unlock UpLock for OrderRank-1 < 1
		Update ShowOverLists set Uplock = 0 where 
		Indext IN(
			select #NumOne.Indext from #NumOne, #NumTwo where 
			#NumOne.RowNum - 1 = #NumTwo.RowNum and 
			#NumOne.OrderRank - #NumTwo.OrderRank > 1
		);

	drop table #NumOne;
	drop table #NumTwo;

	--select * from Shows, ShowOverLists where Shows.Indext = ShowOverLists.ShowIndex and ShowOverLists.UserIndex = 0 order by OrderRank;

	--//Reorder rankings
	With cte As
	(
		SELECT *,
		ROW_NUMBER() OVER (ORDER BY OrderRank) AS RowNum
		FROM ShowOverLists where UserIndex = @intUserIndex
	)
	UPDATE cte SET OrderRank=RowNum-1


END

