--drop PROCEDURE BangOverPullUserList;

create PROCEDURE BangOverPullUserList
AS
BEGIN
	select * 
	from [Over].dbo.BangOverUsers B
	JOIN [Over].dbo.Users O ON B.OverUserIndex = O.OverUserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex;
END