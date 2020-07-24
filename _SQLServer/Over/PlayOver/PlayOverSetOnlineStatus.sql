--drop PROCEDURE PlayOverSetOnlineStatus;

create PROCEDURE PlayOverSetOnlineStatus(
	@intOnline int,
	@strUserName varchar(max)
)
AS
BEGIN
	UPDATE B SET
	Online = @intOnline 
	FROM [OVER].dbo.PlayOverUsers B
	JOIN [OVER].dbo.Users O ON B.OverUserIndex = O.UserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
	where Username = @strUserName 
	COLLATE SQL_Latin1_General_CP1_CS_AS
END