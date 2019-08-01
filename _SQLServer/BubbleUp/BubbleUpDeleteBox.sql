--drop PROCEDURE BubbleUpDeleteBox;

create PROCEDURE BubbleUpDeleteBox
(
	@intUserIndex		int,
	@intBoxIndex		int
)
AS
BEGIN
	DECLARE @orderRank int = 0;
	DECLARE @parentIndex int = 0;

	SET @orderRank = (select top 1 OrderRank from Boxes where BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);
	SET @parentIndex = (select top 1 ParentBoxIndex from Boxes where BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);
	
	DELETE FROM Boxes WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex;

	--Adjust other orderRanks for same parentIndex
	UPDATE Boxes set OrderRank = OrderRank - 1 WHERE BubbleUpUserIndex = @intUserIndex AND ParentBoxIndex = @parentIndex AND OrderRank > @orderRank;
END