SELECT dod_vyr.datum    AS 'Datum Objednania',
       part.nazov       AS 'Objednavatel',
       dod_vyr.nazov    AS 'Vyrobok',
       dod_vyr.mnozstvo AS 'Mnozstvo',
       dod_vyr.pred_cena AS 'Predajna Cena',
       dod_vyr.mnozstvo * dod_vyr.pred_cena AS 'Cena Spolu'
FROM partneri AS part
         RIGHT JOIN
     (SELECT dod_list.datum,
             dod_list.partner_id,
             dod_vyr.nazov,
             dod_vyr.mnozstvo,
             dod_vyr.pred_cena
      FROM dodacie_listy AS dod_list
               RIGHT JOIN
           (SELECT dod_vyr.id, vyr.nazov, dod_vyr.dodaci_list_id, dod_vyr.mnozstvo, vyr.pred_cena
            FROM vyrobky AS vyr
                     RIGHT JOIN
                     (SELECT * FROM dodane_vyrobky) AS dod_vyr
                     ON dod_vyr.vyrobok_id = vyr.id
           ) AS dod_vyr ON dod_vyr.dodaci_list_id = dod_list.id
      ORDER BY dod_list.datum, dod_vyr.id)
         AS dod_vyr ON dod_vyr.partner_id = part.id
