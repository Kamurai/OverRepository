DECLARE @intUserIndex int = 0;
DECLARE @strCelebrity1 VARCHAR(MAX) = 'Kristen Bell';
DECLARE @strCelebrity2 VARCHAR(MAX) = 'Bonnie Wright';

select * from Celebrities, BangOverLists where Celebrities.Indext = BangOverLists.CelebrityIndex and BangOverLists.UserIndex = @intUserIndex order by OrderRank;

--//Swap and or add Celebrities to Personal list
DECLARE @intCelebrityCount int = 0;
DECLARE @intCelebrityIndex1 int = -2; --//Higher rank, lower number, at end
DECLARE @intCelebrityIndex2 int = -2;

set @intCelebrityCount = (select count(*) from Celebrities, BangOverLists where Celebrities.Indext = BangOverLists.CelebrityIndex and BangOverLists.UserIndex = @intUserIndex and (Name = @strCelebrity1 or Name = @strCelebrity2));
set @intCelebrityIndex1 = (select top 1 Indext from Celebrities where Name = @strCelebrity1);
set @intCelebrityIndex2 = (select top 1 Indext from Celebrities where Name = @strCelebrity2);

--//if Neither Celebrity is already in the personal list
if( @intCelebrityCount = 0)
BEGIN
	--//add to table at OrderRank 0 and 1
	insert into BangOverLists (UserIndex, OrderRank, CelebrityIndex) VALUES (@intUserIndex,  0, @intCelebrityIndex1);
	insert into BangOverLists (UserIndex, OrderRank, CelebrityIndex) VALUES (@intUserIndex,  1, @intCelebrityIndex2);
END
ELSE
--//else if One Celebrity is already in the personal list
if( @intCelebrityCount = 1 )
BEGIN
	(select * from BangOverLists where UserIndex = @intUserIndex and (CelebrityIndex = @intCelebrityIndex1 or CelebrityIndex = @intCelebrityIndex2) )
	--//if one celebrity is first on the list
	if( (select top 1 OrderRank from BangOverLists where UserIndex = @intUserIndex and (CelebrityIndex = @intCelebrityIndex1 or CelebrityIndex = @intCelebrityIndex2) ) = 0 )
	BEGIN
		--//if first celebrity is currently in personal list and order = 0
		if( (select count(Indext) from BangOverLists where UserIndex = @intUserIndex and CelebrityIndex = @intCelebrityIndex1 and OrderRank = 0)  > 0)
		BEGIN
			--//Add the second celebrity to table at -1 OrderRank
			insert into BangOverLists (UserIndex, OrderRank, CelebrityIndex) VALUES (@intUserIndex, -1, @intCelebrityIndex2);
		END
		ELSE
		BEGIN
			--//if second celebrity is currently in personal list and order = 0
			if( (select count(Indext) from BangOverLists where UserIndex = @intUserIndex and CelebrityIndex = @intCelebrityIndex2 and OrderRank = 0)  > 0)
			BEGIN
				--//Add the first celebrity to table at -1 OrderRank
				insert into BangOverLists (UserIndex, OrderRank, CelebrityIndex) VALUES (@intUserIndex, -1, @intCelebrityIndex1);
			END
		END
		--//Increment all celebrities on the list by 1
		update BangOverLists set OrderRank = OrderRank + 1 where UserIndex = @intUserIndex;
	END
	ELSE
	--//else one celebrity is last on the list
	BEGIN
		DECLARE @intOrderCount int = 0;
		SET @intOrderCount = (select count(Indext) from BangOverLists where UserIndex = @intUserIndex);
		--//if first celebrity is ordered last (at count)-1
		if( (select count(Indext) from BangOverLists where CelebrityIndex = @intCelebrityIndex1 and OrderRank = @intOrderCount-1 ) > 0)
		BEGIN
			--//Add the second celebrity to table at (count) OrderRank
			insert into BangOverLists (UserIndex, OrderRank, CelebrityIndex) VALUES (@intUserIndex, @intOrderCount, @intCelebrityIndex2);
		END
		ELSE
		BEGIN
			--//if second celebrity is ordered last (at count)-1
			if( (select count(Indext) from BangOverLists where CelebrityIndex = @intCelebrityIndex2 and OrderRank = @intOrderCount-1 ) > 0)
			BEGIN
				--//Add the first celebrity to table at (count) OrderRank
				insert into BangOverLists (UserIndex, OrderRank, CelebrityIndex) VALUES (@intUserIndex, @intOrderCount, @intCelebrityIndex1);
			END
		END
	END
END

--//Set variable for swapping
DECLARE @boolSwapped bit;
SET @boolSwapped = 0;

--//Both Celebrities are NOW in the personal list
  --//Celebrities should also be adjacent
if( (select top 1 OrderRank from BangOverLists where UserIndex = @intUserIndex and CelebrityIndex = @intCelebrityIndex1) > (select top 1 OrderRank from BangOverLists where UserIndex = @intUserIndex and CelebrityIndex = @intCelebrityIndex2) )
BEGIN
	--//Swap the orderranks on the two celebrities
		--//Lower the number on the first and lock down
	update BangOverLists set OrderRank = OrderRank-1, UpLock = 0, DownLock = 1 where UserIndex = @intUserIndex and CelebrityIndex = @intCelebrityIndex1;
		--//Raise the number of the second and lock up
	update BangOverLists set OrderRank = OrderRank+1, UpLock = 1, DownLock = 0 where UserIndex = @intUserIndex and CelebrityIndex = @intCelebrityIndex2;
	SET @boolSwapped = 1;
END
ELSE
BEGIN
	--//DON'T Swap the orderranks on the two celebrities: already in correct order
	--//update BangOverLists set OrderRank = OrderRank-1 where UserIndex = @intUserIndex and CelebrityIndex = @intCelebrityIndex1;
	--//update BangOverLists set OrderRank = OrderRank+1 where UserIndex = @intUserIndex and CelebrityIndex = @intCelebrityIndex2;
		--//Only lock down
	update BangOverLists set DownLock = 1 where UserIndex = @intUserIndex and CelebrityIndex = @intCelebrityIndex1;
		--//Only lock up
	update BangOverLists set UpLock = 1 where UserIndex = @intUserIndex and CelebrityIndex = @intCelebrityIndex2;
END


--//Clear adjacent locks
	--//Get Orders of swapped Celebrities
DECLARE @intCelebrityOrder1 int = -2;
DECLARE @intCelebrityOrder2 int = -2;
DECLARE @intCelebrityTotal int = 0;

SET @intCelebrityOrder1 = (select top 1 OrderRank from BangOverLists where UserIndex = @intUserIndex and CelebrityIndex = @intCelebrityIndex1);
SET @intCelebrityOrder2 = (select top 1 OrderRank from BangOverLists where UserIndex = @intUserIndex and CelebrityIndex = @intCelebrityIndex2);
SET @intCelebrityTotal = (select count(Indext) from BangOverLists where UserIndex = @intUserIndex);

--//if celebrities were swapped
if( @boolSwapped = 1)
--//Clear adjacent locks
BEGIN
	--//if Celebrity1's OrderRank is > 0
	if( @intCelebrityOrder1 > 0 )
	BEGIN	
		--//set DownLock to 0 on record with -1 order and 2nd Celebrity
		update BangOverLists set DownLock = 0 where UserIndex = @intUserIndex and (OrderRank = @intCelebrityOrder1-1 or OrderRank = @intCelebrityOrder2);
	END
	--//if Celebrity2's OrderRank is < Count
	if( @intCelebrityOrder2 < (@intCelebrityTotal) )
	BEGIN
		--//set UpLock to 0 on record with +1 order and 1st Celebrity
		update BangOverLists set UpLock = 0 where UserIndex = @intUserIndex and (OrderRank = @intCelebrityOrder2+1 or OrderRank = @intCelebrityOrder1);
	END
END




--select * from Celebrities, BangOverLists where Celebrities.Indext = BangOverLists.CelebrityIndex and BangOverLists.UserIndex = @intUserIndex order by OrderRank;


--update BangOverLists set Uplock = 0 where Indext = 97



SwapCelebrities 1, 'April Bowlby', 'Kristen Bell';