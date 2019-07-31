--drop PROCEDURE BubbleUpMoveInTarget;

create PROCEDURE BubbleUpMoveInTarget(
	@intUserIndex			int,
	@intMovingTargetIndex	int
)
AS
BEGIN
	DECLARE @intParentBoxIndex		int = (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingTargetIndex);
	DECLARE @intFirstChildBoxIndex	int = (SELECT TOP 1 BoxIndex		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex AND OrderRank = (SELECT MIN(OrderRank) FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex));

	IF( @intFirstChildBoxIndex = NULL )
	BEGIN
		--Add new first child

		--Reassign first child
	END
	
	EXEC BubbleUpMoveTarget @intUserIndex, @intMovingBoxIndex, @intGrandParentBoxIndex;
END