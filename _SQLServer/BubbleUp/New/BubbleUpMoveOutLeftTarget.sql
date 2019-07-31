--drop PROCEDURE BubbleUpMoveOutLeftTarget;

create PROCEDURE BubbleUpMoveOutLeftTarget(
	@intUserIndex			int,
	@intTargetIndex			int
)
AS
BEGIN
	DECLARE @intOrderRank	int;
	DECLARE @intParentIndex int;

	SET @intOrderRank		= (SELECT TOP 1 OrderRank		FROM TARGETS WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intTargetIndex);
	SET @intParentIndex		= (SELECT TOP 1 ParentBoxIndex	FROM TARGETS WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intTargetIndex);
	
	





	UPDATE TARGETS set OrderRank = OrderRank - 1 WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentIndex AND OrderRank > @intOrderRank;
END