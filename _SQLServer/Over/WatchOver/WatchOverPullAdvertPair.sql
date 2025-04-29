--drop PROCEDURE WatchOverPullAdvertPair;

CREATE OR ALTER PROCEDURE WatchOverPullAdvertPair
AS
BEGIN
	select top 2 * from WatchOverAdverts order by newid();
END