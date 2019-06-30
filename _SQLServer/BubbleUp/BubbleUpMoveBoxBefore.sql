--drop PROCEDURE BubbleUpMoveBoxBefore;

create PROCEDURE BubbleUpMoveBoxBefore
(
	@intUserIndex		int,
	@intBoxIndex		int
)
AS
BEGIN
	DECLARE @intOrderRank int;
	DECLARE @intSecondTarget int;
	
	SET @intOrderRank		= (SELECT TOP 1 OrderRank FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);
	
	IF(@intOrderRank != 0)
	BEGIN
		SET @intSecondTarget	= (SELECT TOP 1 T1.BoxIndex FROM BOXES T1 JOIN BOXES T2 ON T1.ParentBoxIndex = T2.ParentBoxIndex
			WHERE T2.BubbleUpUserIndex = @intUserIndex AND T2.BoxIndex = @intBoxIndex AND T1.OrderRank = T2.OrderRank-1);
		UPDATE BOXES SET OrderRank = @intOrderRank WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intSecondTarget;
		UPDATE BOXES SET OrderRank = @intOrderRank-1 WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex;
	END
END