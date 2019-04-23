--DROP TRIGGER AfterNewBubbleUpUser

CREATE TRIGGER AfterNewBubbleUpUser
ON [BubbleUp].dbo.Users
AFTER Insert
AS
	--BubbleUp
	INSERT INTO [BubbleUp].dbo.Boxes (
		BubbleUpUserIndex, Direction, Label, ParentBoxIndex, OrderRank
	) 
	VALUES (
	(SELECT TOP 1 inserted.BubbleUpUserIndex FROM inserted), 'Horizontal', '', -1, 0);
	
GO