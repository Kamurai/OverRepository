--drop PROCEDURE ShowOverPullAdvertPair;

CREATE OR ALTER PROCEDURE ShowOverPullAdvertPair
AS
BEGIN
	select top 2 * from ShowOverAdverts order by newid();
END