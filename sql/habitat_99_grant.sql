/*HABITAT V1.0*/
/*Creation des droits sur l'ensemble des objets */
/* habitat_99_grant.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet */



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        GRANT                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- #################################################################### SCHEMA  ####################################################################

GRANT ALL ON SCHEMA m_habitat TO sig_create;
GRANT ALL ON SCHEMA m_habitat TO create_sig;
GRANT USAGE ON SCHEMA m_habitat TO read_sig;
GRANT USAGE ON SCHEMA m_habitat TO edit_sig;

-- #################################################################### DOMAINE DE VALEUR  ####################################################################

ALTER TABLE m_habitat.lt_hab_indigne_qualif
  OWNER TO sig_create;
GRANT ALL ON TABLE m_habitat.lt_hab_indigne_qualif TO sig_create;
GRANT ALL ON TABLE m_habitat.lt_hab_indigne_qualif TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_habitat.lt_hab_indigne_qualif TO edit_sig;
GRANT SELECT ON TABLE m_habitat.lt_hab_indigne_qualif TO read_sig;

ALTER TABLE m_habitat.lt_hab_indigne_pat
  OWNER TO sig_create;
GRANT ALL ON TABLE m_habitat.lt_hab_indigne_pat TO sig_create;
GRANT ALL ON TABLE m_habitat.lt_hab_indigne_pat TO create_sig;
GRANT SELECT ON TABLE m_habitat.lt_hab_indigne_pat TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_habitat.lt_hab_indigne_pat TO edit_sig;

ALTER TABLE m_habitat.lt_hab_indigne_situ
  OWNER TO sig_create;
GRANT ALL ON TABLE m_habitat.lt_hab_indigne_situ TO sig_create;
GRANT ALL ON TABLE m_habitat.lt_hab_indigne_situ TO create_sig;
GRANT SELECT ON TABLE m_habitat.lt_hab_indigne_situ TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_habitat.lt_hab_indigne_situ TO edit_sig;

ALTER TABLE m_habitat.lt_hab_indigne_tprop
  OWNER TO sig_create;
GRANT ALL ON TABLE m_habitat.lt_hab_indigne_tprop TO sig_create;
GRANT ALL ON TABLE m_habitat.lt_hab_indigne_tprop TO create_sig;
GRANT SELECT ON TABLE m_habitat.lt_hab_indigne_tprop TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_habitat.lt_hab_indigne_tprop TO edit_sig;

ALTER TABLE m_habitat.lt_hab_indigne_avancdos
  OWNER TO sig_create;
GRANT ALL ON TABLE m_habitat.lt_hab_indigne_avancdos TO sig_create;
GRANT ALL ON TABLE m_habitat.lt_hab_indigne_avancdos TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_habitat.lt_hab_indigne_avancdos TO edit_sig;
GRANT SELECT ON TABLE m_habitat.lt_hab_indigne_avancdos TO read_sig;


-- #################################################################### SEQUENCE  ####################################################################

ALTER TABLE m_habitat.an_hab_indigne_sign_seq
  OWNER TO sig_create;
GRANT ALL ON SEQUENCE m_habitat.an_hab_indigne_sign_seq TO sig_create;
GRANT ALL ON SEQUENCE m_habitat.an_hab_indigne_sign_seq TO public;
GRANT ALL ON SEQUENCE m_habitat.an_hab_indigne_sign_seq TO create_sig;

ALTER TABLE m_habitat.an_hab_indigne_occ_seq
  OWNER TO sig_create;
GRANT ALL ON SEQUENCE m_habitat.an_hab_indigne_occ_seq TO sig_create;
GRANT ALL ON SEQUENCE m_habitat.an_hab_indigne_occ_seq TO public;
GRANT ALL ON SEQUENCE m_habitat.an_hab_indigne_occ_seq TO create_sig;

ALTER TABLE m_habitat.an_hab_indigne_prop_seq
  OWNER TO sig_create;
GRANT ALL ON SEQUENCE m_habitat.an_hab_indigne_prop_seq TO sig_create;
GRANT ALL ON SEQUENCE m_habitat.an_hab_indigne_prop_seq TO public;
GRANT ALL ON SEQUENCE m_habitat.an_hab_indigne_prop_seq TO create_sig;

ALTER TABLE m_habitat.an_hab_indigne_media_gid_seq
  OWNER TO sig_create;
GRANT ALL ON SEQUENCE m_habitat.an_hab_indigne_media_gid_seq TO sig_create;
GRANT ALL ON SEQUENCE m_habitat.an_hab_indigne_media_gid_seq TO public;
GRANT ALL ON SEQUENCE m_habitat.an_hab_indigne_media_gid_seq TO create_sig;

ALTER TABLE x_apps.xapps_an_v_hab_indigne_erreur_gid_seq
  OWNER TO sig_create;
GRANT ALL ON SEQUENCE x_apps.xapps_an_v_hab_indigne_erreur_gid_seq TO sig_create;
GRANT ALL ON SEQUENCE x_apps.xapps_an_v_hab_indigne_erreur_gid_seq TO public;
GRANT ALL ON SEQUENCE x_apps.xapps_an_v_hab_indigne_erreur_gid_seq TO create_sig;



-- #################################################################### TABLE  ####################################################################

ALTER TABLE m_habitat.an_hab_indigne_sign
  OWNER TO sig_create;
GRANT ALL ON TABLE m_habitat.an_hab_indigne_sign TO sig_create;
GRANT ALL ON TABLE m_habitat.an_hab_indigne_sign TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_habitat.an_hab_indigne_sign TO edit_sig;
GRANT SELECT ON TABLE m_habitat.an_hab_indigne_sign TO read_sig;

ALTER TABLE m_habitat.an_hab_indigne_occ
  OWNER TO sig_create;
GRANT ALL ON TABLE m_habitat.an_hab_indigne_occ TO sig_create;
GRANT ALL ON TABLE m_habitat.an_hab_indigne_occ TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_habitat.an_hab_indigne_occ TO edit_sig;
GRANT SELECT ON TABLE m_habitat.an_hab_indigne_occ TO read_sig;

ALTER TABLE m_habitat.an_hab_indigne_prop
  OWNER TO sig_create;
GRANT ALL ON TABLE m_habitat.an_hab_indigne_prop TO sig_create;
GRANT ALL ON TABLE m_habitat.an_hab_indigne_prop TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_habitat.an_hab_indigne_prop TO edit_sig;
GRANT SELECT ON TABLE m_habitat.an_hab_indigne_prop TO read_sig;

ALTER TABLE m_habitat.an_hab_indigne_media
  OWNER TO sig_create;
GRANT ALL ON TABLE m_habitat.an_hab_indigne_media TO sig_create;
GRANT ALL ON TABLE m_habitat.an_hab_indigne_media TO create_sig;
GRANT SELECT ON TABLE m_habitat.an_hab_indigne_media TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_habitat.an_hab_indigne_media TO edit_sig;

ALTER TABLE x_apps.xapps_an_v_hab_indigne_erreur
  OWNER TO sig_create;
GRANT ALL ON TABLE x_apps.xapps_an_v_hab_indigne_erreur TO sig_create;
GRANT ALL ON TABLE x_apps.xapps_an_v_hab_indigne_erreur TO create_sig;
GRANT SELECT ON TABLE x_apps.xapps_an_v_hab_indigne_erreur TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE x_apps.xapps_an_v_hab_indigne_erreur TO edit_sig;

-- #################################################################### VUE DE GESTION  ####################################################################

Sans objet

-- #################################################################### VUE APPLICATIVE  ####################################################################

ALTER TABLE x_apps.xapps_an_v_hab_indigne_tb1
  OWNER TO sig_create;
GRANT ALL ON TABLE x_apps.xapps_an_v_hab_indigne_tb1 TO sig_create;
GRANT ALL ON TABLE x_apps.xapps_an_v_hab_indigne_tb1 TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE x_apps.xapps_an_v_hab_indigne_tb1 TO edit_sig;
GRANT SELECT ON TABLE x_apps.xapps_an_v_hab_indigne_tb1 TO read_sig;

ALTER TABLE x_apps.xapps_geo_v_hab_indigne_delais
  OWNER TO sig_create;
GRANT ALL ON TABLE x_apps.xapps_geo_v_hab_indigne_delais TO sig_create;
GRANT ALL ON TABLE x_apps.xapps_geo_v_hab_indigne_delais TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE x_apps.xapps_geo_v_hab_indigne_delais TO edit_sig;
GRANT SELECT ON TABLE x_apps.xapps_geo_v_hab_indigne_delais TO read_sig;

ALTER TABLE x_apps.xapps_geo_v_hab_indigne
  OWNER TO sig_create;
GRANT ALL ON TABLE x_apps.xapps_geo_v_hab_indigne TO sig_create;
GRANT ALL ON TABLE x_apps.xapps_geo_v_hab_indigne TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE x_apps.xapps_geo_v_hab_indigne TO edit_sig;
GRANT SELECT ON TABLE x_apps.xapps_geo_v_hab_indigne TO read_sig;

-- #################################################################### VUE OPENDATA  ####################################################################


Sans objet

-- #################################################################### FUNCTION TRIGGER  ####################################################################

ALTER FUNCTION m_habitat.ft_m_signalclos_delete()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_habitat.ft_m_signalclos_delete() TO public;
GRANT EXECUTE ON FUNCTION m_habitat.ft_m_signalclos_delete() TO sig_create;
GRANT EXECUTE ON FUNCTION m_habitat.ft_m_avancdos() TO create_sig;


ALTER FUNCTION m_habitat.ft_m_avancdos()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_habitat.ft_m_avancdos() TO public;
GRANT EXECUTE ON FUNCTION m_habitat.ft_m_avancdos() TO sig_create;
GRANT EXECUTE ON FUNCTION m_habitat.ft_m_avancdos() TO create_sig;

ALTER FUNCTION m_habitat.ft_m_occprop_delete()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_habitat.ft_m_occprop_delete() TO public;
GRANT EXECUTE ON FUNCTION m_habitat.ft_m_occprop_delete() TO sig_create;
GRANT EXECUTE ON FUNCTION m_habitat.ft_m_occprop_delete() TO create_sig;
