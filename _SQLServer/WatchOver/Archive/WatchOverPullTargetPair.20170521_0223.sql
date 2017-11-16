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
	SET @UserCount = (select count(UserIndex) from WatchOverLists where userindex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked Movies from personal list
			--//adjust OrderCount to exclude (1's uplock and count's downlock only available)
		SET @OrderCount = (
		select count(Indext) from WatchOverLists where UserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
		and not ( OrderRank = 0 and UpLock = 0 and DownLock = 1 ) and not (OrderRank = (@UserCount-1) and UpLock = 1 and DownLock = 0)
		);
		SET @GlobalExclusionCount = (select count(Movies.Indext) from Movies, WatchOverUsers
			where (
			(Genre = 'ComedyM'			and ComedyM = 1)			or 
			(Genre = 'DramaM'			and DramaM = 1)				or 
			(Genre = 'ActionM'			and ActionM = 1)			or 
			(Genre = 'HorrorM'			and HorrorM = 1)			or 
			(Genre = 'ThrillerM'		and ThrillerM = 1)			or 
			(Genre = 'ScienceFictionM'	and ScienceFictionM = 1)	or 
			(Genre = 'FantasyM'			and FantasyM = 1)			or 
			(Genre = 'WesternM'			and WesternM = 1)			or 
			(Genre = 'MartialArtsM'		and MartialArtsM = 1)		or 
			(Genre = 'DocumentaryM'		and DocumentaryM = 1)		or 
			(Genre = 'MockumentaryM'	and MockumentaryM = 1)
			) 
			and WatchOverUsers.UserIndex = @intUserIndex
			and Movies.Indext not in(
			select Movies.Indext from Movies, WatchOverLists, WatchOverUsers
			where WatchOverUsers.UserIndex = @intUserIndex and WatchOverLists.UserIndex = WatchOverUsers.UserIndex and MovieIndex = Movies.Indext
			));
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are Movies left in the global list
			IF( @GlobalExclusionCount > 0 )
			BEGIN
				--//request random non-locked Target from personal list
				SET @TargetIndex = (select top 1 Indext from WatchOverLists where UserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0) order by newid());
			END
			ELSE
			BEGIN
				--//request random non-locked Target from personal list
					--//exclude the first and last Movies
				SET @TargetIndex = (select top 1 Indext from WatchOverLists 
				where UserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
				and (OrderRank != 0 and OrderRank != @UserCount-1 ) order by newid());
			END


			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are Movies left in the global list
			if ( (select count(UserIndex) from WatchOverLists 
			where (Indext = @TargetIndex and OrderRank = 0) or (Indext = @TargetIndex and OrderRank = @UserCount-1) ) > 0 
			and @GlobalExclusionCount > 0 )
			BEGIN    
				--//request @TargetIndex from personal list
				select Movies.Indext, Name, Release, Genre, Picture from WatchOverLists, Movies where WatchOverLists.Indext = @TargetIndex and MovieIndex = Movies.Indext
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( select Top 1 Movies.Indext, Name, Release, Genre, Picture from Movies, WatchOverUsers
				where (
				(Genre = 'ComedyM'			and ComedyM = 1)			or 
				(Genre = 'DramaM'			and DramaM = 1)				or 
				(Genre = 'ActionM'			and ActionM = 1)			or 
				(Genre = 'HorrorM'			and HorrorM = 1)			or 
				(Genre = 'ThrillerM'		and ThrillerM = 1)			or 
				(Genre = 'ScienceFictionM'	and ScienceFictionM = 1)	or 
				(Genre = 'FantasyM'			and FantasyM = 1)			or 
				(Genre = 'WesternM'			and WesternM = 1)			or 
				(Genre = 'MartialArtsM'		and MartialArtsM = 1)		or 
				(Genre = 'DocumentaryM'		and DocumentaryM = 1)		or 
				(Genre = 'MockumentaryM'	and MockumentaryM = 1)
				) 
				and WatchOverUsers.UserIndex = @intUserIndex
				and Movies.Indext not in(
				select Movies.Indext from Movies, WatchOverLists, WatchOverUsers
				where WatchOverUsers.UserIndex = @intUserIndex and WatchOverUsers.UserIndex = WatchOverUsers.UserIndex and MovieIndex = Movies.Indext
				) order by newid() ) T1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select OrderRank from WatchOverLists where Indext = @TargetIndex);
				--//request @TargetIndex from personal list
				select Movies.Indext, Name, Release, Genre, Picture from  Movies, WatchOverLists where WatchOverLists.Indext = @TargetIndex and MovieIndex = Movies.Indext
				UNION
				--//request adjacent non-locked Target from personal list
				select * from (
					select top 1 Movies.Indext, Name, Release, Genre, Picture from Movies, WatchOverLists where UserIndex = @intUserIndex and Movies.Indext = MovieIndex and ( (OrderRank = @SavedOrder-1 and DownLock = 0) or (OrderRank = @SavedOrder+1 and UpLock = 0) ) order by newid()
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
				select top 1 Movies.Indext, Name, Release, Genre, Picture from Movies, WatchOverLists where UserIndex = @intUserIndex and MovieIndex = Movies.Indext and ( OrderRank = 0 or OrderRank = @UserCount-1 )
				order by newid() ) T3
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( select Top 1 Movies.Indext, Name, Release, Genre, Picture from Movies, WatchOverUsers
				where (
				(Genre = 'ComedyM'			and ComedyM = 1)			or 
				(Genre = 'DramaM'			and DramaM = 1)				or 
				(Genre = 'ActionM'			and ActionM = 1)			or 
				(Genre = 'HorrorM'			and HorrorM = 1)			or 
				(Genre = 'ThrillerM'		and ThrillerM = 1)			or 
				(Genre = 'ScienceFictionM'	and ScienceFictionM = 1)	or 
				(Genre = 'FantasyM'			and FantasyM = 1)			or 
				(Genre = 'WesternM'			and WesternM = 1)			or 
				(Genre = 'MartialArtsM'		and MartialArtsM = 1)		or 
				(Genre = 'DocumentaryM'		and DocumentaryM = 1)		or 
				(Genre = 'MockumentaryM'	and MockumentaryM = 1)
				) 
				and WatchOverUsers.UserIndex = @intUserIndex
				and Movies.Indext not in(
				select Movies.Indext from Movies, WatchOverLists, Users
				where WatchOverUsers.UserIndex = @intUserIndex and WatchOverLists.UserIndex = WatchOverUsers.UserIndex and MovieIndex = Movies.Indext
				) order by newid() ) T4;
			END
			ELSE
			--//there are no selections left in the global list
				--//there are no unlocked records
			BEGIN
				--//return the top two records from personal list
				select top 2 Movies.Indext, Name, Release, Genre, Picture from Movies, WatchOverLists where UserIndex = @intUserIndex
				and MovieIndex = Movies.Indext
				and ( (OrderRank = 0) or (OrderRank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random Movies from global list
		select top 2 Movies.Indext, Name, Picture, Release, Genre from Movies, WatchOverUsers where WatchOverUsers.UserIndex = @intUserIndex and 
		(
		(Genre = 'ComedyM'			and ComedyM = 1)			or 
		(Genre = 'DramaM'			and DramaM = 1)				or 
		(Genre = 'ActionM'			and ActionM = 1)			or 
		(Genre = 'HorrorM'			and HorrorM = 1)			or 
		(Genre = 'ThrillerM'		and ThrillerM = 1)			or 
		(Genre = 'ScienceFictionM'	and ScienceFictionM = 1)	or 
		(Genre = 'FantasyM'			and FantasyM = 1)			or 
		(Genre = 'WesternM'			and WesternM = 1)			or 
		(Genre = 'MartialArtsM'		and MartialArtsM = 1)		or 
		(Genre = 'DocumentaryM'		and DocumentaryM = 1)		or 
		(Genre = 'MockumentaryM'	and MockumentaryM = 1)
		) order by newid();
	END

END