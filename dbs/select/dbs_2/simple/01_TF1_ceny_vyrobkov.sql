SELECT vyrobky.nazov                                                      AS 'Názov Výrobku',
       mat_na_vyr.cena_materialu                                          AS 'Cena Materiálu [eur]',
       vyrobky.vyr_cena                                                   AS 'Výrobná Cena [eur]',
       mat_na_vyr.cena_materialu + vyrobky.vyr_cena                       AS 'Náklady na Výrobu [eur]',
       vyrobky.pred_cena                                                  AS 'Predajná Cena [eur]',
       vyrobky.pred_cena - (mat_na_vyr.cena_materialu + vyrobky.vyr_cena) AS 'Zisk za Kus [eur]'
FROM vyrobky
         LEFT JOIN
     (SELECT mat_na_vyr.vyrobok_id,
             SUM(mat_na_vyr.mnozstvo * materialy.jed_cena) AS cena_materialu
      FROM materialy
               RIGHT JOIN
           materialy_na_vyrobok AS mat_na_vyr ON materialy.id = mat_na_vyr.material_id
      GROUP BY mat_na_vyr.vyrobok_id
     ) AS mat_na_vyr
     ON vyrobky.id = mat_na_vyr.vyrobok_id
ORDER BY vyrobky.nazov
