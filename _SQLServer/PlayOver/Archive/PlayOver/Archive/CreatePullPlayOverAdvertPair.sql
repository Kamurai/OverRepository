--drop PROCEDURE PullPlayOverAdvertPair;

create PROCEDURE PullPlayOverAdvertPair
AS
BEGIN
	select top 2 * from PlayOverAdverts order by newid();
END