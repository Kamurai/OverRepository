--drop PROCEDURE BubbleUpDeleteTarget;

create PROCEDURE BubbleUpDeleteTarget
(
	@intUserIndex		int,
	@intTargetIndex		int
)
AS
BEGIN
	DECLARE @orderRank int = 0;
	DECLARE @parentIndex int = 0;

	SET @orderRank = (select top 1 OrderRank from Targets where BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intTargetIndex);
	SET @parentIndex = (select top 1 ParentBoxIndex from Targets where BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intTargetIndex);
	
	DELETE FROM Targets WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intTargetIndex;

	--Adjust other orderRanks for same parentIndex
	EXEC BubbleUpUpdateOrderRankBoxes @intUserIndex, @parentIndex, @orderRank, -1;
END