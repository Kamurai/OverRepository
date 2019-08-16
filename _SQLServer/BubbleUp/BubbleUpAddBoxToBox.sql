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
	
	EXEC BubbleUpAddBox @intUserIndex, @intParentBoxIndex, -2;
END