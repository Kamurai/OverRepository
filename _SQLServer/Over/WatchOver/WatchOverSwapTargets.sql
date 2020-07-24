--drop procedure WatchOverSwapTargets;

create PROCEDURE WatchOverSwapTargets(
    @intUserIndex int,
    @strMovie1 VARCHAR(50),
	@strMovie2 VARCHAR(50)
)
AS
BEGIN
	--//Swap and or add Movies to Personal list
	DECLARE @intMovieCount int = 0;
	DECLARE @intTargetIndex1 int = -2; --//Higher L.Rank, lower number, at end
	DECLARE @intTargetIndex2 int = -2;

	set @intMovieCount = (
		select count(*) from Movies T
		JOIN WatchOverLists L ON
			T.TargetIndex = L.TargetIndex
		where L.UserIndex = @intUserIndex and (T.Name = @strMovie1 or T.Name = @strMovie2)
	);
	set @intTargetIndex1 = (select top 1 T.TargetIndex from Movies T where T.Name = @strMovie1);
	set @intTargetIndex2 = (select top 1 T.TargetIndex from Movies T where T.Name = @strMovie2);

	--//if Neither Target is already in the personal list
	if( @intMovieCount = 0)
	BEGIN
		--//add to table at L.Rank 0 and 1
		insert into WatchOverLists (UserIndex, Rank, TargetIndex) VALUES (@intUserIndex,  0, @intTargetIndex1);
		insert into WatchOverLists (UserIndex, Rank, TargetIndex) VALUES (@intUserIndex,  1, @intTargetIndex2);
	END
	ELSE
	--//else if One Target is already in the personal list
	if( @intMovieCount = 1 )
	BEGIN
		--//if one Target is first on the list
		if( (select top 1 L.Rank from WatchOverLists L where L.UserIndex = @intUserIndex and (L.TargetIndex = @intTargetIndex1 or L.TargetIndex = @intTargetIndex2) ) = 0 )
		BEGIN
			--//if first Target is currently in personal list and order = 0
			if( (select count(L.ListIndex) from WatchOverLists L where L.UserIndex = @intUserIndex and L.TargetIndex = @intTargetIndex1 and L.Rank = 0)  > 0)
			BEGIN
				--//Add the second Target to table at -1 L.Rank
				insert into WatchOverLists (UserIndex, Rank, TargetIndex) VALUES (@intUserIndex, -1, @intTargetIndex2);
			END
			ELSE
			BEGIN
				--//if second Target is currently in personal list and order = 0
				if( (select count(L.ListIndex) from WatchOverLists L where L.UserIndex = @intUserIndex and L.TargetIndex = @intTargetIndex2 and L.Rank = 0)  > 0)
				BEGIN
					--//Add the first Target to table at -1 L.Rank
					insert into WatchOverLists (UserIndex, Rank, TargetIndex) VALUES (@intUserIndex, -1, @intTargetIndex1);
				END
			END
			--//Increment all Movies on the list by 1
			update WatchOverLists set Rank = Rank + 1 where UserIndex = @intUserIndex;
		END
		ELSE
		--//else one Target is last on the list
		BEGIN
			DECLARE @intOrderCount int = 0;
			SET @intOrderCount = (select count(L.ListIndex) from WatchOverLists L where L.UserIndex = @intUserIndex);
			--//if first Target is ordered last (at count)-1
			if( (select count(L.ListIndex) from WatchOverLists L where L.TargetIndex = @intTargetIndex1 and L.Rank = @intOrderCount-1 ) > 0)
			BEGIN
				--//Add the second Target to table at (count) L.Rank
				insert into WatchOverLists (UserIndex, Rank, TargetIndex) VALUES (@intUserIndex, @intOrderCount, @intTargetIndex2);
			END
			ELSE
			BEGIN
				--//if second Target is ordered last (at count)-1
				if( (select count(L.ListIndex) from WatchOverLists L where L.TargetIndex = @intTargetIndex2 and L.Rank = @intOrderCount-1 ) > 0)
				BEGIN
					--//Add the first Target to table at (count) L.Rank
					insert into WatchOverLists (UserIndex, Rank, TargetIndex) VALUES (@intUserIndex, @intOrderCount, @intTargetIndex1);
				END
			END
		END
	END

	--//Set variable for swapping
	DECLARE @boolSwapped bit;
	SET @boolSwapped = 0;

	--//Both Movies are NOW in the personal list
	  --//Movies should also be adjacent
	if( (select top 1 L.Rank from WatchOverLists L where L.UserIndex = @intUserIndex and L.TargetIndex = @intTargetIndex1) > (select top 1 L.Rank from WatchOverLists L where L.UserIndex = @intUserIndex and L.TargetIndex = @intTargetIndex2) )
	BEGIN
		--//Swap the L.Ranks on the two Movies
			--//Lower the number on the first and lock down
		update WatchOverLists set Rank = Rank-1, UpLock = 0, DownLock = 1 where UserIndex = @intUserIndex and TargetIndex = @intTargetIndex1;
			--//Raise the number of the second and lock up
		update WatchOverLists set Rank = Rank+1, UpLock = 1, DownLock = 0 where UserIndex = @intUserIndex and TargetIndex = @intTargetIndex2;
		SET @boolSwapped = 1;
	END
	ELSE
	BEGIN
		--//DON'T Swap the L.Ranks on the two Movies: already in correct order
			--//Only lock down
		update WatchOverLists set DownLock = 1 where UserIndex = @intUserIndex and TargetIndex = @intTargetIndex1;
			--//Only lock up
		update WatchOverLists set UpLock = 1 where UserIndex = @intUserIndex and TargetIndex = @intTargetIndex2;
	END
	
	--if pair of targets is not already remembered
	if(
		(
			SELECT COUNT(M.MemoryIndex) FROM WatchOverMemories M
			WHERE (M.TargetIndex1 = @intTargetIndex1 or M.TargetIndex1 = @intTargetIndex2)
			AND (M.TargetIndex2 = @intTargetIndex1 or M.TargetIndex2 = @intTargetIndex2)
		) = 0
		AND (
			(
				(SELECT top 1 U.Memory FROM WatchOverUsers U WHERE U.UserIndex = @intUserIndex) = 1
			)
		)
	)
	BEGIN
		--add memory to table
		INSERT INTO WatchOverMemories (UserIndex, TargetIndex1, TargetIndex2) VALUES (@intUserIndex, @intTargetIndex1, @intTargetIndex2);
	END
END