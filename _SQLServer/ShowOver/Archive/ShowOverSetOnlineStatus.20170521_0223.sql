--drop PROCEDURE ShowOverSetOnlineStatus;

create PROCEDURE ShowOverSetOnlineStatus
(
	@intOnline int,
	@strUserName varchar(max)
)
AS
BEGIN

	update ShowOverUsers set LoggedOn = @intOnline where 
	ShowOverUsers.UserIndex IN ( select Indext from Users where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS );
        
END