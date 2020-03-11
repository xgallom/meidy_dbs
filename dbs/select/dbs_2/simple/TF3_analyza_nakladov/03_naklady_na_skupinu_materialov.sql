SELECT skupiny_materialov.nazov AS 'Skupina Materiálov',
       obj_mat.naklady          AS 'Náklady na Skupinu Materiálov [eur]'
FROM skupiny_materialov
         RIGHT JOIN
     (SELECT typy_materialov.skupina_materialu_id,
             obj_mat.naklady
      FROM typy_materialov
               RIGHT JOIN
           (SELECT materialy.typ_materialu_id,
                   obj_mat.mnozstvo * materialy.jed_cena AS naklady
            FROM materialy
                     RIGHT JOIN
                 (SELECT material_id, SUM(mnozstvo) AS mnozstvo
                  FROM objednane_materialy
                  GROUP BY material_id) AS obj_mat
                 ON obj_mat.material_id = materialy.id
            GROUP BY materialy.typ_materialu_id) AS obj_mat
           ON obj_mat.typ_materialu_id = typy_materialov.id
      GROUP BY skupina_materialu_id) AS obj_mat
     ON obj_mat.skupina_materialu_id = skupiny_materialov.id
ORDER BY nazov;
