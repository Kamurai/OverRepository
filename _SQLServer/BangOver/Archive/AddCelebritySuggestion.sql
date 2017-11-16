DECLARE @strCelebrityName varChar(max) = 'Neil Patrick Harris';
DECLARE @strCelebritySex varChar(max) = 'M';
DECLARE @strCelebrityPicture varChar(max) = 'http://images.eonline.com/eol_images/Entire_Site/201512//rs_634x1024-150202163833-634.Neil-Patrick-Harris-Oscar-Luncheon.ms.020115.jpg';

INSERT INTO CelebrityRequests (Name, Sex, Picture ) VALUES ( @strCelebrityName, @strCelebritySex, @strCelebrityPicture )

select * from CelebrityRequests;

select * from Celebrities;

--delete from CelebrityRequests where Indext < 3;


delete from Celebrities where Indext = 85;


