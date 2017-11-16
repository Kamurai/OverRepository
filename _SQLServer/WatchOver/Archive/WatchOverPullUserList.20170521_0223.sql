--drop PROCEDURE WatchOverPullUserList;

create PROCEDURE WatchOverPullUserList
AS
BEGIN
	select * from Users, WatchOverUsers where Users.Indext = WatchOverUsers.UserIndex;
END