--drop procedure BoardOverSwapTargets;

create PROCEDURE BoardOverSwapTargets(
    @intUserIndex int,
    @strBoardGame1 VARCHAR(50),
	@strBoardGame2 VARCHAR(50)
)
AS
BEGIN
	--//Swap and or add BoardGames to Personal list
	DECLARE @intBoardGameCount int = 0;
	DECLARE @intBoardGameIndex1 int = -2; --//Higher rank, lower number, at end
	DECLARE @intBoardGameIndex2 int = -2;

	set @intBoardGameCount = (
		select count(*) 
		from BoardGames 
		JOIN BoardOverLists ON
		BoardGames.TargetIndex = BoardOverLists.BoardGameIndex
		where BoardOverLists.BoardOverUserIndex = @intUserIndex and (Name = @strBoardGame1 or Name = @strBoardGame2)
	);
	set @intBoardGameIndex1 = (select top 1 TargetIndex from BoardGames where Name = @strBoardGame1);
	set @intBoardGameIndex2 = (select top 1 TargetIndex from BoardGames where Name = @strBoardGame2);

	--//if Neither Target is already in the personal list
	if( @intBoardGameCount = 0)
	BEGIN
		--//add to table at OrderRank 0 and 1
		insert into BoardOverLists (BoardOverUserIndex, OrderRank, BoardGameIndex) VALUES (@intUserIndex,  0, @intBoardGameIndex1);
		insert into BoardOverLists (BoardOverUserIndex, OrderRank, BoardGameIndex) VALUES (@intUserIndex,  1, @intBoardGameIndex2);
	END
	ELSE
	--//else if One Target is already in the personal list
	if( @intBoardGameCount = 1 )
	BEGIN
		--//if one Target is first on the list
		if( (select top 1 OrderRank from BoardOverLists where BoardOverUserIndex = @intUserIndex and (BoardGameIndex = @intBoardGameIndex1 or BoardGameIndex = @intBoardGameIndex2) ) = 0 )
		BEGIN
			--//if first Target is currently in personal list and order = 0
			if( (select count(ListIndex) from BoardOverLists where BoardOverUserIndex = @intUserIndex and BoardGameIndex = @intBoardGameIndex1 and OrderRank = 0)  > 0)
			BEGIN
				--//Add the second Target to table at -1 OrderRank
				insert into BoardOverLists (BoardOverUserIndex, OrderRank, BoardGameIndex) VALUES (@intUserIndex, -1, @intBoardGameIndex2);
			END
			ELSE
			BEGIN
				--//if second Target is currently in personal list and order = 0
				if( (select count(ListIndex) from BoardOverLists where BoardOverUserIndex = @intUserIndex and BoardGameIndex = @intBoardGameIndex2 and OrderRank = 0)  > 0)
				BEGIN
					--//Add the first Target to table at -1 OrderRank
					insert into BoardOverLists (BoardOverUserIndex, OrderRank, BoardGameIndex) VALUES (@intUserIndex, -1, @intBoardGameIndex1);
				END
			END
			--//Increment all BoardGames on the list by 1
			update BoardOverLists set OrderRank = OrderRank + 1 where BoardOverUserIndex = @intUserIndex;
		END
		ELSE
		--//else one Target is last on the list
		BEGIN
			DECLARE @intOrderCount int = 0;
			SET @intOrderCount = (select count(ListIndex) from BoardOverLists where BoardOverUserIndex = @intUserIndex);
			--//if first Target is ordered last (at count)-1
			if( (select count(ListIndex) from BoardOverLists where BoardGameIndex = @intBoardGameIndex1 and OrderRank = @intOrderCount-1 ) > 0)
			BEGIN
				--//Add the second Target to table at (count) OrderRank
				insert into BoardOverLists (BoardOverUserIndex, OrderRank, BoardGameIndex) VALUES (@intUserIndex, @intOrderCount, @intBoardGameIndex2);
			END
			ELSE
			BEGIN
				--//if second Target is ordered last (at count)-1
				if( (select count(ListIndex) from BoardOverLists where BoardGameIndex = @intBoardGameIndex2 and OrderRank = @intOrderCount-1 ) > 0)
				BEGIN
					--//Add the first Target to table at (count) OrderRank
					insert into BoardOverLists (BoardOverUserIndex, OrderRank, BoardGameIndex) VALUES (@intUserIndex, @intOrderCount, @intBoardGameIndex1);
				END
			END
		END
	END

	--//Set variable for swapping
	DECLARE @boolSwapped bit;
	SET @boolSwapped = 0;

	--//Both BoardGames are NOW in the personal list
	  --//BoardGames should also be adjacent
	if( (select top 1 OrderRank from BoardOverLists where BoardOverUserIndex = @intUserIndex and BoardGameIndex = @intBoardGameIndex1) > (select top 1 OrderRank from BoardOverLists where BoardOverUserIndex = @intUserIndex and BoardGameIndex = @intBoardGameIndex2) )
	BEGIN
		--//Swap the orderranks on the two BoardGames
			--//Lower the number on the first and lock down
		update BoardOverLists set OrderRank = OrderRank-1, UpLock = 0, DownLock = 1 where BoardOverUserIndex = @intUserIndex and BoardGameIndex = @intBoardGameIndex1;
			--//Raise the number of the second and lock up
		update BoardOverLists set OrderRank = OrderRank+1, UpLock = 1, DownLock = 0 where BoardOverUserIndex = @intUserIndex and BoardGameIndex = @intBoardGameIndex2;
		SET @boolSwapped = 1;
	END
	ELSE
	BEGIN
		--//DON'T Swap the orderranks on the two BoardGames: already in correct order
			--//Only lock down
		update BoardOverLists set DownLock = 1 where BoardOverUserIndex = @intUserIndex and BoardGameIndex = @intBoardGameIndex1;
			--//Only lock up
		update BoardOverLists set UpLock = 1 where BoardOverUserIndex = @intUserIndex and BoardGameIndex = @intBoardGameIndex2;
	END
	
	--if pair of targets is not already remembered
	if(
		(
			SELECT COUNT(MemoryIndex) FROM BoardOverMemories 
			WHERE (BoardGameIndex1 = @intBoardGameIndex1 or BoardGameIndex1 = @intBoardGameIndex2)
			AND (BoardGameIndex2 = @intBoardGameIndex1 or BoardGameIndex2 = @intBoardGameIndex2)
		) = 0
		AND (
			(
				(SELECT top 1 BangOverMemory FROM BangOverUsers WHERE BangOverUserIndex = @intUserIndex) = 1
			)
		)
	)
	BEGIN
		--add memory to table
		INSERT INTO BoardOverMemories (BoardOverUserIndex, BoardGameIndex1, BoardGameIndex2) VALUES (@intUserIndex, @intBoardGameIndex1, @intBoardGameIndex2);
	END
	

	--//Clear adjacent locks
		--//Get Orders of swapped BoardGames
	/*
	DECLARE @intBoardGameOrder1 int = -2;
	DECLARE @intBoardGameOrder2 int = -2;
	DECLARE @intBoardGameTotal int = 0;

	SET @intBoardGameOrder1 = (select top 1 OrderRank from BoardOverLists where BoardOverUserIndex = @intUserIndex and BoardGameIndex = @intBoardGameIndex1);
	SET @intBoardGameOrder2 = (select top 1 OrderRank from BoardOverLists where BoardOverUserIndex = @intUserIndex and BoardGameIndex = @intBoardGameIndex2);
	SET @intBoardGameTotal = (select count(ListIndex) from BoardOverLists where BoardOverUserIndex = @intUserIndex);

	--//if BoardGames were swapped
	if( @boolSwapped = 1)
	--//Clear adjacent locks
	BEGIN
		--//if Target1's OrderRank is > 0
		if( @intBoardGameOrder1 > 0 )
		BEGIN	
			--//set DownLock to 0 on record with -1 order and 2nd Target
			update BoardOverLists set DownLock = 0 where BoardOverUserIndex = @intUserIndex and (OrderRank = @intBoardGameOrder1-1 or OrderRank = @intBoardGameOrder2);
		END
		--//if Target2's OrderRank is < Count
		if( @intBoardGameOrder2 < (@intBoardGameTotal) )
		BEGIN
			--//set UpLock to 0 on record with +1 order and 1st Target
			update BoardOverLists set UpLock = 0 where BoardOverUserIndex = @intUserIndex and (OrderRank = @intBoardGameOrder2+1 or OrderRank = @intBoardGameOrder1);
		END
	END
	*/
END