-- Vezmeme nazvy z jednotlivych tabuliek ktore sme nakombinovali + PSC z tabulky mesta
SELECT kraje.nazov             AS 'Kraj',
       okresy.nazov            AS 'Okres',
       mesta.nazov             AS 'Mesto',
       -- Zarovnanie nulami na 5 znakov kvoli tomu ze sme PSC ulozili ako integer
       LPAD(mesta.psc, 5, '0') AS 'PSC'
-- Zoberieme vsetky kombinacie riadkov z krajov, okresov a miest
FROM kraje,
     okresy,
     mesta
-- Vyfiltrujeme tie v ktorych zapadaju do seba id-cka
WHERE mesta.okres_id = okresy.id
  AND okresy.kraj_id = kraje.id
-- Zoradenie zlava doprava, najprv sa zoradi podla krajov, v ramci kraja podla okresov,
-- v ramci okresov podla nazvov miest
ORDER BY kraje.nazov, okresy.nazov, mesta.nazov;
