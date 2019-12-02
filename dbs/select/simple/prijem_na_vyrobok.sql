SELECT vyr.nazov AS 'Vyrobok', SUM(vyr.pred_cena * dod_vyr.mnozstvo) AS 'Prijem na Vyrobok'
FROM vyrobky AS vyr
         RIGHT JOIN
     (SELECT vyrobok_id, mnozstvo
      FROM dodane_vyrobky) AS dod_vyr ON dod_vyr.vyrobok_id = vyr.id
GROUP BY dod_vyr.vyrobok_id
