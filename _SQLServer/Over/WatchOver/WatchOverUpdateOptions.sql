--drop procedure WatchOverUpdateOptions;

create PROCEDURE WatchOverUpdateOptions(
    @intUserIndex		int,
	@bitMemory			bit,
	--Genres
    @bitComedy			bit,
	@bitDrama			bit,
	@bitAction			bit,
	@bitHorror			bit,
	@bitThriller		bit,
	@bitMystery			bit,
	@bitDocumentary		bit,
	--Settings
	@bitScienceFiction bit,
	@bitFantasy			bit,
	@bitWestern			bit,
	@bitMartialArts		bit,
	@bitModern			bit,
	@bitHistoric		bit,
	@bitPrehistoric		bit,
	@bitComics			bit,
	@bitPeriod			bit
)
AS
BEGIN
	--//Update preferences to match check boxes (local variables)
	update WatchOverUsers set 
	Memory				= @bitMemory, 
	--Genres
    Comedy				= @bitComedy, 
	Drama				= @bitDrama, 
	Action				= @bitAction, 
	Horror				= @bitHorror, 
	Thriller			= @bitThriller, 
	Mystery				= @bitMystery, 
	Documentary			= @bitDocumentary, 
	--Settings
	ScienceFiction		= @bitScienceFiction, 
	Fantasy				= @bitFantasy, 
	Western				= @bitWestern, 
	MartialArts			= @bitMartialArts, 
	Modern				= @bitModern, 
	Historic			= @bitHistoric, 
	PreHistoric			= @bitPreHistoric, 
	Comics				= @bitComics, 
	Period				= @bitPeriod

	where UserIndex = @intUserIndex;

	--//Adjust Personal list to match new preferences
	delete from WatchOverLists 
	where UserIndex = @intUserIndex and TargetIndex 
	IN (
		select T.TargetIndex from Movies T
		JOIN WatchOverUsers U ON 
			(
				(
					( T.Genre = 'Comedy'				and U.Comedy = 0 )			or 
					( T.Genre = 'Drama'					and U.Drama = 0 )			or 
					( T.Genre = 'Action'				and U.Action = 0 )			or 
					( T.Genre = 'Horror'				and U.Horror = 0 )			or
					( T.Genre = 'Thriller'				and U.Thriller = 0 )		or
					( T.Genre = 'Mystery'				and U.Mystery = 0 )		or
					( T.Genre = 'Documentary'			and U.Documentary = 0 )
				) 
				and
				(
					( T.Setting = 'ScienceFiction'		and U.ScienceFiction = 0 )	or
					( T.Setting = 'Fantasy'				and U.Fantasy = 0 )		or
					( T.Setting = 'Western'				and U.Western = 0 )		or
					( T.Setting = 'MartialArts'			and U.MartialArts = 0 )	or
					( T.Setting = 'Modern'				and U.Modern = 0 )			or
					( T.Setting = 'Historic'			and U.Historic = 0 )		or
					( T.Setting = 'Prehistoric'			and U.Prehistoric = 0 )	or
					( T.Setting = 'Comics'				and U.Comics = 0 )			or
					( T.Setting = 'Period'				and U.Period = 0 )
				)
			)
		where U.UserIndex = @intUserIndex
	);

	select *, ROW_NUMBER() Over(order by L.Rank) as RowNum INTO #NumOne from WatchOverLists L where L.UserIndex = @intUserIndex; 
	select *, ROW_NUMBER() Over(order by L.Rank) as RowNum INTO #NumTwo from WatchOverLists L where L.UserIndex = @intUserIndex; 
	
	--//Unlock records adacent to removed records
		--//Unlock L.DownLock for L.Rank+1 < 1
		Update WatchOverLists set DownLock = 0 where 
		ListIndex IN(
			select #NumOne.ListIndex from #NumOne, #NumTwo where 
			#NumOne.RowNum + 1 = #NumTwo.RowNum and 
			#NumTwo.Rank - #NumOne.Rank > 1
		);
		
		--//Unlock L.UpLock for L.Rank-1 < 1
		Update WatchOverLists set UpLock = 0 where 
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
		FROM WatchOverLists where UserIndex = @intUserIndex
	)
	UPDATE cte SET Rank = RowNum-1
END

