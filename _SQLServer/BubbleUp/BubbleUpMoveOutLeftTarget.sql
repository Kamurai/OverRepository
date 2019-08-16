--drop PROCEDURE BubbleUpMoveOutLeftTarget;

create PROCEDURE BubbleUpMoveOutLeftTarget(
	@intUserIndex					int,
	@intTargetIndex					int
)
AS
BEGIN
	DECLARE @intParentIndex			int;
	DECLARE @intParentOrderRank		int;
	DECLARE @intGrandParentIndex	int;
	DECLARE @intNeighborIndex		int;

	--Determine if Parent Box has a left neighbor
	SET @intParentIndex			= (SELECT TOP 1 ParentBoxIndex	FROM TARGETS WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intTargetIndex);
	--if Parent Box is Root
	IF(@intParentIndex = -1)
	BEGIN
		--then add new root
		EXEC BubbleUpAddNewRoot @intUserIndex;
	END
	SET @intParentOrderRank		= (SELECT TOP 1 OrderRank		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	SET @intGrandParentIndex	= (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	--if Parent Box is at leftmost position
	IF(@intParentOrderRank = 0)
	BEGIN
		--then add left neighbor to Grand Parent
		EXEC BubbleUpAddBox @intUserIndex, @intGrandParentIndex, 0;
		SET @intParentOrderRank		= (SELECT TOP 1 OrderRank		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	END
	SET @intNeighborIndex		= (SELECT TOP 1 BoxIndex		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intGrandParentIndex AND OrderRank = @intParentOrderRank-1);
	--Move Box from current Parent Box to left neighbor
	EXEC BubbleUpMoveBox @intUserIndex, @intTargetIndex, @intNeighborIndex, -2;
END