--DROP TRIGGER AfterNewBubbleUpUser

CREATE TRIGGER AfterNewBubbleUpUser
ON [BubbleUp].dbo.Users
AFTER Insert
AS
	--BubbleUp
	INSERT INTO [BubbleUp].dbo.Boxes (
		UserIndex, Direction, Label, ParentBoxIndex, Rank
	) 
	VALUES (
	(SELECT TOP 1 inserted.UserIndex FROM inserted), 'Horizontal', '', -1, 0);
	
GO