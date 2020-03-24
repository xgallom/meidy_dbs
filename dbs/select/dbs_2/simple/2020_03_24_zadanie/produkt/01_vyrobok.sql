SELECT dod_vyr.nazov                    AS 'Výrobok',
       dod_vyr.mnozstvo                 AS 'Množstvo Výrobku [ks]',
       dod_vyr.naklady                  AS 'Náklady na Výrobky [eur]',
       dod_vyr.prijmy                   AS 'Príjmy za Výrobky [eur]',
       dod_vyr.prijmy - dod_vyr.naklady AS 'Zisky z Výrobkov [eur]'
FROM (SELECT dod_vyr.nazov,
             SUM((dod_vyr.vyr_cena + mat_na_vyr.cena_materialu) * dod_vyr.mnozstvo) AS naklady,
             SUM(dod_vyr.pred_cena * dod_vyr.mnozstvo)                              AS prijmy,
             SUM(dod_vyr.mnozstvo)                                                  AS mnozstvo
      FROM (SELECT dod_vyr.vyrobok_id,
                   vyr.nazov,
                   vyr.vyr_cena,
                   vyr.pred_cena,
                   dod_vyr.mnozstvo
            FROM vyrobky AS vyr
                     RIGHT JOIN
                 (SELECT vyrobok_id, dodaci_list_id, mnozstvo
                  FROM dodane_vyrobky
                 ) AS dod_vyr
                 ON vyr.id = dod_vyr.vyrobok_id
           ) AS dod_vyr
               LEFT JOIN
           (SELECT mat_na_vyr.vyrobok_id,
                   SUM(mat.jed_cena * mat_na_vyr.mnozstvo) AS cena_materialu
            FROM materialy AS mat
                     RIGHT JOIN
                 materialy_na_vyrobok AS mat_na_vyr ON mat.id = mat_na_vyr.material_id
            GROUP BY mat_na_vyr.vyrobok_id
           ) AS mat_na_vyr
           ON dod_vyr.vyrobok_id = mat_na_vyr.vyrobok_id
      GROUP BY dod_vyr.vyrobok_id
     ) AS dod_vyr
ORDER BY dod_vyr.nazov
