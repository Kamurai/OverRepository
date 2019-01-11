--drop procedure BoardOverUpdateOptions;

create PROCEDURE BoardOverUpdateOptions
(
    @intUserIndex int,
    @bitDeckBuilding bit,
	@bitFixedDeck bit,
	@bitConstructedDeck bit,
	@bitStrategy bit,
	@bitWar bit,
	@bitEconomy bit,
	@bitTableauBuilding bit,
	@bitCoop bit,
	@bitMystery bit,
	@bitSemiCoop bit,
	@bitPPRPG bit,
	@bitBluffing bit,
	@bitPuzzle bit,
	@bitDexterity bit,
	@bitParty bit

)
AS
BEGIN
	--//Update preferences to match check boxes (local variables)
	update BoardOverUsers set 
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
	where BoardOverUsers.MasterUserIndex = @intUserIndex;

	--select * from Users where UserIndex = @intUserIndex;

	
	--//Adjust Personal list to match new preferences
	delete from BoardOverLists where MasterUserIndex = @intUserIndex and BoardGameIndex IN (
	select BoardGames.TargetIndex from BoardGames JOIN BoardOverUsers 
		ON (
			( Genre = 'DeckBuilding'	and BoardOverUsers.DeckBuilding		= 0 )	or 
			( Genre = 'FixedDeck'		and BoardOverUsers.FixedDeck		= 0 )	or 
			( Genre = 'ConstructedDeck' and BoardOverUsers.ConstructedDeck	= 0 )	or 
			( Genre = 'Strategy'		and BoardOverUsers.Strategy			= 0 )	or
			( Genre = 'War'				and BoardOverUsers.War				= 0 )	or
			( Genre = 'Economy'			and BoardOverUsers.Economy			= 0 )	or
			( Genre = 'TableauBuilding' and BoardOverUsers.TableauBuilding	= 0 )	or
			( Genre = 'Coop'			and BoardOverUsers.Coop				= 0 )	or
			( Genre = 'Mystery'			and BoardOverUsers.Mystery			= 0 )	or
			( Genre = 'SemiCoop'		and BoardOverUsers.SemiCoop			= 0 )	or
			( Genre = 'PPRPG'			and BoardOverUsers.PPRPG			= 0 )	or
			( Genre = 'Bluffing'		and BoardOverUsers.Bluffing			= 0 )	or
			( Genre = 'Puzzle'			and BoardOverUsers.Puzzle			= 0 )	or
			( Genre = 'Dexterity'		and BoardOverUsers.Dexterity		= 0 )	or
			( Genre = 'Party'			and BoardOverUsers.Party			= 0 ) 
		) 
		where BoardOverUsers.MasterUserIndex = @intUserIndex
	);

	--select * from Celebrities, BoardOverLists where Celebrities.TargetIndex = BoardOverLists.CelebrityIndex and BoardOverLists.MasterUserIndex = 0 order by OrderRank;


	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumOne from BoardOverLists where MasterUserIndex = 0; 
	--select * from #NumOne;

	select *, ROW_NUMBER() Over(order by OrderRank) as RowNum INTO #NumTwo from BoardOverLists where MasterUserIndex = 0; 
	--select * from #NumTwo;

	--//Unlock records adacent to removed records
		--//Unlock DownLock for OrderRank+1 < 1
		Update BoardOverLists set Downlock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum + 1 = #NumTwo.RowNum and 
			#NumTwo.OrderRank - #NumOne.OrderRank > 1
		);
		
		--//Unlock UpLock for OrderRank-1 < 1
		Update BoardOverLists set Uplock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum - 1 = #NumTwo.RowNum and 
			#NumOne.OrderRank - #NumTwo.OrderRank > 1
		);

	drop table #NumOne;
	drop table #NumTwo;

	--select * from Celebrities, BoardOverLists where Celebrities.TargetIndex = BoardOverLists.CelebrityIndex and BoardOverLists.MasterUserIndex = 0 order by OrderRank;

	--//Reorder rankings
	With cte As
	(
		SELECT *,
		ROW_NUMBER() OVER (ORDER BY OrderRank) AS RowNum
		FROM BoardOverLists where MasterUserIndex = @intUserIndex
	)
	UPDATE cte SET OrderRank=RowNum-1


END

