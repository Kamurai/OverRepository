--DROP TRIGGER AfterBoxDelete

CREATE TRIGGER AfterBoxDelete
ON [BubbleUp].dbo.Boxes
AFTER DELETE
AS
	DECLARE @intUserIndex		int = (SELECT TOP 1 deleted.UserIndex			FROM deleted);
	DECLARE @intBoxIndex		int = (SELECT TOP 1 deleted.BoxIndex			FROM deleted);
	DECLARE @intParentBoxIndex	int = (SELECT TOP 1 deleted.ParentBoxIndex		FROM deleted);
	DECLARE @intRank			int = (SELECT TOP 1 deleted.Rank				FROM deleted);
	
	--Adjust other Ranks for deleted box's parentIndex
	EXEC BubbleUpUpdateRankBoxes @intUserIndex, @intParentBoxIndex, @intRank, -1;
	
	--DELETE subs of subs targets
	WITH BoxesToDelete AS (
		SELECT deleted.BoxIndex FROM deleted
		UNION ALL
		SELECT B1.BoxIndex
		FROM Boxes B1
		WHERE B1.ParentBoxIndex IN (
				SELECT deleted.BoxIndex FROM deleted
			)
		UNION ALL
		SELECT B2.BoxIndex
		FROM Boxes B2
		JOIN BoxesToDelete R ON
		B2.ParentBoxIndex = R.BoxIndex
	)
	DELETE FROM Targets
	WHERE ParentBoxIndex IN (
		SELECT BoxIndex 
		FROM BoxesToDelete R
	)
	AND Targets.UserIndex = @intUserIndex;
	
	--DELETE subs of subs boxes
	WITH BoxesToDelete AS (
		SELECT B1.BoxIndex
		FROM Boxes B1
		WHERE B1.ParentBoxIndex IN (
				SELECT deleted.BoxIndex FROM deleted
			)
		UNION ALL
		SELECT B2.BoxIndex
		FROM Boxes B2
		JOIN BoxesToDelete R ON
		B2.ParentBoxIndex = R.BoxIndex
	)
	DELETE FROM Boxes
	WHERE BoxIndex IN (
		SELECT B2.BoxIndex FROM Boxes B2
		JOIN BoxesToDelete R
		ON B2.BoxIndex = R.BoxIndex
		WHERE B2.UserIndex = @intUserIndex
	)
GO