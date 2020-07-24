--drop PROCEDURE BoardOverPullUserList;

create PROCEDURE BoardOverPullUserList
AS
BEGIN
	select * 
	from [Over].dbo.BoardOverUsers U
	JOIN [Over].dbo.Users O ON U.OverUserIndex = O.UserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex;
END