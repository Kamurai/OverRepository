--drop PROCEDURE BubbleUpAddTargetToBox;

create PROCEDURE BubbleUpAddTargetToBox(
	@intUserIndex		int,
	@intParentBoxIndex	int
)
AS
BEGIN
	EXEC BubbleUpAddTarget @intUserIndex, @intParentBoxIndex, -2;
END