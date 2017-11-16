--drop PROCEDURE BoardOverPullUserList;

create PROCEDURE BoardOverPullUserList
AS
BEGIN
	select * from Users, BoardOverUsers where Users.Indext = BoardOverUsers.UserIndex;
END