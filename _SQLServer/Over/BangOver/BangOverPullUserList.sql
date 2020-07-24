--drop PROCEDURE BangOverPullUserList;

create PROCEDURE BangOverPullUserList
AS
BEGIN
	select * 
	from [Over].dbo.BangOverUsers U
	JOIN [Over].dbo.Users O ON U.OverUserIndex = O.UserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex;
END