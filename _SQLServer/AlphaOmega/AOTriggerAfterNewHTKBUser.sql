--DROP TRIGGER AfterNewHTKBUser

CREATE TRIGGER AfterNewHTKBUser
ON [HTKB].dbo.Users
AFTER Insert
AS
	--Over
	INSERT INTO [Over].dbo.Users (HTKBUserIndex, OverAdminLevel, OverOnline) 
	VALUES ((SELECT TOP 1  inserted.HTKBUserIndex FROM inserted), (SELECT TOP 1 inserted.HTKBAdminLevel  FROM inserted), 0);
	--BubbleUp
	INSERT INTO [BubbleUp].dbo.Users (HTKBUserIndex, BubbleUpAdminLevel, BubbleUpOnline) 
	VALUES ((SELECT TOP 1  inserted.HTKBUserIndex FROM inserted), (SELECT TOP 1 inserted.HTKBAdminLevel  FROM inserted), 0);
	--Shout
	INSERT INTO [Shout].dbo.Users (HTKBUserIndex, ShoutAdminLevel, ShoutOnline) 
	VALUES ((SELECT TOP 1  inserted.HTKBUserIndex FROM inserted), (SELECT TOP 1 inserted.HTKBAdminLevel  FROM inserted), 0);
	--Mist
	INSERT INTO [Mist].dbo.Users (HTKBUserIndex, MistAdminLevel, MistOnline) 
	VALUES ((SELECT TOP 1  inserted.HTKBUserIndex FROM inserted), (SELECT TOP 1 inserted.HTKBAdminLevel  FROM inserted), 0);
GO