--drop PROCEDURE BubbleUpMoveOutRightTarget;

create PROCEDURE BubbleUpMoveOutRightTarget(
	@intUserIndex					int,
	@intTargetIndex					int
)
AS
BEGIN
	DECLARE @intParentIndex			int;
	DECLARE @intParentRank			int;
	DECLARE @intParentMaxRank		int;
	DECLARE @intGrandParentIndex	int;
	DECLARE @intNeighborIndex		int;
	
	--Determine if Parent Box has a right neighbor
	SET @intParentIndex			= (SELECT TOP 1 ParentBoxIndex	FROM TARGETS WHERE UserIndex = @intUserIndex AND TargetIndex = @intTargetIndex);
	--if Parent Box is Root
	IF(@intParentIndex = -1)
	BEGIN
		--then add new root
		EXEC BubbleUpAddNewRoot @intUserIndex;
	END
	SET @intParentRank			= (SELECT TOP 1 Rank			FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	SET @intGrandParentIndex	= (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	SET @intParentMaxRank		= (SELECT TOP 1 MAX(Rank)		FROM BOXES WHERE UserIndex = @intUserIndex AND ParentBoxIndex = @intGrandParentIndex);
	--if Parent Box is at rightmost position
	IF(@intParentRank = @intParentMaxRank)
	BEGIN
		--then add right neighbor to Grand Parent
		EXEC BubbleUpAddBox @intUserIndex, @intGrandParentIndex, -2;
		SET @intParentRank		= (SELECT TOP 1 Rank		FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	END
	SET @intNeighborIndex		= (SELECT TOP 1 BoxIndex		FROM BOXES WHERE UserIndex = @intUserIndex AND ParentBoxIndex = @intGrandParentIndex AND Rank = @intParentRank+1);
	--Move Box from current Parent Box to right neighbor
	EXEC BubbleUpMoveBox @intUserIndex, @intTargetIndex, @intNeighborIndex, -2;
END