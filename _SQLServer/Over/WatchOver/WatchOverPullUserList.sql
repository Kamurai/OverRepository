--drop PROCEDURE WatchOverPullUserList;

create PROCEDURE WatchOverPullUserList
AS
BEGIN
	select * 
	from [Over].dbo.WatchOverUsers W
	JOIN [Over].dbo.Users O ON W.OverUserIndex = O.OverUserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex;
END