--drop procedure AllOverUpdateUser;

create PROCEDURE AllOverUpdateUser
(
    @userName varChar(max),
    @adminLevel varChar(1)

)
AS
BEGIN
	UPDATE O SET
	OverAdminLevel = @AdminLevel 
	FROM [OVER].dbo.Users O
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex
	where Username = @userName 
	COLLATE SQL_Latin1_General_CP1_CS_AS;
END