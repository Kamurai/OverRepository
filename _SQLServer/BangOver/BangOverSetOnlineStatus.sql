--drop PROCEDURE BangOverSetOnlineStatus;

create PROCEDURE BangOverSetOnlineStatus
(
	@intOnline int,
	@strUserName varchar(max)
)
AS
BEGIN

	update BangOverUsers set LoggedOn = @intOnline where 
	BangOverUsers.MasterUserIndex IN ( select UserIndex from Users where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS );
        
END