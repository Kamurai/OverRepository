--drop PROCEDURE BubbleUpAddBoxToBox;

create PROCEDURE BubbleUpAddBoxToBox
(
	@intUserIndex		int,
	@intParentBoxIndex	int
)
AS
BEGIN
	DECLARE @newOrderRank	int = 0;
	DECLARE @newBoxId		int = 0;
	
	if((select count(OrderRank) from BOXES where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex) > 0)
	BEGIN
		SET @newOrderRank = (select max(OrderRank) from BOXES where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex);
		SET @newOrderRank = @newOrderRank + 1;
	END

	INSERT INTO BOXES (BubbleUpUserIndex, Label, Direction, ParentBoxIndex, OrderRank) VALUES (@intUserIndex, '', 'Horizontal', @intParentBoxIndex, @newOrderRank);

	--if count of ParentIndex is > 1
	IF((select count(ParentBoxIndex) from BOXES where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = -1) > 1)
	BEGIN
		--Add new box
		INSERT INTO BOXES (BubbleUpUserIndex, Label, Direction, ParentBoxIndex, OrderRank) VALUES (@intUserIndex, '', 'Horizontal', -1, 0);
		--get id of the new box
		SET @newBoxId = (SELECT max(BoxIndex) FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex);
		--update -1s to id, except where box index matches parentboxindex
		UPDATE BOXES SET ParentBoxIndex = @newBoxId WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = -1 AND BoxIndex != @newBoxId;


		--UPDATE BOXES set ParentBoxIndex = (SELECT TOP 1 BoxIndex FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = ParentBoxIndex) WHERE BubbleUpUserIndex = @intUserIndex;
	END
	--if < 1, then root is missing, add root
	IF((select count(ParentBoxIndex) from BOXES where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = -1) < 1)
	BEGIN
		INSERT INTO BOXES (BubbleUpUserIndex, Label, Direction, ParentBoxIndex, OrderRank) VALUES (@intUserIndex, '', 'Horizontal', -1, 0);
	END
END