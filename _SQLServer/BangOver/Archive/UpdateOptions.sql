DECLARE @intUserIndex int = 0;
DECLARE @bitWomen bit = 0;
DECLARE @bitMen bit = 0;
DECLARE @bitTransWomen bit = 0;
DECLARE @bitTransMen bit = 1;


--//Update preferences to match check boxes (local variables)
update Users set Women = @bitWomen, Men = @bitMen, TransWomen = @bitTransWomen, TransMen = @bitTransMen where Indext = @intUserIndex;

--select * from Users where Indext = @intUserIndex;

	
--//Adjust Personal list to match new preferences
delete from BangOverLists where UserIndex = @intUserIndex and CelebrityIndex IN (
select Celebrities.Indext from Celebrities, Users where Users.Indext = @intUserIndex
	and (
		( sex = 'F' and Users.Women = 0 )
		or ( sex = 'M' and Users.Men = 0 )
		or ( sex = 'W' and Users.TransWomen = 0 )
		or ( sex = 'T' and Users.TransMen = 0 )
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

/*
update BangOverLists SET UpLock = 1, DownLock = 1 where UserIndex = 0 and OrderRank != 0 and OrderRank != 13;
update BangOverLists SET DownLock = 1 where UserIndex = 0 and OrderRank = 0;
update BangOverLists SET UpLock = 1 where UserIndex = 0 and OrderRank = 13;
	*/