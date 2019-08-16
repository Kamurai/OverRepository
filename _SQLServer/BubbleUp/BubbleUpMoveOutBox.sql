--drop PROCEDURE BubbleUpMoveOutBox;

create PROCEDURE BubbleUpMoveOutBox(
	@intUserIndex		int,
	@intMovingBoxIndex	int
)
AS
BEGIN
	DECLARE @intParentBoxIndex		int = (SELECT TOP 1 ParentBoxIndex FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex);
	DECLARE @intGrandParentBoxIndex int;

	--if Moving Out from Root
	IF( @intParentBoxIndex = -1 )
	BEGIN
		--Add new Root
		EXEC BubbleUpAddNewRoot @intUserIndex;
		SET @intGrandParentBoxIndex = (SELECT TOP 1 BoxIndex FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = -1);
	END
	ELSE
	BEGIN
		SET @intGrandParentBoxIndex = (SELECT TOP 1 ParentBoxIndex FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intParentBoxIndex);
	END
	
	EXEC BubbleUpMoveBox @intUserIndex, @intMovingBoxIndex, @intGrandParentBoxIndex;
END