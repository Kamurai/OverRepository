--drop PROCEDURE BoardOverPullTargetPair;

create PROCEDURE BoardOverPullTargetPair(
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
	SET @UserCount = (select count(L.UserIndex) from BoardOverLists L where L.UserIndex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked Board Games from personal list
		IF( (SELECT TOP 1 U.Memory FROM BoardOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
		BEGIN
			--//request count of random non-locked Board Games from personal list
			SET @OrderCount = (
				SELECT count(L1.ListIndex) FROM BoardOverLists L1
				JOIN BoardOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
				JOIN BoardOverUsers U ON L1.UserIndex = U.UserIndex
				WHERE L1.UserIndex = @intUserIndex
				AND(
					 L1.TargetIndex NOT IN(
						SELECT M.TargetIndex1 FROM BoardOverMemories M
						WHERE L1.TargetIndex = M.TargetIndex1
						AND L2.TargetIndex = M.TargetIndex2
						UNION
						SELECT M.TargetIndex2 FROM BoardOverMemories M
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
			select count(L.ListIndex) from BoardOverLists L where L.UserIndex = @intUserIndex 
			and (
				L.UpLock = 0 or L.DownLock = 0
			)and not (
				L.Rank = 0 and L.UpLock = 0 and L.DownLock = 1 
			) and not (
				L.Rank = (@UserCount-1) and L.UpLock = 1 and L.DownLock = 0
			)
		END
		
		SET @GlobalCount = (
			select count(T.TargetIndex) from BoardGames T
			JOIN BoardOverUsers U ON
			(
				(T.Genre = 'DeckBuilding' 		and U.DeckBuilding = 1) 	or 
				(T.Genre = 'FixedDeck' 			and U.FixedDeck = 1) 		or 
				(T.Genre = 'ConstructedDeck' 	and U.ConstructedDeck = 1) 	or 
				(T.Genre = 'Strategy' 			and U.Strategy = 1) 		or 
				(T.Genre = 'War' 				and U.War = 1) 				or 
				(T.Genre = 'Economy' 			and U.Economy = 1) 			or 
				(T.Genre = 'TableauBuilding' 	and U.TableauBuilding = 1) 	or 
				(T.Genre = 'Coop' 				and U.Coop = 1) 			or 
				(T.Genre = 'Mystery' 			and U.Mystery = 1) 			or 
				(T.Genre = 'SemiCoop' 			and U.SemiCoop = 1) 		or 
				(T.Genre = 'PPRPG' 				and U.PPRPG = 1) 			or 
				(T.Genre = 'Bluffing' 			and U.Bluffing = 1) 		or 
				(T.Genre = 'Puzzle' 			and U.Puzzle = 1) 			or 
				(T.Genre = 'Dexterity' 			and U.Dexterity = 1) 		or 
				(T.Genre = 'Party' 				and U.Party = 1)
			) 
			WHERE U.UserIndex = @intUserIndex
			and T.TargetIndex not in(
				select T2.TargetIndex from BoardGames T2
				JOIN BoardOverLists L2 ON
					T2.TargetIndex = L2.TargetIndex
				JOIN BoardOverUsers U2 ON
					L2.UserIndex = U2.UserIndex
				where U2.UserIndex = @intUserIndex
			)
		);
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are BoardGames left in the global list
			IF( @GlobalCount > 0 )
			BEGIN
				IF( (SELECT TOP 1 U.Memory FROM BoardOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = (
						SELECT top 1 L1.ListIndex FROM BoardOverLists L1
						JOIN BoardOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
						JOIN BoardOverUsers U ON L1.UserIndex = U.UserIndex
						WHERE L1.UserIndex = @intUserIndex
						AND(
							 L1.TargetIndex NOT IN(
								SELECT M.TargetIndex1 FROM BoardOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex1
								AND L2.TargetIndex = M.TargetIndex2
								UNION
								SELECT M.TargetIndex2 FROM BoardOverMemories M
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
					SET @ListIndex = (select top 1 L.ListIndex from BoardOverLists L where L.UserIndex = @intUserIndex and (L.UpLock = 0 or L.DownLock = 0) order by newid());
				END
			END
			ELSE
			BEGIN
				IF( (SELECT TOP 1 U.Memory FROM BoardOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = 
					(
						SELECT top 1 L1.ListIndex FROM BoardOverLists L1
						JOIN BoardOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
						JOIN BoardOverUsers U ON L1.UserIndex = U.UserIndex
						WHERE L1.UserIndex = @intUserIndex
						AND(
							 L1.TargetIndex NOT IN(
								SELECT M.TargetIndex1 FROM BoardOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex1
								AND L2.TargetIndex = M.TargetIndex2
								UNION
								SELECT M.TargetIndex2 FROM BoardOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex2
								AND L2.TargetIndex = M.TargetIndex1
							) OR (
								U.Memory = 0
							)
					)
					--//exclude the first and last BoardGames
					and (L1.Rank != 0 and L1.Rank != @UserCount-1 )
					order by newid()
					);
				END
				ELSE
				BEGIN
					--//request random non-locked Target from personal list
					SET @ListIndex = (select top 1 L.ListIndex from BoardOverLists L
					where L.UserIndex = @intUserIndex and (L.UpLock = 0 or L.DownLock = 0)
					--//exclude the first and last Board Games
					and (L.Rank != 0 and L.Rank != @UserCount-1 ) order by newid());
				END
			END
			
			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are BoardGames left in the global list
			if (
				(
					select count(UserIndex) from BoardOverLists L
					where (L.ListIndex = @ListIndex and L.Rank = 0) 
					or (L.ListIndex = @ListIndex and L.Rank = @UserCount-1) 
				) > 0 
				and @GlobalCount > 0 )
			BEGIN    
				--//request @ListIndex from personal list
				select T.TargetIndex, Name, Release, Genre, Picture from BoardOverLists L
				JOIN BoardGames T ON
					L.TargetIndex = T.TargetIndex
				where L.ListIndex = @ListIndex 
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( 
					select Top 1 T.TargetIndex, Name, Release, Genre, Picture from BoardGames T
					JOIN BoardOverUsers U ON
						(
							(T.Genre = 'DeckBuilding' 		and U.DeckBuilding = 1) 	or 
							(T.Genre = 'FixedDeck' 			and U.FixedDeck = 1) 		or 
							(T.Genre = 'ConstructedDeck' 	and U.ConstructedDeck = 1) 	or 
							(T.Genre = 'Strategy' 			and U.Strategy = 1) 		or 
							(T.Genre = 'War' 				and U.War = 1) 				or 
							(T.Genre = 'Economy' 			and U.Economy = 1) 			or 
							(T.Genre = 'TableauBuilding' 	and U.TableauBuilding = 1) 	or 
							(T.Genre = 'Coop' 				and U.Coop = 1) 			or 
							(T.Genre = 'Mystery' 			and U.Mystery = 1) 			or 
							(T.Genre = 'SemiCoop' 			and U.SemiCoop = 1) 		or 
							(T.Genre = 'PPRPG' 				and U.PPRPG = 1) 			or 
							(T.Genre = 'Bluffing' 			and U.Bluffing = 1) 		or 
							(T.Genre = 'Puzzle' 			and U.Puzzle = 1) 			or 
							(T.Genre = 'Dexterity' 			and U.Dexterity = 1) 		or 
							(T.Genre = 'Party' 				and U.Party = 1)
						) 
					WHERE U.UserIndex = @intUserIndex
					and T.TargetIndex not in(
						select T2.TargetIndex from BoardGames T2
						JOIN BoardOverLists L2 ON
							T2.TargetIndex = L2.TargetIndex
						JOIN BoardOverUsers U2 ON
							L2.UserIndex = U2.UserIndex
						where U2.UserIndex = @intUserIndex
					)
					order by newid() 
				) AS TABLE1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select L.Rank from BoardOverLists L where L.ListIndex = @ListIndex);
				
				IF( (SELECT TOP 1 U.Memory FROM BoardOverUsers U WHERE U.UserIndex = @intUserIndex) = 1 )
				BEGIN
					SET @SecondListIndex = (

						SELECT top 1 L2.ListIndex FROM BoardOverLists L1
						JOIN BoardOverLists L2 ON (L1.Rank = L2.Rank + 1 or L1.Rank = L2.Rank - 1)
						JOIN BoardOverUsers U ON L1.UserIndex = U.UserIndex
						WHERE L1.UserIndex = @intUserIndex
						AND L1.ListIndex = @ListIndex
						AND(
							 L1.TargetIndex NOT IN(
								SELECT M.TargetIndex1 FROM BoardOverMemories M
								WHERE L1.TargetIndex = M.TargetIndex1
								AND L2.TargetIndex = M.TargetIndex2
								UNION
								SELECT M.TargetIndex2 FROM BoardOverMemories M
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
					if( (SELECT L.UpLock FROM BoardOverLists L WHERE L.Rank = @SavedOrder) = 0 )
					BEGIN
						SET @SecondListIndex = (SELECT L.ListIndex FROM BoardOverLists L WHERE L.Rank = @SavedOrder-1);
					END
					else if( (SELECT L.DownLock FROM BoardOverLists L WHERE L.Rank = @SavedOrder) = 0 )
					BEGIN
						SET @SecondListIndex = (SELECT L.ListIndex FROM BoardOverLists L WHERE L.Rank = @SavedOrder+1);
					END
				END
				
				--//request @ListIndex from personal list
				(select T.TargetIndex, Name, Release, Genre, Picture from BoardGames T
				JOIN BoardOverLists L ON
					T.TargetIndex = L.TargetIndex
				where L.ListIndex = @ListIndex 
				UNION
				select T.TargetIndex, Name, Release, Genre, Picture from BoardGames T
				JOIN BoardOverLists L ON
					T.TargetIndex = L.TargetIndex
				where L.ListIndex = @SecondListIndex
				);
			END
		END                    
		--//else (there are no unlocked records)
		ELSE
		BEGIN
			--//there are BoardGames left in the global list
			IF( @GlobalCount > 0 )
			BEGIN
				--//request Order = 0 or Order = count from personal list
				select * from (
					select top 1 T.TargetIndex, Name, Release, Genre, Picture from BoardGames T
					JOIN BoardOverLists L ON
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
					select Top 1 T.TargetIndex, Name, Release, Genre, Picture from BoardGames T
					JOIN BoardOverUsers U ON
					(
						(T.Genre = 'DeckBuilding' 		and U.DeckBuilding = 1) 	or 
						(T.Genre = 'FixedDeck' 			and U.FixedDeck = 1) 		or 
						(T.Genre = 'ConstructedDeck' 	and U.ConstructedDeck = 1) 	or 
						(T.Genre = 'Strategy' 			and U.Strategy = 1) 		or 
						(T.Genre = 'War' 				and U.War = 1) 				or 
						(T.Genre = 'Economy' 			and U.Economy = 1) 			or 
						(T.Genre = 'TableauBuilding' 	and U.TableauBuilding = 1) 	or 
						(T.Genre = 'Coop' 				and U.Coop = 1) 			or 
						(T.Genre = 'Mystery' 			and U.Mystery = 1) 			or 
						(T.Genre = 'SemiCoop' 			and U.SemiCoop = 1) 		or 
						(T.Genre = 'PPRPG' 				and U.PPRPG = 1) 			or 
						(T.Genre = 'Bluffing' 			and U.Bluffing = 1) 		or 
						(T.Genre = 'Puzzle' 			and U.Puzzle = 1) 			or 
						(T.Genre = 'Dexterity' 			and U.Dexterity = 1) 		or 
						(T.Genre = 'Party' 				and U.Party = 1)
					) 
					WHERE U.UserIndex = @intUserIndex
					and T.TargetIndex not in(
						select T2.TargetIndex from BoardGames T2
						JOIN BoardOverLists L2 ON
							T2.TargetIndex = L2.TargetIndex
						JOIN Users U2 ON 
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
				select top 2 T.TargetIndex, Name, Release, Genre, Picture from BoardGames T
				JOIN BoardOverLists L ON
					T.TargetIndex = L.TargetIndex
				where UserIndex = @intUserIndex
				and ( (L.Rank = 0) or (L.Rank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random BoardGames from global list
		select top 2 T.TargetIndex, Name, Picture, Release, Genre from BoardGames T
		JOIN BoardOverUsers U ON
		(
			(T.Genre = 'DeckBuilding' 		and U.DeckBuilding = 1) 	or 
			(T.Genre = 'FixedDeck' 			and U.FixedDeck = 1) 		or 
			(T.Genre = 'ConstructedDeck' 	and U.ConstructedDeck = 1) 	or 
			(T.Genre = 'Strategy' 			and U.Strategy = 1) 		or 
			(T.Genre = 'War' 				and U.War = 1) 				or 
			(T.Genre = 'Economy' 			and U.Economy = 1) 			or 
			(T.Genre = 'TableauBuilding' 	and U.TableauBuilding = 1) 	or 
			(T.Genre = 'Coop' 				and U.Coop = 1) 			or 
			(T.Genre = 'Mystery' 			and U.Mystery = 1) 			or 
			(T.Genre = 'SemiCoop' 			and U.SemiCoop = 1) 		or 
			(T.Genre = 'PPRPG' 				and U.PPRPG = 1) 			or 
			(T.Genre = 'Bluffing' 			and U.Bluffing = 1) 		or 
			(T.Genre = 'Puzzle' 			and U.Puzzle = 1) 			or 
			(T.Genre = 'Dexterity' 			and U.Dexterity = 1) 		or 
			(T.Genre = 'Party' 				and U.Party = 1)
		)
		where U.UserIndex = @intUserIndex order by newid();
	END
END