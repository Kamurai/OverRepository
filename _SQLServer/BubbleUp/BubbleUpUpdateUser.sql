--drop procedure BubbleUpUpdateUser;

create PROCEDURE BubbleUpUpdateUser
(
    @userName varChar(max),
    @adminLevel varChar(1)
)
AS
BEGIN
	UPDATE O SET
	BubbleUpAdminLevel = @AdminLevel 
	FROM [BubbleUp].dbo.Users B
	JOIN [HTKB].dbo.Users H ON B.HTKBUserIndex = H.HTKBUserIndex
	where Username = @userName 
	COLLATE SQL_Latin1_General_CP1_CS_AS;
END