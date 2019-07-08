--DROP TRIGGER AfterTargetDelete

CREATE TRIGGER AfterTargetDelete
ON [BubbleUp].dbo.Boxes
AFTER DELETE
AS
	DECLARE @intUserIndex		int = (SELECT TOP 1 deleted.BubbleUpUserIndex	FROM deleted);
	DECLARE @intParentBoxIndex	int = (SELECT TOP 1 deleted.ParentBoxIndex		FROM deleted);
	DECLARE @intOrderRank		int = (SELECT TOP 1 deleted.OrderRank			FROM deleted);

	--Adjust other orderRanks for deleted box's parentIndex
	UPDATE Targets set OrderRank = OrderRank - 1 WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex AND OrderRank > @intOrderRank;
GO