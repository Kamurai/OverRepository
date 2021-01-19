--DROP TRIGGER AfterTargetDelete

CREATE TRIGGER AfterTargetDelete
ON [BubbleUp].dbo.Targets
AFTER DELETE
AS
	DECLARE @intUserIndex		int = (SELECT TOP 1 deleted.UserIndex			FROM deleted);
	DECLARE @intParentBoxIndex	int = (SELECT TOP 1 deleted.ParentBoxIndex		FROM deleted);
	DECLARE @intRank			int = (SELECT TOP 1 deleted.Rank				FROM deleted);

	IF(@intUserIndex IS NOT NULL AND @intUserIndex != '')
	BEGIN
		EXEC BubbleUpUpdateRankTargets @intUserIndex, @intParentBoxIndex, @intRank, -1;
	END
GO