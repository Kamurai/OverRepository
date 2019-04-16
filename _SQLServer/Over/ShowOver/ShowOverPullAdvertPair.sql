--drop PROCEDURE ShowOverPullAdvertPair;

create PROCEDURE ShowOverPullAdvertPair
AS
BEGIN
	select top 2 * from ShowOverAdverts order by newid();
END