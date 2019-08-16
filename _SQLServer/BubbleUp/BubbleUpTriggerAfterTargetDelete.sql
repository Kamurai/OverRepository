--DROP TRIGGER AfterTargetDelete

CREATE TRIGGER AfterTargetDelete
ON [BubbleUp].dbo.Boxes
AFTER DELETE
AS
	DECLARE @intUserIndex		int = (SELECT TOP 1 deleted.BubbleUpUserIndex	FROM deleted);
	DECLARE @intParentBoxIndex	int = (SELECT TOP 1 deleted.ParentBoxIndex		FROM deleted);
	DECLARE @intOrderRank		int = (SELECT TOP 1 deleted.OrderRank			FROM deleted);

	IF(@intUserIndex IS NOT NULL AND @intUserIndex != '')
	BEGIN
		EXEC BubbleUpUpdateOrderRankTargets @intUserIndex, @intParentBoxIndex, @intOrderRank, -1;
	END
GO