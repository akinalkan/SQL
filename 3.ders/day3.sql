CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE, -- UNIQUE --> Bir sutundaki tüm değerlerin BENZERSİZ yani tek olmasını sağlar
maas int NOT NULL, -- NOT NULL --> Bir sutunun NULL içermemesini yani boş olmamasını sağlar
ise_baslama DATE
);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY
select *from calisanlar;
-- FOREIGN KEY--
CREATE TABLE adresler
(
adres_id char(5) ,
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
select * from adresler;
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
--Parent tabloda olmayan id ile child tabloya ekleme yapamayız
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');

--Calısanlar id ile adresler tablosundaki adres_id ile eşlesenlere bakmak için
select * from calisanlar,adresler WHERE calisanlar.id = adresler.adres_id;

DROP table calisanlar
--Parant tabloyu yani primary key olan tabloyu silmek istediğimizde tabloyu silmez
--Önce child tabloyu silmemiz gerekir
delete from calisanlar where id='10002';--parent-->hata verir once child dan silinmeli

delete from adresler where adres_id='10002';--child'dan silebiliriz 

select * from adresler;

drop table calisanlar;--parent-->hata verir once child dan silinmeli

drop table adresler;--child'dan silebiliriz 

-- ON DELETE CASCADE --
--Her defasında önce child tablodaki verileri silmek yerine
--ON DELETE CASCADE silme özelliğini aktif hale getirebiliriz
--Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmamız yeterli

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

select * from talebeler;

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
ON DELETE CASCADE
);
INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('123','Matematik',85);

INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler;--Parent
select * from notlar;--Child

DELETE FROM notlar WHERE talebe_id = '123';

DELETE FROM talebeler WHERE id='126';--ON DELETE CASCADE -->kullandigimiz icin parent table'dan direk silebildik
--Parent table'dan sildigimiz icin child table'dan da silinmis olur


delete from talebeler;--hata verir.

drop table talebeler cascade;--Parent tabloyu kaldirmak istersek Drop table tablo_adi dan sonra... 
--Cascade komutunu kullaniriz

--Talebeler tablosundaki isim sutununa NOT NULL kisitlamasi ekleyiniz ve veri tipini varchar(30) olarak degistiriniz


alter table talebeler
alter column isim type varchar(30),
alter column isim set not null;
--talebeler tablosundaki yazili_notu sutununa 60 dan buyuk rakam girilebilsin

alter table talebeler
add constraint sinir check(yazili_notu>60);

INSERT INTO talebeler VALUES(127, 'Mustafa Can', 'Hasan',45);
--Açiklama :
-- yukarda 60'i sinir olarak belirledigimiz icin bunu eklemedi
--check kisitlamasi ile tablodaki istedigimiz sutunu sinirlandirabiliriz


create table ogrenciler(
id int,
isim varchar(45),
adres varchar(100),
sinav_notu int
);


Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;

select * from ogrenciler
select * from ogrenci_adres


--Tablodaki bir sutuna PRIMARY KEY ekleme

alter table ogrenciler
add primary key (id);

--primary key olusturmada  2.yol

alter table ogrenciler
add constraint pk_id primary key (id);

--PR'den sonra FK atamasi

alter table ogrenci_adres
add foreign key (id) references ogrenciler ;
--Child tabloyu Parent tablodan olusturdugumuz icin column adi vermedik


--Fk' yi constraint silme
alter table ogrenci_adres drop constraint ogrenci_adres_id_fkey;--1. sirada bu yapilir

--Pk'yi constraint silme 
alter table ogrenciler drop constraint pk_id;--2. sirada bu yapilir

--yazili notu  85'den buyuk olan talebe bilgilerini getirin

select * from talebeler where  yazili_notu>85;

--ismi "Mustafa Bak" olan ogrencinin tum bilgilerini getirin

select * from talebeler where  isim='Mustafa Bak'

-- SELECT komutunda BETWEEN kosulu
-- BETWEEN belirttiginiz iki veri arasindaki bilgileri listeler
-- BETWEEN de belirttigimiz degerlerde listelemeye dahildir

create table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

/*
AND (ve) :Belirtilen sartlarin her ikiside gerceklesiyor sa o kayit listelenir
Bir tanesi bile gercelesmezse listelemez
Select *from matematik_sinavi>50 AND sinav2>50
Hem matematik_sinavi hemde sinav2 50'den buyuk olankayitlari listeler
OR (veya): Belirtilen sartlarden en az biri bile gerceklesirse kayit listelenir
Select * from mateamtik_sinav>50 OR sinav2>50
mateamtik_sinav veya sinav2 den herhangi biri 50'den buyuk olan kayitlari listeler
*/

select * from personel;
--id'si 1003 ile 1005 arasinda olan personelin ismi listeleyiniz
select * from personel where id between '1003' and '1005';

--2.Yol
select * from personel where id>='1003' and id<='1005'

--Derya Soylu ile Yavuz Bal arasindaki personel bilgisini listeleyiniz
select*from personel where isim between 'Derya Soylu' and 'Yavuz Bal'
--2.Yol
select * from personel where isim>='Derya Soylu' and isim<='Yavuz Bal';

--Maasi 70000 ve ismi 'Sena Beyaz' olan personeli listele
select * from personel where isim='Sena Beyaz' or maas='70000'

select * from personel where maas>='50000' and maas<='80000';

--IN :Birden fazla mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutta yazabilme imkani verir
--Farkli sutunlar icin IN kullanilamaz

--id'si 1001, 1002 ve 1004 olan personelin bilgilerini listele
--1.Yol
select * from personel where id in('1001','1002','1004');
--2.Yol
select * from personel where id='1001' or id='1002' or id='1004';

--Maas'i sadece 70 000 ,100 000 olanb personel;i listele
select * from personel where maas in('70000','100000')

/*
SELECT - LIKE kosulu
LIKE :Sorgulama yaparken belirli [Pattern]kalip ifadeleri kullanabilmemizi saglar
ILIKE : Sorgulama yaparken buyuk kucuk harfe duyarsiz olarak eslestirir
LIKE : ~~
ILIKE :~~*
NOTLIKE :!~~
NOT ILIKE : !~~*
% --> 0 veya daha fazla karakteri belirtir.
_ -->Tek bir karakteri belirtir
*/

--Ismi A harfi ile baslayan personeli listele

select * from personel where isim like 'A%';

--Ismi T harfi ile biten personeli listele
select * from personel where isim like '%t';


--isminin 2. harfi e olan personeli listeleyiniz
select * from personel where isim like '_e%';

insert into personel (id,isim,maas) values (1009,'Akin Alkan', 25000);
select * FROM personel where isim like 'Aki%n';















