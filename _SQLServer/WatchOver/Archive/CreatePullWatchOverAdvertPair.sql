--drop PROCEDURE PullWatchOverAdvertPair;

create PROCEDURE PullWatchOverAdvertPair
AS
BEGIN
	select top 2 * from WatchOverAdverts order by newid();
END