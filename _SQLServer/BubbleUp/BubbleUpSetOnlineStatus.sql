--drop PROCEDURE BubbleUpSetOnlineStatus;

create PROCEDURE BubbleUpSetOnlineStatus(
	@intOnline int,
	@strUserName varchar(max)
)
AS
BEGIN
	UPDATE B SET
	Online = @intOnline 
	FROM [BubbleUp].dbo.Users B
	JOIN [HTKB].dbo.Users H ON B.HTKBUserIndex = H.UserIndex
	where Username = @strUserName 
	COLLATE SQL_Latin1_General_CP1_CS_AS
END