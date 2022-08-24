--Personel isminde bir tablo olusturalim
create table personel(
pers_id int,
	isim varchar(30),
	sehir varchar(30),
	maas int,
	sirket varchar(20),
	adres varchar(50)
);
--Varolan personel tablosundan pers_id, sehir, adres, field'larina sahip personel_adres adinda yeni bir tablo olusturalim
create table personel_adres
as
select pers_id,sehir,adres from personel;
select * from personel

--DML --> Data Manupulation Lang.
--	INSERT - UPDATE - DELETE
--Tabloya veri ekleme, tablodan veri guncelleme ve silme islemlerinde kullanilan komutlar
--INSERT
create table student
(
id varchar(4),
st_name varchar(30),
age int
);
INSERT into student VALUES('1001','Ali Can',25);
INSERT into student VALUES('1002','Veli Can',35);
INSERT into student VALUES('1003','Ayse Can',45);
INSERT into student VALUES('1004','Derya Can',55);
--Tablo'ya parcali veri ekleme
insert into student (st_name,age) values ('Murat Can',65);


--DQL --> Data Query Lang.
--SELECT
select *from student;
select st_name from student;
--SELECT komutu WHERE kosulu
SELECT * from student where age>35;

--TCL - Transaction Control Lang.
--Begin - Savepoint - rollbback - commit
--Transaction veri tabani sistemlerinde bit islem basladiginda baslar ve islem bitince sona ere
--Bu islemler veri tabani olustrma , veri silme, veri guncelleme, veriyi geri getirme gibbi islemler olabilir

CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);
Begin;
insert into ogrenciler2 values (default,'Ali Can','Hasan Can',75.5);
insert into ogrenciler2 values (default,'Canan Gul','Ayse Sen',90.5);
savepoint x;
insert into ogrenciler2 values (default,'Kemal Can','Ahmet Can',85.5);
insert into ogrenciler2 values (default,'Ahmet Sen','Ayse Can',65.5);

ROLLBACK TO x;

SELECT * from ogrenciler2;

commit;

--Transaction kullaniminda serial data turu kullanimi tavsiye edilmez 
--savepoint'den sonra ekledigimiz veride sayac mantigi ile calistigi icin 
--sayac'da en son hangi sayida kaldiysa oradan devam eder
--Not:PostgreSQL'de Transaction kullanimi icin Begin komutu ile baslariz sonrasinda tekrar yanlis bir 
--veriyi duzeltmek veya bizim icin onemli verilerden sonra ekleme yapabilmek icin 'SAVEPOINT save_point_adi'
--komutunu kullaniriz ve bu savepoint'e donebilmek icin'ROLLBACK TO save_point_adi' komutunu kullaniriz
--ve rollback calistirildiginda savepoint yazdigimiz satirin ustundeki verileri
--tabloda bize verir ve son olarak Transaction'i sonlandirmak icin mutlaka 'COMMIT' komutunu kullaniriz.
--MySQL'de transaction olmadan da kullanilir

--DML - DELETE -
--DELETE FROM tablo_adi--> Tablo'nun tum icerigini siler
--Veriyi secerek silmek icin WHERE kosulu kullanilir
--DELETE FROM tablo_adi WHERE sutun_adi=veri--->Tablo'daki istedigimiz veriyi siler

CREATE TABLE ogrenciler
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(128, 'Mustafa Bak', 'Ali', 99);


select * from ogrenciler;

-- Soru : id'si 124 olan öğrenciyi siliniz
DELETE FROM ogrenciler WHERE id=127;
-- Soru : ismi Kemal Yasa olan satırı siliniz
DELETE FROM ogrenciler WHERE isim='Kemal Yasa';
-- Soru : ismi Nesibe Yılmaz veya Mustafa Bak olan kayıtları silelim
DELETE FROM ogrenciler WHERE isim='Nesibe Yilmaz'or isim= 'Mustafa Bak';
-- soru : ismi Ali Can ve id'si 123 olan kaydı siliniz
DELETE FROM ogrenciler WHERE isim='Ali Can'or id= 123;

--DELETE - TRUNCATE -->
--TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamini siler
--Ancak secmeli silme yapamaz

select * from ogrenciler;
TRUNCATE TABLE ogrenciler;


--DDL - Data Definition Lang.
--CREATE - ALTER - DROP
--ALTER TABLE --
--ALTER TABLE tabloda ADD, TYPE, SET, RENAME veya DROP COLUMNS islemleri icin kullanilir

--Personel isminde bir tablo olusturalim
create table personel(
pers_id int,
	isim varchar(30),
	sehir varchar(30),
	maas int,
	sirket varchar(20),
	adres varchar(50)
);
select * from personel;
--Personel tablosuna cinsiyet Varchar(20) ve yas int seklinde yeni sutunlar ekleyiniz

alter table personel add cinsiyet varchar(20), add yas int ;


--Personel tablosundan sirket field'ini siliniz
alter table personel drop column sirket;

-- Personel tablosundaki sehir sutununun adını ulke olarak değiştirelim
alter table personel rename column sehir to ulke;

-- Personel tablosunun adını isciler olarak değiştiriniz
alter table personel rename to isciler;
alter table isciler rename to personel;

select * from isciler;

DROP TABLE isciler;
alter table personel add cinsiyet varchar(20), add yas int ;


-- CONSTRANINT -- Kısıtlamalar
-- Primary Key --> Bir sutunun NULL içermemesini ve sutundaki verilerin BENZERSİZ olmasını sağlar (NOT NULL - UNIQUE)
-- FOREGIN KEY --> Başka bir tablodaki PRİMARY KEY'i referans göstermek için kullanılır. Böylelikle, tablolar arasında ilişki kurmuş oluruz.
-- UNIQUE --> Bir sutundaki tüm değerlerin BENZERSİZ yani tek olmasını sağlar
-- NOT NULL --> Bir sutunun NULL içermemesini yani boş olmamasını sağlar
-- NOT NULL kısıtlaması için CONSTRAINT ismi tanımlanmaz. Bu kısıtlama veri türünden hemen sonra yerleştirilir
-- CHECK --> Bir sutuna yerleştirilebilecek değer aralığını sınırlamak için kullanılır.


CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,--> Bir sutundaki tüm değerlerin BENZERSİZ yani tek olmasını sağlar
maas int NOT NULL, --> Bir sutunun NULL içermemesini yani boş olmamasını sağlar
ise_baslama DATE
);
select * from calisanlar;

-- create table calisanlar2(
-- id CHAR(5),
-- isim VARCHAR(50),
-- maas int NOT NULL,
-- ise_baslama DATE,
-- CONSTRAINT pk_id PRIMARY KEY(id),
-- CONSTRAINT ism_unq UNIQUE(isim)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
-- INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
-- INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
-- INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');
-- INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
-- INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');
-- INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');
-- INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');


INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY

select * from calisanlar;

--FOREIGN KEY --
CREATE TABLE adresler
(
adres_id char(5),
	sokak varchar(20),
	cadde varchar(30),
	sehir varchar(20),
	CONSTRAINT id_fk FOREIGN KEY(adres_id) REFERENCES calisanlar(id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

select * from adresler;