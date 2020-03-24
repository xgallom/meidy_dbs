SELECT mat.nazov                        AS 'Názov Materiálu',
       stav_mat.mnozstvo                AS 'Množstvo Materiálu na Sklade',
       mat.mer_jed                      AS 'Merná Jednotka',
       mat.jed_cena                     AS 'Jednotková Cena [eur]',
       mat.jed_cena * stav_mat.mnozstvo AS 'Cena Materiálu na Sklade [eur]'
FROM materialy AS mat
         LEFT JOIN
     (SELECT stav_mat.material_id   AS material_id,
             SUM(stav_mat.mnozstvo) AS mnozstvo
      FROM (
               SELECT obj_mat.material_id AS material_id,
                      obj_mat.mnozstvo    AS mnozstvo
               FROM objednane_materialy AS obj_mat

               UNION ALL

               SELECT mat_na_vyr.material_id              AS material_id,
                      -mat_na_vyr.mnozstvo * vyp.mnozstvo AS mnozstvo
               FROM materialy_na_vyrobok AS mat_na_vyr
                        RIGHT JOIN vyprodukovane AS vyp
                                   on mat_na_vyr.vyrobok_id = vyp.vyrobok_id
           ) AS stav_mat
      GROUP BY stav_mat.material_id
     ) AS stav_mat
     ON mat.id = stav_mat.material_id
ORDER BY mat.nazov
