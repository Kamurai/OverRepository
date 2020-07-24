--drop PROCEDURE BangOverPullTargetPair;

create PROCEDURE BangOverPullTargetPair(
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
	SET @UserCount = (select count(L.UserIndex) from BangOverLists L where L.UserIndex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked celebrities from personal list
		IF( (SELECT TOP 1 U.Memory FROM BangOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
		BEGIN
			SET @OrderCount = (
				SELECT count(L1.ListIndex) FROM BangOverLists L1
				JOIN BangOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
				JOIN BangOverUsers U ON L1.UserIndex = U.UserIndex
				WHERE L1.UserIndex = @intUserIndex
				AND(
					 L1.TargetIndex NOT IN(
						SELECT M.TargetIndex1 FROM BangOverMemories M
						WHERE L1.TargetIndex = M.TargetIndex1
						AND L2.TargetIndex = M.TargetIndex2
						UNION
						SELECT M.TargetIndex2 FROM BangOverMemories M
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
			select count(L.ListIndex) from BangOverLists L where L.UserIndex = @intUserIndex 
			and (
				L.UpLock = 0 or L.DownLock = 0
			)and not (
				L.Rank = 0 and L.UpLock = 0 and L.DownLock = 1 
			) and not (
				L.Rank = (@UserCount-1) and L.UpLock = 1 and L.DownLock = 0
			)
		END

		SET @GlobalCount = (
			select count(T.TargetIndex) from Celebrities T
			JOIN BangOverUsers U ON
			(
				(T.Gender = 'F' and U.Women = 1) 		or 
				(T.Gender = 'M' and U.Men = 1) 			or 
				(T.Gender = 'W' and U.TransWomen = 1) 	or 
				(T.Gender = 'T' and U.TransMen = 1)
			) 
			WHERE U.UserIndex = @intUserIndex
			and T.TargetIndex not in(
				select T2.TargetIndex from Celebrities T2
				JOIN BangOverLists L2 ON
					T2.TargetIndex = L2.TargetIndex
				JOIN BangOverUsers U2 ON
					L2.UserIndex = U2.UserIndex
				where U2.UserIndex = @intUserIndex 
			)
		);
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are celebrities left in the global list
			IF( @GlobalCount > 0 )
			BEGIN
				IF( (SELECT TOP 1 U.Memory FROM BangOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = 
					(
						SELECT top 1 L1.ListIndex FROM BangOverLists L1
						JOIN BangOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
						JOIN BangOverUsers U ON L1.UserIndex = U.UserIndex
						WHERE L1.UserIndex = @intUserIndex
						AND(
							 L1.TargetIndex NOT IN(
								SELECT M.TargetIndex1 FROM BangOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex1
								AND L2.TargetIndex = M.TargetIndex2
								UNION
								SELECT M.TargetIndex2 FROM BangOverMemories M
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
					SET @ListIndex = (select top 1 L.ListIndex from BangOverLists L where L.UserIndex = @intUserIndex and (L.UpLock = 0 or L.DownLock = 0) order by newid());
				END
			END
			ELSE
			BEGIN
				IF( (SELECT TOP 1 U.Memory FROM BangOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = 
					(
						SELECT top 1 L1.ListIndex FROM BangOverLists L1
						JOIN BangOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
						JOIN BangOverUsers U ON L1.UserIndex = U.UserIndex
						WHERE L1.UserIndex = @intUserIndex
						AND(
							 L1.TargetIndex NOT IN(
								SELECT M.TargetIndex1 FROM BangOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex1
								AND L2.TargetIndex = M.TargetIndex2
								UNION
								SELECT M.TargetIndex2 FROM BangOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex2
								AND L2.TargetIndex = M.TargetIndex1
							) OR (
								U.Memory = 0
							)
						)
						--//exclude the first and last celebrities
						and (L1.Rank != 0 and L1.Rank != @UserCount-1 )
						order by newid()
					);
				END
				ELSE
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = (select top 1 L.ListIndex from BangOverLists L
					where L.UserIndex = @intUserIndex and (L.UpLock = 0 or L.DownLock = 0)
					--//exclude the first and last celebrities
					and (L.Rank != 0 and L.Rank != @UserCount-1 ) order by newid());
				END
			END
			
			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are celebrities left in the global list
			if ( 
				(
					select count(L.UserIndex) from BangOverLists L
					where (L.ListIndex = @ListIndex and L.Rank = 0) 
					or (L.ListIndex = @ListIndex and L.Rank = @UserCount-1)
				) > 0 
				and @GlobalCount > 0 )
			BEGIN
				--//request @ListIndex from personal list
				select T.TargetIndex, Name, Gender, Picture from BangOverLists L
				JOIN Celebrities T ON
					L.TargetIndex = T.TargetIndex
				where L.ListIndex = @ListIndex
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from (
					select Top 1 T.TargetIndex, Name, Gender, Picture from Celebrities T
					JOIN BangOverUsers U ON
						(
							(T.Gender = 'F' and U.Women = 1) 		or
							(T.Gender = 'M' and U.Men = 1) 		or 
							(T.Gender = 'W' and U.TransWomen = 1) 	or 
							(T.Gender = 'T' and U.TransMen = 1)
						) 
					WHERE U.UserIndex = @intUserIndex
					and T.TargetIndex not in(
						select T2.TargetIndex from Celebrities T2
						JOIN BangOverLists L2 ON
							T2.TargetIndex = L2.TargetIndex
						JOIN BangOverUsers U2 ON
							U2.UserIndex = L2.UserIndex
						where U2.UserIndex = @intUserIndex 
					) 
					order by newid() 
				) AS TABLE1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select L.Rank from BangOverLists L where L.ListIndex = @ListIndex);
				
				IF( (SELECT TOP 1 U.Memory FROM BangOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
				BEGIN
					SET @SecondListIndex = (

						SELECT top 1 L2.ListIndex FROM BangOverLists L1
						JOIN BangOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
						JOIN BangOverUsers U ON L1.UserIndex = U.UserIndex
						WHERE L1.UserIndex = @intUserIndex
						AND L1.ListIndex = @ListIndex
						AND(
							 L1.TargetIndex NOT IN(
								SELECT M.TargetIndex1 FROM BangOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex1
								AND L2.TargetIndex = M.TargetIndex2
								UNION
								SELECT M.TargetIndex2 FROM BangOverMemories M
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
					if( (SELECT L.UpLock FROM BangOverLists L WHERE L.Rank = @SavedOrder) = 0 )
					BEGIN
						SET @SecondListIndex = (SELECT L.ListIndex FROM BangOverLists L WHERE L.Rank = @SavedOrder-1);
					END
					else if( (SELECT L.DownLock FROM BangOverLists L WHERE L.Rank = @SavedOrder) = 0 )
					BEGIN
						SET @SecondListIndex = (SELECT L.ListIndex FROM BangOverLists L WHERE L.Rank = @SavedOrder+1);
					END
				END

				--//request @ListIndex from personal list
				(select T.TargetIndex, Name, Gender, Picture from Celebrities T
				JOIN BangOverLists L ON
					T.TargetIndex = L.TargetIndex
				where L.ListIndex = @ListIndex 
				UNION
				select T.TargetIndex, Name, Gender, Picture from Celebrities T
				JOIN BangOverLists L ON
					T.TargetIndex = L.TargetIndex
				where L.ListIndex = @SecondListIndex
				);
			END
		END                    
		--//else (there are no unlocked records)
		ELSE
		BEGIN
			--//there are celebrities left in the global list
			IF( @GlobalCount > 0 )
			BEGIN
				--//request Order = 0 or Order = count from personal list
				select * from (
					select top 1 T.TargetIndex, Name, Gender, Picture from Celebrities T
					JOIN BangOverLists L ON 
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
					select Top 1 T.TargetIndex, Name, Gender, Picture from Celebrities T
					JOIN BangOverUsers U ON
					(
						(T.Gender = 'F' and U.Women = 1) 		or 
						(T.Gender = 'M' and U.Men = 1) 		or 
						(T.Gender = 'W' and U.TransWomen = 1) 	or 
						(T.Gender = 'T' and U.TransMen = 1)
					) 
					WHERE U.UserIndex = @intUserIndex
					and T.TargetIndex not in(
						select T2.TargetIndex from Celebrities T2
						JOIN BangOverLists L2 ON
							T2.TargetIndex = L2.TargetIndex
						JOIN BangOverUsers U2 ON
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
				select top 2 T.TargetIndex, Name, Gender, Picture from Celebrities T
				JOIN BangOverLists L ON
					T.TargetIndex = L.TargetIndex
				where L.UserIndex = @intUserIndex
				and ( (L.Rank = 0) or (L.Rank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random celebrities from global list
		select top 2 T.TargetIndex, Name, Picture, Gender from Celebrities T
		JOIN BangOverUsers U ON
		(
			(T.Gender = 'F' and U.Women = 1) 		or 
			(T.Gender = 'M' and U.Men = 1) 			or 
			(T.Gender = 'W' and U.TransWomen = 1) 	or 
			(T.Gender = 'T' and U.TransMen = 1)
		)
		where U.UserIndex = @intUserIndex order by newid();
	END
END