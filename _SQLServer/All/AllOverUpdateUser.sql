--drop procedure AllOverUpdateUser;

create PROCEDURE AllOverUpdateUser
(
    @userName varChar(max),
    @adminLevel varChar(1)

)
AS
BEGIN
	--//Update preferences to match check boxes (local variables)
	update Users set AdminLevel = @AdminLevel where Username = @userName COLLATE SQL_Latin1_General_CP1_CS_AS;
END
