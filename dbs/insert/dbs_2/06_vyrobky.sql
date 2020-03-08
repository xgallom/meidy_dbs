INSERT INTO skupiny_vyrobkov (nazov)
VALUES ('Tričká a svetre'),
       ('Bundy a kabáty'),
       ('Nohavice'),
       ('Pokrývky hlavy'),
       ('Formálne oblečenie'),
       ('Spodné prádlo');

INSERT INTO typy_vyrobkov (nazov, skupina_vyrobku_id)
VALUES ('Sveter', 1),
       ('Tričko', 2),
       ('Rifle', 3),
       ('Čiapka', 4),
       ('Košeľa', 5),
       ('Ponožky', 6);

INSERT INTO vyrobky (nazov, vyr_cena, pred_cena, typ_vyrobku_id)
VALUES ('Čierny sveter', 1.504, 65.00, 1),
       ('Krátke tričko čierne', 0.333, 28.50, 2),
       ('Slim-fit rifle čierne', 0.000, 00.00, 3),
       ('Regular-fit rifle čierne', 0.000, 00.00, 3),
       ('Zimná čiapka čierna', 0.998, 15.50, 4),
       ('Biela košeľa', 1.252, 39.99, 5),
       ('Čierna košeľa', 2.350, 45.50, 5),
       ('Pikachu ponožky', 0.552, 7.50, 6),
       ('SuperMário ponožky', 0.552, 7.50, 6);
