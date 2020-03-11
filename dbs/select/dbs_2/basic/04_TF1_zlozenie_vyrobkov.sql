SELECT vyrobky.nazov                                       AS 'Názov Výrobku',
       mat_na_vyr.nazov_materialu                          AS 'Materiál na Výrobok',
       mat_na_vyr.mnozstvo_materialu                       AS 'Množstvo Materiálu',
       mat_na_vyr.mer_jed                                  AS 'Merná Jednotka',
       mat_na_vyr.jed_cena                                 AS 'Jednotková Cena [eur]',
       mat_na_vyr.mnozstvo_materialu * mat_na_vyr.jed_cena AS 'Cena Materiálu na Výrobok [eur]'
FROM vyrobky
         RIGHT JOIN
     (SELECT mat_na_vyr.vyrobok_id AS vyrobok_id,
             mat_na_vyr.mnozstvo   AS mnozstvo_materialu,
             materialy.nazov       AS nazov_materialu,
             materialy.mer_jed     AS mer_jed,
             materialy.jed_cena    AS jed_cena
      FROM materialy
               RIGHT JOIN
           materialy_na_vyrobok AS mat_na_vyr
           ON mat_na_vyr.material_id = materialy.id
     ) AS mat_na_vyr
     ON mat_na_vyr.vyrobok_id = vyrobky.id
ORDER BY vyrobky.nazov, mat_na_vyr.nazov_materialu;
