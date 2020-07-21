--drop procedure PlayOverSwapTargets;

create PROCEDURE PlayOverSwapTargets(
    @intUserIndex int,
    @strVideoGame1 VARCHAR(50),
	@strVideoGame2 VARCHAR(50)
)
AS
BEGIN
	--//Swap and or add VideoGames to Personal list
	DECLARE @intVideoGameCount int = 0;
	DECLARE @intVideoGameIndex1 int = -2; --//Higher rank, lower number, at end
	DECLARE @intVideoGameIndex2 int = -2;

	set @intVideoGameCount = (
		select count(*) 
		from VideoGames 
		JOIN PlayOverLists ON
		VideoGames.TargetIndex = PlayOverLists.VideoGameIndex
		where PlayOverLists.PlayOverUserIndex = @intUserIndex and (Name = @strVideoGame1 or Name = @strVideoGame2)
	);
	set @intVideoGameIndex1 = (select top 1 TargetIndex from VideoGames where Name = @strVideoGame1);
	set @intVideoGameIndex2 = (select top 1 TargetIndex from VideoGames where Name = @strVideoGame2);

	--//if Neither Target is already in the personal list
	if( @intVideoGameCount = 0)
	BEGIN
		--//add to table at OrderRank 0 and 1
		insert into PlayOverLists (PlayOverUserIndex, OrderRank, VideoGameIndex) VALUES (@intUserIndex,  0, @intVideoGameIndex1);
		insert into PlayOverLists (PlayOverUserIndex, OrderRank, VideoGameIndex) VALUES (@intUserIndex,  1, @intVideoGameIndex2);
	END
	ELSE
	--//else if One Target is already in the personal list
	if( @intVideoGameCount = 1 )
	BEGIN
		--//if one Target is first on the list
		if( (select top 1 OrderRank from PlayOverLists where PlayOverUserIndex = @intUserIndex and (VideoGameIndex = @intVideoGameIndex1 or VideoGameIndex = @intVideoGameIndex2) ) = 0 )
		BEGIN
			--//if first Target is currently in personal list and order = 0
			if( (select count(ListIndex) from PlayOverLists where PlayOverUserIndex = @intUserIndex and VideoGameIndex = @intVideoGameIndex1 and OrderRank = 0)  > 0)
			BEGIN
				--//Add the second Target to table at -1 OrderRank
				insert into PlayOverLists (PlayOverUserIndex, OrderRank, VideoGameIndex) VALUES (@intUserIndex, -1, @intVideoGameIndex2);
			END
			ELSE
			BEGIN
				--//if second Target is currently in personal list and order = 0
				if( (select count(ListIndex) from PlayOverLists where PlayOverUserIndex = @intUserIndex and VideoGameIndex = @intVideoGameIndex2 and OrderRank = 0)  > 0)
				BEGIN
					--//Add the first Target to table at -1 OrderRank
					insert into PlayOverLists (PlayOverUserIndex, OrderRank, VideoGameIndex) VALUES (@intUserIndex, -1, @intVideoGameIndex1);
				END
			END
			--//Increment all VideoGames on the list by 1
			update PlayOverLists set OrderRank = OrderRank + 1 where PlayOverUserIndex = @intUserIndex;
		END
		ELSE
		--//else one Target is last on the list
		BEGIN
			DECLARE @intOrderCount int = 0;
			SET @intOrderCount = (select count(ListIndex) from PlayOverLists where PlayOverUserIndex = @intUserIndex);
			--//if first Target is ordered last (at count)-1
			if( (select count(ListIndex) from PlayOverLists where VideoGameIndex = @intVideoGameIndex1 and OrderRank = @intOrderCount-1 ) > 0)
			BEGIN
				--//Add the second Target to table at (count) OrderRank
				insert into PlayOverLists (PlayOverUserIndex, OrderRank, VideoGameIndex) VALUES (@intUserIndex, @intOrderCount, @intVideoGameIndex2);
			END
			ELSE
			BEGIN
				--//if second Target is ordered last (at count)-1
				if( (select count(ListIndex) from PlayOverLists where VideoGameIndex = @intVideoGameIndex2 and OrderRank = @intOrderCount-1 ) > 0)
				BEGIN
					--//Add the first Target to table at (count) OrderRank
					insert into PlayOverLists (PlayOverUserIndex, OrderRank, VideoGameIndex) VALUES (@intUserIndex, @intOrderCount, @intVideoGameIndex1);
				END
			END
		END
	END

	--//Set variable for swapping
	DECLARE @boolSwapped bit;
	SET @boolSwapped = 0;

	--//Both VideoGames are NOW in the personal list
	  --//VideoGames should also be adjacent
	if( (select top 1 OrderRank from PlayOverLists where PlayOverUserIndex = @intUserIndex and VideoGameIndex = @intVideoGameIndex1) > (select top 1 OrderRank from PlayOverLists where PlayOverUserIndex = @intUserIndex and VideoGameIndex = @intVideoGameIndex2) )
	BEGIN
		--//Swap the orderranks on the two VideoGames
			--//Lower the number on the first and lock down
		update PlayOverLists set OrderRank = OrderRank-1, UpLock = 0, DownLock = 1 where PlayOverUserIndex = @intUserIndex and VideoGameIndex = @intVideoGameIndex1;
			--//Raise the number of the second and lock up
		update PlayOverLists set OrderRank = OrderRank+1, UpLock = 1, DownLock = 0 where PlayOverUserIndex = @intUserIndex and VideoGameIndex = @intVideoGameIndex2;
		SET @boolSwapped = 1;
	END
	ELSE
	BEGIN
		--//DON'T Swap the orderranks on the two VideoGames: already in correct order
			--//Only lock down
		update PlayOverLists set DownLock = 1 where PlayOverUserIndex = @intUserIndex and VideoGameIndex = @intVideoGameIndex1;
			--//Only lock up
		update PlayOverLists set UpLock = 1 where PlayOverUserIndex = @intUserIndex and VideoGameIndex = @intVideoGameIndex2;
	END
	
	--if pair of targets is not already remembered
	if(
		(
			SELECT COUNT(MemoryIndex) FROM PlayOverMemories 
			WHERE (VideoGameIndex1 = @intVideoGameIndex1 or VideoGameIndex1 = @intVideoGameIndex2)
			AND (VideoGameIndex2 = @intVideoGameIndex1 or VideoGameIndex2 = @intVideoGameIndex2)
		) = 0
		AND (
			(
				(SELECT top 1 PlayOverMemory FROM PlayOverUsers WHERE PlayOverUserIndex = @intUserIndex) = 1
			)
		)
	)
	BEGIN
		--add memory to table
		INSERT INTO PlayOverMemories (PlayOverUserIndex, VideoGameIndex1, VideoGameIndex2) VALUES (@intUserIndex, @intVideoGameIndex1, @intVideoGameIndex2);
	END


	--//Clear adjacent locks
		--//Get Orders of swapped VideoGames
	/*
	DECLARE @intVideoGameOrder1 int = -2;
	DECLARE @intVideoGameOrder2 int = -2;
	DECLARE @intVideoGameTotal int = 0;

	SET @intVideoGameOrder1 = (select top 1 OrderRank from PlayOverLists where PlayOverUserIndex = @intUserIndex and VideoGameIndex = @intVideoGameIndex1);
	SET @intVideoGameOrder2 = (select top 1 OrderRank from PlayOverLists where PlayOverUserIndex = @intUserIndex and VideoGameIndex = @intVideoGameIndex2);
	SET @intVideoGameTotal = (select count(ListIndex) from PlayOverLists where PlayOverUserIndex = @intUserIndex);

	--//if VideoGames were swapped
	if( @boolSwapped = 1)
	--//Clear adjacent locks
	BEGIN
		--//if Target1's OrderRank is > 0
		if( @intVideoGameOrder1 > 0 )
		BEGIN	
			--//set DownLock to 0 on record with -1 order and 2nd Target
			update PlayOverLists set DownLock = 0 where PlayOverUserIndex = @intUserIndex and (OrderRank = @intVideoGameOrder1-1 or OrderRank = @intVideoGameOrder2);
		END
		--//if Target2's OrderRank is < Count
		if( @intVideoGameOrder2 < (@intVideoGameTotal) )
		BEGIN
			--//set UpLock to 0 on record with +1 order and 1st Target
			update PlayOverLists set UpLock = 0 where PlayOverUserIndex = @intUserIndex and (OrderRank = @intVideoGameOrder2+1 or OrderRank = @intVideoGameOrder1);
		END
	END
	*/
END