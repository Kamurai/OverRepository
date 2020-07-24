--drop PROCEDURE ShowOverPullTargetPair;

create PROCEDURE ShowOverPullTargetPair(
    @intUserIndex int        
)
AS
BEGIN
	DECLARE @UserCount 			int = 0;
	DECLARE @OrderCount 		int = 0;
	DECLARE @GlobalCount 		int = 0;
	DECLARE @ListIndex 			int = 0;
	DECLARE @SecondListIndex 	int = 0;
	DECLARE @SavedOrder 		int = 0;

	--//request count of records related to user
	SET @UserCount = (select count(L.UserIndex) from ShowOverLists L where L.UserIndex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked Shows from personal list
		IF( (SELECT TOP 1 U.Memory FROM ShowOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
		BEGIN
			SET @OrderCount = (
				SELECT count(L1.ListIndex) FROM ShowOverLists L1
				JOIN ShowOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
				JOIN ShowOverUsers U ON L1.UserIndex = U.UserIndex
				WHERE L1.UserIndex = @intUserIndex
				AND(
					 L1.TargetIndex NOT IN(
						SELECT M.TargetIndex1 FROM ShowOverMemories M
						WHERE L1.TargetIndex = M.TargetIndex1
						AND L2.TargetIndex = M.TargetIndex2
						UNION
						SELECT M.TargetIndex2 FROM ShowOverMemories M
						WHERE L1.TargetIndex = M.TargetIndex2
						AND L2.TargetIndex = M.TargetIndex1
					) OR (
						U.Memory = 0
					)				
				)
			);
		END
		ELSE
		BEGIN
			--//adjust OrderCount to exclude (1's L.UpLock and count's L.DownLock only available)
			select count(L.ListIndex) from ShowOverLists L where L.UserIndex = @intUserIndex 
			and (
				L.UpLock = 0 or L.DownLock = 0
			)and not (
				L.Rank = 0 and L.UpLock = 0 and L.DownLock = 1 
			) and not (
				L.Rank = (@UserCount-1) and L.UpLock = 1 and L.DownLock = 0
			)
		END

		SET @GlobalCount = (select count(T.TargetIndex) from Shows T
			JOIN ShowOverUsers U ON
			(
				(
					--Genres
					(T.Genre = 'Comedy'				and U.Comedy = 1)			or 
					(T.Genre = 'Drama'				and U.Drama = 1)			or 
					(T.Genre = 'Action'				and U.Action = 1)			or 
					(T.Genre = 'Horror'				and U.Horror = 1)			or 
					(T.Genre = 'Thriller'			and U.Thriller = 1)			or 
					(T.Genre = 'Mystery'			and U.Mystery = 1)			or 
					(T.Genre = 'Documentary'		and U.Documentary = 1) 
				)
				and
				(
					--Settings
					(T.Setting = 'ScienceFiction'	and U.ScienceFiction = 1)	or 
					(T.Setting = 'Fantasy'			and U.Fantasy = 1)			or 
					(T.Setting = 'Western'			and U.Western = 1)			or 
					(T.Setting = 'MartialArts'		and U.MartialArts = 1)		or 
					(T.Setting = 'Modern'			and U.Modern = 1)			or 
					(T.Setting = 'Historic'			and U.Historic = 1)			or 
					(T.Setting = 'PreHistoric'		and U.PreHistoric = 1)		or 
					(T.Setting = 'Comics'			and U.Comics = 1)			or 
					(T.Setting = 'Period'			and U.Period = 1)
				)
			) 
			WHERE U.UserIndex = @intUserIndex
			and T.TargetIndex not in(
				select T2.TargetIndex from Shows T2
				JOIN ShowOverLists L2 ON
					T2.TargetIndex = L2.TargetIndex
				JOIN ShowOverUsers U2 ON
					L2.UserIndex = U2.UserIndex
				where U2.UserIndex = @intUserIndex
			)
		);
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are Shows left in the global list
			IF( @GlobalCount > 0 )
			BEGIN
				IF( (SELECT TOP 1 U.Memory FROM ShowOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = 
					(
						SELECT top 1 L1.ListIndex FROM ShowOverLists L1
						JOIN ShowOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
						JOIN ShowOverUsers U ON L1.UserIndex = U.UserIndex
						WHERE L1.UserIndex = @intUserIndex
						AND(
							 L1.TargetIndex NOT IN(
								SELECT M.TargetIndex1 FROM ShowOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex1
								AND L2.TargetIndex = M.TargetIndex2
								UNION
								SELECT M.TargetIndex2 FROM ShowOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex2
								AND L2.TargetIndex = M.TargetIndex1
							) OR (
								U.Memory = 0
							)				
						)
						order by newid()
					);
				END
				ELSE
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = (select top 1 L.ListIndex from ShowOverLists L where L.UserIndex = @intUserIndex and (L.UpLock = 0 or L.DownLock = 0) order by newid());
				END
			END
			ELSE
			BEGIN
				IF( (SELECT TOP 1 U.Memory FROM ShowOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
				BEGIN
					--//request random non-locked Target from personal list
						--//exclude the first and last Shows
					SET @ListIndex = 
					(
						SELECT top 1 L1.ListIndex FROM ShowOverLists L1
						JOIN ShowOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
						JOIN ShowOverUsers U ON L1.UserIndex = U.UserIndex
						WHERE L1.UserIndex = @intUserIndex
						AND(
							 L1.TargetIndex NOT IN(
								SELECT M.TargetIndex1 FROM ShowOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex1
								AND L2.TargetIndex = M.TargetIndex2
								UNION
								SELECT M.TargetIndex2 FROM ShowOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex2
								AND L2.TargetIndex = M.TargetIndex1
							) OR (
								U.Memory = 0
							)
						)
						--//exclude the first and last Shows
						and (L1.Rank != 0 and L1.Rank != @UserCount-1 )
						order by newid()
					);
				END
				ELSE
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = (select top 1 L.ListIndex from ShowOverLists L
					where L.UserIndex = @intUserIndex and (L.UpLock = 0 or L.DownLock = 0)
					--//exclude the first and last Shows
					and (L.Rank != 0 and L.Rank != @UserCount-1 ) order by newid());
				END
			END

			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are Shows left in the global list
			if (
				(
					select count(L.UserIndex) from ShowOverLists L
					where (L.ListIndex = @ListIndex and L.Rank = 0) 
					or (L.ListIndex = @ListIndex and L.Rank = @UserCount-1) 
					) > 0 
					and @GlobalCount > 0 )
			BEGIN
				--//request @ListIndex from personal list
				select T.TargetIndex, Name, Release, Picture, Genre, Setting from ShowOverLists L
				JOIN Shows T ON
					L.TargetIndex = T.TargetIndex
				where L.ListIndex = @ListIndex 
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( 
					select Top 1 T.TargetIndex, Name, Release, Picture, Genre, Setting from Shows T
					JOIN ShowOverUsers U ON
						(
							(
								--Genres
								(T.Genre = 'Comedy'				and U.Comedy = 1)			or 
								(T.Genre = 'Drama'				and U.Drama = 1)			or 
								(T.Genre = 'Action'				and U.Action = 1)			or 
								(T.Genre = 'Horror'				and U.Horror = 1)			or 
								(T.Genre = 'Thriller'			and U.Thriller = 1)			or 
								(T.Genre = 'Mystery'			and U.Mystery = 1)			or 
								(T.Genre = 'Documentary'		and U.Documentary = 1) 
							)
							and
							(
								--Settings
								(T.Setting = 'ScienceFiction'	and U.ScienceFiction = 1)	or 
								(T.Setting = 'Fantasy'			and U.Fantasy = 1)			or 
								(T.Setting = 'Western'			and U.Western = 1)			or 
								(T.Setting = 'MartialArts'		and U.MartialArts = 1)		or 
								(T.Setting = 'Modern'			and U.Modern = 1)			or 
								(T.Setting = 'Historic'			and U.Historic = 1)			or 
								(T.Setting = 'PreHistoric'		and U.PreHistoric = 1)		or 
								(T.Setting = 'Comics'			and U.Comics = 1)			or 
								(T.Setting = 'Period'			and U.Period = 1)
							)
						) 
					WHERE U.UserIndex = @intUserIndex
					and T.TargetIndex not in(
						select T2.TargetIndex from Shows T2
						JOIN ShowOverLists L2 ON
							T2.TargetIndex = L2.TargetIndex
						JOIN ShowOverUsers U2 ON
							L2.UserIndex = U2.UserIndex
						where U2.UserIndex = @intUserIndex
					) 
					order by newid() 
				) AS TABLE1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select L.Rank from ShowOverLists L where L.ListIndex = @ListIndex);
				
				IF( (SELECT TOP 1 U.Memory FROM ShowOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
				BEGIN
					SET @SecondListIndex = (
						SELECT top 1 L2.ListIndex FROM ShowOverLists L1
						JOIN ShowOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
						JOIN ShowOverUsers U ON L1.UserIndex = U.UserIndex
						WHERE L1.UserIndex = @intUserIndex
						AND L1.ListIndex = @ListIndex
						AND(
							 L1.TargetIndex NOT IN(
								SELECT M.TargetIndex1 FROM ShowOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex1
								AND L2.TargetIndex = M.TargetIndex2
								UNION
								SELECT M.TargetIndex2 FROM ShowOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex2
								AND L2.TargetIndex = M.TargetIndex1
							) OR (
								U.Memory = 0
							)				
						)
						order by newid()
					);
				END
				ELSE
				BEGIN
					if( (SELECT L.UpLock FROM ShowOverLists L WHERE L.Rank = @SavedOrder) = 0 )
					BEGIN
						SET @SecondListIndex = (SELECT L.ListIndex FROM ShowOverLists L WHERE L.Rank = @SavedOrder-1);
					END
					else if( (SELECT L.DownLock FROM ShowOverLists L WHERE L.Rank = @SavedOrder) = 0 )
					BEGIN
						SET @SecondListIndex = (SELECT L.ListIndex FROM ShowOverLists L WHERE L.Rank = @SavedOrder+1);
					END
				END
				
				--//request @ListIndex from personal list
				(select T.TargetIndex, Name, Release, Picture, Genre, Setting from Shows T
				JOIN ShowOverLists L ON
					T.TargetIndex = L.TargetIndex
				where L.ListIndex = @ListIndex 
				UNION
				select T.TargetIndex, Name, Release, Picture, Genre, Setting from Shows T
				JOIN ShowOverLists L ON
					T.TargetIndex = L.TargetIndex
				where L.ListIndex = @SecondListIndex
				);
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
					select top 1 T.TargetIndex, Name, Release, Picture, Genre, Setting from Shows T
					JOIN ShowOverLists L ON
						T.TargetIndex = L.TargetIndex
					where L.UserIndex = @intUserIndex 
					and 
						( L.Rank = 0 or L.Rank = @UserCount-1 )
					order by newid() 
				) AS TABLE2
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( 
					select Top 1 T.TargetIndex, Name, Release, Picture, Genre, Setting from Shows T
					JOIN ShowOverUsers U ON
					(
						(
							--Genres
							(T.Genre = 'Comedy'				and U.Comedy = 1)			or 
							(T.Genre = 'Drama'				and U.Drama = 1)			or 
							(T.Genre = 'Action'				and U.Action = 1)			or 
							(T.Genre = 'Horror'				and U.Horror = 1)			or 
							(T.Genre = 'Thriller'			and U.Thriller = 1)			or 
							(T.Genre = 'Mystery'			and U.Mystery = 1)			or 
							(T.Genre = 'Documentary'		and U.Documentary = 1) 
						)
						and
						(
							--Settings
							(T.Setting = 'ScienceFiction'	and U.ScienceFiction = 1)	or 
							(T.Setting = 'Fantasy'			and U.Fantasy = 1)			or 
							(T.Setting = 'Western'			and U.Western = 1)			or 
							(T.Setting = 'MartialArts'		and U.MartialArts = 1)		or 
							(T.Setting = 'Modern'			and U.Modern = 1)			or 
							(T.Setting = 'Historic'			and U.Historic = 1)			or 
							(T.Setting = 'PreHistoric'		and U.PreHistoric = 1)		or 
							(T.Setting = 'Comics'			and U.Comics = 1)			or 
							(T.Setting = 'Period'			and U.Period = 1)
						)
					) 
					WHERE U.UserIndex = @intUserIndex
					and T.TargetIndex not in(
						select T2.TargetIndex from Shows T2
						JOIN ShowOverLists L2 ON
							T2.TargetIndex = L2.TargetIndex
						JOIN ShowOverUsers U2 ON
							L2.UserIndex = U2.UserIndex
						where U2.UserIndex = @intUserIndex
					) order by newid() 
				) AS TABLE3;
			END
			ELSE
			--//there are no selections left in the global list
				--//there are no unlocked records
			BEGIN
				--//return the top two records from personal list
				select top 2 T.TargetIndex, Name, Release, Picture, Genre, Setting from Shows T
				JOIN ShowOverLists L ON
					T.TargetIndex = L.TargetIndex
				where L.UserIndex = @intUserIndex
				and ( (L.Rank = 0) or (L.Rank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random Shows from global list
		select top 2 T.TargetIndex, Name, Release, Picture, Genre, Setting from Shows T
		JOIN ShowOverUsers U ON		
		(
			(
				--Genres
				(T.Genre = 'Comedy'				and U.Comedy = 1)			or 
				(T.Genre = 'Drama'				and U.Drama = 1)			or 
				(T.Genre = 'Action'				and U.Action = 1)			or 
				(T.Genre = 'Horror'				and U.Horror = 1)			or 
				(T.Genre = 'Thriller'			and U.Thriller = 1)			or 
				(T.Genre = 'Mystery'			and U.Mystery = 1)			or 
				(T.Genre = 'Documentary'		and U.Documentary = 1) 
			)
			and
			(
				--Settings
				(T.Setting = 'ScienceFiction'	and U.ScienceFiction = 1)	or 
				(T.Setting = 'Fantasy'			and U.Fantasy = 1)			or 
				(T.Setting = 'Western'			and U.Western = 1)			or 
				(T.Setting = 'MartialArts'		and U.MartialArts = 1)		or 
				(T.Setting = 'Modern'			and U.Modern = 1)			or 
				(T.Setting = 'Historic'			and U.Historic = 1)			or 
				(T.Setting = 'PreHistoric'		and U.PreHistoric = 1)		or 
				(T.Setting = 'Comics'			and U.Comics = 1)			or 
				(T.Setting = 'Period'			and U.Period = 1)
			)
		) 
		where U.UserIndex = @intUserIndex order by newid();
	END
END