--drop PROCEDURE BubbleUpPullStructure;

create PROCEDURE BubbleUpPullStructure
(
	@intUserIndex int
)
AS
BEGIN
	select B.BoxIndex, B.Direction, B.Label, B.ParentBoxIndex, B.OrderRank
	from [BubbleUp].dbo.Boxes B 
	where B.BubbleUpUserIndex = @intUserIndex
	UNION
	select T.TargetIndex, NULL, T.Label, T.ParentBoxIndex, T.OrderRank 
	from [BubbleUp].dbo.Targets T
	where T.BubbleUpUserIndex = @intUserIndex
	ORDER BY ParentBoxIndex, OrderRank
	;
END