--drop PROCEDURE BangOverPullAdvertSingle;

create PROCEDURE BangOverPullAdvertSingle
AS
BEGIN
	select top 1 * from BangOverAdverts order by newid();
END