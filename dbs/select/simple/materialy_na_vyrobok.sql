SELECT 
    vyr.nazov AS 'Vyrobok',
    mat.nazov AS 'Material',
    mat_na_vyr.mnozstvo_materialu AS 'Mnozstvo Materialu',
    mat.mer_jed AS 'Merna Jednotka',
    mat.jed_cena AS 'Jednotkova Cena',
    mat.jed_cena * mat_na_vyr.mnozstvo_materialu AS 'Cena'
FROM 
    materialy_na_vyrobok AS mat_na_vyr, 
    materialy AS mat, 
    vyrobky AS vyr
WHERE
    mat_na_vyr.material_id = mat.id AND
    mat_na_vyr.vyrobok_id = vyr.id
ORDER BY
    mat_na_vyr.vyrobok_id ASC, 
    mat_na_vyr.material_id ASC