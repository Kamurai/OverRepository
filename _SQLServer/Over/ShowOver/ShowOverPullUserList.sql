--drop PROCEDURE ShowOverPullUserList;

create PROCEDURE ShowOverPullUserList
AS
BEGIN
	select * 
	from [Over].dbo.ShowOverUsers U
	JOIN [Over].dbo.Users O ON U.OverUserIndex = O.UserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.UserIndex;
END