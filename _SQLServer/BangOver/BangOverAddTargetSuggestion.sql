--drop PROCEDURE BangOverAddTargetSuggestion;

create PROCEDURE BangOverAddTargetSuggestion
(
    @strCelebrityName varChar(max),
	@strCelebritySex varChar(1),
	@strCelebrityPicture varChar(max)
    
)
AS
BEGIN
	INSERT INTO CelebrityRequests (Name, Sex, Picture ) VALUES ( @strCelebrityName, @strCelebritySex, @strCelebrityPicture );
END