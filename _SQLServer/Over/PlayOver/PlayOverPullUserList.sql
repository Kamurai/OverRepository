--drop PROCEDURE PlayOverPullUserList;

create PROCEDURE PlayOverPullUserList
AS
BEGIN
	select * 
	from [Over].dbo.PlayOverUsers U
	JOIN [Over].dbo.Users O ON U.OverUserIndex = O.UserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex;
END