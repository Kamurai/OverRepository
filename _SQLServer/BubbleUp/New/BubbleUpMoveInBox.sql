--drop PROCEDURE BubbleUpMoveInBox;

create PROCEDURE BubbleUpMoveInBox(
	@intUserIndex		int,
	@intMovingBoxIndex	int
)
AS
BEGIN
	DECLARE @intParentBoxIndex		int = (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intMovingBoxIndex);
	DECLARE @intFirstChildBoxIndex	int = (SELECT TOP 1 BoxIndex		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex AND OrderRank = (SELECT MIN(OrderRank) FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex));

	IF( @intFirstChildBoxIndex = NULL OR @intFirstChildBoxIndex = @intMovingBoxIndex )
	BEGIN
		--Add new first child

		--Reassign first child
	END
	
	EXEC BubbleUpMoveBox @intUserIndex, @intMovingBoxIndex, @intFirstChildBoxIndex;
END