--drop PROCEDURE BubbleUpUpdateOrderRankBoxes;

create PROCEDURE BubbleUpUpdateOrderRankBoxes(
	@intUserIndex		int,
	@intParentBoxIndex	int,
	@orderRank			int,
	@intAdjustment		int
)
AS
BEGIN
	PRINT('BubbleUpUpdateOrderRankBoxes');
	PRINT(CONCAT('@intUserIndex: ',			@intUserIndex));
	PRINT(CONCAT('@intParentBoxIndex: ',	@intParentBoxIndex));
	PRINT(CONCAT('@orderRank: ',			@orderRank));
	PRINT(CONCAT('@intAdjustment: ',		@intAdjustment));
	
	--Adjust other orderRanks for same parentIndex
	UPDATE BOXES set OrderRank = OrderRank + @intAdjustment WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex AND OrderRank > @orderRank;
END