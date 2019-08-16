--drop PROCEDURE BubbleUpMoveTargetAfter;

create PROCEDURE BubbleUpMoveTargetAfter(
	@intUserIndex		int,
	@intTargetIndex		int
)
AS
BEGIN
	PRINT('BubbleUpMoveTargetAfter');
	PRINT(CONCAT('@intUserIndex: ',		@intUserIndex));
	PRINT(CONCAT('@intTargetIndex: ',	@intTargetIndex));
	
	DECLARE @intOrderRank	int = (SELECT TOP 1 OrderRank		FROM TARGETS WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intTargetIndex) + 1;
	DECLARE @parentIndex	int = (SELECT TOP 1 ParentBoxIndex	FROM TARGETS WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intTargetIndex);
	
	EXEC BubbleUpMoveTarget @intUserIndex, @intTargetIndex, @parentIndex, @intOrderRank;
END