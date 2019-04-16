--drop PROCEDURE PlayOverPullUserList;

create PROCEDURE PlayOverPullUserList
AS
BEGIN
	select * 
	from [Over].dbo.PlayOverUsers P
	JOIN [Over].dbo.Users O ON P.OverUserIndex = O.OverUserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex;
END