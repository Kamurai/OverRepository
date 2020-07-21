--drop procedure BangOverUpdateOptions;

create PROCEDURE BangOverUpdateOptions(
    @intUserIndex	int,
    @bitMemory		bit,
	--Genders
	@bitWomen		bit,
	@bitMen			bit,
	@bitTransWomen	bit,
	@bitTransMen	bit
)
AS
BEGIN
	--//Update preferences to match check boxes (local variables)
	update BangOverUsers set 
	BangOverMemory	= @bitMemory, 
	--Genders
	Women			= @bitWomen, 
	Men				= @bitMen, 
	TransWomen		= @bitTransWomen, 
	TransMen		= @bitTransMen 
	where BangOverUsers.BangOverUserIndex = @intUserIndex;

	--//Adjust Personal list to match new preferences
	delete from BangOverLists 
	where BangOverUserIndex = @intUserIndex and CelebrityIndex IN (
		select Celebrities.TargetIndex 
		from Celebrities 
		JOIN BangOverUsers
			ON (
				( sex = 'F' and BangOverUsers.Women = 0 )		or
				( sex = 'M' and BangOverUsers.Men = 0 )			or 
				( sex = 'W' and BangOverUsers.TransWomen = 0 )	or 
				( sex = 'T' and BangOverUsers.TransMen = 0 )
			) 
			where BangOverUsers.BangOverUserIndex = @intUserIndex
	);

	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumOne from BangOverLists where BangOverUserIndex = @intUserIndex; 
	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumTwo from BangOverLists where BangOverUserIndex = @intUserIndex; 

	--//Unlock records adacent to removed records
		--//Unlock DownLock for OrderRank+1 < 1
		Update BangOverLists set Downlock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum + 1 = #NumTwo.RowNum and 
			#NumTwo.OrderRank - #NumOne.OrderRank > 1
		);
		
		--//Unlock UpLock for OrderRank-1 < 1
		Update BangOverLists set Uplock = 0 where 
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
		FROM BangOverLists where BangOverUserIndex = @intUserIndex
	)
	UPDATE cte SET OrderRank=RowNum-1
END

