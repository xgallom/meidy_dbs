-- To iste co mesta, akurat ze z materialov berieme ine dodatocne informacie
SELECT skupiny_materialov.nazov AS 'Skupina Materiálov',
       typy_materialov.nazov    AS 'Typ Materiálu',
       materialy.nazov          AS 'Názov Materiálu',
       materialy.jed_cena       AS 'Jednotková Cena [eur]',
       materialy.mer_jed        AS 'Merná Jednotka'
-- Zoberieme vsetky kombinacie rovnako ako u miest
FROM skupiny_materialov,
     typy_materialov,
     materialy
-- Vyfiltrujeme tie v ktorych zapadaju do seba id-cka
WHERE materialy.typ_materialu_id = typy_materialov.id
  AND typy_materialov.skupina_materialu_id = skupiny_materialov.id
-- Zoradenie
ORDER BY skupiny_materialov.nazov, typy_materialov.nazov, materialy.nazov
