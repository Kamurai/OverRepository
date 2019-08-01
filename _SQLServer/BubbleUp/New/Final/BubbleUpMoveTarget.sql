--drop PROCEDURE BubbleUpMoveTarget;

create PROCEDURE BubbleUpMoveTarget(
	@intUserIndex			int,
	@intMovingTargetIndex	int,
	@intTargetBoxIndex		int,
	@intLocationOrderRank	int
)
AS
BEGIN
	DECLARE @parentIndex	int = (SELECT TOP 1 ParentBoxIndex	FROM TARGETS	WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intMovingTargetIndex);
	DECLARE @orderRank		int = (SELECT TOP 1 OrderRank		FROM TARGETS	WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intMovingTargetIndex);
	DECLARE @newOrderRank	int;

	--IF @intLocationOrderRank == -1
	IF(@intLocationOrderRank = -1)
	BEGIN
		SET @newOrderRank = (SELECT MAX(OrderRank)		FROM TARGETS WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intTargetBoxIndex) + 1;
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
		DECLARE @secondTargetIndex	int = (SELECT TOP 1 TargetIndex	FROM TARGETS WHERE BubbleUpUserIndex = @intUserIndex AND OrderRank = @newOrderRank);

		UPDATE TARGETS SET OrderRank = @newOrderRank	WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intMovingTargetIndex;
		UPDATE TARGETS SET OrderRank = @orderRank		WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @secondTargetIndex;
	END
	--ELSE
	ELSE
	BEGIN
		UPDATE TARGETS SET ParentBoxIndex = @intTargetBoxIndex 
		WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intMovingTargetIndex;

		EXEC BubbleUpUpdateOrderRankTargets @intUserIndex, @parentIndex, @orderRank;
	END
END