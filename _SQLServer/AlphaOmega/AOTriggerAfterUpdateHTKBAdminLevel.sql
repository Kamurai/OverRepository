--DROP TRIGGER AOTriggerAfterUpdateHTKBAdminLevel

CREATE TRIGGER AOTriggerAfterUpdateHTKBAdminLevel
ON [HTKB].dbo.Users
AFTER Update
AS
	--Over
	Update O SET 
	AdminLevel = (SELECT TOP 1 INSERTED.AdminLevel FROM INSERTED)
	FROM [Over].dbo.Users O
	JOIN INSERTED ON INSERTED.UserIndex = O.HTKBUserIndex;
	--BubbleUp
	Update B SET 
	AdminLevel = (SELECT TOP 1 INSERTED.AdminLevel FROM INSERTED)
	FROM [BubbleUp].dbo.Users B
	JOIN INSERTED ON INSERTED.UserIndex = B.HTKBUserIndex;
	--Shout
	Update S SET 
	AdminLevel = (SELECT TOP 1 INSERTED.AdminLevel FROM INSERTED)
	FROM [Shout].dbo.Users S
	JOIN INSERTED ON INSERTED.UserIndex = S.HTKBUserIndex;
	--Mist
	Update M SET 
	AdminLevel = (SELECT TOP 1 INSERTED.AdminLevel FROM INSERTED)
	FROM [Mist].dbo.Users M
	JOIN INSERTED ON INSERTED.UserIndex = M.HTKBUserIndex;
GO