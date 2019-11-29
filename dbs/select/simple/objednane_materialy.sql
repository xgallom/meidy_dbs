SELECT obj_mat.datum                       AS 'Datum Dodania',
       part.nazov                          AS 'Dodavatel',
       obj_mat.nazov                       AS 'Material',
       obj_mat.mnozstvo                    AS 'Mnozstvo',
       obj_mat.mer_jed                     AS 'Merna Jednotka',
       obj_mat.jed_cena                    AS 'Jednotkova Cena',
       obj_mat.mnozstvo * obj_mat.jed_cena AS 'Cena Spolu'
FROM partneri AS part
         RIGHT JOIN
     (SELECT obj.datum, obj.partner_id, obj_mat.nazov, obj_mat.mnozstvo, obj_mat.mer_jed, obj_mat.jed_cena
      FROM objednavky AS obj
               RIGHT JOIN
           (SELECT obj_mat.id, mat.nazov, obj_mat.objednavka_id, obj_mat.mnozstvo, mat.mer_jed, mat.jed_cena
            FROM materialy AS mat
                     RIGHT JOIN
                     (SELECT * FROM objednane_materialy) AS obj_mat
                     ON obj_mat.material_id = mat.id
           ) AS obj_mat ON obj_mat.objednavka_id = obj.id
      ORDER BY obj.datum, obj_mat.id)
         AS obj_mat ON obj_mat.partner_id = part.id
