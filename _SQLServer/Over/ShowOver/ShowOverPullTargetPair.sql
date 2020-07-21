--drop PROCEDURE ShowOverPullTargetPair;

create PROCEDURE ShowOverPullTargetPair(
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
	SET @UserCount = (select count(ShowOverUserIndex) from ShowOverLists where ShowOverUserIndex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked Shows from personal list
			--//adjust OrderCount to exclude (1's uplock and count's downlock only available)
		SET @OrderCount = (
			SELECT count(L1.ListIndex) FROM ShowOverLists L1
			JOIN ShowOverLists L2 ON (L1.OrderRank = L2.OrderRank + 1 or L1.OrderRank = L2.OrderRank - 1)
			JOIN ShowOverUsers U ON L1.ShowOverUserIndex = U.ShowOverUserIndex
			WHERE L1.ShowOverUserIndex = @intUserIndex
			AND(
				 L1.ShowIndex NOT IN(
					SELECT M.ShowIndex1 FROM ShowOverMemories M
					WHERE L1.ShowIndex = M.ShowIndex1
					AND L2.ShowIndex = M.ShowIndex2
					UNION
					SELECT M.ShowIndex2 FROM ShowOverMemories M
					WHERE L1.ShowIndex = M.ShowIndex2
					AND L2.ShowIndex = M.ShowIndex1
				) OR (
					U.ShowOverMemory = 0
				)				
			)
		);

		SET @GlobalCount = (select count(Shows.TargetIndex) from Shows
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
			WHERE ShowOverUsers.ShowOverUserIndex = @intUserIndex
			and Shows.TargetIndex not in(
				select Shows.TargetIndex from Shows
				JOIN ShowOverLists ON
					Shows.TargetIndex = ShowOverLists.ShowIndex
				JOIN ShowOverUsers ON
					ShowOverLists.ShowOverUserIndex = ShowOverUsers.ShowOverUserIndex
				where ShowOverUsers.ShowOverUserIndex = @intUserIndex
			)
		);
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are Shows left in the global list
			IF( @GlobalCount > 0 )
			BEGIN
				--//request random non-locked Target from personal list
				SET @TargetIndex = 
				(
					SELECT top 1 L1.ListIndex FROM ShowOverLists L1
					JOIN ShowOverLists L2 ON (L1.OrderRank = L2.OrderRank + 1 or L1.OrderRank = L2.OrderRank - 1)
					JOIN ShowOverUsers U ON L1.ShowOverUserIndex = U.ShowOverUserIndex
					WHERE L1.ShowOverUserIndex = @intUserIndex
					AND(
						 L1.ShowIndex NOT IN(
							SELECT M.ShowIndex1 FROM ShowOverMemories M
							WHERE L1.ShowIndex = M.ShowIndex1
							AND L2.ShowIndex = M.ShowIndex2
							UNION
							SELECT M.ShowIndex2 FROM ShowOverMemories M
							WHERE L1.ShowIndex = M.ShowIndex2
							AND L2.ShowIndex = M.ShowIndex1
						) OR (
							U.ShowOverMemory = 0
						)				
					)
					order by newid()
				);
			END
			ELSE
			BEGIN
				--//request random non-locked Target from personal list
					--//exclude the first and last Shows
				SET @TargetIndex = 
				(
					SELECT top 1 L1.ListIndex FROM ShowOverLists L1
					JOIN ShowOverLists L2 ON (L1.OrderRank = L2.OrderRank + 1 or L1.OrderRank = L2.OrderRank - 1)
					JOIN ShowOverUsers U ON L1.ShowOverUserIndex = U.ShowOverUserIndex
					WHERE L1.ShowOverUserIndex = @intUserIndex
					AND(
						 L1.ShowIndex NOT IN(
							SELECT M.ShowIndex1 FROM ShowOverMemories M
							WHERE L1.ShowIndex = M.ShowIndex1
							AND L2.ShowIndex = M.ShowIndex2
							UNION
							SELECT M.ShowIndex2 FROM ShowOverMemories M
							WHERE L1.ShowIndex = M.ShowIndex2
							AND L2.ShowIndex = M.ShowIndex1
						) OR (
							U.ShowOverMemory = 0
						)
					)
					--//exclude the first and last celebrities
					and (L1.OrderRank != 0 and L1.OrderRank != @UserCount-1 )
					order by newid()
				);
			END

			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are Shows left in the global list
			if (
				(
					select count(ShowOverUserIndex) from ShowOverLists 
					where (ListIndex = @TargetIndex and OrderRank = 0) 
					or (ListIndex = @TargetIndex and OrderRank = @UserCount-1) ) > 0 
					and @GlobalCount > 0 
			)
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
					WHERE ShowOverUsers.ShowOverUserIndex = @intUserIndex
					and Shows.TargetIndex not in(
						select Shows.TargetIndex from Shows
						JOIN ShowOverLists ON
							Shows.TargetIndex = ShowOverLists.ShowIndex
						JOIN ShowOverUsers ON
							ShowOverLists.ShowOverUserIndex = ShowOverUsers.ShowOverUserIndex
						where ShowOverUsers.ShowOverUserIndex = @intUserIndex
					) 
					order by newid() 
				) T1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select OrderRank from ShowOverLists where ListIndex = @TargetIndex);
				
				SET @SecondTargetIndex = (

					SELECT top 1 L2.ListIndex FROM ShowOverLists L1
					JOIN ShowOverLists L2 ON (L1.OrderRank = L2.OrderRank + 1 or L1.OrderRank = L2.OrderRank - 1)
					JOIN ShowOverUsers U ON L1.ShowOverUserIndex = U.ShowOverUserIndex
					WHERE L1.ShowOverUserIndex = @intUserIndex
					AND L1.ListIndex = @TargetIndex
					AND(
						 L1.ShowIndex NOT IN(
							SELECT M.ShowIndex1 FROM ShowOverMemories M
							WHERE L1.ShowIndex = M.ShowIndex1
							AND L2.ShowIndex = M.ShowIndex2
							UNION
							SELECT M.ShowIndex2 FROM ShowOverMemories M
							WHERE L1.ShowIndex = M.ShowIndex2
							AND L2.ShowIndex = M.ShowIndex1
						) OR (
							U.ShowOverMemory = 0
						)				
					)
					order by newid()
				);

				--//request @TargetIndex from personal list
				(select Shows.TargetIndex, Name, Release, Picture, Genre, Setting from Shows
				JOIN ShowOverLists ON
					Shows.TargetIndex = ShowOverLists.ShowIndex
				where ShowOverLists.ListIndex = @TargetIndex 
				UNION
				select Shows.TargetIndex, Name, Release, Picture, Genre, Setting from Shows
				JOIN ShowOverLists ON
					Shows.TargetIndex = ShowOverLists.ShowIndex
				where ShowOverLists.ListIndex = @SecondTargetIndex
				); --T2
			END
		END                    
		--//else (there are no unlocked records)
		ELSE
		BEGIN
			--//there are Shows left in the global list
			IF( @GlobalCount > 0 )
			BEGIN
				--//request Order = 0 or Order = count from personal list
				select * from (
					select top 1 Shows.TargetIndex, Name, Release, Picture, Genre, Setting from Shows
					JOIN ShowOverLists ON
						Shows.TargetIndex = ShowOverLists.ShowIndex
					where ShowOverUserIndex = @intUserIndex 
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
					WHERE ShowOverUsers.ShowOverUserIndex = @intUserIndex
					and Shows.TargetIndex not in(
						select Shows.TargetIndex from Shows
						JOIN ShowOverLists ON
							Shows.TargetIndex = ShowOverLists.ShowIndex
						JOIN ShowOverUsers ON
							ShowOverLists.ShowOverUserIndex = ShowOverUsers.ShowOverUserIndex
						where ShowOverUsers.ShowOverUserIndex = @intUserIndex
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
				where ShowOverUserIndex = @intUserIndex
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
		where ShowOverUsers.ShowOverUserIndex = @intUserIndex order by newid();
	END
END