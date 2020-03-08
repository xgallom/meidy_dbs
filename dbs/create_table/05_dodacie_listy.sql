CREATE TABLE dodacie_listy (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    partner_id INT(6) UNSIGNED,
    datum DATETIME NOT NULL,

    FOREIGN KEY (partner_id) REFERENCES partneri(id)
);
