--drop PROCEDURE ShowOverPullUserList;

create PROCEDURE ShowOverPullUserList
AS
BEGIN
	select * 
	from [Over].dbo.ShowOverUsers S
	JOIN [Over].dbo.Users O ON S.OverUserIndex = O.OverUserIndex
	JOIN [HTKB].dbo.Users H ON O.HTKBUserIndex = H.HTKBUserIndex;
END