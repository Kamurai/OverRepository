--drop PROCEDURE BubbleUpPullAdvertPair;

create PROCEDURE BubbleUpPullAdvertPair
AS
BEGIN
	select top 2 * from [BubbleUp].dbo.Adverts order by newid();
END