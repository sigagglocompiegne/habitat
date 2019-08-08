/*Habitat/
/*Creation des vues applicatives stockées dans le schéma x_apps */
/* habitat_61_vues_xapps.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet */

-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                 VUE APPLICATIVE                                                         ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


  -- View: x_apps.xapps_geo_v_hab_indigne

-- DROP VIEW x_apps.xapps_geo_v_hab_indigne;


-- VUE affichant l'ensemble des adresses avec les informations de signalements pour celles qui en disposent
-- affichage dans la carte sur GEO
-- filtré sur les communes de l'ARC
-- Calcul le nombre de signalement par adresse
CREATE OR REPLACE VIEW x_apps.xapps_geo_v_hab_indigne AS 
 WITH req_ad AS (
         SELECT a.id_adresse,
            a.commune,
            a.libvoie_c,
            a.numero,
            a.repet,
            (((((((a.numero::text ||
                CASE
                    WHEN a.repet IS NOT NULL OR a.repet::text <> ''::text THEN a.repet
                    ELSE ''::character varying
                END::text) || ' '::text) || a.libvoie_c::text) ||
                CASE
                    WHEN a.complement IS NULL OR a.complement::text = ''::text THEN ''::text
                    ELSE chr(10) || a.complement::text
                END) || chr(10)) || ' ' || a.codepostal::text) || ' '::text) || a.commune::text AS adresse,
            a.mot_dir,
            a.libvoie_a,
            a.geom
           FROM x_apps.xapps_geo_vmr_adresse a
          WHERE a.insee = '60023'::bpchar OR a.insee = '60067'::bpchar OR a.insee = '60068'::bpchar OR a.insee = '60070'::bpchar OR a.insee = '60151'::bpchar OR a.insee = '60156'::bpchar OR a.insee = '60159'::bpchar OR a.insee = '60323'::bpchar OR a.insee = '60325'::bpchar OR a.insee = '60326'::bpchar OR a.insee = '60337'::bpchar OR a.insee = '60338'::bpchar OR a.insee = '60382'::bpchar OR a.insee = '60402'::bpchar OR a.insee = '60447'::bpchar OR a.insee = '60578'::bpchar OR a.insee = '60579'::bpchar OR a.insee = '60597'::bpchar OR a.insee = '60600'::bpchar OR a.insee = '60665'::bpchar OR a.insee = '60667'::bpchar OR a.insee = '60674'::bpchar
        ), req_sign AS (
         SELECT s_1.id_adresse,
            count(*) AS nb_sign
           FROM m_habitat.an_hab_indigne_sign s_1
          GROUP BY s_1.id_adresse
        ), req_signdate AS (
         SELECT DISTINCT a.id_adresse,
            a.q_init,
            a.d_signal
           FROM m_habitat.an_hab_indigne_sign a
             JOIN ( SELECT an_hab_indigne_sign.id_adresse,
                    max(an_hab_indigne_sign.d_signal) AS d_signal
                   FROM m_habitat.an_hab_indigne_sign
                  GROUP BY an_hab_indigne_sign.id_adresse) b_1 ON a.id_adresse = b_1.id_adresse AND a.d_signal = b_1.d_signal
        ), req_cptencours AS (
		SELECT id_adresse ,count(*) as nbdos_encours
		FROM m_habitat.an_hab_indigne_sign
		WHERE cloture is false GROUP BY id_adresse
	), req_cpteclos AS (
		SELECT id_adresse, count(*) as nbdos_clos
		FROM m_habitat.an_hab_indigne_sign
		WHERE cloture is true GROUP BY id_adresse
	)
	
 SELECT row_number() OVER () AS gid,
    b.id_adresse,
    b.commune,
    b.libvoie_c,
    b.libvoie_a,
    b.numero,
    b.repet,
    b.adresse,
    b.mot_dir,
        CASE
            WHEN s.nb_sign IS NULL THEN 0::bigint
            ELSE s.nb_sign
        END AS nb_sign,
    sd.q_init,
    sd.d_signal,
    CASE 
	WHEN dec.nbdos_encours > 0 THEN dec.nbdos_encours
	ELSE 0 END AS nbdos_encours,
    CASE 
	WHEN dc.nbdos_clos > 0 THEN dc.nbdos_clos
	ELSE 0 END AS nbdos_clos,
    b.geom
   FROM req_ad b
     LEFT JOIN req_sign s ON b.id_adresse = s.id_adresse
     LEFT JOIN req_signdate sd ON b.id_adresse = sd.id_adresse
     LEFT JOIN req_cptencours dec ON dec.id_adresse = b.id_adresse
     LEFT JOIN req_cpteclos dc ON dc.id_adresse = b.id_adresse
  ORDER BY b.numero::integer;


COMMENT ON VIEW x_apps.xapps_geo_v_hab_indigne
  IS 'Vue applicative récupérant le nombre de dossier d''habitat indigne par adresse et affichant l''état du dernier signalement pour affichage dans GEO';


-- View: x_apps.xapps_geo_v_hab_indigne_delais

-- DROP VIEW x_apps.xapps_geo_v_hab_indigne_delais;


CREATE OR REPLACE VIEW x_apps.xapps_geo_v_hab_indigne_delais AS 
 WITH req_ad AS (
         SELECT a.id_adresse,
            a.geom
           FROM x_apps.xapps_geo_vmr_adresse a
          WHERE a.insee = '60023'::bpchar OR a.insee = '60067'::bpchar OR a.insee = '60068'::bpchar OR a.insee = '60070'::bpchar OR a.insee = '60151'::bpchar OR a.insee = '60156'::bpchar OR a.insee = '60159'::bpchar OR a.insee = '60323'::bpchar OR a.insee = '60325'::bpchar OR a.insee = '60326'::bpchar OR a.insee = '60337'::bpchar OR a.insee = '60338'::bpchar OR a.insee = '60382'::bpchar OR a.insee = '60402'::bpchar OR a.insee = '60447'::bpchar OR a.insee = '60578'::bpchar OR a.insee = '60579'::bpchar OR a.insee = '60597'::bpchar OR a.insee = '60600'::bpchar OR a.insee = '60665'::bpchar OR a.insee = '60667'::bpchar OR a.insee = '60674'::bpchar
        ), req_sign AS (
         SELECT s_1.id_adresse,
            count(*) AS nb_depasse,
            s_1.id_dos
           FROM m_habitat.an_hab_indigne_sign s_1
           WHERE cloture is false AND d_pdelais IS NOT NULL AND d_pdelais < now()
          GROUP BY s_1.id_adresse,s_1.id_dos
        )
	
 SELECT row_number() OVER () AS gid,
    b.id_adresse,
    s.nb_depasse,
    s.id_dos,
    b.geom
   FROM req_ad b
     LEFT JOIN req_sign s ON b.id_adresse = s.id_adresse
   WHERE
   s.nb_depasse >=1;


COMMENT ON VIEW x_apps.xapps_geo_v_hab_indigne_delais
  IS 'Vue applicative sélectionnant les adresses sur lesquellesla date du prochain délais est supérieur à la date du jour pour affichage dans GEO';


-- VUE TABLEAU DE BORD

-- View: x_apps.xapps_an_v_hab_indigne_tb1

-- DROP VIEW x_apps.xapps_an_v_hab_indigne_tb1;


CREATE OR REPLACE VIEW x_apps.xapps_an_v_hab_indigne_tb1 AS 
WITH
req_complete AS
(
WITH
req_com AS
(
SELECT DISTINCT
	a.insee,
        a.commune
FROM
        x_apps.xapps_geo_vmr_adresse a
WHERE   (a.insee = '60023' or a.insee = '60067' or a.insee = '60068' or a.insee = '60070' or a.insee = '60151' or a.insee = '60156' or a.insee = '60159' or a.insee = '60323' or a.insee = '60325'
        or a.insee = '60326' or a.insee = '60337' or a.insee = '60338' or a.insee = '60382' or a.insee = '60402' or a.insee = '60447' or a.insee = '60578' or a.insee = '60579' or a.insee = '60597'
        or a.insee = '60600' or a.insee = '60665' or a.insee = '60667' or a.insee = '60674')
ORDER BY a.commune
),
req_tot AS
(
SELECT
	a.insee,
        count(*) as nb_dos_ouvert

FROM
	m_habitat.an_hab_indigne_sign s
	LEFT JOIN x_apps.xapps_geo_vmr_adresse a ON a.id_adresse = s.id_adresse
	
WHERE 
	cloture is FALSE
GROUP BY a.insee
),
req_q10 AS
(
SELECT
	a.insee,
        count(*) as nb_dos_10

FROM
	m_habitat.an_hab_indigne_sign s
	LEFT JOIN x_apps.xapps_geo_vmr_adresse a ON a.id_adresse = s.id_adresse
	
WHERE 
	s.cloture is FALSE AND s.q_init='10'
GROUP BY a.insee
),
req_q20 AS
(
SELECT
	a.insee,
        count(*) as nb_dos_20

FROM
	m_habitat.an_hab_indigne_sign s
	LEFT JOIN x_apps.xapps_geo_vmr_adresse a ON a.id_adresse = s.id_adresse
	
WHERE 
	s.cloture is FALSE AND s.q_init='20'
GROUP BY a.insee
),
req_q30 AS
(
SELECT
	a.insee,
        count(*) as nb_dos_30

FROM
	m_habitat.an_hab_indigne_sign s
	LEFT JOIN x_apps.xapps_geo_vmr_adresse a ON a.id_adresse = s.id_adresse
	
WHERE 
	s.cloture is FALSE AND s.q_init='30'
GROUP BY a.insee
),
req_q40 AS
(
SELECT
	a.insee,
        count(*) as nb_dos_40

FROM
	m_habitat.an_hab_indigne_sign s
	LEFT JOIN x_apps.xapps_geo_vmr_adresse a ON a.id_adresse = s.id_adresse
	
WHERE 
	s.cloture is FALSE AND s.q_init='40'
GROUP BY a.insee
),
req_q50 AS
(
SELECT
	a.insee,
        count(*) as nb_dos_50

FROM
	m_habitat.an_hab_indigne_sign s
	LEFT JOIN x_apps.xapps_geo_vmr_adresse a ON a.id_adresse = s.id_adresse
	
WHERE 
	s.cloture is FALSE AND s.q_init='50'
GROUP BY a.insee
),
req_q60 AS
(
SELECT
	a.insee,
        count(*) as nb_dos_60

FROM
	m_habitat.an_hab_indigne_sign s
	LEFT JOIN x_apps.xapps_geo_vmr_adresse a ON a.id_adresse = s.id_adresse
	
WHERE 
	s.cloture is FALSE AND s.q_init='60'
GROUP BY a.insee
),
req_q00 AS
(
SELECT
	a.insee,
        count(*) as nb_dos_00

FROM
	m_habitat.an_hab_indigne_sign s
	LEFT JOIN x_apps.xapps_geo_vmr_adresse a ON a.id_adresse = s.id_adresse
	
WHERE 
	s.cloture is FALSE AND s.q_init='00'
GROUP BY a.insee
)
SELECT row_number() OVER () AS id,
            
            string_agg(('<tr><td align=right>&nbsp;' || c.commune || '&nbsp;</td><td align=center>'::text ||
                CASE
                    WHEN t.nb_dos_ouvert IS NOT NULL THEN t.nb_dos_ouvert
                    ELSE 0::bigint::numeric
                END) || '</td>'::text, ''::text) || string_agg(('<td align=center>'::text ||
                CASE
                    WHEN q10.nb_dos_10 IS NOT NULL THEN q10.nb_dos_10
                    ELSE 0::bigint::numeric
                END) || '</td>'::text, ''::text) || string_agg(('<td align=center>'::text ||
		CASE
                    WHEN q20.nb_dos_20 IS NOT NULL THEN q20.nb_dos_20
                    ELSE 0::bigint::numeric
                END) || '</td>'::text, ''::text) || string_agg(('<td align=center>'::text ||
		CASE
                    WHEN q30.nb_dos_30 IS NOT NULL THEN q30.nb_dos_30
                    ELSE 0::bigint::numeric
                END) || '</td>'::text, ''::text) || string_agg(('<td align=center>'::text ||
		CASE
                    WHEN q40.nb_dos_40 IS NOT NULL THEN q40.nb_dos_40
                    ELSE 0::bigint::numeric
                END) || '</td>'::text, ''::text) || string_agg(('<td align=center>'::text ||
		CASE
                    WHEN q50.nb_dos_50 IS NOT NULL THEN q50.nb_dos_50
                    ELSE 0::bigint::numeric
                END) || '</td>'::text, ''::text) || string_agg(('<td align=center>'::text ||
		CASE
                    WHEN q60.nb_dos_60 IS NOT NULL THEN q60.nb_dos_60
                    ELSE 0::bigint::numeric
                END) || '</td>'::text, ''::text) || string_agg(('<td align=center>'::text ||
                CASE
                    WHEN q00.nb_dos_00 IS NOT NULL THEN q00.nb_dos_00
                    ELSE 0::bigint::numeric
                END) || '</td>'::text, ''::text) || '</tr>'::text AS tableau1


FROM req_com c
JOIN req_tot t ON c.insee = t.insee
LEFT JOIN req_q10 q10 ON c.insee = q10.insee
LEFT JOIN req_q20 q20 ON c.insee = q20.insee
LEFT JOIN req_q30 q30 ON c.insee = q30.insee
LEFT JOIN req_q40 q40 ON c.insee = q40.insee
LEFT JOIN req_q50 q50 ON c.insee = q50.insee
LEFT JOIN req_q60 q60 ON c.insee = q60.insee
LEFT JOIN req_q00 q00 ON c.insee = q00.insee
GROUP BY c.commune ORDER BY c.commune
)
SELECT
row_number() OVER () AS id,
'<table border=1 align=center><tr>' || '<td>&nbsp;</td>' || '<td align=center>&nbsp;Total&nbsp;</td><td align=center>&nbsp;Péril&nbsp;</td><td align=center>&nbsp;Insalubrité&nbsp;</td>
            <td align=center>&nbsp;R.S.D.&nbsp;</td><td align=center>&nbsp;Incurie&nbsp;</td><td align=center>&nbsp;Indécence&nbsp;</td><td align=center>&nbsp;Autres santé publique&nbsp;</td>
            <td align=center>&nbsp;Non renseignée&nbsp;</td></tr>' || 
	    string_agg(t.tableau1,'')
            ||
            '</table>' as tableau
FROM
req_complete t
;


COMMENT ON VIEW x_apps.xapps_an_v_hab_indigne_tb1
  IS 'Vue applicative tableau de bord (tableau 1) décomptant le nombre de dossier par commune par qualification pour affichage dans GEO';


-- View: x_apps.xapps_geo_v_hab_indigne_peril

-- DROP VIEW x_apps.xapps_geo_v_hab_indigne_peril;


-- VUE affichant à l'adresse si il existe au moins 1 signalement de péril
-- affichage dans la carte sur GEO
-- filtré sur les communes de l'ARC

CREATE OR REPLACE VIEW x_apps.xapps_geo_v_hab_indigne_peril AS 
SELECT s.id_dos,s.nm_doc,a.geom

FROM
m_habitat.an_hab_indigne_sign s , x_apps.xapps_geo_vmr_adresse a
WHERE s.id_adresse = a.id_adresse AND s.q_init ='10' AND cloture = false;

ALTER TABLE x_apps.xapps_geo_v_hab_indigne_peril
  OWNER TO sig_create;
GRANT ALL ON TABLE x_apps.xapps_geo_v_hab_indigne_peril TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE x_apps.xapps_geo_v_hab_indigne_peril TO edit_sig;
GRANT SELECT ON TABLE x_apps.xapps_geo_v_hab_indigne_peril TO read_sig;
COMMENT ON VIEW x_apps.xapps_geo_v_hab_indigne_peril
  IS 'Vue applicative récupérant les adresses avec au moins un signalement de péril pour affichage sur la carte de l''application HABITAT';
