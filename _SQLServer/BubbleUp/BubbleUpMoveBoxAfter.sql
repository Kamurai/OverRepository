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
	
	DECLARE @intRank		int = (SELECT TOP 1 Rank			FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intBoxIndex) + 1;
	DECLARE @parentIndex	int = (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);
	
	EXEC BubbleUpMoveBox @intUserIndex, @intBoxIndex, @parentIndex, @intRank;
END