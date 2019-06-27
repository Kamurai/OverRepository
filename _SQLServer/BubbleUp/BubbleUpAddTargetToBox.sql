--drop PROCEDURE BubbleUpAddTargetToBox;

create PROCEDURE BubbleUpAddTargetToBox
(
	@intUserIndex		int,
	@intBoxIndex		int
)
AS
BEGIN
	DECLARE @newOrderRank int = (select max(OrderRank) from targets where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intBoxIndex);
	SET @newOrderRank = @newOrderRank + 1;
	INSERT INTO Targets (BubbleUpUserIndex, ParentBoxIndex, OrderRank) VALUES (@intUserIndex, @intBoxIndex, @newOrderRank);
END