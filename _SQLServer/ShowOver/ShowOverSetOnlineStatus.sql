--drop PROCEDURE ShowOverSetOnlineStatus;

create PROCEDURE ShowOverSetOnlineStatus
(
	@intOnline int,
	@strUserName varchar(max)
)
AS
BEGIN

	update ShowOverUsers set LoggedOn = @intOnline where 
	ShowOverUsers.MasterUserIndex IN ( select UserIndex from Users where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS );
        
END