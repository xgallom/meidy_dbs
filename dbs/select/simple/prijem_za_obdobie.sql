SELECT SUM(vyr.pred_cena * dod_vyr.mnozstvo) AS 'Celkovy Prijem'
FROM vyrobky AS vyr
         RIGHT JOIN
     (SELECT dod_vyr.vyrobok_id, dod_vyr.mnozstvo
      FROM dodacie_listy AS dod_list
               RIGHT JOIN
           (SELECT dodaci_list_id, vyrobok_id, mnozstvo
            FROM dodane_vyrobky) AS dod_vyr ON dod_vyr.dodaci_list_id = dod_list.id
      WHERE dod_list.datum >= '2019-09-01 00:00:00' AND dod_list.datum <= '2019-09-10 23:59:59'
     ) AS dod_vyr ON dod_vyr.vyrobok_id = vyr.id
