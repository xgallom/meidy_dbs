CREATE TABLE objednane_materialy (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    material_id INT(6) UNSIGNED NOT NULL,
    objednavka_id INT(6) UNSIGNED NOT NULL,
    mnozstvo DECIMAL(6,2) NOT NULL,

    FOREIGN KEY (material_id) REFERENCES materialy(id),
    FOREIGN KEY (objednavka_id) REFERENCES objednavky(id)
)
