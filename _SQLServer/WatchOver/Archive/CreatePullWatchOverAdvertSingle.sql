--drop PROCEDURE PullWatchOverAdvertSingle;

create PROCEDURE PullWatchOverAdvertSingle
AS
BEGIN
	select top 1 * from WatchOverAdverts order by newid();
END