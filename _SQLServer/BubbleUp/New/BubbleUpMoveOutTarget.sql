--drop PROCEDURE BubbleUpMoveOutTarget;

create PROCEDURE BubbleUpMoveOutTarget(
	@intUserIndex		int,
	@intMovingBoxIndex	int
)
AS
BEGIN
	DECLARE @intParentBoxIndex		int = (SELECT TOP 1 ParentBoxIndex FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex);
	DECLARE @intGrandParentBoxIndex int = (SELECT TOP 1 ParentBoxIndex FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intParentBoxIndex);

	IF( @intParentBoxIndex = -1 )
	BEGIN
		--Add new root
		--adjust existing root's index
	END
	
	EXEC BubbleUpMoveTarget @intUserIndex, @intMovingBoxIndex, @intGrandParentBoxIndex;
END