--drop PROCEDURE PlayOverSetOnlineStatus;

create PROCEDURE PlayOverSetOnlineStatus
(
	@intOnline int,
	@strUserName varchar(max)
)
AS
BEGIN

	update PlayOverUsers set LoggedOn = @intOnline where 
	PlayOverUsers.UserIndex IN ( select Indext from Users where Username = @strUserName COLLATE SQL_Latin1_General_CP1_CS_AS );
        
END