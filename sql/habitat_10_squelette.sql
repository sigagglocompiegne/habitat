/*Habitat/
/*Creation du squelette de la structure des données (table, séquence, trigger,...) */
/* habitat_10_squelette.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet */


-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


  -- fkey
ALTER TABLE m_habitat.an_hab_indigne_occ DROP CONSTRAINT IF EXISTS an_hab_indigne_occ_pat_fkey;
ALTER TABLE m_habitat.an_hab_indigne_occ DROP CONSTRAINT IF EXISTS an_hab_indigne_occ_situ_fkey;
ALTER TABLE m_habitat.an_hab_indigne_prop DROP CONSTRAINT IF EXISTS an_hab_indigne_prop_pat_fkey;
ALTER TABLE m_habitat.an_hab_indigne_prop DROP CONSTRAINT IF EXISTS an_hab_indigne_prop_tprop_fkey;
ALTER TABLE m_habitat.an_hab_indigne_prop DROP CONSTRAINT IF EXISTS an_hab_indigne_prop_tvoie_fkey;
ALTER TABLE m_habitat.an_hab_indigne_sign DROP CONSTRAINT IF EXISTS an_hab_indigne_sign_avancdos_fkey;
ALTER TABLE m_habitat.an_hab_indigne_sign DROP CONSTRAINT IF EXISTS an_hab_indigne_sign_edos_fkey;
ALTER TABLE m_habitat.an_hab_indigne_sign DROP CONSTRAINT IF EXISTS an_hab_indigne_sign_qualiffinal_fkey;
ALTER TABLE m_habitat.an_hab_indigne_sign DROP CONSTRAINT IF EXISTS an_hab_indigne_sign_qualifinit_fkey;

-- CLASSES

DROP TABLE IF EXISTS m_habitat.an_hab_indigne_sign;
DROP TABLE IF EXISTS m_habitat.an_hab_indigne_occ;
DROP TABLE IF EXISTS m_habitat.an_hab_indigne_prop;
DROP TABLE IF EXISTS m_habitat.an_hab_indigne_media;
DROP TABLE IF EXISTS x_apps.xapps_an_v_hab_indigne_erreur;


-- DOMAINES DE VALEUR

DROP TABLE IF EXISTS m_habitat.x_apps.lt_hab_indigne_avancdos;
DROP TABLE IF EXISTS m_habitat.x_apps.lt_hab_indigne_pat;
DROP TABLE IF EXISTS m_habitat.x_apps.lt_hab_indigne_qualif;
DROP TABLE IF EXISTS m_habitat.x_apps.lt_hab_indigne_situ;
DROP TABLE IF EXISTS m_habitat.x_apps.lt_hab_indigne_tprop;

--SEQUENCES

DROP SEQUENCE IF EXISTS m_habitat.an_hab_indigne_media_gid_seq;
DROP SEQUENCE IF EXISTS m_habitat.an_hab_indigne_occ_seq;
DROP SEQUENCE IF EXISTS m_habitat.an_hab_indigne_prop_seq;
DROP SEQUENCE IF EXISTS m_habitat.an_hab_indigne_sign_seq;
DROP SEQUENCE IF EXISTS x_apps.xapps_an_v_hab_indigne_erreur_gid_seq;

-- VUE APPLICATIVE

DROP VIEW IF EXISTS x_apps.xapps_an_v_hab_indigne_tb1;

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                SCHEMA                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- Schema: m_habitat

-- DROP SCHEMA m_habitat;
/*
CREATE SCHEMA m_habitat
  AUTHORIZATION sig_create
COMMENT ON SCHEMA m_habitat
  IS 'Données géographiques métiers sur le thème de l'habitat';
*/


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                SEQUENCE                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


DROP SEQUENCE IF EXISTS ;


-- ################################################################# Séquence sur domaine valeur ouvert -   ###############################################




-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                DOMAINES DE VALEURS                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


  -- fkey
ALTER TABLE  DROP CONSTRAINT IF EXISTS ;

-- domaine de valeur
DROP TABLE IF EXISTS ;



-- ################################################################# Domaine valeur -   ###############################################


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                TABLE                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


DROP TABLE IF EXISTS ;


-- #################################################################### -------- ####################################################  
  
    

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        FKEY                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ************ --------- ************ 


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                INDEX                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################













