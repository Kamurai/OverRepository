 --drop PROCEDURE BubbleUpMoveBox;

create PROCEDURE BubbleUpMoveBox(
	@intUserIndex			int,
	@intMovingBoxIndex		int,
	@intTargetBoxIndex		int,
	@intLocationOrderRank	int
)
AS
BEGIN
	PRINT('BubbleUpMoveBox');
	PRINT(CONCAT('@intUserIndex: ',			@intUserIndex));
	PRINT(CONCAT('@intMovingBoxIndex: ',	@intMovingBoxIndex));
	PRINT(CONCAT('@intTargetBoxIndex: ',	@intTargetBoxIndex));
	PRINT(CONCAT('@intLocationOrderRank: ',	@intLocationOrderRank));
	
	
	DECLARE @parentIndex	int = (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex);
	DECLARE @orderRank		int = (SELECT TOP 1 OrderRank		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex);
	DECLARE @newOrderRank	int;

	--IF @intLocationOrderRank == -2
	IF(@intLocationOrderRank = -2)
	BEGIN
		SET @newOrderRank = (SELECT MAX(OrderRank) FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intTargetBoxIndex) + 1;

		IF(@newOrderRank IS NULL)
		BEGIN
			SET @newOrderRank = 0;
		END
	END
	--ELSE
	ELSE
	BEGIN
		SET @newOrderRank = @intLocationOrderRank;
	END


	PRINT(CONCAT('@parentIndex: ',			@parentIndex));
	PRINT(CONCAT('@intTargetBoxIndex: ',	@intTargetBoxIndex));
	PRINT(CONCAT('@orderRank: ',			@orderRank));
	PRINT(CONCAT('@newOrderRank: ',			@newOrderRank));
	--IF @parentIndex == @intTargetBoxIndex AND @newOrderRank is -1 OR 1 from @orderRank
	IF( (@parentIndex = @intTargetBoxIndex) AND (@newOrderRank = @orderRank-1 OR @newOrderRank = @orderRank+1) )
	BEGIN
		PRINT('ALPHA');
		--THEN swap
		--Declare secondTargetIndex
		DECLARE @secondTargetIndex	int = (SELECT TOP 1 BoxIndex FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @parentIndex AND OrderRank = @newOrderRank);
		PRINT(CONCAT('@secondTargetIndex: ', @secondTargetIndex));
	
		UPDATE BOXES SET OrderRank = @newOrderRank	WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex;
		UPDATE BOXES SET OrderRank = @orderRank		WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @secondTargetIndex;
	END
	--ELSE
	ELSE
	BEGIN
		PRINT('BETA');
		--Update OrderRank of the new Box, increase post target OrderRanks
		EXEC BubbleUpUpdateOrderRankBoxes @intUserIndex, @intTargetBoxIndex, @newOrderRank, 1;
		
		UPDATE BOXES SET ParentBoxIndex = @intTargetBoxIndex 
		WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex;

		--Update OrderRank of the old Box, reduce post target OrderRanks
		EXEC BubbleUpUpdateOrderRankBoxes @intUserIndex, @parentIndex, @orderRank, -1;
	END
END