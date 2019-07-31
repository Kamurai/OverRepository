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
		SET @newOrderRank = (SELECT MAX(OrderRank)		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intTargetBoxIndex) + 1;
	END
	--ELSE
	ELSE
	BEGIN
		SET @newOrderRank = @intLocationOrderRank;
	END

	UPDATE BOXES SET ParentBoxIndex = @intTargetBoxIndex, OrderRank = @newOrderRank 
	WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex;

	EXEC BubbleUpUpdateOrderRankBoxes @intUserIndex, @parentIndex, @orderRank;
END