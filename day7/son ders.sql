CREATE TABLE workers
(
  id CHAR(9),
  name VARCHAR(50),
  state VARCHAR(50),
  salary SMALLINT,
  company VARCHAR(20)
);
INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM workers;

--Toplam salary değeri 2500 üzeri olan her bir çalışan için salary toplamını bulun.


SELECT name,SUM(salary)"Total Salary"
FROM workers
GROUP BY name
HAVING SUM(salary)>2500;-->'GROUP BY' ardindan 'WHERE' kullanilmaz

--Birden fazla çalışanı olan, her bir state için çalışan toplamlarını bulun.
select state,count(state) as "number of employees"
from workers
group by state
having count(state)>1;-->having group by ardindan filtreleme icin kullanilir

--Her bir state için değeri 3000'den az olan maximum salary değerlerini bulun.
select state,max(salary)
from workers
group by state
having max(salary)<3000;

--Her bir company için değeri 2000'den fazla olan minimum salary değerlerini bulun.
select company, min(salary)
from workers
group by company
having min(salary)>2000;






--Tekrarsız isimleri çağırın.
select  DISTINCT name 
from workers;-->DISTINCT clause , cagrilan terimlerden tekrarli olanlardan sadece 1.'ni alir

--Name değerlerini company kelime uzunluklarına göre sıralayın.
select name,company,length(company) as "length"
from workers
order by length(company);

--Tüm name ve state değerlerini aynı sütunda çağırarak her bir sütun değerinin uzunluğuna göre sıralayın.
--concate() fonksiyonu birden fazla sutun veya string degerini birlestirmek icin kullanilir 
--1.Yol
select concat(name,' ',state)as name_and_state,length(concat(name,' ',state))
from workers
order by length(concat(name,' ',state));

--2.Yol
select name || ' ' || state || ' ' || length(name) + length(state) as " Name and States"
from workers
order by length(name)+length(state);
/*
UNION Operator: 1) İki sorgu(query) sonucunu birleştirmek için kullanılır.
                2) Tekrarsız(unique) recordları verir.
                3) Tek bir sütuna çok sütun koyabiliriz.
				4) Tek bir sütuna çok sütun koyarken mevcut data durumuna dikkat etmek gerekir.
				[KUMELERDE BIRLESIM]
*/

--salary değeri 3000'den yüksek olan state değerlerini ve 2000'den küçük olan name değerlerini tekrarsız olarak bulun.
select state as " name and state", salary
from workers
where salary>3000

union

select name, salary
from workers
where salary<2000;



--salary değeri 3000'den yüksek olan state değerlerini ve 2000'den küçük olan name değerlerini tekrarlı olarak bulun.
select state as " name and state", salary,id
from workers
where salary>3000

union all -->union ile ayni isi yapar ancak tekrarli degerleri de verir.

select name, salary,id
from workers
where salary<2000;

--salary değeri 1000'den yüksek, 2000'den az olan "ortak" name değerlerini bulun.
select name
from workers
where salary >1000

intersect
-->INTERSECT Operator: İki sorgu (query) sonucunun ortak(common) değerlerini verir.[KUMELERDE KESISIM]
--Unique(tekrarsız) recordları verir.

select name
from workers
where salary<2000;

--salary değeri 2000'den az olan ve company değeri  IBM, APPLE yada MICROSOFT olan ortak "name" değerlerini bulun.

select name
from workers
where salary<2000

intersect

select name 
from workers
where company in('IBM','APPLE','MICROSOFT')

--EXCEPT Operator : Bir sorgu sonucundan başka bir sorgu sonucunu çıkarmak için kullanılır.
--Unique(tekrarsız) recordları verir.
--[KUMELERDE FARK]


--salary değeri 3000'den az ve GOOGLE'da çalışmayan  name değerlerini bulun.
select name
from workers
where salary<3000

except

select name
from workers
where company='GOOGLE';


----------------------------OO----------------------------
CREATE TABLE my_companies
(
  company_id CHAR(3),
  company_name VARCHAR(20)
);
INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');
SELECT * FROM my_companies;
CREATE TABLE orders
(
  company_id CHAR(3),
  order_id CHAR(3),
  order_date DATE
);
INSERT INTO orders VALUES(101, 11, '17-Apr-2020');
INSERT INTO orders VALUES(102, 22, '18-Apr-2020');
INSERT INTO orders VALUES(103, 33, '19-Apr-2020');
INSERT INTO orders VALUES(104, 44, '20-Apr-2020');
INSERT INTO orders VALUES(105, 55, '21-Apr-2020');
SELECT * FROM orders;








/*
JOINS: 1) INNER JOIN: Ortak (Common) datayı verir.
       2) LEFT JOIN: Birinci table'ın tüm datasını verir.
       3) RIGHT JOIN: İkinci table'ın tüm datasını verir.
       4) FULL JOIN: İki table'ın da tüm datasını verir.
       5) SELF JOIN: Tek table üzerinde çalışırken iki table varmış gibi çalışılır.
*/

--1) INNER JOIN
--Ortak companyler için company_name, order_id ve order_date değerlerini çağırın.

SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc INNER JOIN orders o
ON mc.company_id=o.company_id;

-- 2) LEFT JOIN
--my_companies table'ındaki companyler için order_id ve order_date değerlerini çağırın.
select mc.company_name,o.order_id, o.order_date
FROM my_companies mc LEFT JOIN orders o
ON mc.company_id=o.company_id;



-- 3) RIGHT JOIN
--orders table'ındaki order_id için company_name, order_id ve order_date değerlerini çağırın.
select mc.company_name,o.order_id, o.order_date
FROM my_companies mc RIGHT JOIN orders o
ON mc.company_id=o.company_id;

-- 4)FULL JOIN
--İki table'dan da company_name, order_id ve order_date değerlerini çağırın.
select*
FROM my_companies mc FULL JOIN orders o
ON mc.company_id=o.company_id;

--5)SELF JOIN

--SELF JOIN
CREATE TABLE workers
(
  id CHAR(2),
  name VARCHAR(20),
  title VARCHAR(60),
  manager_id CHAR(2)
);
INSERT INTO workers VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO workers VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5);
SELECT * FROM workers;

--workers tablosunu kullanarak çalışanların yöneticilerini gösteren bir tablo hazırlayın.
SELECT employee.name AS Employee, manager.name AS Manager
FROM workers employee FULL JOIN workers manager
ON employee.manager_id = manager.id;












