--drop PROCEDURE PlayOverPullUserList;

create PROCEDURE PlayOverPullUserList
AS
BEGIN
	select * from Users JOIN PlayOverUsers ON Users.UserIndex = PlayOverUsers.MasterUserIndex;
END