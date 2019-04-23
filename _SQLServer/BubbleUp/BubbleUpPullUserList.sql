--drop PROCEDURE BubbleUpPullUserList;

create PROCEDURE BubbleUpPullUserList
AS
BEGIN
	select * 
	from [BubbleUp].dbo.Users B
	JOIN [HTKB].dbo.Users H ON B.HTKBUserIndex = H.HTKBUserIndex;
END