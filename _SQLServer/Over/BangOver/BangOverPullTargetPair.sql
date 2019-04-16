--drop PROCEDURE BangOverPullTargetPair;

create PROCEDURE BangOverPullTargetPair
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
	SET @UserCount = (select count(BangOverUserIndex) from BangOverLists where BangOverUserIndex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked celebrities from personal list
			--//adjust OrderCount to exclude (1's uplock and count's downlock only available)
		SET @OrderCount = (
		select count(ListIndex) from BangOverLists where BangOverUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
		and not ( OrderRank = 0 and UpLock = 0 and DownLock = 1 ) and not (OrderRank = (@UserCount-1) and UpLock = 1 and DownLock = 0)
		);
		SET @GlobalExclusionCount = (
			select count(Celebrities.TargetIndex) from Celebrities
			JOIN BangOverUsers ON
			(
				(Celebrities.Sex = 'F' and BangOverUsers.Women = 1) 		or 
				(Celebrities.Sex = 'M' and BangOverUsers.Men = 1) 			or 
				(Celebrities.Sex = 'W' and BangOverUsers.TransWomen = 1) 	or 
				(Celebrities.Sex = 'T' and BangOverUsers.TransMen = 1)
			) 
			WHERE BangOverUsers.BangOverUserIndex = @intUserIndex
			and Celebrities.TargetIndex not in(
				select Celebrities.TargetIndex from Celebrities 
				JOIN BangOverLists ON
					Celebrities.TargetIndex = BangOverLists.CelebrityIndex
				JOIN BangOverUsers ON
					BangOverLists.BangOverUserIndex = BangOverUsers.BangOverUserIndex
				where BangOverUsers.BangOverUserIndex = @intUserIndex 
			)
		);
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are celebrities left in the global list
			IF( @GlobalExclusionCount > 0 )
			BEGIN
				--//request random non-locked Target from personal list
				SET @TargetIndex = (select top 1 ListIndex from BangOverLists where BangOverUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0) order by newid());
			END
			ELSE
			BEGIN
				--//request random non-locked Target from personal list
					--//exclude the first and last celebrities
				SET @TargetIndex = (select top 1 ListIndex from BangOverLists 
				where BangOverUserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
				and (OrderRank != 0 and OrderRank != @UserCount-1 ) order by newid());
			END
			
			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are celebrities left in the global list
			if ( (select count(BangOverUserIndex) from BangOverLists 
			where (ListIndex = @TargetIndex and OrderRank = 0) or (ListIndex = @TargetIndex and OrderRank = @UserCount-1) ) > 0 
			and @GlobalExclusionCount > 0 )
			BEGIN    
				--//request @TargetIndex from personal list
				select Celebrities.TargetIndex, Name, Sex, Picture from BangOverLists 
				JOIN Celebrities ON
					BangOverLists.CelebrityIndex = Celebrities.TargetIndex
				where BangOverLists.ListIndex = @TargetIndex
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from (
					select Top 1 Celebrities.TargetIndex, Name, Sex, Picture from Celebrities
					JOIN BangOverUsers ON
						(
							(Celebrities.Sex = 'F' and BangOverUsers.Women = 1) 		or
							(Celebrities.Sex = 'M' and BangOverUsers.Men = 1) 			or 
							(Celebrities.Sex = 'W' and BangOverUsers.TransWomen = 1) 	or 
							(Celebrities.Sex = 'T' and BangOverUsers.TransMen = 1)
						) 
					WHERE BangOverUsers.BangOverUserIndex = @intUserIndex
					and Celebrities.TargetIndex not in(
						select Celebrities.TargetIndex from Celebrities
						JOIN BangOverLists ON
							Celebrities.TargetIndex = BangOverLists.CelebrityIndex
						JOIN BangOverUsers ON
							BangOverUsers.BangOverUserIndex = BangOverLists.BangOverUserIndex
						where BangOverUsers.BangOverUserIndex = @intUserIndex 
					) 
					order by newid() 
				) T1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select OrderRank from BangOverLists where ListIndex = @TargetIndex);
				--//request @TargetIndex from personal list
				select Celebrities.TargetIndex, Name, Sex, Picture from Celebrities
				JOIN BangOverLists ON
					Celebrities.TargetIndex = BangOverLists.CelebrityIndex
				where BangOverLists.ListIndex = @TargetIndex 
				UNION
				--//request adjacent non-locked Target from personal list
				select * from (
					select top 1 Celebrities.TargetIndex, Name, Sex, Picture from Celebrities
					JOIN BangOverLists ON 
						Celebrities.TargetIndex = BangOverLists.CelebrityIndex
					where BangOverUserIndex = @intUserIndex 
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
			--//there are celebrities left in the global list
			IF( @GlobalExclusionCount > 0 )
			BEGIN
				--//request Order = 0 or Order = count from personal list
				select * from (
					select top 1 Celebrities.TargetIndex, Name, Sex, Picture from Celebrities 
					JOIN BangOverLists ON 
						Celebrities.TargetIndex = BangOverLists.CelebrityIndex
					where BangOverUserIndex = @intUserIndex 
					and
						( OrderRank = 0 or OrderRank = @UserCount-1 )
					order by newid() 
				) T3
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( 
					select Top 1 Celebrities.TargetIndex, Name, Sex, Picture from Celebrities
					JOIN BangOverUsers ON
					(
						(Celebrities.Sex = 'F' and BangOverUsers.Women = 1) 		or 
						(Celebrities.Sex = 'M' and BangOverUsers.Men = 1) 			or 
						(Celebrities.Sex = 'W' and BangOverUsers.TransWomen = 1) 	or 
						(Celebrities.Sex = 'T' and BangOverUsers.TransMen = 1)
					) 
					WHERE BangOverUsers.BangOverUserIndex = @intUserIndex
					and Celebrities.TargetIndex not in(
						select Celebrities.TargetIndex from Celebrities
						JOIN BangOverLists ON
							Celebrities.TargetIndex = BangOverLists.CelebrityIndex
						JOIN BangOverUsers ON
							BangOverLists.BangOverUserIndex = BangOverUsers.BangOverUserIndex
						where BangOverUsers.BangOverUserIndex = @intUserIndex 
					) order by newid() 
				) T4;
			END
			ELSE
			--//there are no selections left in the global list
				--//there are no unlocked records
			BEGIN
				--//return the top two records from personal list
				select top 2 Celebrities.TargetIndex, Name, Sex, Picture from Celebrities 
				JOIN BangOverLists ON
					Celebrities.TargetIndex = BangOverLists.CelebrityIndex
				where BangOverUserIndex = @intUserIndex
				and ( (OrderRank = 0) or (OrderRank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random celebrities from global list
		select top 2 Celebrities.TargetIndex, Name, Picture, Sex from Celebrities
		JOIN BangOverUsers ON
		(
			(Celebrities.Sex = 'F' and BangOverUsers.Women = 1) 		or 
			(Celebrities.Sex = 'M' and BangOverUsers.Men = 1) 			or 
			(Celebrities.Sex = 'W' and BangOverUsers.TransWomen = 1) 	or 
			(Celebrities.Sex = 'T' and BangOverUsers.TransMen = 1)
		)
		where BangOverUsers.BangOverUserIndex = @intUserIndex order by newid();
	END
END