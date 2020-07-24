--drop PROCEDURE BubbleUpMoveOutLeftTarget;

create PROCEDURE BubbleUpMoveOutLeftTarget(
	@intUserIndex					int,
	@intTargetIndex					int
)
AS
BEGIN
	DECLARE @intParentIndex			int;
	DECLARE @intParentRank		int;
	DECLARE @intGrandParentIndex	int;
	DECLARE @intNeighborIndex		int;

	--Determine if Parent Box has a left neighbor
	SET @intParentIndex			= (SELECT TOP 1 ParentBoxIndex	FROM TARGETS WHERE UserIndex = @intUserIndex AND TargetIndex = @intTargetIndex);
	--if Parent Box is Root
	IF(@intParentIndex = -1)
	BEGIN
		--then add new root
		EXEC BubbleUpAddNewRoot @intUserIndex;
	END
	SET @intParentRank		= (SELECT TOP 1 Rank		FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	SET @intGrandParentIndex	= (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	--if Parent Box is at leftmost position
	IF(@intParentRank = 0)
	BEGIN
		--then add left neighbor to Grand Parent
		EXEC BubbleUpAddBox @intUserIndex, @intGrandParentIndex, 0;
		SET @intParentRank		= (SELECT TOP 1 Rank		FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	END
	SET @intNeighborIndex		= (SELECT TOP 1 BoxIndex		FROM BOXES WHERE UserIndex = @intUserIndex AND ParentBoxIndex = @intGrandParentIndex AND Rank = @intParentRank-1);
	--Move Box from current Parent Box to left neighbor
	EXEC BubbleUpMoveBox @intUserIndex, @intTargetIndex, @intNeighborIndex, -2;
END