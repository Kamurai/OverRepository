--drop procedure ShowOverSwapTargets;

create PROCEDURE ShowOverSwapTargets
(
    @intUserIndex int,
    @strShow1 VARCHAR(50),
	@strShow2 VARCHAR(50)
)
AS
BEGIN
	--//Swap and or add Shows to Personal list
	DECLARE @intShowCount int = 0;
	DECLARE @intShowIndex1 int = -2; --//Higher rank, lower number, at end
	DECLARE @intShowIndex2 int = -2;

	set @intShowCount = (
		select count(*) from Shows 
		JOIN ShowOverLists ON
			Shows.TargetIndex = ShowOverLists.ShowIndex
		where ShowOverLists.MasterUserIndex = @intUserIndex and (Name = @strShow1 or Name = @strShow2)
	);
	set @intShowIndex1 = (select top 1 TargetIndex from Shows where Name = @strShow1);
	set @intShowIndex2 = (select top 1 TargetIndex from Shows where Name = @strShow2);

	--//if Neither Target is already in the personal list
	if( @intShowCount = 0)
	BEGIN
		--//add to table at OrderRank 0 and 1
		insert into ShowOverLists (MasterUserIndex, OrderRank, ShowIndex) VALUES (@intUserIndex,  0, @intShowIndex1);
		insert into ShowOverLists (MasterUserIndex, OrderRank, ShowIndex) VALUES (@intUserIndex,  1, @intShowIndex2);
	END
	ELSE
	--//else if One Target is already in the personal list
	if( @intShowCount = 1 )
	BEGIN
		(select * from ShowOverLists where MasterUserIndex = @intUserIndex and (ShowIndex = @intShowIndex1 or ShowIndex = @intShowIndex2) )
		--//if one Target is first on the list
		if( (select top 1 OrderRank from ShowOverLists where MasterUserIndex = @intUserIndex and (ShowIndex = @intShowIndex1 or ShowIndex = @intShowIndex2) ) = 0 )
		BEGIN
			--//if first Target is currently in personal list and order = 0
			if( (select count(ListIndex) from ShowOverLists where MasterUserIndex = @intUserIndex and ShowIndex = @intShowIndex1 and OrderRank = 0)  > 0)
			BEGIN
				--//Add the second Target to table at -1 OrderRank
				insert into ShowOverLists (MasterUserIndex, OrderRank, ShowIndex) VALUES (@intUserIndex, -1, @intShowIndex2);
			END
			ELSE
			BEGIN
				--//if second Target is currently in personal list and order = 0
				if( (select count(ListIndex) from ShowOverLists where MasterUserIndex = @intUserIndex and ShowIndex = @intShowIndex2 and OrderRank = 0)  > 0)
				BEGIN
					--//Add the first Target to table at -1 OrderRank
					insert into ShowOverLists (MasterUserIndex, OrderRank, ShowIndex) VALUES (@intUserIndex, -1, @intShowIndex1);
				END
			END
			--//Increment all Shows on the list by 1
			update ShowOverLists set OrderRank = OrderRank + 1 where MasterUserIndex = @intUserIndex;
		END
		ELSE
		--//else one Target is last on the list
		BEGIN
			DECLARE @intOrderCount int = 0;
			SET @intOrderCount = (select count(ListIndex) from ShowOverLists where MasterUserIndex = @intUserIndex);
			--//if first Target is ordered last (at count)-1
			if( (select count(ListIndex) from ShowOverLists where ShowIndex = @intShowIndex1 and OrderRank = @intOrderCount-1 ) > 0)
			BEGIN
				--//Add the second Target to table at (count) OrderRank
				insert into ShowOverLists (MasterUserIndex, OrderRank, ShowIndex) VALUES (@intUserIndex, @intOrderCount, @intShowIndex2);
			END
			ELSE
			BEGIN
				--//if second Target is ordered last (at count)-1
				if( (select count(ListIndex) from ShowOverLists where ShowIndex = @intShowIndex2 and OrderRank = @intOrderCount-1 ) > 0)
				BEGIN
					--//Add the first Target to table at (count) OrderRank
					insert into ShowOverLists (MasterUserIndex, OrderRank, ShowIndex) VALUES (@intUserIndex, @intOrderCount, @intShowIndex1);
				END
			END
		END
	END

	--//Set variable for swapping
	DECLARE @boolSwapped bit;
	SET @boolSwapped = 0;

	--//Both Shows are NOW in the personal list
	  --//Shows should also be adjacent
	if( (select top 1 OrderRank from ShowOverLists where MasterUserIndex = @intUserIndex and ShowIndex = @intShowIndex1) > (select top 1 OrderRank from ShowOverLists where MasterUserIndex = @intUserIndex and ShowIndex = @intShowIndex2) )
	BEGIN
		--//Swap the orderranks on the two Shows
			--//Lower the number on the first and lock down
		update ShowOverLists set OrderRank = OrderRank-1, UpLock = 0, DownLock = 1 where MasterUserIndex = @intUserIndex and ShowIndex = @intShowIndex1;
			--//Raise the number of the second and lock up
		update ShowOverLists set OrderRank = OrderRank+1, UpLock = 1, DownLock = 0 where MasterUserIndex = @intUserIndex and ShowIndex = @intShowIndex2;
		SET @boolSwapped = 1;
	END
	ELSE
	BEGIN
		--//DON'T Swap the orderranks on the two Shows: already in correct order
		--//update ShowOverLists set OrderRank = OrderRank-1 where MasterUserIndex = @intUserIndex and ShowIndex = @intShowIndex1;
		--//update ShowOverLists set OrderRank = OrderRank+1 where MasterUserIndex = @intUserIndex and ShowIndex = @intShowIndex2;
			--//Only lock down
		update ShowOverLists set DownLock = 1 where MasterUserIndex = @intUserIndex and ShowIndex = @intShowIndex1;
			--//Only lock up
		update ShowOverLists set UpLock = 1 where MasterUserIndex = @intUserIndex and ShowIndex = @intShowIndex2;
	END


	--//Clear adjacent locks
		--//Get Orders of swapped Shows
	DECLARE @intShowOrder1 int = -2;
	DECLARE @intShowOrder2 int = -2;
	DECLARE @intShowTotal int = 0;

	SET @intShowOrder1 = (select top 1 OrderRank from ShowOverLists where MasterUserIndex = @intUserIndex and ShowIndex = @intShowIndex1);
	SET @intShowOrder2 = (select top 1 OrderRank from ShowOverLists where MasterUserIndex = @intUserIndex and ShowIndex = @intShowIndex2);
	SET @intShowTotal = (select count(ListIndex) from ShowOverLists where MasterUserIndex = @intUserIndex);

	--//if Shows were swapped
	if( @boolSwapped = 1)
	--//Clear adjacent locks
	BEGIN
		--//if Target1's OrderRank is > 0
		if( @intShowOrder1 > 0 )
		BEGIN	
			--//set DownLock to 0 on record with -1 order and 2nd Target
			update ShowOverLists set DownLock = 0 where MasterUserIndex = @intUserIndex and (OrderRank = @intShowOrder1-1 or OrderRank = @intShowOrder2);
		END
		--//if Target2's OrderRank is < Count
		if( @intShowOrder2 < (@intShowTotal) )
		BEGIN
			--//set UpLock to 0 on record with +1 order and 1st Target
			update ShowOverLists set UpLock = 0 where MasterUserIndex = @intUserIndex and (OrderRank = @intShowOrder2+1 or OrderRank = @intShowOrder1);
		END
	END
END