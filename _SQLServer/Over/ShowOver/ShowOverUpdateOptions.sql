--drop procedure ShowOverUpdateOptions;

create PROCEDURE ShowOverUpdateOptions(
    @intUserIndex		int,
	@bitMemory			bit,
	--Genres
    @bitComedyS			bit,
	@bitDramaS			bit,
	@bitActionS			bit,
	@bitHorrorS			bit,
	@bitThrillerS		bit,
	@bitMysteryS		bit,
	@bitDocumentaryS	bit,
	--Settings
	@bitScienceFictionS bit,
	@bitFantasyS		bit,
	@bitWesternS		bit,
	@bitMartialArtsS	bit,
	@bitModernS			bit,
	@bitHistoricS		bit,
	@bitPrehistoricS	bit,
	@bitComicsS			bit,
	@bitPeriodS			bit
)
AS
BEGIN
	--//Update preferences to match check boxes (local variables)
	update ShowOverUsers set
	ShowOverMemory		= @bitMemory, 
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

	where ShowOverUsers.ShowOverUserIndex = @intUserIndex;

	--//Adjust Personal list to match new preferences
	delete from ShowOverLists where ShowOverUserIndex = @intUserIndex and ShowIndex IN (
	select Shows.TargetIndex from Shows JOIN ShowOverUsers 
		ON (
			(
				( Genre = 'ComedyS'				and ShowOverUsers.ComedyS			= 0 )	or 
				( Genre = 'DramaS'				and ShowOverUsers.DramaS			= 0 )	or 
				( Genre = 'ActionS'				and ShowOverUsers.ActionS			= 0 )	or 
				( Genre = 'HorrorS'				and ShowOverUsers.HorrorS			= 0 )	or
				( Genre = 'ThrillerS'			and ShowOverUsers.ThrillerS			= 0 )	or
				( Genre = 'MysteryS'			and ShowOverUsers.MysteryS			= 0 )	or
				( Genre = 'DocumentaryS'		and ShowOverUsers.DocumentaryS		= 0 )
			) 
			and
			(
				( Setting = 'ScienceFictionS'	and ShowOverUsers.ScienceFictionS	= 0 )	or
				( Setting = 'FantasyS'			and ShowOverUsers.FantasyS			= 0 )	or
				( Setting = 'WesternS'			and ShowOverUsers.WesternS			= 0 )	or
				( Setting = 'MartialArtsS'		and ShowOverUsers.MartialArtsS		= 0 )	or
				( Setting = 'ModernS'			and ShowOverUsers.ModernS			= 0 )	or
				( Setting = 'HistoricS'			and ShowOverUsers.HistoricS			= 0 )	or
				( Setting = 'PrehistoricS'		and ShowOverUsers.PrehistoricS		= 0 )	or
				( Setting = 'ComicsS'			and ShowOverUsers.ComicsS			= 0 )	or
				( Setting = 'PeriodS'			and ShowOverUsers.PeriodS			= 0 )
			)
		)
		where ShowOverUsers.ShowOverUserIndex = @intUserIndex
	);

	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumOne from ShowOverLists where ShowOverUserIndex = @intUserIndex; 
	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumTwo from ShowOverLists where ShowOverUserIndex = @intUserIndex; 
	
	--//Unlock records adacent to removed records
		--//Unlock DownLock for OrderRank+1 < 1
		Update ShowOverLists set Downlock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum + 1 = #NumTwo.RowNum and 
			#NumTwo.OrderRank - #NumOne.OrderRank > 1
		);
		
		--//Unlock UpLock for OrderRank-1 < 1
		Update ShowOverLists set Uplock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum - 1 = #NumTwo.RowNum and 
			#NumOne.OrderRank - #NumTwo.OrderRank > 1
		);

	drop table #NumOne;
	drop table #NumTwo;

	--//Reorder rankings
	With cte As
	(
		SELECT *,
		ROW_NUMBER() OVER (ORDER BY OrderRank) AS RowNum
		FROM ShowOverLists where ShowOverUserIndex = @intUserIndex
	)
	UPDATE cte SET OrderRank=RowNum-1
END

