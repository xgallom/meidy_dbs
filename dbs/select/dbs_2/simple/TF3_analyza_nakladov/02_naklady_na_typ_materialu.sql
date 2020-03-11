SELECT typy_materialov.nazov AS 'Typ Materiálu',
       obj_mat.naklady       AS 'Náklady na Typ Materiálu [eur]'
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

ORDER BY nazov;
