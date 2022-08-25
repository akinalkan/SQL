-- SELECT - SIMILAR TO - REGEX(Regular Expressions) -- 
/*
SIMILAR TO : Daha karmasik pattern(kalip) ile sorgulama islmei icin SIMILAR TO kullanilabilir
Sadece PostgreSQL'de kullanilir.Buyuk-kucuk harf onemlidir

REGEX : Herhangi bbir kod, metin icerisin de yazi veya kod parcasinin aranip bulunmasini saglayan
kendine ait bir soz dizimi olan bbir yapidir.MySQL'de (REGEX_LIKE)	 olarak kullanılır
PostgreSQL'de "~" karakteri ile kullanılır.
*/

CREATE TABLE kelimeler
(
id int,
kelime VARCHAR(50),
harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3);
   INSERT INTO kelimeler VALUES (1002, 'hat', 3);
   INSERT INTO kelimeler VALUES (1003, 'hit', 3);
   INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
   INSERT INTO kelimeler VALUES (1005, 'hct', 3);
   INSERT INTO kelimeler VALUES (1006, 'adem', 4);
   INSERT INTO kelimeler VALUES (1007, 'selim', 5);
   INSERT INTO kelimeler VALUES (1008, 'yusuf', 5);
   INSERT INTO kelimeler VALUES (1009, 'hip', 3);
   INSERT INTO kelimeler VALUES (1010, 'HOT', 3);
   INSERT INTO kelimeler VALUES (1011, 'hOt', 3);
   INSERT INTO kelimeler VALUES (1012, 'h9t', 3);
   INSERT INTO kelimeler VALUES (1013, 'hoot', 4);
   INSERT INTO kelimeler VALUES (1014, 'haaat', 5);
   INSERT INTO kelimeler VALUES (1015, 'hooooot', 5);
   INSERT INTO kelimeler VALUES (1016, 'booooot', 5);
   INSERT INTO kelimeler VALUES (1017, 'bolooot', 5);
   
  select * from kelimeler;
  
  --  İçerisinde 'ot' veya 'at' bulunan kelimeleri listeleyiniz
  --Veya islemi icin | karakteri kullanilir
  --1.Yol SIMILAR TO ile
  select * from kelimeler where kelime SIMILAR TO '%(at|ot)%'
  --2.yol[like]
  select * from kelimeler where kelime ~~*'%at%' or kelime ~~*'%ot%';
--3.Yol[like]
select * from kelimeler where kelime ILIKE '%at%' or kelime ILIKE '%ot%';
--REGEX
select * from kelimeler where kelime ~* 'ot' or kelime ~* 'at';


-- : 'ho' veya 'hi' ile başlayan kelimeleri listeleyeniz

select * from kelimeler where kelime ~~* 'ho%' or kelime ~~*'hi%';
select * from kelimeler where kelime SIMILAR TO 'ho%|hi%';
select * from kelimeler where kelime ILIKE 'ho%' or kelime ILIKE'hi%';

--REGEX ile
select * from kelimeler where kelime ~* 'h[oi](.*)'; 
--Regex'de ikinci karakter için köşeli parantez kullanılır. * hepsi anlamında kullanılır

--Sonu 't' veya 'm' ile bitenleri listeleyeniz
select *from kelimeler where kelime ~~*'%t' or kelime ~~* '%m'; 
--SIMILAR TO ile 
select * from kelimeler where kelime SIMILAR TO '%t|%m';

--REGEX ile
select * from kelimeler where kelime ~* '(.*)[tm]$'; 

-- h ile başlayıp t ile biten 3 harfli kelimeleri listeleyeniz
select * from kelimeler where kelime ~~*'h_t';

--SIMILAR TO ile 
select * from kelimeler where kelime SIMILAR TO 'h[0-9,A-Z,a-z]t';

--İlk karakteri 'h', son karakteri 't' ve ikinci karakteri 'a'dan 'e'ye herhangi bir karakter olan
--“kelime" değerlerini çağırın.

--SIMILAR TO ile
select * from kelimeler where kelime SIMILAR TO 'h[a-e](.*)%t';
--REGEX ile
select * from kelimeler where kelime ~* 'h[a-e](.*)t';

--İlk karakteri 's', 'a' veya 'y' olan "kelime" değerlerini çağırın.
select kelime from kelimeler where kelime ~*'^[say](.*)';--> ^ baslangic'i temsil eder

--Son karakteri 'm', 'a' veya 'f' olan "kelime" değerlerini çağırın.
select * from kelimeler where kelime ~ '(.*)[maf]$'

--İlk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tüm bilgilerini sorgulayalım.
select * from kelimeler where kelime ~* 'h[ai]t';
--SIMILAR TO ile
select * from kelimeler where kelime SIMILAR TO 'h[a|i]t';
--REGEX ile
select * from kelimeler where kelime ~ '^h[a|i]t$';

--İlk harfi 'b' dan ‘s' ye bir karakter olan ve ikinci harfi
--herhangi bir karakter olup üçüncü harfi ‘l' olan “kelime" değerlerini çağırın.

select * from kelimeler where kelime ~ '^[b-s].l(.*)';

select*from kelimeler where kelime similar to '[b-s]_l%';

--içerisinde en az 2 adet o o barıdıran kelimelerin tüm bilgilerini listeleyiniz.

select*from kelimeler where kelime similar to '%[o][o]%';

select*from kelimeler where kelime  similar to '%[o]{2}%';
-->{...} icine yazilan rakam bir onceki[...] icine yazilan karakterin kac tane oldugunu belirtir

--içerisinde en az 4 adet oooo barıdıran kelimelerin tüm bilgilerini listeleyiniz.
select*from kelimeler where kelime  similar to '%[o]{4}%';

select*from kelimeler where kelime ~~* '%o%o%o%o%';

--'a', 's' yada 'y' ile başlayan VE 'm' yada 'f' ile biten "kelime" değerlerini çağırın.
select*from kelimeler where kelime  ~'^[a|s|y](.*)[m|f]$'






  
  
  
  
  
  
  
  
  