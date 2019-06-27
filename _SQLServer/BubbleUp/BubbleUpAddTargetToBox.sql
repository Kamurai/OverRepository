--drop PROCEDURE BubbleUpAddTargetToBox;

create PROCEDURE BubbleUpAddTargetToBox
(
	@intUserIndex		int,
	@intBoxIndex		int
)
AS
BEGIN
	DECLARE @newOrderRank int = 0;
	if((select count(OrderRank) from targets where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intBoxIndex) > 0)
	BEGIN
		SET @newOrderRank = (select max(OrderRank) from targets where BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intBoxIndex);
		SET @newOrderRank = @newOrderRank + 1;
	END

	INSERT INTO Targets (BubbleUpUserIndex, ParentBoxIndex, OrderRank) VALUES (@intUserIndex, @intBoxIndex, @newOrderRank);
END