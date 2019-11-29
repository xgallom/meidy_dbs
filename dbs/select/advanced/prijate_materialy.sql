SELECT mat.nazov                       AS 'Prijaty Material',
       obj_mat.mnozstvo                AS 'Mnozstvo',
       mat.mer_jed                     AS 'Merna Jednotka',
       mat.jed_cena                    AS 'Jednotkova Cena',
       obj_mat.mnozstvo * mat.jed_cena AS 'Cena Spolu'
FROM materialy AS mat
         RIGHT JOIN
     (SELECT material_id, SUM(mnozstvo) AS mnozstvo
      FROM objednane_materialy
      GROUP BY material_id
     ) AS obj_mat ON obj_mat.material_id = mat.id
