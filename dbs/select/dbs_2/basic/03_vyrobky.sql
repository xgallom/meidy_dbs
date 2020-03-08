-- To iste co mesta, akurat ze z vyrobkov berieme ine dodatocne informacie
SELECT skupiny_vyrobkov.nazov AS 'Skupina Výrobkov',
       typy_vyrobkov.nazov    AS 'Typ Výrobku',
       vyrobky.nazov          AS 'Názov Výrobku',
       vyrobky.vyr_cena       AS 'Výrobná Cena [eur]',
       vyrobky.pred_cena      AS 'Predajná Cena [eur]'
-- Zoberieme vsetky kombinacie rovnako ako u miest
FROM skupiny_vyrobkov,
     typy_vyrobkov,
     vyrobky
-- Vyfiltrujeme tie v ktorych zapadaju do seba id-cka
WHERE vyrobky.typ_vyrobku_id = typy_vyrobkov.id
  AND typy_vyrobkov.skupina_vyrobku_id = skupiny_vyrobkov.id
-- Zoradenie
ORDER BY skupiny_vyrobkov.nazov, typy_vyrobkov.nazov, vyrobky.nazov