--DROP TRIGGER AOTriggerAfterUpdateOverAdminLevel

CREATE TRIGGER AOTriggerAfterUpdateOverAdminLevel
ON [Over].dbo.Users
AFTER Update
AS
	--Over
	Update B SET 
	BangOverAdminLevel = (SELECT TOP 1 INSERTED.OverAdminLevel FROM INSERTED)
	FROM [Over].dbo.BangOverUsers B
	JOIN INSERTED ON INSERTED.OverUserIndex = B.BangOverUserIndex;
	--Board Over
	Update D SET 
	BoardOverAdminLevel = (SELECT TOP 1 INSERTED.OverAdminLevel FROM INSERTED)
	FROM [Over].dbo.BoardOverUsers D
	JOIN INSERTED ON INSERTED.OverUserIndex = D.BoardOverUserIndex;
	--Play Over
	Update P SET 
	PlayOverAdminLevel = (SELECT TOP 1 INSERTED.OverAdminLevel FROM INSERTED)
	FROM [Over].dbo.PlayOverUsers P
	JOIN INSERTED ON INSERTED.OverUserIndex = P.PlayOverUserIndex;
	--Show Over
	Update S SET 
	ShowOverAdminLevel = (SELECT TOP 1 INSERTED.OverAdminLevel FROM INSERTED)
	FROM [Over].dbo.ShowOverUsers S
	JOIN INSERTED ON INSERTED.OverUserIndex = S.ShowOverUserIndex;
	--Watch Over
	Update W SET 
	WatchOverAdminLevel = (SELECT TOP 1 INSERTED.OverAdminLevel FROM INSERTED)
	FROM [Over].dbo.WatchOverUsers W
	JOIN INSERTED ON INSERTED.OverUserIndex = W.WatchOverUserIndex;
GO