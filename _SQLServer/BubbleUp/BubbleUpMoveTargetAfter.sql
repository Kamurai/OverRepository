--drop PROCEDURE BubbleUpMoveTargetAfter;

create PROCEDURE BubbleUpMoveTargetAfter
(
	@intUserIndex		int,
	@intTargetIndex		int
)
AS
BEGIN
	DECLARE @intOrderRank int;
	DECLARE @intSecondTarget int;
	DECLARE @intMaxRank int;

	SET @intOrderRank		= (SELECT TOP 1 OrderRank FROM TARGETS WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intTargetIndex);
	SET @intMaxRank			= (SELECT TOP 1 max(T1.OrderRank) FROM TARGETS T1 JOIN TARGETS T2 ON T1.ParentBoxIndex = T2.ParentBoxIndex
	WHERE T2.BubbleUpUserIndex = @intUserIndex AND T2.TargetIndex = @intTargetIndex);

	IF(@intOrderRank < @intMaxRank)
	BEGIN
		SET @intSecondTarget	= (SELECT TOP 1 T1.TargetIndex FROM TARGETS T1 JOIN TARGETS T2 ON T1.ParentBoxIndex = T2.ParentBoxIndex
			WHERE T2.BubbleUpUserIndex = @intUserIndex AND T2.TargetIndex = @intTargetIndex AND T1.OrderRank = T2.OrderRank+1);
		UPDATE TARGETS SET OrderRank = @intOrderRank WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intSecondTarget;
		UPDATE TARGETS SET OrderRank = @intOrderRank+1 WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intTargetIndex;
	END
END