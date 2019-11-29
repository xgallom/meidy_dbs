CREATE TABLE vyprodukovane (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    vyrobok_id INT(6) UNSIGNED NOT NULL,
    mnozstvo DECIMAL(5,2) NOT NULL,

    FOREIGN KEY (vyrobok_id) REFERENCES vyrobky(id)
)