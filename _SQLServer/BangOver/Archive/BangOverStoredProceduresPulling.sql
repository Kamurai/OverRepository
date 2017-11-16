--drop PROCEDURE BangOverPullCelebritiesGlobalPair;
--drop PROCEDURE BangOverPullCelebritiesGlobalSingle;
--drop PROCEDURE BangOverPullCelebritiesPersonalSingleEnds;
--drop PROCEDURE BangOverPullCelebritiesPersonalSingleTarget



create PROCEDURE BangOverPullCelebritiesGlobalPair
(
    @intUserIndex int
)
AS
BEGIN
	--//request 2 random celebrities from global list
    select top 2 * from Celebrities, BangOverUsers where BangOverUsers.UserIndex = @intUserIndex and ((Sex = 'F' and Women = 1) or (Sex = 'M' and Men = 1) or (Sex = 'W' and TransWomen = 1) or (Sex = 'T' and TransMen = 1)) order by newid();
END

create PROCEDURE BangOverPullCelebritiesGlobalSingle
(
    @intUserIndex int
)
AS
BEGIN
	select * from ( select Top 1 Celebrities.Indext, Name, Sex, Picture from Celebrities, BangOverUsers
	where ((Sex = 'F' and Women = 1) or (Sex = 'M' and Men = 1) or (Sex = 'W' and TransWomen = 1) or (Sex = 'T' and TransMen = 1)) 
	and BangOverUsers.UserIndex = @intUserIndex
	and Celebrities.Indext not in(
	select Celebrities.Indext from Celebrities, BangOverLists, Users
	where BangOverUsers.UserIndex = @intUserIndex and BangOverLists.UserIndex = BangOverUsers.UserIndex and CelebrityIndex = Celebrities.Indext
	) order by newid() ) T4;
END

create PROCEDURE BangOverPullCelebritiesPersonalSingleEnds
(
    @TargetIndex int
)
AS
BEGIN
	select * from (
			select top 1 Celebrities.Indext, Name, Sex, Picture from Celebrities, BangOverLists where BangOverLists.Indext = @TargetIndex
		order by newid() ) T3;
END

create PROCEDURE BangOverPullCelebritiesPersonalSingleTarget
(
    @TargetIndex int
)
AS
BEGIN
	select Celebrities.Indext, Name, Sex, Picture from BangOverLists, Celebrities where BangOverLists.Indext = @TargetIndex and CelebrityIndex = Celebrities.Indext;
END



