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
	Memory	= @bitMemory, 
	--Genders
	Women			= @bitWomen, 
	Men				= @bitMen, 
	TransWomen		= @bitTransWomen, 
	TransMen		= @bitTransMen 
	where UserIndex = @intUserIndex;

	--//Adjust Personal list to match new preferences
	delete from BangOverLists
	where UserIndex = @intUserIndex and TargetIndex IN (
		select T.TargetIndex 
		from Celebrities T
		JOIN BangOverUsers U
			ON (
				( T.Gender = 'F' and U.Women = 0 )		or
				( T.Gender = 'M' and U.Men = 0 )		or 
				( T.Gender = 'W' and U.TransWomen = 0 )	or 
				( T.Gender = 'T' and U.TransMen = 0 )
			) 
			where U.UserIndex = @intUserIndex
	);

	select *, ROW_NUMBER() Over(order by L.Rank) as RowNum INTO #NumOne from BangOverLists L where UserIndex = @intUserIndex; 
	select *, ROW_NUMBER() Over(order by L.Rank) as RowNum INTO #NumTwo from BangOverLists L where UserIndex = @intUserIndex; 

	--//Unlock records adacent to removed records
		--//Unlock L.DownLock for L.Rank+1 < 1
		Update BangOverLists set DownLock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum + 1 = #NumTwo.RowNum and 
			#NumTwo.Rank - #NumOne.Rank > 1
		);
		
		--//Unlock L.UpLock for L.Rank-1 < 1
		Update BangOverLists set UpLock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum - 1 = #NumTwo.RowNum and 
			#NumOne.Rank - #NumTwo.Rank > 1
		);

	drop table #NumOne;
	drop table #NumTwo;

	--//Reorder L.Rankings
	With cte As
	(
		SELECT *,
		ROW_NUMBER() OVER (ORDER BY Rank) AS RowNum
		FROM BangOverLists where UserIndex = @intUserIndex
	)
	UPDATE cte SET Rank=RowNum-1
END

