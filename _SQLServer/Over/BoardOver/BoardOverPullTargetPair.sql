--drop PROCEDURE BoardOverPullTargetPair;

create PROCEDURE BoardOverPullTargetPair(
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
	SET @UserCount = (select count(BoardOverUserIndex) from BoardOverLists where BoardOverUserIndex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked celebrities from personal list
		SET @OrderCount = (
			SELECT count(L1.ListIndex) FROM BoardOverLists L1
			JOIN BoardOverLists L2 ON (L1.OrderRank = L2.OrderRank + 1 or L1.OrderRank = L2.OrderRank - 1)
			JOIN BoardOverUsers U ON L1.BoardOverUserIndex = U.BoardOverUserIndex
			WHERE L1.BoardOverUserIndex = @intUserIndex
			AND(
				 L1.BoardGameIndex NOT IN(
					SELECT M.BoardGameIndex1 FROM BoardOverMemories M
					WHERE L1.BoardGameIndex = M.BoardGameIndex1
					AND L2.BoardGameIndex = M.BoardGameIndex2
					UNION
					SELECT M.BoardGameIndex2 FROM BoardOverMemories M
					WHERE L1.BoardGameIndex = M.BoardGameIndex2
					AND L2.BoardGameIndex = M.BoardGameIndex1
				) OR (
					U.BoardOverMemory = 0
				)				
			)
		);

		SET @GlobalCount = (
			select count(BoardGames.TargetIndex) from BoardGames
			JOIN BoardOverUsers ON
			(
				(Genre = 'DeckBuilding' 	and DeckBuilding = 1) 		or 
				(Genre = 'FixedDeck' 		and FixedDeck = 1) 			or 
				(Genre = 'ConstructedDeck' 	and ConstructedDeck = 1) 	or 
				(Genre = 'Strategy' 		and Strategy = 1) 			or 
				(Genre = 'War' 				and War = 1) 				or 
				(Genre = 'Economy' 			and Economy = 1) 			or 
				(Genre = 'TableauBuilding' 	and TableauBuilding = 1) 	or 
				(Genre = 'Coop' 			and Coop = 1) 				or 
				(Genre = 'Mystery' 			and Mystery = 1) 			or 
				(Genre = 'SemiCoop' 		and SemiCoop = 1) 			or 
				(Genre = 'PPRPG' 			and PPRPG = 1) 				or 
				(Genre = 'Bluffing' 		and Bluffing = 1) 			or 
				(Genre = 'Puzzle' 			and Puzzle = 1) 			or 
				(Genre = 'Dexterity' 		and Dexterity = 1) 			or 
				(Genre = 'Party' 			and Party = 1)
			) 
			WHERE BoardOverUsers.BoardOverUserIndex = @intUserIndex
			and BoardGames.TargetIndex not in(
				select BoardGames.TargetIndex from BoardGames
				JOIN BoardOverLists ON
					BoardGames.TargetIndex = BoardOverLists.BoardGameIndex
				JOIN BoardOverUsers ON
					BoardOverLists.BoardOverUserIndex = BoardOverUsers.BoardOverUserIndex
				where BoardOverUsers.BoardOverUserIndex = @intUserIndex
			)
		);
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are BoardGames left in the global list
			IF( @GlobalCount > 0 )
			BEGIN
				--//request random non-locked Target from personal list
				SET @TargetIndex = (
					SELECT top 1 L1.ListIndex FROM BoardOverLists L1
					JOIN BoardOverLists L2 ON (L1.OrderRank = L2.OrderRank + 1 or L1.OrderRank = L2.OrderRank - 1)
					JOIN BoardOverUsers U ON L1.BoardOverUserIndex = U.BoardOverUserIndex
					WHERE L1.BoardOverUserIndex = @intUserIndex
					AND(
						 L1.BoardGameIndex NOT IN(
							SELECT M.BoardGameIndex1 FROM BoardOverMemories M
							WHERE L1.BoardGameIndex = M.BoardGameIndex1
							AND L2.BoardGameIndex = M.BoardGameIndex2
							UNION
							SELECT M.BoardGameIndex2 FROM BoardOverMemories M
							WHERE L1.BoardGameIndex = M.BoardGameIndex2
							AND L2.BoardGameIndex = M.BoardGameIndex1
						) OR (
							U.BoardOverMemory = 0
						)				
					)
					order by newid()
				);
			END
			ELSE
			BEGIN
				--//request random non-locked Target from personal list
				SET @TargetIndex = 
				(
					SELECT top 1 L1.ListIndex FROM BoardOverLists L1
					JOIN BoardOverLists L2 ON (L1.OrderRank = L2.OrderRank + 1 or L1.OrderRank = L2.OrderRank - 1)
					JOIN BoardOverUsers U ON L1.BoardOverUserIndex = U.BoardOverUserIndex
					WHERE L1.BoardOverUserIndex = @intUserIndex
					AND(
						 L1.BoardGameIndex NOT IN(
							SELECT M.BoardGameIndex1 FROM BoardOverMemories M
							WHERE L1.BoardGameIndex = M.BoardGameIndex1
							AND L2.BoardGameIndex = M.BoardGameIndex2
							UNION
							SELECT M.BoardGameIndex2 FROM BoardOverMemories M
							WHERE L1.BoardGameIndex = M.BoardGameIndex2
							AND L2.BoardGameIndex = M.BoardGameIndex1
						) OR (
							U.BoardOverMemory = 0
						)
				)
				--//exclude the first and last BoardGames
				and (L1.OrderRank != 0 and L1.OrderRank != @UserCount-1 )
				order by newid()
				);
			END
			
			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are BoardGames left in the global list
			if ( (select count(BoardOverUserIndex) from BoardOverLists 
			where (ListIndex = @TargetIndex and OrderRank = 0) or (ListIndex = @TargetIndex and OrderRank = @UserCount-1) ) > 0 
			and @GlobalCount > 0 )
			BEGIN    
				--//request @TargetIndex from personal list
				select BoardGames.TargetIndex, Name, Release, Genre, Picture from BoardOverLists
				JOIN BoardGames ON
					BoardOverLists.BoardGameIndex = BoardGames.TargetIndex
				where BoardOverLists.ListIndex = @TargetIndex 
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( 
					select Top 1 BoardGames.TargetIndex, Name, Release, Genre, Picture from BoardGames
					JOIN BoardOverUsers ON
						(
							(Genre = 'DeckBuilding' 	and DeckBuilding = 1) 		or 
							(Genre = 'FixedDeck' 		and FixedDeck = 1) 			or 
							(Genre = 'ConstructedDeck' 	and ConstructedDeck = 1) 	or 
							(Genre = 'Strategy' 		and Strategy = 1) 			or 
							(Genre = 'War' 				and War = 1) 				or 
							(Genre = 'Economy' 			and Economy = 1) 			or 
							(Genre = 'TableauBuilding' 	and TableauBuilding = 1) 	or 
							(Genre = 'Coop' 			and Coop = 1) 				or 
							(Genre = 'Mystery' 			and Mystery = 1) 			or 
							(Genre = 'SemiCoop' 		and SemiCoop = 1) 			or 
							(Genre = 'PPRPG' 			and PPRPG = 1) 				or 
							(Genre = 'Bluffing' 		and Bluffing = 1) 			or 
							(Genre = 'Puzzle' 			and Puzzle = 1) 			or 
							(Genre = 'Dexterity' 		and Dexterity = 1) 			or 
							(Genre = 'Party' 			and Party = 1)
						) 
					WHERE BoardOverUsers.BoardOverUserIndex = @intUserIndex
					and BoardGames.TargetIndex not in(
						select BoardGames.TargetIndex from BoardGames 
						JOIN BoardOverLists ON
							BoardGames.TargetIndex = BoardOverLists.BoardGameIndex
						JOIN BoardOverUsers ON
							BoardOverLists.BoardOverUserIndex = BoardOverUsers.BoardOverUserIndex
						where BoardOverUsers.BoardOverUserIndex = @intUserIndex
					)
					order by newid() 
				) T1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select OrderRank from BoardOverLists where ListIndex = @TargetIndex);
				
				SET @SecondTargetIndex = (

					SELECT top 1 L2.ListIndex FROM BoardOverLists L1
					JOIN BoardOverLists L2 ON (L1.OrderRank = L2.OrderRank + 1 or L1.OrderRank = L2.OrderRank - 1)
					JOIN BoardOverUsers U ON L1.BoardOverUserIndex = U.BoardOverUserIndex
					WHERE L1.BoardOverUserIndex = @intUserIndex
					AND L1.ListIndex = @TargetIndex
					AND(
						 L1.BoardGameIndex NOT IN(
							SELECT M.BoardGameIndex1 FROM BoardOverMemories M
							WHERE L1.BoardGameIndex = M.BoardGameIndex1
							AND L2.BoardGameIndex = M.BoardGameIndex2
							UNION
							SELECT M.BoardGameIndex2 FROM BoardOverMemories M
							WHERE L1.BoardGameIndex = M.BoardGameIndex2
							AND L2.BoardGameIndex = M.BoardGameIndex1
						) OR (
							U.BoardOverMemory = 0
						)				
					)
					order by newid()
				);

				--//request @TargetIndex from personal list
				(select BoardGames.TargetIndex, Name, Release, Genre, Picture from BoardGames
				JOIN BoardOverLists ON
					BoardGames.TargetIndex = BoardOverLists.BoardGameIndex
				where BoardOverLists.ListIndex = @TargetIndex 
				UNION
				select BoardGames.TargetIndex, Name, Release, Genre, Picture from BoardGames
				JOIN BoardOverLists ON
					BoardGames.TargetIndex = BoardOverLists.BoardGameIndex
				where BoardOverLists.ListIndex = @SecondTargetIndex
				); --T2
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
					select top 1 BoardGames.TargetIndex, Name, Release, Genre, Picture from BoardGames
					JOIN BoardOverLists ON
						BoardGames.TargetIndex = BoardOverLists.BoardGameIndex
					where BoardOverUserIndex = @intUserIndex 
					and 
						( OrderRank = 0 or OrderRank = @UserCount-1 )
					order by newid() 
				) T3
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from (
					select Top 1 BoardGames.TargetIndex, Name, Release, Genre, Picture from BoardGames
					JOIN BoardOverUsers ON
					(
						(Genre = 'DeckBuilding' 	and DeckBuilding = 1) 		or 
						(Genre = 'FixedDeck' 		and FixedDeck = 1) 			or 
						(Genre = 'ConstructedDeck' 	and ConstructedDeck = 1) 	or 
						(Genre = 'Strategy' 		and Strategy = 1) 			or 
						(Genre = 'War' 				and War = 1) 				or 
						(Genre = 'Economy' 			and Economy = 1) 			or 
						(Genre = 'TableauBuilding' 	and TableauBuilding = 1) 	or 
						(Genre = 'Coop' 			and Coop = 1) 				or 
						(Genre = 'Mystery' 			and Mystery = 1) 			or 
						(Genre = 'SemiCoop' 		and SemiCoop = 1) 			or 
						(Genre = 'PPRPG' 			and PPRPG = 1) 				or 
						(Genre = 'Bluffing' 		and Bluffing = 1) 			or 
						(Genre = 'Puzzle' 			and Puzzle = 1) 			or 
						(Genre = 'Dexterity' 		and Dexterity = 1) 			or 
						(Genre = 'Party' 			and Party = 1)
					) 
					WHERE BoardOverUsers.BoardOverUserIndex = @intUserIndex
					and BoardGames.TargetIndex not in(
						select BoardGames.TargetIndex from BoardGames
						JOIN BoardOverLists ON
							BoardGames.TargetIndex = BoardOverLists.BoardGameIndex
						JOIN Users ON 
							BoardOverLists.BoardOverUserIndex = BoardOverUsers.BoardOverUserIndex
						where BoardOverUsers.BoardOverUserIndex = @intUserIndex
					) order by newid() 
				) T4;
			END
			ELSE
			--//there are no selections left in the global list
				--//there are no unlocked records
			BEGIN
				--//return the top two records from personal list
				select top 2 BoardGames.TargetIndex, Name, Release, Genre, Picture from BoardGames
				JOIN BoardOverLists ON
					BoardGames.TargetIndex = BoardOverLists.BoardGameIndex
				where BoardOverUserIndex = @intUserIndex
				and ( (OrderRank = 0) or (OrderRank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random BoardGames from global list
		select top 2 BoardGames.TargetIndex, Name, Picture, Release, Genre from BoardGames
		JOIN BoardOverUsers ON
		(
			(Genre = 'DeckBuilding' 		and DeckBuilding = 1) 		or 
			(Genre = 'FixedDeck' 			and FixedDeck = 1) 			or 
			(Genre = 'ConstructedDeck' 		and ConstructedDeck = 1) 	or 
			(Genre = 'Strategy' 			and Strategy = 1) 			or 
			(Genre = 'War' 					and War = 1) 				or 
			(Genre = 'Economy' 				and Economy = 1) 			or 
			(Genre = 'TableauBuilding' 		and TableauBuilding = 1) 	or 
			(Genre = 'Coop' 				and Coop = 1) 				or 
			(Genre = 'Mystery' 				and Mystery = 1) 			or 
			(Genre = 'SemiCoop' 			and SemiCoop = 1) 			or 
			(Genre = 'PPRPG' 				and PPRPG = 1) 				or 
			(Genre = 'Bluffing' 			and Bluffing = 1) 			or 
			(Genre = 'Puzzle' 				and Puzzle = 1) 			or 
			(Genre = 'Dexterity' 			and Dexterity = 1) 			or 
			(Genre = 'Party' 				and Party = 1)
		)
		where BoardOverUsers.BoardOverUserIndex = @intUserIndex order by newid();
	END
END