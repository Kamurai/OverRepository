--drop PROCEDURE WatchOverAddTarget;

create PROCEDURE WatchOverAddTarget
(
    @strMovieName varChar(50),
	@strMovieRelease varChar(50),
	@strMovieGenre varChar(50),
	@strMoviePicture varChar(50)    
)
AS
BEGIN
	INSERT INTO Movies (Name, Release, Genre, Picture ) VALUES ( @strMovieName, @strMovieRelease, @strMovieGenre, @strMoviePicture );

	DELETE FROM MovieRequests where Name = @strMovieName;
END