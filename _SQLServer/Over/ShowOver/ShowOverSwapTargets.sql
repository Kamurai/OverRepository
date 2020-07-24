--drop procedure ShowOverSwapTargets;

create PROCEDURE ShowOverSwapTargets(
    @intUserIndex int,
    @strShow1 VARCHAR(50),
	@strShow2 VARCHAR(50)
)
AS
BEGIN
	--//Swap and or add Shows to Personal list
	DECLARE @intShowCount int = 0;
	DECLARE @intTargetIndex1 int = -2; --//Higher L.Rank, lower number, at end
	DECLARE @intTargetIndex2 int = -2;

	set @intShowCount = (
		select count(*) from Shows T
		JOIN ShowOverLists L ON
			T.TargetIndex = L.TargetIndex
		where L.UserIndex = @intUserIndex and (T.Name = @strShow1 or T.Name = @strShow2)
	);
	set @intTargetIndex1 = (select top 1 T.TargetIndex from Shows T where T.Name = @strShow1);
	set @intTargetIndex2 = (select top 1 T.TargetIndex from Shows T where T.Name = @strShow2);

	--//if Neither Target is already in the personal list
	if( @intShowCount = 0)
	BEGIN
		--//add to table at L.Rank 0 and 1
		insert into ShowOverLists (UserIndex, Rank, TargetIndex) VALUES (@intUserIndex,  0, @intTargetIndex1);
		insert into ShowOverLists (UserIndex, Rank, TargetIndex) VALUES (@intUserIndex,  1, @intTargetIndex2);
	END
	ELSE
	--//else if One Target is already in the personal list
	if( @intShowCount = 1 )
	BEGIN
		--//if one Target is first on the list
		if( (select top 1 L.Rank from ShowOverLists L where L.UserIndex = @intUserIndex and (L.TargetIndex = @intTargetIndex1 or L.TargetIndex = @intTargetIndex2) ) = 0 )
		BEGIN
			--//if first Target is currently in personal list and order = 0
			if( (select count(L.ListIndex) from ShowOverLists L where L.UserIndex = @intUserIndex and L.TargetIndex = @intTargetIndex1 and L.Rank = 0)  > 0)
			BEGIN
				--//Add the second Target to table at -1 L.Rank
				insert into ShowOverLists (UserIndex, Rank, TargetIndex) VALUES (@intUserIndex, -1, @intTargetIndex2);
			END
			ELSE
			BEGIN
				--//if second Target is currently in personal list and order = 0
				if( (select count(L.ListIndex) from ShowOverLists L where L.UserIndex = @intUserIndex and L.TargetIndex = @intTargetIndex2 and L.Rank = 0)  > 0)
				BEGIN
					--//Add the first Target to table at -1 L.Rank
					insert into ShowOverLists (UserIndex, Rank, TargetIndex) VALUES (@intUserIndex, -1, @intTargetIndex1);
				END
			END
			--//Increment all Shows on the list by 1
			update ShowOverLists set Rank = Rank + 1 where UserIndex = @intUserIndex;
		END
		ELSE
		--//else one Target is last on the list
		BEGIN
			DECLARE @intOrderCount int = 0;
			SET @intOrderCount = (select count(L.ListIndex) from ShowOverLists L where L.UserIndex = @intUserIndex);
			--//if first Target is ordered last (at count)-1
			if( (select count(L.ListIndex) from ShowOverLists L where L.TargetIndex = @intTargetIndex1 and L.Rank = @intOrderCount-1 ) > 0)
			BEGIN
				--//Add the second Target to table at (count) L.Rank
				insert into ShowOverLists (UserIndex, Rank, TargetIndex) VALUES (@intUserIndex, @intOrderCount, @intTargetIndex2);
			END
			ELSE
			BEGIN
				--//if second Target is ordered last (at count)-1
				if( (select count(L.ListIndex) from ShowOverLists L where L.TargetIndex = @intTargetIndex2 and L.Rank = @intOrderCount-1 ) > 0)
				BEGIN
					--//Add the first Target to table at (count) L.Rank
					insert into ShowOverLists (UserIndex, Rank, TargetIndex) VALUES (@intUserIndex, @intOrderCount, @intTargetIndex1);
				END
			END
		END
	END

	--//Set variable for swapping
	DECLARE @boolSwapped bit;
	SET @boolSwapped = 0;

	--//Both Shows are NOW in the personal list
	  --//Shows should also be adjacent
	if( (select top 1 L.Rank from ShowOverLists L where L.UserIndex = @intUserIndex and L.TargetIndex = @intTargetIndex1) > (select top 1 L.Rank from ShowOverLists L where L.UserIndex = @intUserIndex and L.TargetIndex = @intTargetIndex2) )
	BEGIN
		--//Swap the L.Ranks on the two Shows
			--//Lower the number on the first and lock down
		update ShowOverLists set Rank = Rank-1, UpLock = 0, DownLock = 1 where UserIndex = @intUserIndex and TargetIndex = @intTargetIndex1;
			--//Raise the number of the second and lock up
		update ShowOverLists set Rank = Rank+1, UpLock = 1, DownLock = 0 where UserIndex = @intUserIndex and TargetIndex = @intTargetIndex2;
		SET @boolSwapped = 1;
	END
	ELSE
	BEGIN
		--//DON'T Swap the L.Ranks on the two Shows: already in correct order
			--//Only lock down
		update ShowOverLists set DownLock = 1 where UserIndex = @intUserIndex and TargetIndex = @intTargetIndex1;
			--//Only lock up
		update ShowOverLists set UpLock = 1 where UserIndex = @intUserIndex and TargetIndex = @intTargetIndex2;
	END

	--if pair of targets is not already remembered
	if(
		(
			SELECT COUNT(M.MemoryIndex) FROM ShowOverMemories M
			WHERE (M.TargetIndex1 = @intTargetIndex1 or M.TargetIndex1 = @intTargetIndex2)
			AND (M.TargetIndex2 = @intTargetIndex1 or M.TargetIndex2 = @intTargetIndex2)
		) = 0
		AND (
			(
				(SELECT top 1 U.Memory FROM ShowOverUsers U WHERE U.UserIndex = @intUserIndex) = 1
			)
		)
	)
	BEGIN
		--add memory to table
		INSERT INTO ShowOverMemories (UserIndex, TargetIndex1, TargetIndex2) VALUES (@intUserIndex, @intTargetIndex1, @intTargetIndex2);
	END
END