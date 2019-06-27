--drop PROCEDURE BubbleUpDeleteTarget;

create PROCEDURE BubbleUpDeleteTarget
(
	@intUserIndex		int,
	@intTargetIndex		int
)
AS
BEGIN
	DELETE FROM Targets WHERE BubbleUpUserIndex = @intUserIndex AND TargetIndex = @intTargetIndex;
END