--drop PROCEDURE BoardOverSetOnlineStatus;

create PROCEDURE BoardOverSetOnlineStatus
(
	@intOnline int,
	@strUserName varchar(max)
)
AS
BEGIN

	update BoardOverUsers set LoggedOn = @intOnline where 
	BoardOverUsers.UserIndex IN ( select Indext from Users where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS );
        
END