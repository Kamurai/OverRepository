--drop procedure WatchOverSwapTargets;

create PROCEDURE WatchOverSwapTargets
(
    @intUserIndex int,
    @strMovie1 VARCHAR(50),
	@strMovie2 VARCHAR(50)
)
AS
BEGIN
	--//Swap and or add Movies to Personal list
	DECLARE @intMovieCount int = 0;
	DECLARE @intMovieIndex1 int = -2; --//Higher rank, lower number, at end
	DECLARE @intMovieIndex2 int = -2;

	set @intMovieCount = (
		select count(*) from Movies 
		JOIN WatchOverLists ON
			Movies.TargetIndex = WatchOverLists.MovieIndex
		where WatchOverLists.WatchOverUserIndex = @intUserIndex and (Name = @strMovie1 or Name = @strMovie2)
	);
	set @intMovieIndex1 = (select top 1 TargetIndex from Movies where Name = @strMovie1);
	set @intMovieIndex2 = (select top 1 TargetIndex from Movies where Name = @strMovie2);

	--//if Neither Target is already in the personal list
	if( @intMovieCount = 0)
	BEGIN
		--//add to table at OrderRank 0 and 1
		insert into WatchOverLists (WatchOverUserIndex, OrderRank, MovieIndex) VALUES (@intUserIndex,  0, @intMovieIndex1);
		insert into WatchOverLists (WatchOverUserIndex, OrderRank, MovieIndex) VALUES (@intUserIndex,  1, @intMovieIndex2);
	END
	ELSE
	--//else if One Target is already in the personal list
	if( @intMovieCount = 1 )
	BEGIN
		--//if one Target is first on the list
		if( (select top 1 OrderRank from WatchOverLists where WatchOverUserIndex = @intUserIndex and (MovieIndex = @intMovieIndex1 or MovieIndex = @intMovieIndex2) ) = 0 )
		BEGIN
			--//if first Target is currently in personal list and order = 0
			if( (select count(ListIndex) from WatchOverLists where WatchOverUserIndex = @intUserIndex and MovieIndex = @intMovieIndex1 and OrderRank = 0)  > 0)
			BEGIN
				--//Add the second Target to table at -1 OrderRank
				insert into WatchOverLists (WatchOverUserIndex, OrderRank, MovieIndex) VALUES (@intUserIndex, -1, @intMovieIndex2);
			END
			ELSE
			BEGIN
				--//if second Target is currently in personal list and order = 0
				if( (select count(ListIndex) from WatchOverLists where WatchOverUserIndex = @intUserIndex and MovieIndex = @intMovieIndex2 and OrderRank = 0)  > 0)
				BEGIN
					--//Add the first Target to table at -1 OrderRank
					insert into WatchOverLists (WatchOverUserIndex, OrderRank, MovieIndex) VALUES (@intUserIndex, -1, @intMovieIndex1);
				END
			END
			--//Increment all Movies on the list by 1
			update WatchOverLists set OrderRank = OrderRank + 1 where WatchOverUserIndex = @intUserIndex;
		END
		ELSE
		--//else one Target is last on the list
		BEGIN
			DECLARE @intOrderCount int = 0;
			SET @intOrderCount = (select count(ListIndex) from WatchOverLists where WatchOverUserIndex = @intUserIndex);
			--//if first Target is ordered last (at count)-1
			if( (select count(ListIndex) from WatchOverLists where MovieIndex = @intMovieIndex1 and OrderRank = @intOrderCount-1 ) > 0)
			BEGIN
				--//Add the second Target to table at (count) OrderRank
				insert into WatchOverLists (WatchOverUserIndex, OrderRank, MovieIndex) VALUES (@intUserIndex, @intOrderCount, @intMovieIndex2);
			END
			ELSE
			BEGIN
				--//if second Target is ordered last (at count)-1
				if( (select count(ListIndex) from WatchOverLists where MovieIndex = @intMovieIndex2 and OrderRank = @intOrderCount-1 ) > 0)
				BEGIN
					--//Add the first Target to table at (count) OrderRank
					insert into WatchOverLists (WatchOverUserIndex, OrderRank, MovieIndex) VALUES (@intUserIndex, @intOrderCount, @intMovieIndex1);
				END
			END
		END
	END

	--//Set variable for swapping
	DECLARE @boolSwapped bit;
	SET @boolSwapped = 0;

	--//Both Movies are NOW in the personal list
	  --//Movies should also be adjacent
	if( (select top 1 OrderRank from WatchOverLists where WatchOverUserIndex = @intUserIndex and MovieIndex = @intMovieIndex1) > (select top 1 OrderRank from WatchOverLists where WatchOverUserIndex = @intUserIndex and MovieIndex = @intMovieIndex2) )
	BEGIN
		--//Swap the orderranks on the two Movies
			--//Lower the number on the first and lock down
		update WatchOverLists set OrderRank = OrderRank-1, UpLock = 0, DownLock = 1 where WatchOverUserIndex = @intUserIndex and MovieIndex = @intMovieIndex1;
			--//Raise the number of the second and lock up
		update WatchOverLists set OrderRank = OrderRank+1, UpLock = 1, DownLock = 0 where WatchOverUserIndex = @intUserIndex and MovieIndex = @intMovieIndex2;
		SET @boolSwapped = 1;
	END
	ELSE
	BEGIN
		--//DON'T Swap the orderranks on the two Movies: already in correct order
			--//Only lock down
		update WatchOverLists set DownLock = 1 where WatchOverUserIndex = @intUserIndex and MovieIndex = @intMovieIndex1;
			--//Only lock up
		update WatchOverLists set UpLock = 1 where WatchOverUserIndex = @intUserIndex and MovieIndex = @intMovieIndex2;
	END


	--//Clear adjacent locks
		--//Get Orders of swapped Movies
	DECLARE @intMovieOrder1 int = -2;
	DECLARE @intMovieOrder2 int = -2;
	DECLARE @intMovieTotal int = 0;

	SET @intMovieOrder1 = (select top 1 OrderRank from WatchOverLists where WatchOverUserIndex = @intUserIndex and MovieIndex = @intMovieIndex1);
	SET @intMovieOrder2 = (select top 1 OrderRank from WatchOverLists where WatchOverUserIndex = @intUserIndex and MovieIndex = @intMovieIndex2);
	SET @intMovieTotal = (select count(ListIndex) from WatchOverLists where WatchOverUserIndex = @intUserIndex);

	--//if Movies were swapped
	if( @boolSwapped = 1)
	--//Clear adjacent locks
	BEGIN
		--//if Target1's OrderRank is > 0
		if( @intMovieOrder1 > 0 )
		BEGIN	
			--//set DownLock to 0 on record with -1 order and 2nd Target
			update WatchOverLists set DownLock = 0 where WatchOverUserIndex = @intUserIndex and (OrderRank = @intMovieOrder1-1 or OrderRank = @intMovieOrder2);
		END
		--//if Target2's OrderRank is < Count
		if( @intMovieOrder2 < (@intMovieTotal) )
		BEGIN
			--//set UpLock to 0 on record with +1 order and 1st Target
			update WatchOverLists set UpLock = 0 where WatchOverUserIndex = @intUserIndex and (OrderRank = @intMovieOrder2+1 or OrderRank = @intMovieOrder1);
		END
	END
END