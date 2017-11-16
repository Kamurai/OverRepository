--drop PROCEDURE WatchOverPullAdvertPair;

create PROCEDURE WatchOverPullAdvertPair
AS
BEGIN
	select top 2 * from WatchOverAdverts order by newid();
END