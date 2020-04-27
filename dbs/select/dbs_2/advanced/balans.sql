DROP VIEW IF EXISTS view_balans;

CREATE VIEW view_balans AS
SELECT balans.datum    AS datum,
       part.nazov      AS partner,
       balans.typ      AS typ_pohybu,
       balans.polozka  AS polozka,
       balans.mnozstvo AS mnozstvo,
       balans.mer_jed  AS mer_jed,
       balans.jed_cena AS jed_cena,
       balans.cena     AS cena,
       SUM(balans.zmena_stavu) OVER (ORDER BY balans.datum, balans.id ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
                       AS stav
FROM partneri AS part
         RIGHT JOIN
     (SELECT obj_mat.id                         AS id,
             obj_mat.datum                      AS datum,
             obj_mat.partner_id                 AS partner_id,
             'prijem'                           AS typ,
             mat.nazov                          AS polozka,
             obj_mat.mnozstvo                   AS mnozstvo,
             mat.mer_jed                        AS mer_jed,
             mat.jed_cena                       AS jed_cena,
             mat.jed_cena * obj_mat.mnozstvo    AS cena,
             -(mat.jed_cena * obj_mat.mnozstvo) AS zmena_stavu
      FROM materialy AS mat
               RIGHT JOIN
           (SELECT obj_mat.id,
                   obj.datum,
                   obj.partner_id,
                   obj_mat.material_id,
                   obj_mat.mnozstvo
            FROM objednavky AS obj
                     RIGHT JOIN
                 (SELECT id, objednavka_id, material_id, mnozstvo
                  FROM objednane_materialy
                 ) AS obj_mat ON obj_mat.objednavka_id = obj.id
           ) AS obj_mat ON obj_mat.material_id = mat.id
      UNION ALL
      SELECT dod_vyr.id,
             dod_vyr.datum,
             dod_vyr.partner_id,
             'vydaj',
             vyr.nazov,
             dod_vyr.mnozstvo,
             'ks',
             vyr.pred_cena,
             vyr.pred_cena * dod_vyr.mnozstvo,
             vyr.pred_cena * dod_vyr.mnozstvo
      FROM vyrobky AS vyr
               RIGHT JOIN
           (SELECT dod_vyr.id,
                   dod_list.datum,
                   dod_list.partner_id,
                   dod_vyr.vyrobok_id,
                   dod_vyr.mnozstvo
            FROM dodacie_listy AS dod_list
                     RIGHT JOIN(
                SELECT id, dodaci_list_id, vyrobok_id, mnozstvo
                FROM dodane_vyrobky
            ) AS dod_vyr ON dod_vyr.dodaci_list_id = dod_list.id
           ) AS dod_vyr ON dod_vyr.vyrobok_id = vyr.id
     ) AS balans ON balans.partner_id = part.id
ORDER BY balans.datum, balans.id
