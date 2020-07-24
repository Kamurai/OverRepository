--DROP TRIGGER AOTriggerAfterUpdateAdminLevel

CREATE TRIGGER AOTriggerAfterUpdateAdminLevel
ON [Over].dbo.Users
AFTER Update
AS
	--Bang Over
	Update B SET 
	B.AdminLevel = (SELECT TOP 1 INSERTED.AdminLevel FROM INSERTED)
	FROM [Over].dbo.BangOverUsers B
	JOIN INSERTED ON INSERTED.UserIndex = B.UserIndex;
	--Board Over
	Update D SET 
	D.AdminLevel = (SELECT TOP 1 INSERTED.AdminLevel FROM INSERTED)
	FROM [Over].dbo.BoardOverUsers D
	JOIN INSERTED ON INSERTED.UserIndex = D.UserIndex;
	--Play Over
	Update P SET 
	P.AdminLevel = (SELECT TOP 1 INSERTED.AdminLevel FROM INSERTED)
	FROM [Over].dbo.PlayOverUsers P
	JOIN INSERTED ON INSERTED.UserIndex = P.UserIndex;
	--Show Over
	Update S SET 
	S.AdminLevel = (SELECT TOP 1 INSERTED.AdminLevel FROM INSERTED)
	FROM [Over].dbo.ShowOverUsers S
	JOIN INSERTED ON INSERTED.UserIndex = S.UserIndex;
	--Watch Over
	Update W SET 
	W.AdminLevel = (SELECT TOP 1 INSERTED.AdminLevel FROM INSERTED)
	FROM [Over].dbo.WatchOverUsers W
	JOIN INSERTED ON INSERTED.UserIndex = W.UserIndex;
GO