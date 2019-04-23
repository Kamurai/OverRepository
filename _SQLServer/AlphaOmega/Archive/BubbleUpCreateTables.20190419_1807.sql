--drop [BubbleUp].dbo.Boxes, [BubbleUp].dbo.Targets;

create table [BubbleUp].dbo.Boxes (
	BoxIndex			bigint IDENTITY(0,1) PRIMARY KEY, 
	BubbleUpUserIndex	bigint not null, 
	ParentBoxIndex		bigint not null,
	Label				varchar(max),
	OrderRank			int not null
);

create table [BubbleUp].dbo.Targets (
	TargetIndex			bigint IDENTITY(0,1) PRIMARY KEY, 
	BubbleUpUserIndex	bigint not null, 
	ParentBoxIndex		bigint not null,
	Label				varchar(max),
	OrderRank			int not null
);