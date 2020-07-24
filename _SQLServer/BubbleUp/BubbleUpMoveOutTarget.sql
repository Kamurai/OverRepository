--drop PROCEDURE BubbleUpMoveOutTarget;

create PROCEDURE BubbleUpMoveOutTarget(
	@intUserIndex			int,
	@intMovingTargetIndex	int
)
AS
BEGIN
	DECLARE @intParentBoxIndex		int = (SELECT TOP 1 ParentBoxIndex FROM TARGETS WHERE UserIndex = @intUserIndex AND TargetIndex = @intMovingTargetIndex);
	DECLARE @intGrandParentBoxIndex int;

	--if Moving Out from Root
	IF( @intParentBoxIndex = -1 )
	BEGIN
		--Add new Root
		EXEC BubbleUpAddNewRoot @intUserIndex;
		SET @intGrandParentBoxIndex = (SELECT TOP 1 BoxIndex FROM BOXES WHERE UserIndex = @intUserIndex AND ParentBoxIndex = -1);
	END
	ELSE
	BEGIN
		SET @intGrandParentBoxIndex = (SELECT TOP 1 ParentBoxIndex FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intParentBoxIndex);
	END

	EXEC BubbleUpMoveTarget @intUserIndex, @intMovingTargetIndex, @intGrandParentBoxIndex;
END