SELECT dod_listy.datum AS 'Datum Objednania', nazov AS 'Objednavatel'
FROM partneri
         RIGHT JOIN(
    SELECT partner_id, datum
    FROM dodacie_listy
    ORDER BY datum
) AS dod_listy ON dod_listy.partner_id = id
