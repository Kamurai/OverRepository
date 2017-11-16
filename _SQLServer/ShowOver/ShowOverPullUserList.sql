--drop PROCEDURE ShowOverPullUserList;

create PROCEDURE ShowOverPullUserList
AS
BEGIN
	select * from Users, ShowOverUsers where Users.Indext = ShowOverUsers.UserIndex;
END