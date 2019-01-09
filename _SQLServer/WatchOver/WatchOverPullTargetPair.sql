--drop PROCEDURE WatchOverPullTargetPair;

create PROCEDURE WatchOverPullTargetPair
(
    @intUserIndex int        
)
AS
BEGIN
	DECLARE @UserCount int = 0;
	DECLARE @OrderCount int = 0;
	DECLARE @GlobalExclusionCount int = 0;
	DECLARE @TargetIndex int = 0;
	DECLARE @SavedOrder int = 0;

	--//request count of records related to user
	SET @UserCount = (select count(MasterUserIndex) from WatchOverLists where userindex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked Movies from personal list
			--//adjust OrderCount to exclude (1's uplock and count's downlock only available)
		SET @OrderCount = (
		select count(ListIndex) from WatchOverLists where MasterUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
		and not ( OrderRank = 0 and UpLock = 0 and DownLock = 1 ) and not (OrderRank = (@UserCount-1) and UpLock = 1 and DownLock = 0)
		);
		SET @GlobalExclusionCount = (select count(Movies.TargetIndex) from Movies, WatchOverUsers
			where (
				(
					--Genres
					(Genre = 'Comedy'			and ComedyM = 1)			or 
					(Genre = 'Drama'			and DramaM = 1)				or 
					(Genre = 'Action'			and ActionM = 1)			or 
					(Genre = 'Horror'			and HorrorM = 1)			or 
					(Genre = 'Thriller'			and ThrillerM = 1)			or 
					(Genre = 'Mystery'			and MysteryM = 1)			or 
					(Genre = 'Documentary'		and DocumentaryM = 1) 
				)
				and
				(
					--Settings
					(Setting = 'ScienceFiction'	and ScienceFictionM = 1)	or 
					(Setting = 'Fantasy'		and FantasyM = 1)			or 
					(Setting = 'Western'		and WesternM = 1)			or 
					(Setting = 'MartialArts'	and MartialArtsM = 1)		or 
					(Setting = 'Modern'			and ModernM = 1)			or 
					(Setting = 'Historic'		and HistoricM = 1)			or 
					(Setting = 'PreHistoric'	and PreHistoricM = 1)		or 
					(Setting = 'Comics'			and ComicsM = 1)			or 
					(Setting = 'Period'			and PeriodM = 1)
				)
			) 
			and WatchOverUsers.MasterUserIndex = @intUserIndex
			and Movies.TargetIndex not in(
			select Movies.TargetIndex from Movies, WatchOverLists, WatchOverUsers
			where WatchOverUsers.MasterUserIndex = @intUserIndex and WatchOverLists.MasterUserIndex = WatchOverUsers.MasterUserIndex and MovieIndex = Movies.TargetIndex
			));
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are Movies left in the global list
			IF( @GlobalExclusionCount > 0 )
			BEGIN
				--//request random non-locked Target from personal list
				SET @TargetIndex = (select top 1 ListIndex from WatchOverLists where MasterUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0) order by newid());
			END
			ELSE
			BEGIN
				--//request random non-locked Target from personal list
					--//exclude the first and last Movies
				SET @TargetIndex = (select top 1 ListIndex from WatchOverLists 
				where MasterUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
				and (OrderRank != 0 and OrderRank != @UserCount-1 ) order by newid());
			END


			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are Movies left in the global list
			if ( (select count(MasterUserIndex) from WatchOverLists 
			where (ListIndex = @TargetIndex and OrderRank = 0) or (ListIndex = @TargetIndex and OrderRank = @UserCount-1) ) > 0 
			and @GlobalExclusionCount > 0 )
			BEGIN    
				--//request @TargetIndex from personal list
				select Movies.TargetIndex, Name, Release, Picture, Genre, Setting from WatchOverLists, Movies where WatchOverLists.ListIndex = @TargetIndex and MovieIndex = Movies.TargetIndex
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( select Top 1 Movies.TargetIndex, Name, Release, Picture, Genre, Setting from Movies, WatchOverUsers
				where (
					(
						--Genres
						(Genre = 'Comedy'			and ComedyM = 1)			or 
						(Genre = 'Drama'			and DramaM = 1)				or 
						(Genre = 'Action'			and ActionM = 1)			or 
						(Genre = 'Horror'			and HorrorM = 1)			or 
						(Genre = 'Thriller'			and ThrillerM = 1)			or 
						(Genre = 'Mystery'			and MysteryM = 1)			or 
						(Genre = 'Documentary'		and DocumentaryM = 1) 
					)
					and
					(
						--Settings
						(Setting = 'ScienceFiction'	and ScienceFictionM = 1)	or 
						(Setting = 'Fantasy'		and FantasyM = 1)			or 
						(Setting = 'Western'		and WesternM = 1)			or 
						(Setting = 'MartialArts'	and MartialArtsM = 1)		or 
						(Setting = 'Modern'			and ModernM = 1)			or 
						(Setting = 'Historic'		and HistoricM = 1)			or 
						(Setting = 'PreHistoric'	and PreHistoricM = 1)		or 
						(Setting = 'Comics'			and ComicsM = 1)			or 
						(Setting = 'Period'			and PeriodM = 1)
					)
				) 
				and WatchOverUsers.MasterUserIndex = @intUserIndex
				and Movies.TargetIndex not in(
				select Movies.TargetIndex from Movies, WatchOverLists, WatchOverUsers
				where WatchOverUsers.MasterUserIndex = @intUserIndex and WatchOverUsers.MasterUserIndex = WatchOverUsers.MasterUserIndex and MovieIndex = Movies.TargetIndex
				) order by newid() ) T1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select OrderRank from WatchOverLists where ListIndex = @TargetIndex);
				--//request @TargetIndex from personal list
				select Movies.TargetIndex, Name, Release, Picture, Genre, Setting from  Movies, WatchOverLists where WatchOverLists.ListIndex = @TargetIndex and MovieIndex = Movies.TargetIndex
				UNION
				--//request adjacent non-locked Target from personal list
				select * from (
					select top 1 Movies.TargetIndex, Name, Release, Picture, Genre, Setting from Movies, WatchOverLists where MasterUserIndex = @intUserIndex and Movies.TargetIndex = MovieIndex and ( (OrderRank = @SavedOrder-1 and DownLock = 0) or (OrderRank = @SavedOrder+1 and UpLock = 0) ) order by newid()
				) T2;
			END
		END                    
		--//else (there are no unlocked records)
		ELSE
		BEGIN
			--//there are Movies left in the global list
			IF( @GlobalExclusionCount > 0 )
			BEGIN
				--//request Order = 0 or Order = count from personal list
				select * from (
				select top 1 Movies.TargetIndex, Name, Release, Picture, Genre, Setting from Movies, WatchOverLists where MasterUserIndex = @intUserIndex and MovieIndex = Movies.TargetIndex and ( OrderRank = 0 or OrderRank = @UserCount-1 )
				order by newid() ) T3
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( select Top 1 Movies.TargetIndex, Name, Release, Picture, Genre, Setting from Movies, WatchOverUsers
				where (
					(
						--Genres
						(Genre = 'Comedy'			and ComedyM = 1)			or 
						(Genre = 'Drama'			and DramaM = 1)				or 
						(Genre = 'Action'			and ActionM = 1)			or 
						(Genre = 'Horror'			and HorrorM = 1)			or 
						(Genre = 'Thriller'			and ThrillerM = 1)			or 
						(Genre = 'Mystery'			and MysteryM = 1)			or 
						(Genre = 'Documentary'		and DocumentaryM = 1) 
					)
					and
					(
						--Settings
						(Setting = 'ScienceFiction'	and ScienceFictionM = 1)	or 
						(Setting = 'Fantasy'		and FantasyM = 1)			or 
						(Setting = 'Western'		and WesternM = 1)			or 
						(Setting = 'MartialArts'	and MartialArtsM = 1)		or 
						(Setting = 'Modern'			and ModernM = 1)			or 
						(Setting = 'Historic'		and HistoricM = 1)			or 
						(Setting = 'PreHistoric'	and PreHistoricM = 1)		or 
						(Setting = 'Comics'			and ComicsM = 1)			or 
						(Setting = 'Period'			and PeriodM = 1)
					)
				) 
				and WatchOverUsers.MasterUserIndex = @intUserIndex
				and Movies.TargetIndex not in(
				select Movies.TargetIndex from Movies, WatchOverLists, Users
				where WatchOverUsers.MasterUserIndex = @intUserIndex and WatchOverLists.MasterUserIndex = WatchOverUsers.MasterUserIndex and MovieIndex = Movies.TargetIndex
				) order by newid() ) T4;
			END
			ELSE
			--//there are no selections left in the global list
				--//there are no unlocked records
			BEGIN
				--//return the top two records from personal list
				select top 2 Movies.TargetIndex, Name, Release, Picture, Genre, Setting from Movies, WatchOverLists where MasterUserIndex = @intUserIndex
				and MovieIndex = Movies.TargetIndex
				and ( (OrderRank = 0) or (OrderRank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random Movies from global list
		select top 2 Movies.TargetIndex, Name, Picture, Release, Genre, Setting from Movies, WatchOverUsers where WatchOverUsers.MasterUserIndex = @intUserIndex and 
		(
			(
				--Genres
				(Genre = 'Comedy'			and ComedyM = 1)			or 
				(Genre = 'Drama'			and DramaM = 1)				or 
				(Genre = 'Action'			and ActionM = 1)			or 
				(Genre = 'Horror'			and HorrorM = 1)			or 
				(Genre = 'Thriller'			and ThrillerM = 1)			or 
				(Genre = 'Mystery'			and MysteryM = 1)			or 
				(Genre = 'Documentary'		and DocumentaryM = 1) 
			)
			and
			(
				--Settings
				(Setting = 'ScienceFiction'	and ScienceFictionM = 1)	or 
				(Setting = 'Fantasy'		and FantasyM = 1)			or 
				(Setting = 'Western'		and WesternM = 1)			or 
				(Setting = 'MartialArts'	and MartialArtsM = 1)		or 
				(Setting = 'Modern'			and ModernM = 1)			or 
				(Setting = 'Historic'		and HistoricM = 1)			or 
				(Setting = 'PreHistoric'	and PreHistoricM = 1)		or 
				(Setting = 'Comics'			and ComicsM = 1)			or 
				(Setting = 'Period'			and PeriodM = 1)
			)
		) order by newid();
	END

END