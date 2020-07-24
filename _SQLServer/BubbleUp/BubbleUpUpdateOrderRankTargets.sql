--drop PROCEDURE BubbleUpUpdateRankTargets;

create PROCEDURE BubbleUpUpdateRankTargets(
	@intUserIndex		int,
	@intParentBoxIndex	int,
	@Rank				int,
	@intAdjustment		int
)
AS
BEGIN
	PRINT('BubbleUpUpdateRankTargets');
	PRINT(CONCAT('@intUserIndex: ',			@intUserIndex));
	PRINT(CONCAT('@intParentBoxIndex: ',	@intParentBoxIndex));
	PRINT(CONCAT('@Rank: ',					@Rank));
	PRINT(CONCAT('@intAdjustment: ',		@intAdjustment));
	
	--Adjust other Ranks for same parentIndex
	UPDATE TARGETS set Rank = Rank + @intAdjustment WHERE UserIndex = @intUserIndex AND ParentBoxIndex = @intParentBoxIndex AND Rank > @Rank;
END