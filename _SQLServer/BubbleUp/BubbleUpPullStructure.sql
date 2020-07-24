--drop PROCEDURE BubbleUpPullStructure;

create PROCEDURE BubbleUpPullStructure(
	@intUserIndex int
)
AS
BEGIN
	select B.BoxIndex, B.Direction, B.Label, B.ParentBoxIndex, B.Rank
	from [BubbleUp].dbo.Boxes B 
	where B.UserIndex = @intUserIndex
	UNION
	select T.TargetIndex, NULL, T.Label, T.ParentBoxIndex, T.Rank 
	from [BubbleUp].dbo.Targets T
	where T.UserIndex = @intUserIndex
	ORDER BY ParentBoxIndex, Rank
	;
END