--drop procedure WatchOverUpdateOptions;

create PROCEDURE WatchOverUpdateOptions
(
    @intUserIndex int,
	--Genres
    @bitComedyM bit,
	@bitDramaM bit,
	@bitActionM bit,
	@bitHorrorM bit,
	@bitThrillerM bit,
	@bitMysteryM bit,
	@bitDocumentaryM bit,
	--Settings
	@bitScienceFictionM bit,
	@bitFantasyM bit,
	@bitWesternM bit,
	@bitMartialArtsM bit,
	@bitModernM bit,
	@bitHistoricM bit,
	@bitPrehistoricM bit,
	@bitComicsM bit,
	@bitPeriodM bit
)
AS
BEGIN
	--//Update preferences to match check boxes (local variables)
	update WatchOverUsers set 
	--Genres
    ComedyM				= @bitComedyM, 
	DramaM				= @bitDramaM, 
	ActionM				= @bitActionM, 
	HorrorM				= @bitHorrorM, 
	ThrillerM			= @bitThrillerM, 
	MysteryM			= @bitMysteryM, 
	DocumentaryM		= @bitDocumentaryM, 
	--Settings
	ScienceFictionM		= @bitScienceFictionM, 
	FantasyM			= @bitFantasyM, 
	WesternM			= @bitWesternM, 
	MartialArtsM		= @bitMartialArtsM, 
	ModernM				= @bitModernM, 
	HistoricM			= @bitHistoricM, 
	PreHistoricM		= @bitPreHistoricM, 
	ComicsM				= @bitComicsM, 
	PeriodM				= @bitPeriodM

	where WatchOverUsers.UserIndex = @intUserIndex;

	--select * from Users where Indext = @intUserIndex;
		
	--//Adjust Personal list to match new preferences
	delete from WatchOverLists where UserIndex = @intUserIndex and MovieIndex IN (
	select Movies.Indext from Movies, WatchOverUsers where WatchOverUsers.UserIndex = @intUserIndex
		and (
				(
					( Genre = 'ComedyM'			and WatchOverUsers.ComedyM = 0 )			or 
					( Genre = 'DramaM'			and WatchOverUsers.DramaM = 0 )				or 
					( Genre = 'ActionM'			and WatchOverUsers.ActionM = 0 )			or 
					( Genre = 'HorrorM'			and WatchOverUsers.HorrorM = 0 )			or
					( Genre = 'ThrillerM'		and WatchOverUsers.ThrillerM = 0 )			or
					( Genre = 'MysteryM'		and WatchOverUsers.MysteryM = 0 )			or
					( Genre = 'DocumentaryM'	and WatchOverUsers.DocumentaryM = 0 )
				) 
				and
				(
					( Setting = 'ScienceFictionM'	and WatchOverUsers.ScienceFictionM = 0 )	or
					( Setting = 'FantasyM'		and WatchOverUsers.FantasyM = 0 )				or
					( Setting = 'WesternM'		and WatchOverUsers.WesternM = 0 )				or
					( Setting = 'MartialArtsM'	and WatchOverUsers.MartialArtsM = 0 )			or
					( Setting = 'ModernM'	and WatchOverUsers.ModernM = 0 )				or
					( Setting = 'HistoricM'	and WatchOverUsers.HistoricM = 0 )				or
					( Setting = 'PrehistoricM'	and WatchOverUsers.PrehistoricM = 0 )			or
					( Setting = 'ComicsM'	and WatchOverUsers.ComicsM = 0 )				or
					( Setting = 'PeriodM'	and WatchOverUsers.PeriodM = 0 )
				)
			)
	);

	--select * from Movies, WatchOverLists where Movies.Indext = WatchOverLists.MovieIndex and WatchOverLists.UserIndex = 0 order by OrderRank;


	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumOne from WatchOverLists where UserIndex = 0; 
	--select * from #NumOne;

	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumTwo from WatchOverLists where UserIndex = 0; 
	--select * from #NumTwo;

	--//Unlock records adacent to removed records
		--//Unlock DownLock for OrderRank+1 < 1
		Update WatchOverLists set Downlock = 0 where 
		Indext IN(
			select #NumOne.Indext from #NumOne, #NumTwo where 
			#NumOne.RowNum + 1 = #NumTwo.RowNum and 
			#NumTwo.OrderRank - #NumOne.OrderRank > 1
		);
		
		--//Unlock UpLock for OrderRank-1 < 1
		Update WatchOverLists set Uplock = 0 where 
		Indext IN(
			select #NumOne.Indext from #NumOne, #NumTwo where 
			#NumOne.RowNum - 1 = #NumTwo.RowNum and 
			#NumOne.OrderRank - #NumTwo.OrderRank > 1
		);

	drop table #NumOne;
	drop table #NumTwo;

	--select * from Movies, WatchOverLists where Movies.Indext = WatchOverLists.MovieIndex and WatchOverLists.UserIndex = 0 order by OrderRank;

	--//Reorder rankings
	With cte As
	(
		SELECT *,
		ROW_NUMBER() OVER (ORDER BY OrderRank) AS RowNum
		FROM WatchOverLists where UserIndex = @intUserIndex
	)
	UPDATE cte SET OrderRank=RowNum-1


END

