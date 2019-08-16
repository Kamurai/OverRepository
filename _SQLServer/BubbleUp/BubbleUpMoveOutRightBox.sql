--drop PROCEDURE BubbleUpMoveOutRightBox;

create PROCEDURE BubbleUpMoveOutRightBox(
	@intUserIndex					int,
	@intBoxIndex					int
)
AS
BEGIN
	DECLARE @intParentIndex			int;
	DECLARE @intParentOrderRank		int;
	DECLARE @intParentMaxOrderRank	int;
	DECLARE @intGrandParentIndex	int;
	DECLARE @intNeighborIndex		int;
	
	--Determine if Parent Box has a right neighbor
	SET @intParentIndex			= (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);
	--if Parent Box is Root
	IF(@intParentIndex = -1)
	BEGIN
		--then add new root
		EXEC BubbleUpAddNewRoot @intUserIndex;
	END
	SET @intParentOrderRank		= (SELECT TOP 1 OrderRank		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	SET @intGrandParentIndex	= (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	SET @intParentMaxOrderRank	= (SELECT TOP 1 MAX(OrderRank)	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intGrandParentIndex);
	--if Parent Box is at rightmost position
	IF(@intParentOrderRank = @intParentMaxOrderRank)
	BEGIN
		--then add right neighbor to Grand Parent
		EXEC BubbleUpAddBox @intUserIndex, @intGrandParentIndex, -2;
		SET @intParentOrderRank		= (SELECT TOP 1 OrderRank		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	END
	SET @intNeighborIndex		= (SELECT TOP 1 BoxIndex		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intGrandParentIndex AND OrderRank = @intParentOrderRank+1);
	--Move Box from current Parent Box to right neighbor
	EXEC BubbleUpMoveBox @intUserIndex, @intBoxIndex, @intNeighborIndex, -2;
END