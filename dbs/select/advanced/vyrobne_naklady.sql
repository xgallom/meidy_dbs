SELECT vyr.nazov                                                  AS 'Vyrobok',
       mat_na_vyr.cena_materialu                                  AS 'Cena Materialu',
       vyr.vyr_cena                                               AS 'Vyrobna Cena',
       mat_na_vyr.cena_materialu + vyr.vyr_cena                   AS 'Naklady na Vyrobu',
       vyr.pred_cena                                              AS 'Predajna Cena',
       vyr.pred_cena - (mat_na_vyr.cena_materialu + vyr.vyr_cena) AS 'Zisk za Kus'
FROM vyrobky AS vyr
         RIGHT JOIN
     (SELECT mat_na_vyr.vyrobok_id,
             SUM(mat.jed_cena * mat_na_vyr.mnozstvo) AS cena_materialu
      FROM materialy AS mat
               RIGHT JOIN
               (SELECT * FROM materialy_na_vyrobok AS mat_na_vyr ORDER BY vyrobok_id)
               AS mat_na_vyr ON mat_na_vyr.material_id = mat.id
      GROUP BY mat_na_vyr.vyrobok_id)
         AS mat_na_vyr ON mat_na_vyr.vyrobok_id = vyr.id
