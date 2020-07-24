--drop procedure AllOverUpdateUser;

create PROCEDURE AllOverUpdateUser(
    @userName varChar(max),
    @adminLevel varChar(1)
)
AS
BEGIN
	UPDATE O SET
	O.AdminLevel = @AdminLevel 
	FROM [OVER].dbo.Users O
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex
	where Username = @userName 
	COLLATE SQL_Latin1_General_CP1_CS_AS;
END