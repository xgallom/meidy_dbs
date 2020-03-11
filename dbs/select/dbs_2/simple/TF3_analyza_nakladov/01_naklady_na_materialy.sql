SELECT materialy.nazov                       AS 'Názov Výrobku',
       obj_mat.mnozstvo                      AS 'Množstvo Predaného Výrobku',
       materialy.mer_jed                     AS 'Merná Jednotka',
       materialy.jed_cena                    AS 'Jednotková Cena [eur]',
       obj_mat.mnozstvo * materialy.jed_cena AS 'Náklady na Materiál [eur]'
FROM materialy
         RIGHT JOIN
     (SELECT material_id, SUM(mnozstvo) AS mnozstvo
      FROM objednane_materialy
      GROUP BY material_id) AS obj_mat
     ON obj_mat.material_id = materialy.id
ORDER BY materialy.nazov;
