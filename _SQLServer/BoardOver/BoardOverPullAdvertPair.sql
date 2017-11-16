--drop PROCEDURE BoardOverPullAdvertPair;

create PROCEDURE BoardOverPullAdvertPair
AS
BEGIN
	select top 2 * from BoardOverAdverts order by newid();
END