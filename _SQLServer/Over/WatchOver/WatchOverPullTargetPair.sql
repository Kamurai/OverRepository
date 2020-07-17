--drop PROCEDURE WatchOverPullTargetPair;

create PROCEDURE WatchOverPullTargetPair
(
    @intUserIndex int        
)
AS
BEGIN
	DECLARE @UserCount int = 0;
	DECLARE @OrderCount int = 0;
	DECLARE @GlobalCount int = 0;
	DECLARE @TargetIndex int = 0;
	DECLARE @SecondTargetIndex int = 0;
	DECLARE @SavedOrder int = 0;

	--//request count of records related to user
	SET @UserCount = (select count(WatchOverUserIndex) from WatchOverLists where WatchOverUserIndex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked Movies from personal list
			--//adjust OrderCount to exclude (1's uplock and count's downlock only available)
		SET @OrderCount = (
			select count(ListIndex) from WatchOverLists where WatchOverUserIndex = @intUserIndex 
			and (
				UpLock = 0 or DownLock = 0
			)and not (
				OrderRank = 0 and UpLock = 0 and DownLock = 1 
			) and not (
				OrderRank = (@UserCount-1) and UpLock = 1 and DownLock = 0
			)
		);
		SET @GlobalCount = (select count(Movies.TargetIndex) from Movies
			JOIN WatchOverUsers ON
			(
				(
					--Genres
					(Movies.Genre = 'Comedy'			and WatchOverUsers.ComedyM = 1)			or 
					(Movies.Genre = 'Drama'				and WatchOverUsers.DramaM = 1)			or 
					(Movies.Genre = 'Action'			and WatchOverUsers.ActionM = 1)			or 
					(Movies.Genre = 'Horror'			and WatchOverUsers.HorrorM = 1)			or 
					(Movies.Genre = 'Thriller'			and WatchOverUsers.ThrillerM = 1)		or 
					(Movies.Genre = 'Mystery'			and WatchOverUsers.MysteryM = 1)		or 
					(Movies.Genre = 'Documentary'		and WatchOverUsers.DocumentaryM = 1) 
				)
				and
				(
					--Settings
					(Movies.Setting = 'ScienceFiction'	and WatchOverUsers.ScienceFictionM = 1)	or 
					(Movies.Setting = 'Fantasy'			and WatchOverUsers.FantasyM = 1)		or 
					(Movies.Setting = 'Western'			and WatchOverUsers.WesternM = 1)		or 
					(Movies.Setting = 'MartialArts'		and WatchOverUsers.MartialArtsM = 1)	or 
					(Movies.Setting = 'Modern'			and WatchOverUsers.ModernM = 1)			or 
					(Movies.Setting = 'Historic'		and WatchOverUsers.HistoricM = 1)		or 
					(Movies.Setting = 'PreHistoric'		and WatchOverUsers.PreHistoricM = 1)	or 
					(Movies.Setting = 'Comics'			and WatchOverUsers.ComicsM = 1)			or 
					(Movies.Setting = 'Period'			and WatchOverUsers.PeriodM = 1)
				)
			) 
			WHERE WatchOverUsers.WatchOverUserIndex = @intUserIndex
			and Movies.TargetIndex not in(
				select Movies.TargetIndex from Movies
				JOIN WatchOverLists ON
					Movies.TargetIndex = WatchOverLists.MovieIndex
				JOIN WatchOverUsers ON
					WatchOverUsers.WatchOverUserIndex = WatchOverLists.WatchOverUserIndex
				where WatchOverUsers.WatchOverUserIndex = @intUserIndex
			)
		);
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are Movies left in the global list
			IF( @GlobalCount > 0 )
			BEGIN
				--//request random non-locked Target from personal list
				SET @TargetIndex = (select top 1 ListIndex from WatchOverLists where WatchOverUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0) order by newid());
			END
			ELSE
			BEGIN
				--//request random non-locked Target from personal list
					--//exclude the first and last Movies
				SET @TargetIndex = (select top 1 ListIndex from WatchOverLists 
				where WatchOverUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
				and (OrderRank != 0 and OrderRank != @UserCount-1 ) order by newid());
			END
			
			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are Movies left in the global list
			if ( 
				(select count(WatchOverUserIndex) from WatchOverLists 
			where (ListIndex = @TargetIndex and OrderRank = 0) or (ListIndex = @TargetIndex and OrderRank = @UserCount-1) ) > 0 
			and @GlobalCount > 0 )
			BEGIN    
				--//request @TargetIndex from personal list
				select Movies.TargetIndex, Name, Release, Picture, Genre, Setting from WatchOverLists
				JOIN Movies ON
					WatchOverLists.MovieIndex = Movies.TargetIndex
				where WatchOverLists.ListIndex = @TargetIndex 
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from (
					select Top 1 Movies.TargetIndex, Name, Release, Picture, Genre, Setting from Movies
					JOIN WatchOverUsers ON
					(
						(
							--Genres
							(Movies.Genre = 'Comedy'			and WatchOverUsers.ComedyM = 1)			or 
							(Movies.Genre = 'Drama'				and WatchOverUsers.DramaM = 1)			or 
							(Movies.Genre = 'Action'			and WatchOverUsers.ActionM = 1)			or 
							(Movies.Genre = 'Horror'			and WatchOverUsers.HorrorM = 1)			or 
							(Movies.Genre = 'Thriller'			and WatchOverUsers.ThrillerM = 1)		or 
							(Movies.Genre = 'Mystery'			and WatchOverUsers.MysteryM = 1)		or 
							(Movies.Genre = 'Documentary'		and WatchOverUsers.DocumentaryM = 1) 
						)
						and
						(
							--Settings
							(Movies.Setting = 'ScienceFiction'	and WatchOverUsers.ScienceFictionM = 1)	or 
							(Movies.Setting = 'Fantasy'			and WatchOverUsers.FantasyM = 1)		or 
							(Movies.Setting = 'Western'			and WatchOverUsers.WesternM = 1)		or 
							(Movies.Setting = 'MartialArts'		and WatchOverUsers.MartialArtsM = 1)	or 
							(Movies.Setting = 'Modern'			and WatchOverUsers.ModernM = 1)			or 
							(Movies.Setting = 'Historic'		and WatchOverUsers.HistoricM = 1)		or 
							(Movies.Setting = 'PreHistoric'		and WatchOverUsers.PreHistoricM = 1)	or 
							(Movies.Setting = 'Comics'			and WatchOverUsers.ComicsM = 1)			or 
							(Movies.Setting = 'Period'			and WatchOverUsers.PeriodM = 1)
						)
					) 
					WHERE WatchOverUsers.WatchOverUserIndex = @intUserIndex
					and Movies.TargetIndex not in(
						select Movies.TargetIndex from Movies
						JOIN WatchOverLists ON
							Movies.TargetIndex = WatchOverLists.MovieIndex
						JOIN WatchOverUsers ON
							WatchOverUsers.WatchOverUserIndex = WatchOverLists.WatchOverUserIndex
						where WatchOverUsers.WatchOverUserIndex = @intUserIndex
					) order by newid() 
				) T1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select OrderRank from WatchOverLists where ListIndex = @TargetIndex);
				
				if( (SELECT UpLock FROM WatchOverLists WHERE OrderRank = @SavedOrder) = 0 )
				BEGIN
					SET @SecondTargetIndex = (SELECT ListIndex FROM WatchOverLists WHERE OrderRank = @SavedOrder-1);
				END
				else if( (SELECT DownLock FROM WatchOverLists WHERE OrderRank = @SavedOrder) = 0 )
				BEGIN
					SET @SecondTargetIndex = (SELECT ListIndex FROM WatchOverLists WHERE OrderRank = @SavedOrder+1);
				END

				--//request @TargetIndex from personal list
				(select Movies.TargetIndex, Name, Release, Picture, Genre, Setting from Movies
				JOIN WatchOverLists ON
					Movies.TargetIndex = WatchOverLists.MovieIndex
				where WatchOverLists.ListIndex = @TargetIndex 
				UNION
				select Movies.TargetIndex, Name, Release, Picture, Genre, Setting from Movies
				JOIN WatchOverLists ON
					Movies.TargetIndex = WatchOverLists.MovieIndex
				where WatchOverLists.ListIndex = @SecondTargetIndex
				); --T2
			END
		END                    
		--//else (there are no unlocked records)
		ELSE
		BEGIN
			--//there are Movies left in the global list
			IF( @GlobalCount > 0 )
			BEGIN
				--//request Order = 0 or Order = count from personal list
				select * from (
					select top 1 Movies.TargetIndex, Name, Release, Picture, Genre, Setting from Movies
					JOIN WatchOverLists ON
						Movies.TargetIndex = WatchOverLists.MovieIndex
					where WatchOverUserIndex = @intUserIndex 
					and 
						( OrderRank = 0 or OrderRank = @UserCount-1 )
					order by newid() 
				) T3
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( 
					select Top 1 Movies.TargetIndex, Name, Release, Picture, Genre, Setting from Movies
					JOIN WatchOverUsers ON
					(
						(
							--Genres
							(Movies.Genre = 'Comedy'			and WatchOverUsers.ComedyM = 1)			or 
							(Movies.Genre = 'Drama'				and WatchOverUsers.DramaM = 1)			or 
							(Movies.Genre = 'Action'			and WatchOverUsers.ActionM = 1)			or 
							(Movies.Genre = 'Horror'			and WatchOverUsers.HorrorM = 1)			or 
							(Movies.Genre = 'Thriller'			and WatchOverUsers.ThrillerM = 1)		or 
							(Movies.Genre = 'Mystery'			and WatchOverUsers.MysteryM = 1)		or 
							(Movies.Genre = 'Documentary'		and WatchOverUsers.DocumentaryM = 1) 
						)
						and
						(
							--Settings
							(Movies.Setting = 'ScienceFiction'	and WatchOverUsers.ScienceFictionM = 1)	or 
							(Movies.Setting = 'Fantasy'			and WatchOverUsers.FantasyM = 1)		or 
							(Movies.Setting = 'Western'			and WatchOverUsers.WesternM = 1)		or 
							(Movies.Setting = 'MartialArts'		and WatchOverUsers.MartialArtsM = 1)	or 
							(Movies.Setting = 'Modern'			and WatchOverUsers.ModernM = 1)			or 
							(Movies.Setting = 'Historic'		and WatchOverUsers.HistoricM = 1)		or 
							(Movies.Setting = 'PreHistoric'		and WatchOverUsers.PreHistoricM = 1)	or 
							(Movies.Setting = 'Comics'			and WatchOverUsers.ComicsM = 1)			or 
							(Movies.Setting = 'Period'			and WatchOverUsers.PeriodM = 1)
						)
					) 
					WHERE WatchOverUsers.WatchOverUserIndex = @intUserIndex
					and Movies.TargetIndex not in(
						select Movies.TargetIndex from Movies
						JOIN WatchOverLists ON
							Movies.TargetIndex = WatchOverLists.MovieIndex
						JOIN Users ON
							WatchOverLists.WatchOverUserIndex = WatchOverUsers.WatchOverUserIndex
						where WatchOverUsers.WatchOverUserIndex = @intUserIndex
					) order by newid() 
				) T4;
			END
			ELSE
			--//there are no selections left in the global list
				--//there are no unlocked records
			BEGIN
				--//return the top two records from personal list
				select top 2 Movies.TargetIndex, Name, Release, Picture, Genre, Setting from Movies
				JOIN WatchOverLists ON
					Movies.TargetIndex = WatchOverLists.MovieIndex
				where WatchOverUserIndex = @intUserIndex
				and ( (OrderRank = 0) or (OrderRank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random Movies from global list
		select top 2 Movies.TargetIndex, Name, Picture, Release, Genre, Setting from Movies
		JOIN WatchOverUsers  ON 
		(
				(
					--Genres
					(Movies.Genre = 'Comedy'			and WatchOverUsers.ComedyM = 1)			or 
					(Movies.Genre = 'Drama'				and WatchOverUsers.DramaM = 1)			or 
					(Movies.Genre = 'Action'			and WatchOverUsers.ActionM = 1)			or 
					(Movies.Genre = 'Horror'			and WatchOverUsers.HorrorM = 1)			or 
					(Movies.Genre = 'Thriller'			and WatchOverUsers.ThrillerM = 1)		or 
					(Movies.Genre = 'Mystery'			and WatchOverUsers.MysteryM = 1)		or 
					(Movies.Genre = 'Documentary'		and WatchOverUsers.DocumentaryM = 1) 
				)
				and
				(
					--Settings
					(Movies.Setting = 'ScienceFiction'	and WatchOverUsers.ScienceFictionM = 1)	or 
					(Movies.Setting = 'Fantasy'			and WatchOverUsers.FantasyM = 1)		or 
					(Movies.Setting = 'Western'			and WatchOverUsers.WesternM = 1)		or 
					(Movies.Setting = 'MartialArts'		and WatchOverUsers.MartialArtsM = 1)	or 
					(Movies.Setting = 'Modern'			and WatchOverUsers.ModernM = 1)			or 
					(Movies.Setting = 'Historic'		and WatchOverUsers.HistoricM = 1)		or 
					(Movies.Setting = 'PreHistoric'		and WatchOverUsers.PreHistoricM = 1)	or 
					(Movies.Setting = 'Comics'			and WatchOverUsers.ComicsM = 1)			or 
					(Movies.Setting = 'Period'			and WatchOverUsers.PeriodM = 1)
				)
			)  
			where WatchOverUsers.WatchOverUserIndex = @intUserIndex order by newid();
	END
END