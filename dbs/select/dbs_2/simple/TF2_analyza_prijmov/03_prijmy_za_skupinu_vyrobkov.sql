SELECT skupiny_vyrobkov.nazov    AS 'Skupina Výrobkov',
       dod_vyr.mnozstvo          AS 'Predané Výrobky [ks]',
       dod_vyr.prijem_za_vyrobok AS 'Príjem za Skupinu Výrobkov [eur]'
FROM skupiny_vyrobkov
         RIGHT JOIN
     (SELECT typy_vyrobkov.skupina_vyrobku_id,
             dod_vyr.mnozstvo,
             dod_vyr.prijem_za_vyrobok
      FROM typy_vyrobkov
               RIGHT JOIN
           (SELECT vyrobky.typ_vyrobku_id                    AS typ_vyrobku_id,
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
      GROUP BY typy_vyrobkov.skupina_vyrobku_id) AS dod_vyr
     ON dod_vyr.skupina_vyrobku_id = skupiny_vyrobkov.id
ORDER BY skupiny_vyrobkov.nazov;
