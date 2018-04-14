--drop PROCEDURE PlayOverPullAdvertPair;

create PROCEDURE PlayOverPullAdvertPair
AS
BEGIN
	select top 2 * from PlayOverAdverts order by newid();
END