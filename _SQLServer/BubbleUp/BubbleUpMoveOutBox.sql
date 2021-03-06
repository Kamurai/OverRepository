--drop PROCEDURE BubbleUpMoveOutBox;

create PROCEDURE BubbleUpMoveOutBox(
	@intUserIndex		int,
	@intMovingBoxIndex	int
)
AS
BEGIN
	DECLARE @intParentBoxIndex		int = (SELECT TOP 1 ParentBoxIndex FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex);
	DECLARE @intGrandParentBoxIndex int = (SELECT TOP 1 ParentBoxIndex FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intParentBoxIndex);

	PRINT('BubbleUpMoveOutBox');
	PRINT(CONCAT('@intParentBoxIndex: ',			@intParentBoxIndex));
	
	--if Moving Out from Root
	IF( @intGrandParentBoxIndex = -1 )
	BEGIN
		--Add new Root
		EXEC BubbleUpAddNewRoot @intUserIndex;
		SET @intGrandParentBoxIndex = (SELECT TOP 1 BoxIndex FROM BOXES WHERE UserIndex = @intUserIndex AND ParentBoxIndex = -1);
	END
	
	EXEC BubbleUpMoveBox @intUserIndex, @intMovingBoxIndex, @intGrandParentBoxIndex, -2;
END