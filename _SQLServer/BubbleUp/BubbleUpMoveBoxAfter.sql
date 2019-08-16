--drop PROCEDURE BubbleUpMoveBoxAfter;

create PROCEDURE BubbleUpMoveBoxAfter(
	@intUserIndex		int,
	@intBoxIndex		int
)
AS
BEGIN
	PRINT('BubbleUpMoveBoxAfter');
	PRINT(CONCAT('@intUserIndex: ',		@intUserIndex));
	PRINT(CONCAT('@intBoxIndex: ',		@intBoxIndex));
	
	DECLARE @intOrderRank	int = (SELECT TOP 1 OrderRank		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex) + 1;
	DECLARE @parentIndex	int = (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);
	
	EXEC BubbleUpMoveBox @intUserIndex, @intBoxIndex, @parentIndex, @intOrderRank;
END