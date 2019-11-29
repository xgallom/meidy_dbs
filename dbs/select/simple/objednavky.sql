SELECT objed.datum AS 'Datum Dodania', nazov AS 'Dodavatel'
FROM partneri
         RIGHT JOIN(
    SELECT partner_id, datum
    FROM objednavky
    ORDER BY datum
) AS objed ON objed.partner_id = id
