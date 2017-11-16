--drop PROCEDURE WatchOverAddTargetSuggestion;

create PROCEDURE WatchOverAddTargetSuggestion
(
    @strMovieName varChar(50),
	@strMovieRelease varChar(50),
	@strMovieGenre varChar(50),
	@strMoviePicture varChar(50)
    
)
AS
BEGIN
	INSERT INTO MovieRequests (Name, Release, Genre, Picture ) VALUES ( @strMovieName, @strMovieRelease, @strMovieGenre, @strMoviePicture );
END