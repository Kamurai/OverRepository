--drop PROCEDURE BubbleUpMoveInBox;

create PROCEDURE BubbleUpMoveInBox(
	@intUserIndex		int,
	@intMovingBoxIndex	int
)
AS
BEGIN
	DECLARE @intParentBoxIndex	int = (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex);
	DECLARE @intChildCount		int = (SELECT COUNT(BoxIndex)		FROM BOXES WHERE UserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex AND BoxIndex != @intMovingBoxIndex);

	IF( @intChildCount < 1 )
	BEGIN
		--Add new first child
		EXEC BubbleUpAddBox @intUserIndex, @intParentBoxIndex, 0;
	END

	DECLARE @intFirstChildBoxIndex int = (SELECT TOP 1 BoxIndex FROM BOXES WHERE UserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex AND Rank = 0);

	EXEC BubbleUpMoveBox @intUserIndex, @intMovingBoxIndex, @intFirstChildBoxIndex;
END