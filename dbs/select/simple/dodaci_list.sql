SELECT dod_vyr.datum                    AS 'Datum Objednania',
       dod_vyr.nazov_partnera           AS 'Partner',
       vyr.nazov                        AS 'Vyrobok',
       dod_vyr.mnozstvo                 AS 'Mnozstvo',
       vyr.pred_cena                    AS 'Predajna Cena',
       dod_vyr.mnozstvo * vyr.pred_cena AS 'Celkova Cena'
FROM vyrobky AS vyr
         RIGHT JOIN
     (SELECT dod_vyr.datum,
             dod_vyr.vyrobok_id,
             dod_vyr.mnozstvo,
             part.nazov AS nazov_partnera
      FROM partneri AS part
               RIGHT JOIN
           (SELECT dod_list.partner_id, dod_list.datum, dod_vyr.vyrobok_id, dod_vyr.mnozstvo
            FROM dodane_vyrobky AS dod_vyr
                     RIGHT JOIN
                 (SELECT id, partner_id, datum
                  FROM dodacie_listy
                  WHERE id = 1
                 ) AS dod_list ON dod_list.id = dod_vyr.dodaci_list_id
           ) AS dod_vyr ON dod_vyr.partner_id = part.id
     ) AS dod_vyr ON dod_vyr.vyrobok_id = vyr.id
