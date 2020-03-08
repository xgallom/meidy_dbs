-- Okej prvy zlozitejsi SELECT, vyzera to desivo ale je to najebane komentarmi po povalu tak by to malo pomoct :D

-- Kedze WHERE id = id robi kombinacie vsetkych riadkov tabuliek,
-- pri velkom pocte moznych kombinacii je to zbytocna zataz na databazu,
-- a pouzije sa JOIN (to su tie mnozinove picoviny co som kreslil na tabulu raz)

-- !!! Dolezite: RIGHT JOIN sa vyhodnocuje z prava dolava (preto sa to vola RIGHT join :DDD) !!!

-- Kazde cislo 1 - 3 oznacuje jeden samostatny select ktory pracuje s tym predchadzajucim
-- Preto to vyzera zlozito ale je to iba vrstvenie toho co uz existuje
-- Zacni u komentu (1.) - riadok 36

-- 3. Mame skombinovane vyrobok, material, aj materialy_na_vyrobok.
--    Teraz uz len vyberieme od vsade co chceme a dame tomu zmysluplne nazvy
SELECT vyrobky.nazov                                       AS 'Názov Výrobku',
       -- Tu pristupujeme do tej RIGHT JOINnutej zatvorkovej sub-tabulky
       mat_na_vyr.nazov_materialu                          AS 'Materiál na Výrobok',
       mat_na_vyr.mnozstvo_materialu                       AS 'Množstvo Materiálu',
       mat_na_vyr.mer_jed                                  AS 'Merná Jednotka',
       mat_na_vyr.jed_cena                                 AS 'Jednotková Cena [eur]',
       -- mnozstvo_materialu * jed_cena je celkova cena, * znamena nasobenie
       mat_na_vyr.mnozstvo_materialu * mat_na_vyr.jed_cena AS 'Cena Materiálu na Výrobok [eur]'
-- 3. Priradime k vnutornej tabulke vyrobok uplne identicky ako sme to spravili s materialom
FROM vyrobky
         RIGHT JOIN

     (
         -- 2. Teraz si vezmeme von zo zatvoriek vsetko co potrebujeme z materialov aj z materialy_na_vyrobok
         --    Tu uz k vnutornej tabulke pristujeme cez ten alias mat_na_vyr
         --    Z mat_na_vyr uz neberieme material_id lebo ten uz sme pouzili na priradenie materialu a je nam na nic
         --    vyrobok_id stale potrebujeme lebo musime este vonku priradit vyrobok aby sme ziskali jeho nazov - riadok 43
         SELECT mat_na_vyr.vyrobok_id AS vyrobok_id,
                mat_na_vyr.mnozstvo   AS mnozstvo_materialu,
                materialy.nazov       AS nazov_materialu,
                materialy.mer_jed     AS mer_jed,
                materialy.jed_cena    AS jed_cena
                -- 2. Priradime k nim material podla `materialy RIGHT JOIN mat_na_vyr ON podmienka na priradenie`
         FROM materialy
                  RIGHT JOIN
              -- 1. Zoberieme vsetky riadky a stlpce z materialy_na_vyrobok a dame jej prezyvku mat_na_vyr
                  materialy_na_vyrobok AS mat_na_Vyr
                  -- 2. Priradime k nim material podla `materialy RIGHT JOIN mat_na_vyr ON podmienka na priradenie`
              ON mat_na_vyr.material_id = materialy.id -- tak aby zapadli do seba id-cka (ta ista podmienka ako u WHERE)
         -- Po tom vyhodnotime zatvorky - riadok 23-41
     ) AS mat_na_vyr
         -- 2. Zatvorky nad nami reprezentuju samostatnu tabulku. (zatvorky maju prednost ako v matematike)
         --    Kedze je pred nimi RIGHT JOIN spajame ju s tou co je na lavo (vyrobky)
         --    Jedna sa o identicky princip RIGHT JOINU ako vo vnutri zatvoriek, akurat ze uz mame na pravo
         --    zlozenu tabulku ktora obsahuje aj data z tabulky materialy. Dame jej znova ten isty alias mat_na_vyr,
         --    a tym padom sa k nej mimo zatvoriek pristupuje cez ten. Mohli sme ju nazvat aj hociako inak a
         --    vnutro by sa nezmenilo, ale tu uz by sa musela nazyvat novym aliasom

         -- 3. Vyrobky priradujeme podla toho kedy zapadnu id-cka (ta ista podmienka ako u WHERE)
     ON mat_na_vyr.vyrobok_id = vyrobky.id

-- Zoradime podla nazvu vyrobku a v ramci jedneho vyrobku potom podla nazvu materialu
ORDER BY vyrobky.nazov, mat_na_vyr.nazov_materialu;


-- -----------------------------------------------------------------------------------------------------
-- Ak by ta to prilis zmiatlo a dojebalo tu je identicky SELECT ale bez komentarov (ten mozes odovzdat):

SELECT vyrobky.nazov                                       AS 'Názov Výrobku',
       mat_na_vyr.nazov_materialu                          AS 'Materiál na Výrobok',
       mat_na_vyr.mnozstvo_materialu                       AS 'Množstvo Materiálu',
       mat_na_vyr.mer_jed                                  AS 'Merná Jednotka',
       mat_na_vyr.jed_cena                                 AS 'Jednotková Cena [eur]',
       mat_na_vyr.mnozstvo_materialu * mat_na_vyr.jed_cena AS 'Cena Materiálu na Výrobok [eur]'
FROM vyrobky
         RIGHT JOIN
     (SELECT mat_na_vyr.vyrobok_id AS vyrobok_id,
             mat_na_vyr.mnozstvo   AS mnozstvo_materialu,
             materialy.nazov       AS nazov_materialu,
             materialy.mer_jed     AS mer_jed,
             materialy.jed_cena    AS jed_cena
      FROM materialy
               RIGHT JOIN
           materialy_na_vyrobok AS mat_na_Vyr
           ON mat_na_vyr.material_id = materialy.id
     ) AS mat_na_vyr
     ON mat_na_vyr.vyrobok_id = vyrobky.id
ORDER BY vyrobky.nazov, mat_na_vyr.nazov_materialu;
