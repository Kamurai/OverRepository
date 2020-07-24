--drop PROCEDURE BubbleUpMoveTargetBefore;

create PROCEDURE BubbleUpMoveTargetBefore(
	@intUserIndex		int,
	@intTargetIndex		int
)
AS
BEGIN
	PRINT('BubbleUpMoveTargetBefore');
	PRINT(CONCAT('@intUserIndex: ',		@intUserIndex));
	PRINT(CONCAT('@intTargetIndex: ',	@intTargetIndex));
	
	DECLARE @intRank		int = (SELECT TOP 1 Rank FROM TARGETS WHERE UserIndex = @intUserIndex AND TargetIndex = @intTargetIndex) - 1;
	DECLARE @parentIndex	int = (SELECT TOP 1 ParentBoxIndex	FROM TARGETS WHERE UserIndex = @intUserIndex AND TargetIndex = @intTargetIndex);
	
	EXEC BubbleUpMoveTarget @intUserIndex, @intTargetIndex, @parentIndex, @intRank;
END