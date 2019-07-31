--drop PROCEDURE BubbleUpMoveOutBox;

create PROCEDURE BubbleUpMoveOutBox(
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
	
	EXEC BubbleUpMoveBox @intUserIndex, @intMovingBoxIndex, @intGrandParentBoxIndex;
END