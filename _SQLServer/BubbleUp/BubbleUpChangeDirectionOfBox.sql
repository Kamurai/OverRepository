--drop PROCEDURE BubbleUpChangeDirectionOfBox;

create PROCEDURE BubbleUpChangeDirectionOfBox
(
	@intUserIndex		int,
	@intBoxIndex		int
)
AS
BEGIN
	DECLARE @direction varchar(max);

	SET @direction = (SELECT TOP 1 Direction FROM BOXES WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);

	UPDATE BOXES SET Direction = @direction WHERE BubbleUpUserIndex = @intUserIndex AND BoxIndex = @intBoxIndex;
END