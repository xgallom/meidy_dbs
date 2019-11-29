SELECT vyprod.datum, vyr.nazov, vyprod.mnozstvo
FROM vyrobky AS vyr
         RIGHT JOIN
     (SELECT vyrobok_id, mnozstvo, datum
      FROM vyprodukovane
      ORDER BY datum, id
     )
         AS vyprod ON vyprod.vyrobok_id = vyr.id
