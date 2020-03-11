SELECT typy_vyrobkov.nazov       AS 'Typ Výrobku',
       dod_vyr.mnozstvo          AS 'Predané Výrobky [ks]',
       dod_vyr.prijem_za_vyrobok AS 'Príjem za Typ Výrobku [eur]'
FROM typy_vyrobkov
         RIGHT JOIN
     (SELECT vyrobky.typ_vyrobku_id,
             SUM(dod_vyr.mnozstvo)                     AS mnozstvo,
             SUM(dod_vyr.mnozstvo * vyrobky.pred_cena) AS prijem_za_vyrobok
      FROM vyrobky
               RIGHT JOIN
           (SELECT vyrobok_id, SUM(mnozstvo) AS mnozstvo
            FROM dodane_vyrobky
            GROUP BY vyrobok_id) AS dod_vyr
           ON dod_vyr.vyrobok_id = vyrobky.id
      GROUP BY vyrobky.typ_vyrobku_id) AS dod_vyr
     ON dod_vyr.typ_vyrobku_id = typy_vyrobkov.id
ORDER BY typy_vyrobkov.nazov;
