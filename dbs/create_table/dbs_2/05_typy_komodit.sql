CREATE TABLE typy_vyrobkov (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    skupina_vyrobku_id INT(6) UNSIGNED NOT NULL,
    nazov VARCHAR(64) NOT NULL,

    FOREIGN KEY (skupina_vyrobku_id) REFERENCES skupiny_vyrobkov(id)
);

CREATE TABLE typy_materialov (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    skupina_materialu_id INT(6) UNSIGNED NOT NULL,
    nazov VARCHAR(64) NOT NULL,

    FOREIGN KEY (skupina_materialu_id) REFERENCES skupiny_materialov(id)
);
