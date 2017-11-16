--drop PROCEDURE PullPlayOverAdvertSingle;

create PROCEDURE PullPlayOverAdvertSingle
AS
BEGIN
	select top 1 * from PlayOverAdverts order by newid();
END