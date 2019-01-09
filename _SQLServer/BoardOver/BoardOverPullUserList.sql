--drop PROCEDURE BoardOverPullUserList;

create PROCEDURE BoardOverPullUserList
AS
BEGIN
	select * from Users JOIN BoardOverUsers ON Users.UserIndex = BoardOverUsers.MasterUserIndex;
END