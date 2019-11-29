CREATE TABLE materialy_na_vyrobok (
    vyrobok_id INT(6) UNSIGNED NOT NULL,
    material_id INT(6) UNSIGNED NOT NULL,
    mnozstvo_materialu DECIMAL(5,2),
    
    FOREIGN KEY (vyrobok_id) REFERENCES vyrobky(id),
    FOREIGN KEY (material_id) REFERENCES materialy(id)
)
