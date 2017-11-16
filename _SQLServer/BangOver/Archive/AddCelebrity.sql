DECLARE @strCelebrityName varChar(max) = 'Neil Patrick Harris';
DECLARE @strCelebritySex varChar(max) = 'M';
DECLARE @strCelebrityPicture varChar(max) = 'http://images.eonline.com/eol_images/Entire_Site/201512//rs_634x1024-150202163833-634.Neil-Patrick-Harris-Oscar-Luncheon.ms.020115.jpg';

INSERT INTO CelebrityRequests (Name, Sex, Picture ) VALUES ( @strCelebrityName, @strCelebritySex, @strCelebrityPicture );

--select * from CelebrityRequests;


--delete from CelebrityRequests where Indext < 3;
















/*
Jared Padalecki
http://i41.tinypic.com/33cno81.jpg

Ashley Williams
http://www1.pictures.zimbio.com/gi/Premiere+Warner+Bros+Something+Borrowed+Red+xBfZpjfs_Ryl.jpg

Emmy Rossum
https://www.google.com/imgres?imgurl=http%3A%2F%2Fcdn03.cdn.justjared.com%2Fwp-content%2Fuploads%2F2016%2F09%2Femmy-emmys%2Femmy-rossum-sam-esmail-2016-emmys-02.jpg&imgrefurl=http%3A%2F%2Fwww.justjared.com%2Fphoto-gallery%2F3763884%2Femmy-rossum-sam-esmail-2016-emmys-02%2F&docid=_WS8ck4AmbyXqM&tbnid=HVRcDnyYnGugqM%3A&vet=10ahUKEwio_tCUsbbTAhVB6yYKHZxwBPUQMwhjKCAwIA..i&w=815&h=1222&safe=off&bih=549&biw=1280&q=emmy%20rossum%202016&ved=0ahUKEwio_tCUsbbTAhVB6yYKHZxwBPUQMwhjKCAwIA&iact=mrc&uact=8#h=1222&imgdii=ef7c21-M6ScSjM:&vet=10ahUKEwio_tCUsbbTAhVB6yYKHZxwBPUQMwhjKCAwIA..i&w=815

Tina Fey
http://zntent.com/wp-content/uploads/2016/03/Tina-Fey-award-image.jpg

Jim Gaffigan
https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk9E0rvO_CzulKqxpAPcT-cDfGygSPkekf0VifdOoJVHLQenOu-g

Seth Rogan
http://www.aceshowbiz.com/images/wennpic/seth-rogen-53rd-new-york-film-festival-02.jpg

Summer Glau
http://photos.summer-glau.com/albums/userpics/10003/0d/TV_Guide_Hot_List_Party_17.jpg

*/