--drop PROCEDURE BoardOverPullUserList;

create PROCEDURE BoardOverPullUserList
AS
BEGIN
	select * 
	from [Over].dbo.BoardOverUsers B
	JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex;
END