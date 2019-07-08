--drop PROCEDURE BubbleUpAddTargetToBox;

create PROCEDURE BubbleUpAddTargetToBox
(
	@intUserIndex		int,
	@intParentBoxIndex	int
)
AS
BEGIN
	DECLARE @newOrderRank int = 0;
	if((select count(OrderRank) from targets where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex) > 0)
	BEGIN
		SET @newOrderRank = (select max(OrderRank) from targets where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex);
		SET @newOrderRank = @newOrderRank + 1;
	END

	INSERT INTO Targets (BubbleUpUserIndex, Label, ParentBoxIndex, OrderRank) VALUES (@intUserIndex, '', @intParentBoxIndex, @newOrderRank);
END