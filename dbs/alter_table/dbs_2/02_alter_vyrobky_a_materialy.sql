ALTER TABLE vyrobky
    ADD COLUMN typ_vyrobku_id INT(6) UNSIGNED NOT NULL,
    ADD FOREIGN KEY (typ_vyrobku_id) REFERENCES typy_vyrobkov(id);

ALTER TABLE materialy
    ADD COLUMN typ_materialu_id INT(6) UNSIGNED NOT NULL,
    ADD FOREIGN KEY (typ_materialu_id) REFERENCES typy_materialov(id);
