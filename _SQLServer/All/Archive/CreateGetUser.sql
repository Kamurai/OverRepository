--drop PROCEDURE GetUser;

create PROCEDURE GetUser
(
	@strUserName varchar(max)
)
AS
BEGIN

	select * from Users where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS;
        
END