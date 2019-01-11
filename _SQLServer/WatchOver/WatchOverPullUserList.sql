--drop PROCEDURE WatchOverPullUserList;

create PROCEDURE WatchOverPullUserList
AS
BEGIN
	select * from Users 
	JOIN WatchOverUsers ON 
		Users.UserIndex = WatchOverUsers.MasterUserIndex;
END