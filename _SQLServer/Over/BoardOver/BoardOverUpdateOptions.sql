--drop procedure BoardOverUpdateOptions;

create PROCEDURE BoardOverUpdateOptions(
    @intUserIndex		int,
    @bitMemory			bit,
	--Types
	@bitDeckBuilding	bit,
	@bitFixedDeck		bit,
	@bitConstructedDeck bit,
	@bitStrategy		bit,
	@bitWar				bit,
	@bitEconomy			bit,
	@bitTableauBuilding bit,
	@bitCoop			bit,
	@bitMystery			bit,
	@bitSemiCoop		bit,
	@bitPPRPG			bit,
	@bitBluffing		bit,
	@bitPuzzle			bit,
	@bitDexterity		bit,
	@bitParty			bit

)
AS
BEGIN
	--//Update preferences to match check boxes (local variables)
	update BoardOverUsers set 
		Memory				= @bitMemory, 
		--Types
		DeckBuilding		= @bitDeckBuilding, 
		FixedDeck			= @bitFixedDeck, 
		ConstructedDeck		= @bitConstructedDeck, 
		Strategy			= @bitStrategy, 
		War					= @bitWar, 
		Economy				= @bitEconomy, 
		TableauBuilding		= @bitTableauBuilding, 
		Coop				= @bitCoop, 
		Mystery				= @bitMystery, 
		SemiCoop			= @bitSemiCoop, 
		PPRPG				= @bitPPRPG, 
		Bluffing			= @bitBluffing, 
		Puzzle				= @bitPuzzle, 
		Dexterity			= @bitDexterity, 
		Party				= @bitParty 	
	where UserIndex = @intUserIndex;

	--//Adjust Personal list to match new preferences
	delete from BoardOverLists 
	where UserIndex = @intUserIndex and TargetIndex IN (
		select T.TargetIndex 
		from BoardGames T JOIN BoardOverUsers U
			ON (
				( T.Genre = 'DeckBuilding'		and U.DeckBuilding		= 0 )	or 
				( T.Genre = 'FixedDeck'			and U.FixedDeck			= 0 )	or 
				( T.Genre = 'ConstructedDeck'	and U.ConstructedDeck	= 0 )	or 
				( T.Genre = 'Strategy'			and U.Strategy			= 0 )	or
				( T.Genre = 'War'				and U.War				= 0 )	or
				( T.Genre = 'Economy'			and U.Economy			= 0 )	or
				( T.Genre = 'TableauBuilding'	and U.TableauBuilding	= 0 )	or
				( T.Genre = 'Coop'				and U.Coop				= 0 )	or
				( T.Genre = 'Mystery'			and U.Mystery			= 0 )	or
				( T.Genre = 'SemiCoop'			and U.SemiCoop			= 0 )	or
				( T.Genre = 'PPRPG'				and U.PPRPG				= 0 )	or
				( T.Genre = 'Bluffing'			and U.Bluffing			= 0 )	or
				( T.Genre = 'Puzzle'			and U.Puzzle			= 0 )	or
				( T.Genre = 'Dexterity'			and U.Dexterity			= 0 )	or
				( T.Genre = 'Party'				and U.Party				= 0 ) 
			) 
			where U.UserIndex = @intUserIndex
	);

	select *, ROW_NUMBER() Over(order by L.Rank) as RowNum INTO #NumOne from BoardOverLists L where L.UserIndex = @intUserIndex; 
	select *, ROW_NUMBER() Over(order by L.Rank) as RowNum INTO #NumTwo from BoardOverLists L where L.UserIndex = @intUserIndex; 
	
	--//Unlock records adacent to removed records
		--//Unlock L.DownLock for L.Rank+1 < 1
		Update BoardOverLists set DownLock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum + 1 = #NumTwo.RowNum and 
			#NumTwo.Rank - #NumOne.Rank > 1
		);
		
		--//Unlock L.UpLock for L.Rank-1 < 1
		Update BoardOverLists set UpLock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum - 1 = #NumTwo.RowNum and 
			#NumOne.Rank - #NumTwo.Rank > 1
		);

	drop table #NumOne;
	drop table #NumTwo;

	--//Reorder L.Rankings
	With cte As
	(
		SELECT *,
		ROW_NUMBER() OVER (ORDER BY Rank) AS RowNum
		FROM BoardOverLists where UserIndex = @intUserIndex
	)
	UPDATE cte SET Rank=RowNum-1


END

