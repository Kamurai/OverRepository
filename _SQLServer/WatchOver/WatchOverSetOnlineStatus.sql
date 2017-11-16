--drop PROCEDURE WatchOverSetOnlineStatus;

create PROCEDURE WatchOverSetOnlineStatus
(
	@intOnline int,
	@strUserName varchar(max)
)
AS
BEGIN

	update WatchOverUsers set LoggedOn = @intOnline where 
	WatchOverUsers.UserIndex IN ( select Indext from Users where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS );
        
END