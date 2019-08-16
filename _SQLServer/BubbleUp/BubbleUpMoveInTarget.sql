--drop PROCEDURE BubbleUpMoveInTarget;

create PROCEDURE BubbleUpMoveInTarget(
	@intUserIndex			int,
	@intMovingTargetIndex	int
)
AS
BEGIN
	DECLARE @intParentBoxIndex	int = (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingTargetIndex);
	DECLARE @intChildCount		int = (SELECT COUNT(BoxIndex)		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex);

	IF( @intChildCount < 1 )
	BEGIN
		--Add new first child
		EXEC BubbleUpAddBox @intUserIndex, @intParentBoxIndex, 0;
	END

	DECLARE @intFirstChildBoxIndex int = (SELECT TOP 1 BoxIndex FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex AND OrderRank = 0);

	EXEC BubbleUpMoveTarget @intUserIndex, @intMovingTargetIndex, @intFirstChildBoxIndex;
END