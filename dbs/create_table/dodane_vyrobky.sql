CREATE TABLE dodane_vyrobky (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    vyrobok_id INT(6) UNSIGNED NOT NULL,
    dodaci_list_id INT(6) UNSIGNED NOT NULL,
    mnozstvo DECIMAL(5,2) NOT NULL,

    FOREIGN KEY (vyrobok_id) REFERENCES vyrobky(id),
    FOREIGN KEY (dodaci_list_id) REFERENCES dodacie_listy(id)
)
