--drop procedure BangOverUpdateOptions;

create PROCEDURE BangOverUpdateOptions
(
    @intUserIndex int,
    @bitWomen bit,
	@bitMen bit,
	@bitTransWomen bit,
	@bitTransMen bit

)
AS
BEGIN
	--//Update preferences to match check boxes (local variables)
	update BangOverUsers set Women = @bitWomen, Men = @bitMen, TransWomen = @bitTransWomen, TransMen = @bitTransMen where BangOverUsers.UserIndex = @intUserIndex;

	--select * from Users where Indext = @intUserIndex;

	
	--//Adjust Personal list to match new preferences
	delete from BangOverLists where UserIndex = @intUserIndex and CelebrityIndex IN (
	select Celebrities.Indext from Celebrities, BangOverUsers where BangOverUsers.UserIndex = @intUserIndex
		and (
			( sex = 'F' and BangOverUsers.Women = 0 )
			or ( sex = 'M' and BangOverUsers.Men = 0 )
			or ( sex = 'W' and BangOverUsers.TransWomen = 0 )
			or ( sex = 'T' and BangOverUsers.TransMen = 0 )
		)
	);

	--select * from Celebrities, BangOverLists where Celebrities.Indext = BangOverLists.CelebrityIndex and BangOverLists.UserIndex = 0 order by OrderRank;


	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumOne from BangOverLists where UserIndex = 0; 
	--select * from #NumOne;

	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumTwo from BangOverLists where UserIndex = 0; 
	--select * from #NumTwo;

	--//Unlock records adacent to removed records
		--//Unlock DownLock for OrderRank+1 < 1
		Update BangOverLists set Downlock = 0 where 
		Indext IN(
			select #NumOne.Indext from #NumOne, #NumTwo where 
			#NumOne.RowNum + 1 = #NumTwo.RowNum and 
			#NumTwo.OrderRank - #NumOne.OrderRank > 1
		);
		
		--//Unlock UpLock for OrderRank-1 < 1
		Update BangOverLists set Uplock = 0 where 
		Indext IN(
			select #NumOne.Indext from #NumOne, #NumTwo where 
			#NumOne.RowNum - 1 = #NumTwo.RowNum and 
			#NumOne.OrderRank - #NumTwo.OrderRank > 1
		);

	drop table #NumOne;
	drop table #NumTwo;

	--select * from Celebrities, BangOverLists where Celebrities.Indext = BangOverLists.CelebrityIndex and BangOverLists.UserIndex = 0 order by OrderRank;

	--//Reorder rankings
	With cte As
	(
		SELECT *,
		ROW_NUMBER() OVER (ORDER BY OrderRank) AS RowNum
		FROM BangOverLists where UserIndex = @intUserIndex
	)
	UPDATE cte SET OrderRank=RowNum-1


END

