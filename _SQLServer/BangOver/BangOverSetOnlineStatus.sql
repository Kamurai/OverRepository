--drop PROCEDURE BangOverSetOnlineStatus;

create PROCEDURE BangOverSetOnlineStatus
(
	@intOnline int,
	@strUserName varchar(max)
)
AS
BEGIN

	update BangOverUsers set LoggedOn = @intOnline where 
	BangOverUsers.UserIndex IN ( select Indext from Users where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS );
        
END