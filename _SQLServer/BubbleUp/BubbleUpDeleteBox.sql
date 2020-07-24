--drop PROCEDURE BubbleUpDeleteBox;

create PROCEDURE BubbleUpDeleteBox(
	@intUserIndex		int,
	@intBoxIndex		int
)
AS
BEGIN
	DECLARE @Rank int = 0;
	DECLARE @parentIndex int = 0;

	SET @Rank			= (select top 1 Rank			from Boxes where UserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);
	SET @parentIndex	= (select top 1 ParentBoxIndex	from Boxes where UserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);
	
	DELETE FROM Boxes WHERE UserIndex = @intUserIndex AND BoxIndex = @intBoxIndex;

	--Adjust other Ranks for same parentIndex
	EXEC BubbleUpUpdateRankBoxes @intUserIndex, @parentIndex, @Rank, -1;
END