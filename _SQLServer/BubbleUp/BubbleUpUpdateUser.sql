--drop procedure BubbleUpUpdateUser;

create PROCEDURE BubbleUpUpdateUser(
    @userName varChar(max),
    @adminLevel varChar(1)
)
AS
BEGIN
	UPDATE [BubbleUp].dbo.Users SET
	AdminLevel = @AdminLevel 
	FROM [BubbleUp].dbo.Users B
	JOIN [HTKB].dbo.Users H ON B.HTKBUserIndex = H.UserIndex
	where Username = @userName 
	COLLATE SQL_Latin1_General_CP1_CS_AS;
END