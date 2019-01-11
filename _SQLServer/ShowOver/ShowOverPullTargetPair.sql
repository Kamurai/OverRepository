--drop PROCEDURE ShowOverPullTargetPair;

create PROCEDURE ShowOverPullTargetPair
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
	SET @UserCount = (select count(MasterUserIndex) from ShowOverLists where MasterUserIndex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked Shows from personal list
			--//adjust OrderCount to exclude (1's uplock and count's downlock only available)
		SET @OrderCount = (
		select count(ListIndex) from ShowOverLists where MasterUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
		and not ( OrderRank = 0 and UpLock = 0 and DownLock = 1 ) and not (OrderRank = (@UserCount-1) and UpLock = 1 and DownLock = 0)
		);
		SET @GlobalExclusionCount = (select count(Shows.TargetIndex) from Shows
			JOIN ShowOverUsers ON
			(
				(
					--Genres
					(Genre = 'Comedy'			and ComedyS = 1)			or 
					(Genre = 'Drama'			and DramaS = 1)				or 
					(Genre = 'Action'			and ActionS = 1)			or 
					(Genre = 'Horror'			and HorrorS = 1)			or 
					(Genre = 'Thriller'			and ThrillerS = 1)			or 
					(Genre = 'Mystery'			and MysteryS = 1)			or 
					(Genre = 'Documentary'		and DocumentaryS = 1) 
				)
				and
				(
					--Settings
					(Setting = 'ScienceFiction'	and ScienceFictionS = 1)	or 
					(Setting = 'Fantasy'		and FantasyS = 1)			or 
					(Setting = 'Western'		and WesternS = 1)			or 
					(Setting = 'MartialArts'	and MartialArtsS = 1)		or 
					(Setting = 'Modern'			and ModernS = 1)			or 
					(Setting = 'Historic'		and HistoricS = 1)			or 
					(Setting = 'PreHistoric'	and PreHistoricS = 1)		or 
					(Setting = 'Comics'			and ComicsS = 1)			or 
					(Setting = 'Period'			and PeriodS = 1)
				)
			) 
			WHERE ShowOverUsers.MasterUserIndex = @intUserIndex
			and Shows.TargetIndex not in(
				select Shows.TargetIndex from Shows
				JOIN ShowOverLists ON
					Shows.TargetIndex = ShowOverLists.ShowIndex
				JOIN ShowOverUsers ON
					ShowOverLists.MasterUserIndex = ShowOverUsers.MasterUserIndex
				where ShowOverUsers.MasterUserIndex = @intUserIndex
			)
		);
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are Shows left in the global list
			IF( @GlobalExclusionCount > 0 )
			BEGIN
				--//request random non-locked Target from personal list
				SET @TargetIndex = (select top 1 ListIndex from ShowOverLists where MasterUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0) order by newid());
			END
			ELSE
			BEGIN
				--//request random non-locked Target from personal list
					--//exclude the first and last Shows
				SET @TargetIndex = (select top 1 ListIndex from ShowOverLists 
				where MasterUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
				and (OrderRank != 0 and OrderRank != @UserCount-1 ) order by newid());
			END


			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are Shows left in the global list
			if ( (select count(MasterUserIndex) from ShowOverLists 
			where (ListIndex = @TargetIndex and OrderRank = 0) or (ListIndex = @TargetIndex and OrderRank = @UserCount-1) ) > 0 
			and @GlobalExclusionCount > 0 )
			BEGIN    
				--//request @TargetIndex from personal list
				select Shows.TargetIndex, Name, Release, Picture, Genre, Setting from ShowOverLists
				JOIN Shows ON
					ShowOverLists.ShowIndex = Shows.TargetIndex
				where ShowOverLists.ListIndex = @TargetIndex 
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( 
					select Top 1 Shows.TargetIndex, Name, Release, Picture, Genre, Setting from Shows
					JOIN ShowOverUsers ON
						(
							(
								--Genres
								(Genre = 'Comedy'			and ComedyS = 1)			or 
								(Genre = 'Drama'			and DramaS = 1)				or 
								(Genre = 'Action'			and ActionS = 1)			or 
								(Genre = 'Horror'			and HorrorS = 1)			or 
								(Genre = 'Thriller'			and ThrillerS = 1)			or 
								(Genre = 'Mystery'			and MysteryS = 1)			or 
								(Genre = 'Documentary'		and DocumentaryS = 1) 
							)
							and
							(
								--Settings
								(Setting = 'ScienceFiction'	and ScienceFictionS = 1)	or 
								(Setting = 'Fantasy'		and FantasyS = 1)			or 
								(Setting = 'Western'		and WesternS = 1)			or 
								(Setting = 'MartialArts'	and MartialArtsS = 1)		or 
								(Setting = 'Modern'			and ModernS = 1)			or 
								(Setting = 'Historic'		and HistoricS = 1)			or 
								(Setting = 'PreHistoric'	and PreHistoricS = 1)		or 
								(Setting = 'Comics'			and ComicsS = 1)			or 
								(Setting = 'Period'			and PeriodS = 1)
							)
						) 
					WHERE ShowOverUsers.MasterUserIndex = @intUserIndex
					and Shows.TargetIndex not in(
						select Shows.TargetIndex from Shows
						JOIN ShowOverLists ON
							Shows.TargetIndex = ShowOverLists.ShowIndex
						JOIN ShowOverUsers ON
							ShowOverLists.MasterUserIndex = ShowOverUsers.MasterUserIndex
						where ShowOverUsers.MasterUserIndex = @intUserIndex
					) order by newid() 
				) T1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select OrderRank from ShowOverLists where ListIndex = @TargetIndex);
				--//request @TargetIndex from personal list
				select Shows.TargetIndex, Name, Release, Picture, Genre, Setting from  Shows
				JOIN ShowOverLists ON
					Shows.TargetIndex = ShowOverLists.ShowIndex
				where ShowOverLists.ListIndex = @TargetIndex
				UNION
				--//request adjacent non-locked Target from personal list
				select * from (
					select top 1 Shows.TargetIndex, Name, Release, Picture, Genre, Setting from Shows
					JOIN ShowOverLists ON
						Shows.TargetIndex = ShowOverLists.ShowIndex
					where MasterUserIndex = @intUserIndex 
					and
					( 
						(OrderRank = @SavedOrder-1 and DownLock = 0) or 
						(OrderRank = @SavedOrder+1 and UpLock = 0) 
					) order by newid()
				) T2;
			END
		END                    
		--//else (there are no unlocked records)
		ELSE
		BEGIN
			--//there are Shows left in the global list
			IF( @GlobalExclusionCount > 0 )
			BEGIN
				--//request Order = 0 or Order = count from personal list
				select * from (
					select top 1 Shows.TargetIndex, Name, Release, Picture, Genre, Setting from Shows
					JOIN ShowOverLists ON
						Shows.TargetIndex = ShowOverLists.ShowIndex
					where MasterUserIndex = @intUserIndex 
					and 
						( OrderRank = 0 or OrderRank = @UserCount-1 )
					order by newid() 
				) T3
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( 
					select Top 1 Shows.TargetIndex, Name, Release, Picture, Genre, Setting from Shows
					JOIN ShowOverUsers ON
					(
						(
							--Genres
							(Genre = 'Comedy'			and ComedyS = 1)			or 
							(Genre = 'Drama'			and DramaS = 1)				or 
							(Genre = 'Action'			and ActionS = 1)			or 
							(Genre = 'Horror'			and HorrorS = 1)			or 
							(Genre = 'Thriller'			and ThrillerS = 1)			or 
							(Genre = 'Mystery'			and MysteryS = 1)			or 
							(Genre = 'Documentary'		and DocumentaryS = 1) 
						)
						and
						(
							--Settings
							(Setting = 'ScienceFiction'	and ScienceFictionS = 1)	or 
							(Setting = 'Fantasy'		and FantasyS = 1)			or 
							(Setting = 'Western'		and WesternS = 1)			or 
							(Setting = 'MartialArts'	and MartialArtsS = 1)		or 
							(Setting = 'Modern'			and ModernS = 1)			or 
							(Setting = 'Historic'		and HistoricS = 1)			or 
							(Setting = 'PreHistoric'	and PreHistoricS = 1)		or 
							(Setting = 'Comics'			and ComicsS = 1)			or 
							(Setting = 'Period'			and PeriodS = 1)
						)
					) 
					WHERE ShowOverUsers.MasterUserIndex = @intUserIndex
					and Shows.TargetIndex not in(
						select Shows.TargetIndex from Shows
						JOIN ShowOverLists ON
							Shows.TargetIndex = ShowOverLists.ShowIndex
						JOIN ShowOverUsers ON
							ShowOverLists.MasterUserIndex = ShowOverUsers.MasterUserIndex
						where ShowOverUsers.MasterUserIndex = @intUserIndex
					) order by newid() 
				) T4;
			END
			ELSE
			--//there are no selections left in the global list
				--//there are no unlocked records
			BEGIN
				--//return the top two records from personal list
				select top 2 Shows.TargetIndex, Name, Release, Picture, Genre, Setting from Shows
				JOIN ShowOverLists ON
					Shows.TargetIndex = ShowOverLists.ShowIndex
				where MasterUserIndex = @intUserIndex
				and ( (OrderRank = 0) or (OrderRank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random Shows from global list
		select top 2 Shows.TargetIndex, Name, Release, Picture, Genre, Setting from Shows
		JOIN ShowOverUsers ON		
		(
			(
				--Genres
				(Genre = 'Comedy'			and ComedyS = 1)			or 
				(Genre = 'Drama'			and DramaS = 1)				or 
				(Genre = 'Action'			and ActionS = 1)			or 
				(Genre = 'Horror'			and HorrorS = 1)			or 
				(Genre = 'Thriller'			and ThrillerS = 1)			or 
				(Genre = 'Mystery'			and MysteryS = 1)			or 
				(Genre = 'Documentary'		and DocumentaryS = 1) 
			)
			and
			(
				--Settings
				(Setting = 'ScienceFiction'	and ScienceFictionS = 1)	or 
				(Setting = 'Fantasy'		and FantasyS = 1)			or 
				(Setting = 'Western'		and WesternS = 1)			or 
				(Setting = 'MartialArts'	and MartialArtsS = 1)		or 
				(Setting = 'Modern'			and ModernS = 1)			or 
				(Setting = 'Historic'		and HistoricS = 1)			or 
				(Setting = 'PreHistoric'	and PreHistoricS = 1)		or 
				(Setting = 'Comics'			and ComicsS = 1)			or 
				(Setting = 'Period'			and PeriodS = 1)
			)
		) 
		where ShowOverUsers.MasterUserIndex = @intUserIndex order by newid();
	END

END