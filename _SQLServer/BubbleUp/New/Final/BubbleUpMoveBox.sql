 --drop PROCEDURE BubbleUpMoveBox;

create PROCEDURE BubbleUpMoveBox(
	@intUserIndex			int,
	@intMovingBoxIndex		int,
	@intTargetBoxIndex		int,
	@intLocationOrderRank	int
)
AS
BEGIN
	DECLARE @parentIndex	int = (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex);
	DECLARE @orderRank		int = (SELECT TOP 1 OrderRank		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex);
	DECLARE @newOrderRank	int;

	--IF @intLocationOrderRank == -1
	IF(@intLocationOrderRank = -1)
	BEGIN
		SET @newOrderRank = (SELECT MAX(OrderRank)		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intTargetBoxIndex) + 1;
	END
	--ELSE
	ELSE
	BEGIN
		SET @newOrderRank = @intLocationOrderRank;
	END

	--IF @parentIndex == @intTargetBoxIndex AND @newOrderRank is -1 OR 1 from @orderRank
	IF( (@parentIndex = @intTargetBoxIndex) AND (@newOrderRank = @orderRank-1 OR @newOrderRank = @orderRank+1) )
	BEGIN
		--THEN swap
		--Declare secondTargetIndex
		DECLARE @secondTargetIndex	int = (SELECT TOP 1 BoxIndex	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND OrderRank = @newOrderRank);

		UPDATE BOXES SET OrderRank = @newOrderRank	WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex;
		UPDATE BOXES SET OrderRank = @orderRank		WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @secondTargetIndex;
	END
	--ELSE
	ELSE
	BEGIN
		UPDATE BOXES SET ParentBoxIndex = @intTargetBoxIndex, OrderRank = @newOrderRank 
		WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex;

		EXEC BubbleUpUpdateOrderRankBoxes @intUserIndex, @parentIndex, @orderRank;
	END
END