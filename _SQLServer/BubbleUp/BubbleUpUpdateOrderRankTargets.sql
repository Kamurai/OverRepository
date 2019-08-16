--drop PROCEDURE BubbleUpUpdateOrderRankTargets;

create PROCEDURE BubbleUpUpdateOrderRankTargets(
	@intUserIndex		int,
	@intParentBoxIndex	int,
	@orderRank			int,
	@intAdjustment		int
)
AS
BEGIN
	PRINT('BubbleUpUpdateOrderRankTargets');
	PRINT(CONCAT('@intUserIndex: ',			@intUserIndex));
	PRINT(CONCAT('@intParentBoxIndex: ',	@intParentBoxIndex));
	PRINT(CONCAT('@orderRank: ',			@orderRank));
	PRINT(CONCAT('@intAdjustment: ',		@intAdjustment));
	
	--Adjust other orderRanks for same parentIndex
	UPDATE TARGETS set OrderRank = OrderRank + @intAdjustment WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex AND OrderRank > @orderRank;
END