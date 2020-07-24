--drop PROCEDURE WatchOverPullUserList;

create PROCEDURE WatchOverPullUserList
AS
BEGIN
	select * 
	from [Over].dbo.WatchOverUsers U
	JOIN [Over].dbo.Users O ON U.OverUserIndex = O.UserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex;
END