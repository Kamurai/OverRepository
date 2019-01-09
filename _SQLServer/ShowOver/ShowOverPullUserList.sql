--drop PROCEDURE ShowOverPullUserList;

create PROCEDURE ShowOverPullUserList
AS
BEGIN
	select * from Users JOIN ShowOverUsers ON Users.UserIndex = ShowOverUsers.MasterUserIndex;
END