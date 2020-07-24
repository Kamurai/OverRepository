--DROP TRIGGER AfterNewHTKBUser

CREATE TRIGGER AfterNewHTKBUser
ON [HTKB].dbo.Users
AFTER Insert
AS
	--Over
	INSERT INTO [Over].dbo.Users (HTKBUserIndex, AdminLevel, Online) 
	VALUES ((SELECT TOP 1  inserted.UserIndex FROM inserted), (SELECT TOP 1 inserted.AdminLevel  FROM inserted), 0);
	--BubbleUp
	INSERT INTO [BubbleUp].dbo.Users (HTKBUserIndex, AdminLevel, Online) 
	VALUES ((SELECT TOP 1  inserted.UserIndex FROM inserted), (SELECT TOP 1 inserted.AdminLevel  FROM inserted), 0);
	--Shout
	INSERT INTO [Shout].dbo.Users (HTKBUserIndex, AdminLevel, Online) 
	VALUES ((SELECT TOP 1  inserted.UserIndex FROM inserted), (SELECT TOP 1 inserted.AdminLevel  FROM inserted), 0);
	--Mist
	INSERT INTO [Mist].dbo.Users (HTKBUserIndex, AdminLevel, Online) 
	VALUES ((SELECT TOP 1  inserted.UserIndex FROM inserted), (SELECT TOP 1 inserted.AdminLevel  FROM inserted), 0);
GO