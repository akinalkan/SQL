/*
--           GROUP BY HAVING
 HAVING ifadesinin islevi WHERE ifadesinin gibidir.

 Ancak kumeleme fonksiyonlari ile WHERE ifadesi birlikte kullanimadigi icin
HAVING ifadesine ihtiyac duyulmustur.

 GROUP BY ile kullanilir.

 Gruplama'dan sonraki sart icin GROUP BY' dan sonra HAVING kullanilir.
*/

--Maaş ortalaması 3000’den fazla olan ülkelerdeki erkek çalışanların maaş ortalaması.
select ulke ,round(avg(maas))as maas_ort
from personel
where cinsiyet='E'
group by ulke 
having avg(maas)>3000;
-- siralamaya dikkat[group by'dan sonra where kullanilmaz having kullanilir]

--Erkek çalışanların sayısı 1’den fazla olan ülkelerin maaş ortalamasını getiren sorgu
select ulke, round(avg(maas))
from personel
where cinsiyet='E'
group by ulke
having count(*)>1;

