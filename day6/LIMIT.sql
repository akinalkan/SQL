--LIMIT --

--Kisiler tablosundan  listeden ilk 5 veriyi listeleyiniz
select * from kisiler
limit 5;

--ilk 2 veriden sonra 5 veriyi listeleyiniz

select * from kisiler
limit 5 offset 2; 

--maaşı en çok olandan sıralayıp onun ilk 3 verisini listeleyiniz
select * from kisiler
order by maas desc
limit 3;

-- id değeri 5 den büyük olan ilk iki veriyi listeleyiniz
select * from kisiler
where id>5 
limit 2;

-- En yüksek maaşı alan 4. 5.  6. kişilerin bilgilerini listeleyiniz
select * from kisiler
order by maas desc
limit 3 offset 3;















