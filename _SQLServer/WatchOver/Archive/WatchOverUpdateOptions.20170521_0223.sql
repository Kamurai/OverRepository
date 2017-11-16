--drop procedure WatchOverUpdateOptions;

create PROCEDURE WatchOverUpdateOptions
(
    @intUserIndex int,

    @bitComedyM bit,
	@bitDramaM bit,
	@bitActionM bit,
	@bitHorrorM bit,
	@bitThrillerM bit,
	@bitScienceFictionM bit,
	@bitFantasyM bit,
	@bitWesternM bit,
	@bitMartialArtsM bit,
	@bitDocumentaryM bit,
	@bitMockumentaryM bit

)
AS
BEGIN
	--//Update preferences to match check boxes (local variables)
	update WatchOverUsers set 
	ComedyM = @bitComedyM, 
	DramaM = @bitDramaM, 
	ActionM = @bitActionM, 
	HorrorM = @bitHorrorM, 
	ThrillerM = @bitThrillerM, 
	ScienceFictionM = @bitScienceFictionM, 
	FantasyM = @bitFantasyM, 
	WesternM = @bitWesternM, 
	MartialArtsM = @bitMartialArtsM, 
	DocumentaryM = @bitDocumentaryM, 
	MockumentaryM = @bitMockumentaryM

	where WatchOverUsers.UserIndex = @intUserIndex;

	--select * from Users where Indext = @intUserIndex;
		
	--//Adjust Personal list to match new preferences
	delete from WatchOverLists where UserIndex = @intUserIndex and MovieIndex IN (
	select Movies.Indext from Movies, WatchOverUsers where WatchOverUsers.UserIndex = @intUserIndex
		and (
			( Genre = 'ComedyM'			and WatchOverUsers.ComedyM = 0 )			or 
			( Genre = 'DramaM'			and WatchOverUsers.DramaM = 0 )			or 
			( Genre = 'ActionM'			and WatchOverUsers.ActionM = 0 )			or 
			( Genre = 'HorrorM'			and WatchOverUsers.HorrorM = 0 )			or
			( Genre = 'ThrillerM'		and WatchOverUsers.ThrillerM = 0 )		or
			( Genre = 'ScienceFictionM'	and WatchOverUsers.ScienceFictionM = 0 )	or
			( Genre = 'FantasyM'		and WatchOverUsers.FantasyM = 0 )		or
			( Genre = 'WesternM'		and WatchOverUsers.WesternM = 0 )		or
			( Genre = 'MartialArtsM'	and WatchOverUsers.MartialArtsM = 0 )	or
			( Genre = 'DocumentaryM'	and WatchOverUsers.DocumentaryM = 0 )	or
			( Genre = 'MockumentaryM'	and WatchOverUsers.MockumentaryM = 0 )
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

