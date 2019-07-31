--drop PROCEDURE BubbleUpMoveOutRightBox;

create PROCEDURE BubbleUpMoveOutRightBox(
	@intUserIndex					int,
	@intBoxIndex					int
)
AS
BEGIN
	DECLARE @intOrderRank			int;
	DECLARE @intMaxOrderRank		int;
	DECLARE @intParentIndex			int;
	DECLARE @intParentOrderRank		int;
	DECLARE @intParentMaxOrderRank	int;
	DECLARE @intGrandParentIndex	int;
	DECLARE @intNeighborIndex		int;
	DECLARE @intNewOrder			int;
	DECLARE @newBoxId				int;


	PRINT CONCAT('User Index: ', @intUserIndex);
	PRINT CONCAT('Box Index: ', @intBoxIndex);
	
	SET @intOrderRank			= (SELECT TOP 1 OrderRank		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);
	PRINT CONCAT('Order Rank: ', @intOrderRank);
	SET @intMaxOrderRank		= (SELECT TOP 1 MAX(OrderRank)	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);
	PRINT CONCAT('Max Order Rank: ', @intMaxOrderRank);
	SET @intParentIndex			= (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);
	PRINT CONCAT('Parent Index: ', @intParentIndex);
	--Determine orderRank of Parent
	SET @intParentOrderRank		= (SELECT TOP 1 OrderRank		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	PRINT CONCAT('Parent Order Rank: ', @intParentOrderRank);
	--*Find the Parent of Parent
	SET @intGrandParentIndex	= (SELECT TOP 1 ParentBoxIndex	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intParentIndex);
	PRINT CONCAT('Grand Parent Index: ', @intGrandParentIndex);
	SET @intParentMaxOrderRank	= (SELECT TOP 1 MAX(OrderRank)	FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intGrandParentIndex);
	PRINT CONCAT('Parent Max Order Rank: ', @intParentMaxOrderRank);
	
	--Update the Parent Index with the "right" neighbor of that Parent
		--if Parent's orderRank is not maxRank
	IF(@intParentOrderRank < @intParentMaxOrderRank)
	BEGIN
		PRINT 'Parent Order Rank != 0';
		PRINT CONCAT('User Index: ', @intUserIndex);
		PRINT CONCAT('Grand Parent Box Index: ', @intGrandParentIndex);
		PRINT CONCAT('Parent Order Rank: ', @intParentOrderRank);
		SET @intNeighborIndex		= (SELECT TOP 1 BoxIndex		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intGrandParentIndex AND OrderRank = @intParentOrderRank+1);
		--if count > 1
		IF((SELECT COUNT(OrderRank) FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intNeighborIndex) > 0)
		BEGIN
			SET @intNewOrder			= (SELECT MAX(OrderRank)		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intNeighborIndex) + 1;
		END
		--else
		ELSE
		BEGIN
			--set order to 0
			SET @intNewOrder			= 0;
		END
		--Reassign target's ParentIndex to BoxIndex at ParentIndex's OrderRank-1
			--target box's orderRank should be count of boxes of new Parent
		PRINT CONCAT('Neighbor Index: ', @intNeighborIndex);
		UPDATE BOXES set ParentBoxIndex = @intNeighborIndex, OrderRank = @intNewOrder
		WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex; 
	END
	--if Parent's orderRank is maxRank
	ELSE IF(@intParentOrderRank >= @intParentMaxOrderRank)
	BEGIN
		PRINT CONCAT('Grand Parent Index: ', @intGrandParentIndex);
		--Add Box to Parent's Parent with orderRank+1
		INSERT INTO BOXES (BubbleUpUserIndex, Label, Direction, ParentBoxIndex, OrderRank) 
		VALUES (@intUserIndex, 'New Right Box', 'Horizontal', @intGrandParentIndex, @intParentMaxOrderRank+1);
			
		SET @intNeighborIndex		= (SELECT TOP 1 BoxIndex		FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intGrandParentIndex AND OrderRank = @intParentOrderRank+1);
		SET @intNewOrder			= 0;
		--Reassign target's ParentIndex to BoxIndex at ParentIndex's orderRank-1
			--target box's orderRank should be maxRank + 1
		UPDATE BOXES set ParentBoxIndex = @intNeighborIndex, OrderRank = @intParentMaxOrderRank+1
		WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex; 
	END

	--if count of ParentIndex=-1 is > 1
	IF((select count(ParentBoxIndex) from BOXES where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = -1) > 1)
	BEGIN
		--Add new box
		INSERT INTO BOXES (BubbleUpUserIndex, Label, Direction, ParentBoxIndex, OrderRank) VALUES (@intUserIndex, 'New Root', 'Horizontal', -1, 0);
		--get id of the new box
		SET @newBoxId = (SELECT max(BoxIndex) FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex);

		--update -1s to id, except where box index matches parentboxindex
		UPDATE BOXES SET ParentBoxIndex = @newBoxId WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = -1 AND BoxIndex != @newBoxId;
	END
	--if < 1, then root is missing, add root
	IF((select count(ParentBoxIndex) from BOXES where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = -1) < 1)
	BEGIN
		INSERT INTO BOXES (BubbleUpUserIndex, Label, Direction, ParentBoxIndex, OrderRank) VALUES (@intUserIndex, '', 'Horizontal', -1, 0);
	END

	UPDATE BOXES set OrderRank = OrderRank - 1 WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentIndex AND OrderRank > @intOrderRank;
END