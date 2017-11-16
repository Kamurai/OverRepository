--drop procedure ShowOverUpdateOptions;

create PROCEDURE ShowOverUpdateOptions
(
    @intUserIndex int,

    @bitComedyS bit,
	@bitDramaS bit,
	@bitActionS bit,
	@bitHorrorS bit,
	@bitThrillerS bit,
	@bitScienceFictionS bit,
	@bitFantasyS bit,
	@bitWesternS bit,
	@bitMartialArtsS bit,
	@bitDocumentaryS bit,
	@bitMockumentaryS bit

)
AS
BEGIN
	--//Update preferences to match check boxes (local variables)
	update ShowOverUsers set 
	ComedyS = @bitComedyS, 
	DramaS = @bitDramaS, 
	ActionS = @bitActionS, 
	HorrorS = @bitHorrorS, 
	ThrillerS = @bitThrillerS, 
	ScienceFictionS = @bitScienceFictionS, 
	FantasyS = @bitFantasyS, 
	WesternS = @bitWesternS, 
	MartialArtsS = @bitMartialArtsS, 
	DocumentaryS = @bitDocumentaryS, 
	MockumentaryS = @bitMockumentaryS

	where ShowOverUsers.UserIndex = @intUserIndex;

	--select * from Users where Indext = @intUserIndex;
		
	--//Adjust Personal list to match new preferences
	delete from ShowOverLists where UserIndex = @intUserIndex and ShowIndex IN (
	select Shows.Indext from Shows, ShowOverUsers where ShowOverUsers.UserIndex = @intUserIndex
		and (
			( Genre = 'ComedyS'			and ShowOverUsers.ComedyS = 0 )			or 
			( Genre = 'DramaS'			and ShowOverUsers.DramaS = 0 )			or 
			( Genre = 'ActionS'			and ShowOverUsers.ActionS = 0 )			or 
			( Genre = 'HorrorS'			and ShowOverUsers.HorrorS = 0 )			or
			( Genre = 'ThrillerS'		and ShowOverUsers.ThrillerS = 0 )		or
			( Genre = 'ScienceFictionS'	and ShowOverUsers.ScienceFictionS = 0 )	or
			( Genre = 'FantasyS'		and ShowOverUsers.FantasyS = 0 )		or
			( Genre = 'WesternS'		and ShowOverUsers.WesternS = 0 )		or
			( Genre = 'MartialArtsS'	and ShowOverUsers.MartialArtsS = 0 )	or
			( Genre = 'DocumentaryS'	and ShowOverUsers.DocumentaryS = 0 )	or
			( Genre = 'MockumentaryS'	and ShowOverUsers.MockumentaryS = 0 )
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

