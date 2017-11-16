--drop PROCEDURE ShowOverAddTarget;

create PROCEDURE ShowOverAddTarget
(
    @strShowName varChar(50),
	@strShowRelease varChar(50),
	@strShowGenre varChar(50),
	@strShowPicture varChar(50)
    
)
AS
BEGIN
	INSERT INTO Shows (Name, Release, Genre, Picture ) VALUES ( @strShowName, @strShowRelease, @strShowGenre, @strShowPicture );

	DELETE FROM ShowRequests where Name = @strShowName;
END