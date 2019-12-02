SELECT dod_listy.id    AS 'Identifikacne Cislo',
       dod_listy.datum AS 'Datum Objednania',
       part.nazov      AS 'Objednavatel'
FROM partneri AS part
         RIGHT JOIN(
    SELECT id, partner_id, datum
    FROM dodacie_listy
    ORDER BY datum
) AS dod_listy ON dod_listy.partner_id = part.id
