--drop PROCEDURE BubbleUpChangeDirectionOfBox;

create PROCEDURE BubbleUpChangeDirectionOfBox(
	@intUserIndex		int,
	@intBoxIndex		int
)
AS
BEGIN
	DECLARE @direction varchar(max);

	SET @direction = (SELECT TOP 1 Direction FROM BOXES WHERE UserIndex = @intUserIndex AND BoxIndex = @intBoxIndex);

	IF(@direction = 'Horizontal')
	BEGIN
		SET @direction = 'Vertical';
	END
	ELSE
	BEGIN
		SET @direction = 'Horizontal';
	END

	UPDATE BOXES SET Direction = @direction WHERE UserIndex = @intUserIndex AND BoxIndex = @intBoxIndex;
END