--drop PROCEDURE BoardOverPullAdvertSingle;

create PROCEDURE BoardOverPullAdvertSingle
AS
BEGIN
	select top 1 * from BoardOverAdverts order by newid();
END