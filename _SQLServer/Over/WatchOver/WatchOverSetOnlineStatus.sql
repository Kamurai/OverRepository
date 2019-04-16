--drop PROCEDURE WatchOverSetOnlineStatus;

create PROCEDURE WatchOverSetOnlineStatus
(
	@intOnline int,
	@strUserName varchar(max)
)
AS
BEGIN
	UPDATE B SET
	WatchOverOnline = @intOnline 
	FROM [OVER].dbo.WatchOverUsers B
	JOIN [OVER].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
	where Username = @strUserName 
	COLLATE SQL_Latin1_General_CP1_CS_AS
END