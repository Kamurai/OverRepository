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
	SET @UserCount = (select count(UserIndex) from BangOverLists where userindex = @intUserIndex);

	--//if count != 0 (user has records)
	if( @UserCount > 0 )
	BEGIN
		--//request count of random non-locked celebrities from personal list
			--//adjust OrderCount to exclude (1's uplock and count's downlock only available)
		SET @OrderCount = (
		select count(Indext) from BangOverLists where UserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
		and not ( OrderRank = 0 and UpLock = 0 and DownLock = 1 ) and not (OrderRank = (@UserCount-1) and UpLock = 1 and DownLock = 0)
		);
		SET @GlobalExclusionCount = (select count(Celebrities.Indext) from Celebrities, BangOverUsers
			where ((Sex = 'F' and Women = 1) or (Sex = 'M' and Men = 1) or (Sex = 'W' and TransWomen = 1) or (Sex = 'T' and TransMen = 1)) 
			and BangOverUsers.UserIndex = @intUserIndex
			and Celebrities.Indext not in(
			select Celebrities.Indext from Celebrities, BangOverLists, BangOverUsers
			where BangOverUsers.UserIndex = @intUserIndex and BangOverLists.UserIndex = BangOverUsers.UserIndex and CelebrityIndex = Celebrities.Indext
			));
	
		--//if count is not 0 (there are some unlocked records)
		if( @OrderCount != 0 )
		BEGIN
			--//there are celebrities left in the global list
			IF( @GlobalExclusionCount > 0 )
			BEGIN
				--//request random non-locked Target from personal list
				SET @TargetIndex = (select top 1 Indext from BangOverLists where UserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0) order by newid());
			END
			ELSE
			BEGIN
				--//request random non-locked Target from personal list
					--//exclude the first and last celebrities
				SET @TargetIndex = (select top 1 Indext from BangOverLists 
				where UserIndex = @intUserIndex and (UpLock = 0 or DownLock = 0)
				and (OrderRank != 0 and OrderRank != @UserCount-1 ) order by newid());
			END


			--//find a record to compare to the one we have
				--//if order is 0 or equal to count
					--//there are celebrities left in the global list
			if ( (select count(UserIndex) from BangOverLists 
			where (Indext = @TargetIndex and OrderRank = 0) or (Indext = @TargetIndex and OrderRank = @UserCount-1) ) > 0 
			and @GlobalExclusionCount > 0 )
			BEGIN    
				--//request @TargetIndex from personal list
				select Celebrities.Indext, Name, Sex, Picture from BangOverLists, Celebrities where BangOverLists.Indext = @TargetIndex and CelebrityIndex = Celebrities.Indext
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( select Top 1 Celebrities.Indext, Name, Sex, Picture from Celebrities, BangOverUsers
				where ((Sex = 'F' and Women = 1) or (Sex = 'M' and Men = 1) or (Sex = 'W' and TransWomen = 1) or (Sex = 'T' and TransMen = 1)) 
				and BangOverUsers.UserIndex = @intUserIndex
				and Celebrities.Indext not in(
				select Celebrities.Indext from Celebrities, BangOverLists, BangOverUsers
				where BangOverUsers.UserIndex = @intUserIndex and BangOverUsers.UserIndex = BangOverUsers.UserIndex and CelebrityIndex = Celebrities.Indext
				) order by newid() ) T1;
			END
			--//else we're looking for an adjacent Target from the personal list
			ELSE
			BEGIN
				SET @SavedOrder = (select OrderRank from BangOverLists where Indext = @TargetIndex);
				--//request @TargetIndex from personal list
				select Celebrities.Indext, Name, Sex, Picture from  Celebrities, BangOverLists where BangOverLists.Indext = @TargetIndex and CelebrityIndex = Celebrities.Indext
				UNION
				--//request adjacent non-locked Target from personal list
				select * from (
					select top 1 Celebrities.Indext, Name, Sex, Picture from Celebrities, BangOverLists where UserIndex = @intUserIndex and Celebrities.Indext = CelebrityIndex and ( (OrderRank = @SavedOrder-1 and DownLock = 0) or (OrderRank = @SavedOrder+1 and UpLock = 0) ) order by newid()
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
				select top 1 Celebrities.Indext, Name, Sex, Picture from Celebrities, BangOverLists where UserIndex = @intUserIndex and CelebrityIndex = Celebrities.Indext and ( OrderRank = 0 or OrderRank = @UserCount-1 )
				order by newid() ) T3
				UNION
				--//request random from global list
					--//exclude from personal list
				select * from ( select Top 1 Celebrities.Indext, Name, Sex, Picture from Celebrities, BangOverUsers
				where ((Sex = 'F' and Women = 1) or (Sex = 'M' and Men = 1) or (Sex = 'W' and TransWomen = 1) or (Sex = 'T' and TransMen = 1)) 
				and BangOverUsers.UserIndex = @intUserIndex
				and Celebrities.Indext not in(
				select Celebrities.Indext from Celebrities, BangOverLists, Users
				where BangOverUsers.UserIndex = @intUserIndex and BangOverLists.UserIndex = BangOverUsers.UserIndex and CelebrityIndex = Celebrities.Indext
				) order by newid() ) T4;
			END
			ELSE
			--//there are no selections left in the global list
				--//there are no unlocked records
			BEGIN
				--//return the top two records from personal list
				select top 2 Celebrities.Indext, Name, Sex, Picture from Celebrities, BangOverLists where UserIndex = @intUserIndex
				and CelebrityIndex = Celebrities.Indext
				and ( (OrderRank = 0) or (OrderRank = 1) );
			END
		END
	END
	--//else (if user has no records)
	ELSE
	BEGIN
		--//request 2 random celebrities from global list
		select top 2 Celebrities.Indext, Name, Picture, Sex from Celebrities, BangOverUsers where BangOverUsers.UserIndex = @intUserIndex and ((Sex = 'F' and Women = 1) or (Sex = 'M' and Men = 1) or (Sex = 'W' and TransWomen = 1) or (Sex = 'T' and TransMen = 1)) order by newid();
	END

END