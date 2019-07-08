--DROP TRIGGER AfterBoxDelete

CREATE TRIGGER AfterBoxDelete
ON [BubbleUp].dbo.Boxes
AFTER DELETE
AS
	DECLARE @intUserIndex		int = (SELECT TOP 1 deleted.BubbleUpUserIndex	FROM deleted);
	PRINT CONCAT('User index: ', @intUserIndex);
	DECLARE @intBoxIndex		int = (SELECT TOP 1 deleted.BoxIndex			FROM deleted);
	PRINT CONCAT('Box index: ', @intBoxIndex);
	DECLARE @intParentBoxIndex	int = (SELECT TOP 1 deleted.ParentBoxIndex		FROM deleted);
	PRINT CONCAT('Parent index: ', @intParentBoxIndex);
	DECLARE @intOrderRank		int = (SELECT TOP 1 deleted.OrderRank			FROM deleted);
	PRINT CONCAT('Order rank: ', @intOrderRank);
	
	--Adjust other orderRanks for deleted box's parentIndex
	UPDATE Boxes set OrderRank = OrderRank - 1 WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex AND OrderRank > @intOrderRank;

	PRINT 'DELETE sub targets';
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
	AND Targets.BubbleUpUserIndex = @intUserIndex
	
	PRINT 'DELETE sub boxes';
	
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
		WHERE B2.BubbleUpUserIndex = @intUserIndex
	)

	DECLARE @countIt int = (select count(ParentBoxIndex) from BOXES where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = -1);
	IF(@intUserIndex IS NOT NULL AND @intUserIndex != '')
	BEGIN
		PRINT CONCAT('Count of root: ', @countIt);
		--if < 1, then root is missing, add root
		IF((select count(ParentBoxIndex) from BOXES where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = -1) < 1)
		BEGIN
			PRINT 'INSERT root';
			INSERT INTO BOXES (BubbleUpUserIndex, Label, Direction, ParentBoxIndex, OrderRank) VALUES (@intUserIndex, '', 'Horizontal', -1, 0);
		END
	END
	PRINT 'Triggers';
	
GO