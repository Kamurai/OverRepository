--drop PROCEDURE PlayOverPullUserList;

create PROCEDURE PlayOverPullUserList
AS
BEGIN
	select * from Users, PlayOverUsers where Users.Indext = PlayOverUsers.UserIndex;
END