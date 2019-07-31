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
		SET @newOrderRank = (SELECT MAX(OrderRank)		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intTargetBoxIndex) + 1;
	END
	--ELSE
	ELSE
	BEGIN
		SET @newOrderRank = @intLocationOrderRank;
	END

	UPDATE TARGETS SET ParentBoxIndex = @intTargetBoxIndex 
	WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intMovingTargetIndex;

	EXEC BubbleUpUpdateOrderRankTargets @intUserIndex, @parentIndex, @orderRank;
END