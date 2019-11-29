SELECT mat.nazov                                          AS 'Material',
       obj_mat_mnozstvo                                   AS 'Prijaty Material',
       spotr_mnozstvo                                     AS 'Spotrebovany Material',
       obj_mat_mnozstvo - spotr_mnozstvo                  AS 'Stav Materialu',
       mat.mer_jed                                        AS 'Merna Jednotka',
       mat.jed_cena                                       AS 'Jednotkova Cena',
       (obj_mat_mnozstvo - spotr_mnozstvo) * mat.jed_cena AS 'Cena Stavu'
FROM materialy AS mat
         RIGHT JOIN
     (SELECT obj_mat.material_id, obj_mat.mnozstvo AS obj_mat_mnozstvo, spotr.mnozstvo AS spotr_mnozstvo
      FROM (SELECT material_id, SUM(mnozstvo) AS mnozstvo
            FROM objednane_materialy
            GROUP BY material_id
           ) AS obj_mat
               RIGHT JOIN
           (SELECT mat_na_vyr.material_id, SUM(mat_na_vyr.mnozstvo * vyprod.mnozstvo) AS mnozstvo
            FROM (SELECT * FROM materialy_na_vyrobok) AS mat_na_vyr,
                 (SELECT vyrobok_id, mnozstvo FROM vyprodukovane) AS vyprod
            WHERE vyprod.vyrobok_id = mat_na_vyr.vyrobok_id
            GROUP BY mat_na_vyr.material_id
           ) AS spotr ON spotr.material_id = obj_mat.material_id
     ) AS stav_mat ON stav_mat.material_id = mat.id