--drop PROCEDURE BubbleUpAddBoxToBox;

create PROCEDURE BubbleUpAddBoxToBox(
	@intUserIndex		int,
	@intParentBoxIndex	int
)
AS
BEGIN
	PRINT('BubbleUpAddBoxToBox');
	PRINT(CONCAT('@intUserIndex: ',				@intUserIndex));
	PRINT(CONCAT('@intParentBoxIndex: ',		@intParentBoxIndex));

	DECLARE @taretParentId		int = -2;
	

	IF(@intParentBoxIndex = -1)
	BEGIN
		EXEC BubbleUpAddNewRoot @intUserIndex;

		SET @taretParentId = (SELECT TOP 1 BoxIndex FROM BOXES WHERE UserIndex = @intUserIndex AND ParentBoxIndex = -1);
	END
	ELSE
	BEGIN
		SET @taretParentId = @intParentBoxIndex;
	END

	EXEC BubbleUpAddBox @intUserIndex, @taretParentId, -2;
END