--drop PROCEDURE BangOverPullUserList;

create PROCEDURE BangOverPullUserList
AS
BEGIN
	select * from Users, BangOverUsers where Users.Indext = BangOverUsers.UserIndex;
END