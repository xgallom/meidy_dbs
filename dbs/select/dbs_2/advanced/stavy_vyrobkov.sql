SELECT vyr.nazov                         AS 'Názov Výrobku',
       stav_vyr.mnozstvo                 AS 'Množstvo Výrobkov na Sklade [ks]',
       vyr.pred_cena                     AS 'Predajná Cena [eur]',
       stav_vyr.mnozstvo * vyr.pred_cena AS 'Cena Výrobkov na Sklade [eur]'
FROM vyrobky AS vyr
         LEFT JOIN
     (SELECT stav_vyr.vyrobok_id    AS vyrobok_id,
             SUM(stav_vyr.mnozstvo) AS mnozstvo
      FROM (
               SELECT vyp.vyrobok_id AS vyrobok_id,
                      vyp.mnozstvo   AS mnozstvo
               FROM vyprodukovane AS vyp

               UNION ALL

               SELECT dod_vyr.vyrobok_id AS vyrobok_id,
                      -dod_vyr.mnozstvo  AS mnozstvo
               FROM dodane_vyrobky AS dod_vyr
           ) AS stav_vyr
      GROUP BY stav_vyr.vyrobok_id
     ) AS stav_vyr
     ON vyr.id = stav_vyr.vyrobok_id
ORDER BY vyr.nazov
