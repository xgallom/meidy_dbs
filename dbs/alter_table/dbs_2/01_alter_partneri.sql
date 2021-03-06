ALTER TABLE partneri
    ADD COLUMN adresa   VARCHAR(64)     NOT NULL,
    ADD COLUMN mesto_id INT(6) UNSIGNED NOT NULL,
    ADD COLUMN ico CHAR(8) NOT NULL,
    ADD COLUMN dic CHAR(10) NOT NULL,
    ADD FOREIGN KEY (mesto_id) REFERENCES mesta(id),
    DROP COLUMN mesto,
    DROP COLUMN okres,
    DROP COLUMN ulica,
    DROP COLUMN psc;
