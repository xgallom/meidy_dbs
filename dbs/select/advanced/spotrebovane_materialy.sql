SELECT mat.nazov                     AS 'Material',
       spotr.mnozstvo                AS 'Spotrebovane Mnozstvo',
       mat.mer_jed                   AS 'Merna Jednotka',
       mat.jed_cena                  AS 'Jednotkova Cena',
       spotr.mnozstvo * mat.jed_cena AS 'Cena Spolu'
FROM materialy AS mat
         RIGHT JOIN
     (SELECT mat_na_vyr.material_id, SUM(mat_na_vyr.mnozstvo * vyprod.mnozstvo) AS mnozstvo
      FROM (SELECT * FROM materialy_na_vyrobok) AS mat_na_vyr,
           (SELECT vyrobok_id, mnozstvo FROM vyprodukovane) AS vyprod
      WHERE vyprod.vyrobok_id = mat_na_vyr.vyrobok_id
      GROUP BY mat_na_vyr.material_id
     ) AS spotr ON spotr.material_id = mat.id
