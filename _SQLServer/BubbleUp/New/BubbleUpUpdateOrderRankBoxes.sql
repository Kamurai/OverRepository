--drop PROCEDURE BubbleUpUpdateOrderRankBoxes;

create PROCEDURE BubbleUpUpdateOrderRankBoxes(
	@intUserIndex		int,
	@intParentBoxIndex	int,
	@orderRank			int
)
AS
BEGIN
	--Adjust other orderRanks for same parentIndex
	UPDATE BOXES set OrderRank = OrderRank - 1 WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex AND OrderRank > @orderRank;
END