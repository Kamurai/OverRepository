--drop PROCEDURE ShowOverSetOnlineStatus;

create PROCEDURE ShowOverSetOnlineStatus
(
	@intOnline int,
	@strUserName varchar(max)
)
AS
BEGIN
	UPDATE B SET
	ShowOverOnline = @intOnline 
	FROM [OVER].dbo.ShowOverUsers B
	JOIN [OVER].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
	where Username = @strUserName 
	COLLATE SQL_Latin1_General_CP1_CS_AS
END