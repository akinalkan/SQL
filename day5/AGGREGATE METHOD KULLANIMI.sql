-- AGGREGATE METHOD KULLANIMI --
/*
-Aggregate Methodları (SUM(Topla),COUNT(Say),MIN(EN küçük değer),MAX(En büyük değer),AVG(Ortalama))
-Subquery içinde de kullanılır
-ANcak, sorgu tek bir değer döndürüyor olmalıdır
SYNTAX: sum() şeklinde olmalı sum () arasında boşluk olmamalı
*/

select * from calisanlar2;

--calisanlar2 tablosundaki en yuksek maas degerini listeleyiniz
select max(maas) from calisanlar2

--calisanlar2 tablosundaki maaslarin toplamini listeleyiniz
select sum(maas) from calisanlar2

--calisanlar2 tablosundaki maaslarin ortalamalarini listeleyiniz
select avg(maas) from calisanlar2;--2714.2857142857142857
select round(avg (maas)) from calisanlar2;--2714
select round(avg (maas),2) from calisanlar2;--2714.29

--calisanlar2 tablosundaki en dusuk maas degerini listeleyiniz
select min(maas) from calisanlar2;--1000

--calisanlar tablosunda kac kisinin maas aldigini listeleyiniz
select count(maas) from calisanlar2;-->7

select * from markalar;
select * from calisanlar2;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
select marka_isim,calisan_sayisi,
(select sum(maas) from calisanlar2 where marka_isim=isyeri)as toplam_maas from markalar;

-- Her markanin ismini, calisan sayisini ve o markaya 
--ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz
select marka_isim,calisan_sayisi,
(select min(maas)from calisanlar2 where  marka_isim=isyeri )as min_maas,
(select max(maas)from calisanlar2 where  marka_isim=isyeri )as max_maas from markalar;

--Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
select marka_id,marka_isim,
(select count(sehir) from calisanlar2 where marka_isim=isyeri ) as sehir_sayisi from markalar;

--Interview Question: En yüksek ikinci maas değerini çağırın.
select max(maas)as enYuksek_ikincimaas from calisanlar2 where
maas<(select max(maas) from calisanlar2);



--Interview Question: En yüksek ucuncu maas değerini çağırın.
select max(maas)as enYuksek_ucuncumaas from calisanlar2 where
maas<(select max(maas) from calisanlar2 where maas<(select max(maas) from calisanlar2))

--Interview Question: En dusuk ikinci maas değerini çağırın.
select min(maas)as endusuk_ikincimaas from calisanlar2 where
maas>(select min(maas) from calisanlar2);

-- En dusuk ucuncu maas değerini çağırın.
select min(maas)as endusuk_ucuncumaas from calisanlar2 where
maas>(select min(maas) from calisanlar2 where maas>(select min(maas) from calisanlar2))




