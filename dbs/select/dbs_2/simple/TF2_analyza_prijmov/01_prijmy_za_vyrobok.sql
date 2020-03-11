SELECT vyrobky.nazov AS 'Názov Výrobku',
       dod_vyr.mnozstvo AS 'Množstvo Predaného Výrobku [ks]',
       vyrobky.pred_cena AS 'Predajná Cena [eur]',
       dod_vyr.mnozstvo * vyrobky.pred_cena AS 'Príjem za Výrobok [eur]'
FROM vyrobky
         RIGHT JOIN
     (SELECT vyrobok_id, SUM(mnozstvo) AS mnozstvo
      FROM dodane_vyrobky
      GROUP BY vyrobok_id) AS dod_vyr
     ON dod_vyr.vyrobok_id = vyrobky.id
ORDER BY vyrobky.nazov;
