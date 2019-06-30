--drop PROCEDURE BubbleUpMoveBoxAfter;

create PROCEDURE BubbleUpMoveBoxAfter
(
	@intUserIndex		int,
	@intBoxIndex		int
)
AS
BEGIN
	DECLARE @intOrderRank int;
	DECLARE @intSecondTarget int;
	DECLARE @intMaxRank int;

	SET @intOrderRank		= (SELECT TOP 1 OrderRank FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);
	SET @intMaxRank			= (SELECT TOP 1 max(T1.OrderRank) FROM BOXES T1 JOIN BOXES T2 ON T1.ParentBoxIndex = T2.ParentBoxIndex
	WHERE T2.BubbleUpUserIndex = @intUserIndex AND T2.BoxIndex = @intBoxIndex);

	IF(@intOrderRank < @intMaxRank)
	BEGIN
		SET @intSecondTarget	= (SELECT TOP 1 T1.BoxIndex FROM BOXES T1 JOIN BOXES T2 ON T1.ParentBoxIndex = T2.ParentBoxIndex
			WHERE T2.BubbleUpUserIndex = @intUserIndex AND T2.BoxIndex = @intBoxIndex AND T1.OrderRank = T2.OrderRank+1);
		UPDATE BOXES SET OrderRank = @intOrderRank WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intSecondTarget;
		UPDATE BOXES SET OrderRank = @intOrderRank+1 WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex;
	END
END