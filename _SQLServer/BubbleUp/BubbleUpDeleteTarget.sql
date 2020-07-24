--drop PROCEDURE BubbleUpDeleteTarget;

create PROCEDURE BubbleUpDeleteTarget(
	@intUserIndex		int,
	@intTargetIndex		int
)
AS
BEGIN
	DECLARE @Rank int = 0;
	DECLARE @parentIndex int = 0;

	SET @Rank		 = (select top 1 Rank			from Targets where UserIndex = @intUserIndex AND TargetIndex = @intTargetIndex);
	SET @parentIndex = (select top 1 ParentBoxIndex from Targets where UserIndex = @intUserIndex AND TargetIndex = @intTargetIndex);
	
	DELETE FROM Targets WHERE UserIndex = @intUserIndex AND TargetIndex = @intTargetIndex;

	--Adjust other Ranks for same parentIndex
	EXEC BubbleUpUpdateRankBoxes @intUserIndex, @parentIndex, @Rank, -1;
END