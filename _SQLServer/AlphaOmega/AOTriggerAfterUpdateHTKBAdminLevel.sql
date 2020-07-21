--DROP TRIGGER AOTriggerAfterUpdateHTKBAdminLevel

CREATE TRIGGER AOTriggerAfterUpdateHTKBAdminLevel
ON [HTKB].dbo.Users
AFTER Update
AS
	--Over
	Update O SET 
	OverAdminLevel = (SELECT TOP 1 INSERTED.HTKBAdminLevel FROM INSERTED)
	FROM [Over].dbo.Users O
	JOIN INSERTED ON INSERTED.HTKBUserIndex = O.OverUserIndex;
	--BubbleUp
	Update B SET 
	BubbleUpAdminLevel = (SELECT TOP 1 INSERTED.HTKBAdminLevel FROM INSERTED)
	FROM [BubbleUp].dbo.Users B
	JOIN INSERTED ON INSERTED.HTKBUserIndex = B.BubbleUpUserIndex;
	--Shout
	Update S SET 
	ShoutAdminLevel = (SELECT TOP 1 INSERTED.HTKBAdminLevel FROM INSERTED)
	FROM [Shout].dbo.Users S
	JOIN INSERTED ON INSERTED.HTKBUserIndex = S.ShoutUserIndex;
	--Mist
	Update M SET 
	MistAdminLevel = (SELECT TOP 1 INSERTED.HTKBAdminLevel FROM INSERTED)
	FROM [Mist].dbo.Users M
	JOIN INSERTED ON INSERTED.HTKBUserIndex = M.MistUserIndex;
GO