--drop PROCEDURE BoardOverPullTargetPair;

create PROCEDURE BoardOverPullTargetPair
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
	SET @UserCount = (select count(BoardOverUserIndex) from BoardOverLists where BoardOverUserIndex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked BoardGames from personal list
			--//adjust OrderCount to exclude (1's uplock and count's downlock only available)
		SET @OrderCount = (
		select count(ListIndex) from BoardOverLists where BoardOverUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
		and not ( OrderRank = 0 and UpLock = 0 and DownLock = 1 ) and not (OrderRank = (@UserCount-1) and UpLock = 1 and DownLock = 0)
		);
		SET @GlobalExclusionCount = (
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
			IF( @GlobalExclusionCount > 0 )
			BEGIN
				--//request random non-locked Target from personal list
				SET @TargetIndex = (select top 1 ListIndex from BoardOverLists where BoardOverUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0) order by newid());
			END
			ELSE
			BEGIN
				--//request random non-locked Target from personal list
					--//exclude the first and last BoardGames
				SET @TargetIndex = (select top 1 ListIndex from BoardOverLists 
				where BoardOverUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
				and (OrderRank != 0 and OrderRank != @UserCount-1 ) order by newid());
			END
			
			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are BoardGames left in the global list
			if ( (select count(BoardOverUserIndex) from BoardOverLists 
			where (ListIndex = @TargetIndex and OrderRank = 0) or (ListIndex = @TargetIndex and OrderRank = @UserCount-1) ) > 0 
			and @GlobalExclusionCount > 0 )
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
				--//request @TargetIndex from personal list
				select BoardGames.TargetIndex, Name, Release, Genre, Picture from BoardGames
				JOIN BoardOverLists ON
					BoardGames.TargetIndex = BoardOverLists.BoardGameIndex
				where BoardOverLists.ListIndex = @TargetIndex
				UNION
				--//request adjacent non-locked Target from personal list
				select * from (
					select top 1 BoardGames.TargetIndex, Name, Release, Genre, Picture from BoardGames
					JOIN BoardOverLists ON
						BoardGames.TargetIndex = BoardOverLists.BoardGameIndex
					where BoardOverUserIndex = @intUserIndex 
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
			--//there are BoardGames left in the global list
			IF( @GlobalExclusionCount > 0 )
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