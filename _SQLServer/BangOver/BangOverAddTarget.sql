--drop PROCEDURE BangOverAddTarget;

create PROCEDURE BangOverAddTarget
(
    @strCelebrityName varChar(max),
	@strCelebritySex varChar(1),
	@strCelebrityPicture varChar(max)
    
)
AS
BEGIN
	INSERT INTO Celebrities (Name, Sex, Picture ) VALUES ( @strCelebrityName, @strCelebritySex, @strCelebrityPicture );

	DELETE FROM CelebrityRequests where Name = @strCelebrityName;
END