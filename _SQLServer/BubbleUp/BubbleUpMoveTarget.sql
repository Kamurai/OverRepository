--drop PROCEDURE BubbleUpMoveTarget;

create PROCEDURE BubbleUpMoveTarget(
	@intUserIndex			int,
	@intMovingTargetIndex	int,
	@intTargetBoxIndex		int,
	@intLocationRank		int
)
AS
BEGIN
	PRINT('BubbleUpMoveTarget');
	PRINT(CONCAT('@intUserIndex: ',			@intUserIndex));
	PRINT(CONCAT('@intMovingBoxIndex: ',	@intMovingTargetIndex));
	PRINT(CONCAT('@intTargetBoxIndex: ',	@intTargetBoxIndex));
	PRINT(CONCAT('@intLocationRank: ',		@intLocationRank));
	
	DECLARE @parentIndex	int = (SELECT TOP 1 ParentBoxIndex	FROM TARGETS WHERE UserIndex = @intUserIndex AND TargetIndex = @intMovingTargetIndex);
	DECLARE @Rank			int = (SELECT TOP 1 Rank			FROM TARGETS WHERE UserIndex = @intUserIndex AND TargetIndex = @intMovingTargetIndex);
	DECLARE @newRank		int;

	--IF @intLocationRank == -2
	IF(@intLocationRank = -2)
	BEGIN
		SET @newRank = (SELECT MAX(Rank) FROM TARGETS WHERE UserIndex = @intUserIndex AND ParentBoxIndex = @intTargetBoxIndex) + 1;

		IF(@newRank IS NULL)
		BEGIN
			SET @newRank = 0;
		END
	END
	--ELSE
	ELSE
	BEGIN
		SET @newRank = @intLocationRank;
	END

	PRINT(CONCAT('@parentIndex: ',			@parentIndex));
	PRINT(CONCAT('@intTargetBoxIndex: ',	@intTargetBoxIndex));
	PRINT(CONCAT('@Rank: ',					@Rank));
	PRINT(CONCAT('@newRank: ',				@newRank));
	--IF @parentIndex == @intTargetBoxIndex AND @newRank is -1 OR 1 from @Rank
	IF( (@parentIndex = @intTargetBoxIndex) AND (@newRank = @Rank-1 OR @newRank = @Rank+1) )
	BEGIN
		PRINT('ALPHA');
		--THEN swap
		--Declare secondTargetIndex
		DECLARE @SecondListIndex	int = (SELECT TOP 1 TargetIndex	FROM TARGETS WHERE UserIndex = @intUserIndex AND ParentBoxIndex = @parentIndex AND Rank = @newRank);
		PRINT(CONCAT('@SecondListIndex: ', @SecondListIndex));
	
		UPDATE TARGETS SET Rank = @newRank	WHERE UserIndex = @intUserIndex AND TargetIndex = @intMovingTargetIndex;
		UPDATE TARGETS SET Rank = @Rank		WHERE UserIndex = @intUserIndex AND TargetIndex = @SecondListIndex;
	END
	--ELSE
	ELSE
	BEGIN
		PRINT('BETA');
		--Update Rank of the new Box, increase post target Ranks
		EXEC BubbleUpUpdateRankTargets @intUserIndex, @intTargetBoxIndex, @newRank, 1;
		
		UPDATE TARGETS SET ParentBoxIndex = @intTargetBoxIndex 
		WHERE UserIndex = @intUserIndex AND TargetIndex = @intMovingTargetIndex;

		--Update Rank of the old Box, reduce post target Ranks
		EXEC BubbleUpUpdateRankTargets @intUserIndex, @parentIndex, @Rank, -1;
	END
END