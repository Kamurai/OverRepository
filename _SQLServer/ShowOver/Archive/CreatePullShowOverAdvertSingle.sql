--drop PROCEDURE PullShowOverAdvertSingle;

create PROCEDURE PullShowOverAdvertSingle
AS
BEGIN
	select top 1 * from ShowOverAdverts order by newid();
END