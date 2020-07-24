--drop PROCEDURE BubbleUpAddNewRoot;

create PROCEDURE BubbleUpAddNewRoot(
	@intUserIndex		int
)
AS
BEGIN
	DECLARE @newRootId		int = 0;
	
	--Add new root
	INSERT INTO BOXES (UserIndex, Label, Direction, ParentBoxIndex, Rank) 
	VALUES (@intUserIndex, '', 'Horizontal', -2, 0);

	--Set newRootId
	SET @newRootId = (SELECT TOP 1 BoxIndex FROM BOXES WHERE UserIndex = @intUserIndex AND ParentBoxIndex = -2);

	--Update current root
	UPDATE BOXES SET ParentBoxIndex = @newRootId 
	WHERE UserIndex = @intUserIndex AND ParentBoxIndex = -1;

	--Update new root
	UPDATE BOXES SET ParentBoxIndex = -1 
	WHERE UserIndex = @intUserIndex AND ParentBoxIndex = -2;
END