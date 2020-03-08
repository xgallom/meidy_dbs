INSERT INTO skupiny_materialov (nazov)
VALUES ('Tkanivo'),
       ('Polotovary'),
       ('Hrubý materiál');

INSERT INTO typy_materialov (nazov, skupina_materialu_id)
VALUES ('Hrubá látka', 1),
       ('Tenká látka', 1),
       ('Riflovina', 1),
       ('Gombík', 2),
       ('Zips', 2),
       ('Guma', 3);

INSERT INTO materialy (nazov, jed_cena, mer_jed, typ_materialu_id)
VALUES ('Čierna hrubá látka', 0.50, 'm2', 1),
       ('Čierna tenká látka', 0.75, 'm2', 2),
       ('Obyčajná riflovina', 1.00, 'm2', 3),
       ('Malý gombík', 0.05, 'ks', 4),
       ('Lacný zips', 1.25, 'm', 5),
       ('Pružná guma', 0.25, 'm', 6);
