--drop PROCEDURE BangOverPullUserList;

create PROCEDURE BangOverPullUserList
AS
BEGIN
	select * from Users JOIN BangOverUsers ON Users.UserIndex = BangOverUsers.MasterUserIndex;
END