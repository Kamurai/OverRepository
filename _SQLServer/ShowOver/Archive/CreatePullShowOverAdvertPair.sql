--drop PROCEDURE PullShowOverAdvertPair;

create PROCEDURE PullShowOverAdvertPair
AS
BEGIN
	select top 2 * from ShowOverAdverts order by newid();
END