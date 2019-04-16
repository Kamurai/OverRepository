--drop PROCEDURE BangOverPullAdvertPair;

create PROCEDURE BangOverPullAdvertPair
AS
BEGIN
	select top 2 * from BangOverAdverts order by newid();
END