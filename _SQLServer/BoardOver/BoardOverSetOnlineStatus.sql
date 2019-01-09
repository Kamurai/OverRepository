--drop PROCEDURE BoardOverSetOnlineStatus;

create PROCEDURE BoardOverSetOnlineStatus
(
	@intOnline int,
	@strUserName varchar(max)
)
AS
BEGIN

	update BoardOverUsers set LoggedOn = @intOnline where 
	BoardOverUsers.MasterUserIndex IN ( select UserIndex from Users where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS );
        
END