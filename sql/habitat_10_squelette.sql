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


-- Sequence: m_habitat.an_hab_indigne_sign_seq

-- DROP SEQUENCE m_habitat.an_hab_indigne_sign_seq;

CREATE SEQUENCE m_habitat.an_hab_indigne_sign_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;


-- Sequence: m_habitat.an_hab_indigne_occ_seq

-- DROP SEQUENCE m_habitat.an_hab_indigne_occ_seq;

CREATE SEQUENCE m_habitat.an_hab_indigne_occ_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

-- Sequence: m_habitat.an_hab_indigne_prop_seq

-- DROP SEQUENCE m_habitat.an_hab_indigne_prop_seq;

CREATE SEQUENCE m_habitat.an_hab_indigne_prop_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;



-- Sequence: m_habitat.an_hab_indigne_media_gid_seq

-- DROP SEQUENCE m_habitat.an_hab_indigne_media_gid_seq;

CREATE SEQUENCE m_habitat.an_hab_indigne_media_gid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;



-- Sequence: x_apps.xapps_an_v_hab_indigne_erreur_gid_seq

-- DROP SEQUENCE x_apps.xapps_an_v_hab_indigne_erreur_gid_seq;

CREATE SEQUENCE x_apps.xapps_an_v_hab_indigne_erreur_gid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                DOMAINES DE VALEURS                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


--############################################################ QUALIFICATION ##################################################

CREATE TABLE m_habitat.lt_hab_indigne_qualif
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_hab_indigne_qualif_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

INSERT INTO m_habitat.lt_hab_indigne_qualif(code, valeur)
    VALUES
	('00','Non renseignée'),
	('01','Péril'),
	('02','Insalubrité / Impropre à l’habitation'),
        ('03','RSD (Règlement Sanitaire Départemental)'),
	('04','Incurie'),
	('05','Indécence'),
	('06','Autres santé publique');

COMMENT ON TABLE m_habitat.lt_hab_indigne_qualif
  IS 'Liste des qualifications de l''habitat indigne';
COMMENT ON COLUMN m_habitat.lt_hab_indigne_pat.code IS 'Code interne des qualifications';
COMMENT ON COLUMN m_habitat.lt_hab_indigne_pat.valeur IS 'Libellé des qualifications';


--############################################################ PATRONYME ##################################################

-- Table: m_habitat.lt_hab_indigne_pat

-- DROP TABLE m_habitat.lt_hab_indigne_pat;

CREATE TABLE m_habitat.lt_hab_indigne_pat
(
  code character(2) NOT NULL, -- Code interne des types de patronyme
  valeur character varying(80) NOT NULL, -- Libellé des types de patronyme
  CONSTRAINT lt_hab_indigne_pat_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

INSERT INTO m_habitat.lt_hab_indigne_pat(code, valeur)
    VALUES
	('00','Non renseignée'),
	('10','M'),
	('20','Mme'),
        ('30','M et Mme'),
	('40','Autre (précisez)');

COMMENT ON TABLE m_habitat.lt_hab_indigne_pat
  IS 'Liste des types de patronyme';
COMMENT ON COLUMN m_habitat.lt_hab_indigne_pat.code IS 'Code interne des types de patronyme';
COMMENT ON COLUMN m_habitat.lt_hab_indigne_pat.valeur IS 'Libellé des types de patronyme';


--############################################################ SITUATION OCCUPANT ##################################################

-- Table: m_habitat.lt_hab_indigne_situ

-- DROP TABLE m_habitat.lt_hab_indigne_situ;

CREATE TABLE m_habitat.lt_hab_indigne_situ
(
  code character(2) NOT NULL, -- Code interne des types de patronyme
  valeur character varying(80) NOT NULL, -- Libellé des types de patronyme
  CONSTRAINT lt_hab_indigne_situ_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

INSERT INTO m_habitat.lt_hab_indigne_situ(code, valeur)
    VALUES
	('00','Non renseignée'),
	('10','Locataire'),
	('20','Propriétaire');

COMMENT ON TABLE m_habitat.lt_hab_indigne_situ
  IS 'Liste des situations de l''occupant';
COMMENT ON COLUMN m_habitat.lt_hab_indigne_situ.code IS 'Code interne des situations de l''occupant';
COMMENT ON COLUMN m_habitat.lt_hab_indigne_situ.valeur IS 'Libellé des situations de l''occupant';

--############################################################ TYPE DE PROPRIETAIRE ##################################################

-- Table: m_habitat.lt_hab_indigne_tprop

-- DROP TABLE m_habitat.lt_hab_indigne_tprop;

CREATE TABLE m_habitat.lt_hab_indigne_tprop
(
  code character(2) NOT NULL, -- Code interne des types de patronyme
  valeur character varying(80) NOT NULL, -- Libellé des types de patronyme
  CONSTRAINT lt_hab_indigne_tprop_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

INSERT INTO m_habitat.lt_hab_indigne_tprop(code, valeur)
    VALUES
	('00','Non renseignée'),
	('10','PO (propriétaire occupant)'),
	('20','PB (propriétaire bailleur)'),
	('30','RS (résidence secondaire)');

COMMENT ON TABLE m_habitat.lt_hab_indigne_tprop
  IS 'Liste des types de propriétés';
COMMENT ON COLUMN m_habitat.lt_hab_indigne_tprop.code IS 'Code interne des types de propriétés';
COMMENT ON COLUMN m_habitat.lt_hab_indigne_tprop.valeur IS 'Libellé des types de propriétés';


--############################################################ ETAT D'AVANCEMENT DOSSIER ##################################################

CREATE TABLE m_habitat.lt_hab_indigne_avancdos
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  definition character varying(100),
  tri integer,
  CONSTRAINT lt_hab_indigne_avancdos_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

INSERT INTO m_habitat.lt_hab_indigne_avancdos(code, valeur,definition)
    VALUES
	('0','Signalement','délai : 15 jours (demande de visite = date ouverture du dossier)',100),
	('1','Visite','délai : 15 jours',101),
	('2','Rapport de visite','délai : 5 jours',102),
        ('3','Courrier initiale','Information et demande de travaux au propriétaire -> délai : à remplir manuellement',103),
	('4','Réponse du propriétaire','',104),
	('5','Relance ou accusé réception','Délais à remplir manuellement',105),
	('6','Arrêté de mise en demeure','Délais à remplir manuellement',106),
        ('7','Annonce de fin de travaux','Délais 15 jours',107),
	('8','Visite de fin de travaux','possibilité de revenir à l’étape 5',108),
	('9','Dossier à clôturer',109),
	('10','','Dossier clos, pas d''état et de prochaine étape',110);

COMMENT ON TABLE m_habitat.lt_hab_indigne_avancdos
  IS 'Liste des états d''avancement des dossiers de signalement de l''habitat indigne';
COMMENT ON COLUMN m_habitat.lt_hab_indigne_avancdos.code IS 'Code des états d''avancement des dossiers de signalement de l''habitat indigne';
COMMENT ON COLUMN m_habitat.lt_hab_indigne_avancdos.valeur IS 'Libellé des états d''avancement des dossiers de signalement de l''habitat indigne';
COMMENT ON COLUMN m_habitat.lt_hab_indigne_avancdos.definition IS 'Détail de l''étape avec les délais';
COMMENT ON COLUMN m_habitat.lt_hab_indigne_avancdos.tri IS 'Attribut de tri pour GEO pour afficher les listes de domaines dans l''ordre croisant';


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                CLASSE D'OBJETS                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


--############################################################ SIGNALEMENT ##################################################

-- Table: m_habitat.an_hab_indigne_sign

-- DROP TABLE m_habitat.an_hab_indigne_sign;

CREATE TABLE m_habitat.an_hab_indigne_sign
(
  id_dos integer NOT NULL DEFAULT nextval('m_habitat.an_hab_indigne_sign_seq'::regclass), -- Identifiant unique interne ARC du signalement
  id_adresse integer, -- Identifiant de l'adresse
  secpar character varying(2), -- Section cadastrale de la propriété
  numpar integer, -- Numéro de la parcelle de la propriété
  idu character varying(20), -- Clé de référence parcellaire déduie des attributs secpar et numpar saisie par l''utilisateur et regénéré via la trigger. Cette clé permet de faire le lien dans GEO avec latable Parcelle (Alpha) V3 pour accéder à la fiche parcelle depuis la fiche de signalement
  nm_doc character varying(254), -- Référence du dossier ARC
  n_dos character varying(254), -- Numéro de dossier de l'organisme extérieur ayant fait le signalement
  compt_ad character varying(254), -- Complément d'adresse
  o_signal character varying(254), -- Provenance du signalement
  d_signal timestamp without time zone, -- Date du signalement
  q_init character varying(2), -- Qualification initiale du signalement (liste de valeur dans lt_hab_indigne_qualif)
  q_det character varying(254), -- Détail de la qualification initiale
  d_visit_d timestamp without time zone, -- Date de demande d'une visite
  d_visit_e timestamp without time zone, -- Date de la visite
  o_visit character varying(100), -- Opérateur de la visite
  m_nvisit character varying(254), -- Motif de la non visite
  d_rvisit timestamp without time zone, -- Date du rapport de la visite
  q_final character varying(2), -- Qualification finale du signalement (lien vers lt_hab_indigne_qualif)
  r_rvisit character varying(1000), -- Résumé du rapport de visite
  action character varying(1000), -- Action(s) à entreprendre
  e_dos character varying(2) DEFAULT '10', -- Etat d'avancement du dossier
  ep_dos character varying(2) DEFAULT '20', -- Prochaine étape d'avancement du dossier
  av_dos character varying(254), -- Avancement du dossier
  d_pvmed timestamp without time zone, -- Date du procès-verbal de mise en demeure
  d_pdelais timestamp without time zone, -- Date du prochain délai
  d_visitconf timestamp without time zone, -- Date de la visite de conformité
  cloture boolean NOT NULL DEFAULT false, -- Dossier clos
  m_avise boolean NOT NULL DEFAULT false, -- Information donnée au maire
  nblog character varying(20), -- Nombre de logements
  occupation boolean NOT NULL DEFAULT true, -- Le logement ou l'immeuble concerné est-il occupé ?
  dos_anah boolean NOT NULL DEFAULT false, -- Dossier ANAH
  observ character varying(2500), -- Observations
  op_sai character varying(80), -- Opérateur de saisie de l'information
  date_sai timestamp without time zone, -- Date de saisie de l'information
  date_maj timestamp without time zone -- Date de mise à jour de l'information
  )
WITH (
  OIDS=FALSE
);


COMMENT ON TABLE m_habitat.an_hab_indigne_sign
  IS 'Table alphanumérique contenant les informations de signalement de l''habitat "indigne"';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.id_dos IS 'Identifiant unique interne ARC du signalement';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.id_adresse IS 'Identifiant de l''adresse';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.secpar IS 'Section cadastrale de la propriété';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.numpar IS 'Numéro de la parcelle de la propriété';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.nm_doc IS 'Référence du dossier ARC';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.n_dos IS 'Numéro de dossier de l''organisme extérieur ayant fait le signalement';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.compt_ad IS 'Complément d''adresse';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.o_signal IS 'Provenance du signalement';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.d_signal IS 'Date du signalement';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.q_init IS 'Qualification initiale du signalement (liste de valeur dans lt_hab_indigne_qualif)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.q_det IS 'Détail de la qualification initiale';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.d_visit_d IS 'Date de demande d''une visite';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.d_visit_e IS 'Date de la visite';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.o_visit IS 'Opérateur de la visite';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.m_nvisit IS 'Motif de la non visite';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.d_rvisit IS 'Date du rapport de la visite';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.q_final IS 'Qualification finale du signalement (lien vers lt_hab_indigne_qualif)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.r_rvisit IS 'Résumé du rapport de visite';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.action IS 'Action(s) à entreprendre';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.av_dos IS 'Avancement du dossier';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.d_pvmed IS 'Date du procès-verbal de mise en demeure';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.d_pdelais IS 'Date du prochain délai';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.d_visitconf IS 'Date de la visite de conformité';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.cloture IS 'Dossier clos';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.m_avise IS 'Information donnée au maire';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.nblog IS 'Nombre de logements';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.occupation IS 'Le logement ou l''immeuble concerné est-il occupé ?';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.dos_anah IS 'Dossier ANAH';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.observ IS 'Observations';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.op_sai IS 'Opérateur de saisie de l''information';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.date_sai IS 'Date de saisie de l''information';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.date_maj IS 'Date de mise à jour de l''information';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.e_dos IS 'Etat d''avancement du dossier';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.ep_dos IS 'Prochaine étape d''avancement du dossier';
COMMENT ON COLUMN m_habitat.an_hab_indigne_sign.idu IS 'Clé de référence parcellaire déduie des attributs secpar et numpar saisie par l''utilisateur et regénéré via la trigger. Cette clé permet de faire le lien dans GEO avec latable Parcelle (Alpha) V3 pour accéder à la fiche parcelle depuis la fiche de signalement';


--############################################################ OCCUPANT ##################################################

-- Table: m_habitat.an_hab_indigne_occ

-- DROP TABLE m_habitat.an_hab_indigne_occ;

CREATE TABLE m_habitat.an_hab_indigne_occ
(
  id_occ integer NOT NULL DEFAULT nextval('m_habitat.an_hab_indigne_occ_seq'::regclass), -- Identifiant unique de l'occupant
  id_dos integer NOT NULL, -- Identifiant unique interne ARC du signalement
  nom character varying (80), -- Nom de l'occupant
  prenom character varying(50), -- Prénom de l'occupant
  telf_occ character varying(14), -- Téléphone fixe de l'occupant
  telp_occ character varying(14), -- Téléphone portable de l'occupant
  tela_occ character varying(14), -- Autre téléphone de l'occupant
  e_occ character varying(100), -- Mail de l'occupant
  titre character varying(2), -- Titre de l'occupant (lien vers table lt_)
  titre_aut character varying(50), -- Autre titre
  situation character varying(2), -- Situation de l'occupant (lien vers table lt_hab_indigne_occ)
  nb_occ character varying(50), -- Nombre d'occupants du logement
  enf_occ character varying(100), -- Présence d'enfants dans le logement et âge
  refe character varying(80), -- Libellé du référent
  telf_refe character varying(14), -- Téléphone fixe du référent
  telp_refe character varying(14), -- Téléphone portable du référent
  tela_refe character varying(14), -- Autre téléphone pour joindre le référent
  e_refe character varying(100), -- Mail du référent

  arefe character varying(80), -- Libellé du référent (non personne morale)
  telf_arefe character varying(14), -- Téléphone fixe du référent (non personne morale)
  telp_arefe character varying(14), -- Téléphone portable du référent (non personne morale)
  tela_arefe character varying(14), -- Autre téléphone pour joindre le référent (non personne morale)
  e_arefe character varying(100), -- Mail du référent (non personne morale)

  s_social character varying(254), -- Situation sociale
  t_social character varying(254), -- Traitement social
  r_loca boolean NOT NULL DEFAULT false, -- Relogement des locataires
  op_sai character varying(80), -- Opérateur de saisie de l'information
  date_sai timestamp without time zone, -- Date de saisie de l'information
  date_maj timestamp without time zone -- Date de mise à jour de l'information
)
WITH (
  OIDS=FALSE
);


COMMENT ON TABLE m_habitat.an_hab_indigne_occ
  IS 'Table alphanumérique contenant les informations des occupants concernés par un signalement';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.id_occ IS 'Identifiant unique de l''occupant';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.id_dos IS 'Identifiant unique interne ARC du signalement';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.nom IS 'Nom de l''occupant';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.prenom IS 'Prénom de l''occupant';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.telf_occ IS 'Téléphone fixe de l''occupant';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.telp_occ IS 'Téléphone portable de l''occupant';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.tela_occ IS 'Autre téléphone de l''occupant';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.e_occ IS 'Mail de l''occupant';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.titre IS 'Titre de l''occupant (lien vers table lt_hab_indigne_pat)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.titre_aut IS 'Autre titre';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.situation IS 'Situation de l''occupant (lien vers table lt_hab_indigne_situ)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.nb_occ IS 'Nombre d''occupants du logement';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.enf_occ IS 'Présence d''enfants dans le logement et âge';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.refe IS 'Libellé du référent';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.telf_refe IS 'Téléphone fixe du référent';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.telp_refe IS 'Téléphone portable du référent';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.tela_refe IS 'Autre Téléphone du référent';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.e_refe IS 'Email du référent';

COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.arefe IS 'Libellé du référent (non personne morale)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.telf_arefe IS 'Téléphone fixe du référent (non personne morale)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.telp_arefe IS 'Téléphone portable du référent (non personne morale)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.tela_arefe IS 'Autre Téléphone du référent (non personne morale)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.e_arefe IS 'Email du référent (non personne morale)';

COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.s_social IS 'Situation sociale';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.t_social IS 'Traitement sociale';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.op_sai IS 'Opérateur de saisie de l''information';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.date_sai IS 'Date de saisie de l''information';
COMMENT ON COLUMN m_habitat.an_hab_indigne_occ.date_maj IS 'Date de mise à jour de l''information';

--############################################################ PROPRIETAIRE ##################################################

-- Table: m_habitat.an_hab_indigne_prop

-- DROP TABLE m_habitat.an_hab_indigne_prop;

CREATE TABLE m_habitat.an_hab_indigne_prop
(
  id_prop integer DEFAULT nextval('m_habitat.an_hab_indigne_prop_seq'::regclass), -- Identifiant unique du propiétaire
  id_dos integer, -- Identifiant unique interne ARC du signalement
  nom character varying(80), -- Nom du propriétaire ou nom du bailleur
  prenom character varying(50), -- Prénom du propriétaire
  nom_gest character varying(80) -- libellé du gestionnaire
  telf_prop character varying(14), -- Téléphone fixe du propriétaire
  telp_prop character varying(14), -- Téléphone portable du propriétaire
  tela_prop character varying(14), -- Autre téléphone pour joindre le propriétaire
  e_prop character varying(100), -- Mail du propriétaire
  titre character varying(2), -- Titre de l'occupant (lien vers la table lt_hab_indigne_pat)
  titre_aut character varying(50), -- Autre titre
  numero integer, -- Numéro dans la voie
  repet character varying(10), -- Indice de répétition dans la voie
  compt_ad character varying(80), -- Complément d'adresse
  type_voie character varying(2), -- Type de voie (lien vers la table r_voie.lt_type_voie)
  nom_voie character varying(254), -- Libellé de la voie
  cp character varying(5), -- Code postal
  commune character varying(100), -- Commune
  pays character varying(100), -- Pays
  contact character varying(100), -- Nom d'un contact éventuel privilégié
  telf_contact character varying(14), -- Téléphone fixe du contact privilégié
  telp_contact character varying(14), -- Téléphone portable du contact privilégié
  tela_contact character varying(14), -- Autre téléphone pour joindre le contact privilégié
  e_contact character varying(100), -- Mail du contact privilégié
  ad_contact character varying(254), -- Adresse du contact privilégié
  t_prop character varying(2), -- Type de propriété (lien vers la table lt_hab_indigne_tprop)
  op_sai character varying(80), -- Opérateur de saisie de l'information
  date_sai timestamp without time zone, -- Date de saisie de l'information
  date_maj character varying -- Date de mise à jour de l'information
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_habitat.an_hab_indigne_prop
  IS 'Table alphanumérique contenant les informations des propriétaires concernés par un signalement';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.id_prop IS 'Identifiant unique du propiétaire';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.id_dos IS 'Identifiant unique interne ARC du signalement';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.nom IS 'Nom du propriétaire ou nom du bailleur';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.prenom IS 'Prénom du propriétaire';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.nom_gest IS 'Nom du gestionnaire';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.telf_occ IS 'Téléphone fixe du propriétaire';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.telp_prop IS 'Téléphone portable du propriétaire';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.tela_prop IS 'Autre téléphone pour joindre le propriétaire';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.e_prop IS 'Mail du propriétaire';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.titre IS 'Titre de l''occupant (lien vers la table lt_hab_indigne_titre)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.titre_aut IS 'Autre titre';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.numero IS 'Numéro dans la voie';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.repet IS 'Indice de répétition dans la voie';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.compt_ad IS 'Complément d''adresse';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.type_voie IS 'Type de voie (lien vers la table r_voie.lt_type_voie)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.nom_voie IS 'Libellé de la voie';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.cp IS 'Code postal';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.commune IS 'Commune';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.pays IS 'Pays';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.contact IS 'Nom d''un contact éventuel privilégié';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.telf_contact IS 'Téléphone fixe du contact privilégié';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.telp_contact IS 'Téléphone portable du contact privilégié';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.tela_contact IS 'Autre téléphone pour joindre le contact privilégié';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.e_contact IS 'Mail du contact privilégié';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.ad_contact IS 'Adresse du contact privilégié';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.t_prop IS 'Type de propriété (lien vers la table lt_hab_indigne_tprop)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.op_sai IS 'Opérateur de saisie de l''information';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.date_sai IS 'Date de saisie de l''information';
COMMENT ON COLUMN m_habitat.an_hab_indigne_prop.date_maj IS 'Date de mise à jour de l''information';


--############################################################ MEDIA ##################################################

-- Table: m_habitat.an_hab_indigne_media

-- DROP TABLE m_habitat.an_hab_indigne_media;

CREATE TABLE m_habitat.an_hab_indigne_media
(
  gid serial NOT NULL DEFAULT nextval('m_habitat.an_hab_indigne_media_gid_seq'::regclass), -- Compteur (identifiant interne)
  id integer, -- Identifiant du signalement
  media text, -- Champ Média de GEO
  miniature bytea, -- Champ miniature de GEO
  n_fichier text, -- Nom du fichier
  t_fichier text, -- Type de média dans GEO
  op_sai character varying(20), -- Opérateur de saisie (par défaut login de connexion à GEO)
  l_doc character varying(100), -- nom ou léger descriptif du document
  date_sai timestamp without time zone -- Date de la saisie du document
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_habitat.an_hab_indigne_media
  IS 'Table gérant les documents des signalements de l''habitat indigne dans le module MEDIA dans GEO avec stockage des documents dans une arborescence de fichiers (saisie de docs par les utilisateurs)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_media.gid IS 'Compteur (identifiant interne)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_media.id IS 'Identifiant du signalement';
COMMENT ON COLUMN m_habitat.an_hab_indigne_media.media IS 'Champ Média de GEO';
COMMENT ON COLUMN m_habitat.an_hab_indigne_media.miniature IS 'Champ miniature de GEO';
COMMENT ON COLUMN m_habitat.an_hab_indigne_media.n_fichier IS 'Nom du fichier';
COMMENT ON COLUMN m_habitat.an_hab_indigne_media.t_fichier IS 'Type de média dans GEO';
COMMENT ON COLUMN m_habitat.an_hab_indigne_media.op_sai IS 'Opérateur de saisie (par défaut login de connexion à GEO)';
COMMENT ON COLUMN m_habitat.an_hab_indigne_media.l_doc IS 'nom ou léger descriptif du document';
COMMENT ON COLUMN m_habitat.an_hab_indigne_media.date_sai IS 'Date de la saisie du document';

--############################################################ ERREUR ##################################################

-- Table: x_apps.xapps_an_v_hab_indigne_erreur

-- DROP TABLE x_apps.xapps_an_v_hab_indigne_erreur;

CREATE TABLE x_apps.xapps_an_v_hab_indigne_erreur
(
  gid integer NOT NULL, -- Identifiant unique
  id_adresse integer, -- Identifiant de l'adresse
  id_dos integer, -- Identifiant du signalement
  erreur character varying(500), -- Message
  horodatage timestamp without time zone, -- Date (avec heure) de génération du message (ce champ permet de filtrer l'affichage < x secondsdans GEo)
  CONSTRAINT xapps_an_v_hab_indigne_erreur_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE x_apps.xapps_an_v_hab_indigne_erreur
  IS 'Table gérant les messages d''erreurs de sécurité remontés dans GEO suite à des enregistrements d''habitat indigne incorrect';
COMMENT ON COLUMN x_apps.xapps_an_v_hab_indigne_erreur.gid IS 'Identifiant unique';
COMMENT ON COLUMN x_apps.xapps_an_v_hab_indigne_erreur.id_adresse IS 'Identifiant de l''adresse';
COMMENT ON COLUMN x_apps.xapps_an_v_hab_indigne_erreur.id_dos IS 'Identifiant du signalement';
COMMENT ON COLUMN x_apps.xapps_an_v_hab_indigne_erreur.erreur IS 'Message';
COMMENT ON COLUMN x_apps.xapps_an_v_hab_indigne_erreur.horodatage IS 'Date (avec heure) de génération du message (ce champ permet de filtrer l''affichage < x secondsdans GEo)';


-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                        CONTRAINTES                                                      ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


						    

--##################################################### SIGNALEMENT ##################################################

ALTER TABLE m_habitat.an_hab_indigne_sign
  ADD CONSTRAINT an_hab_indigne_sign_pkey PRIMARY KEY (id_dos);

  
ALTER TABLE m_habitat.an_hab_indigne_sign
  ADD CONSTRAINT an_hab_indigne_sign_qualifinit_fkey FOREIGN KEY (q_init)
      REFERENCES m_habitat.lt_hab_indigne_qualif (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE m_habitat.an_hab_indigne_sign
  ADD CONSTRAINT an_hab_indigne_sign_qualiffinal_fkey FOREIGN KEY (q_final)
      REFERENCES m_habitat.lt_hab_indigne_qualif (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE m_habitat.an_hab_indigne_sign
  ADD CONSTRAINT an_hab_indigne_sign_edos_fkey FOREIGN KEY (e_dos)
      REFERENCES m_habitat.lt_hab_indigne_avancdos (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE m_habitat.an_hab_indigne_sign
  ADD CONSTRAINT an_hab_indigne_sign_avancdos_fkey FOREIGN KEY (ep_dos)
      REFERENCES m_habitat.lt_hab_indigne_avancdos (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


--##################################################### OCCUPANT ##################################################

ALTER TABLE m_habitat.an_hab_indigne_occ
  ADD CONSTRAINT an_hab_indigne_occ_pkey PRIMARY KEY (id_occ);

  
ALTER TABLE m_habitat.an_hab_indigne_occ
  ADD CONSTRAINT an_hab_indigne_occ_pat_fkey FOREIGN KEY (titre)
      REFERENCES m_habitat.lt_hab_indigne_pat (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


ALTER TABLE m_habitat.an_hab_indigne_occ
  ADD CONSTRAINT an_hab_indigne_occ_situ_fkey FOREIGN KEY (situation)
      REFERENCES m_habitat.lt_hab_indigne_situ (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
--##################################################### PROPRIETAIRE ##################################################

ALTER TABLE m_habitat.an_hab_indigne_prop
  ADD CONSTRAINT an_hab_indigne_prop_pkey PRIMARY KEY (id_prop);

ALTER TABLE m_habitat.an_hab_indigne_prop
  ADD CONSTRAINT an_hab_indigne_prop_pat_fkey FOREIGN KEY (titre)
      REFERENCES m_habitat.lt_hab_indigne_pat (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE m_habitat.an_hab_indigne_prop
  ADD CONSTRAINT an_hab_indigne_prop_tprop_fkey FOREIGN KEY (t_prop)
      REFERENCES m_habitat.lt_hab_indigne_tprop (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE m_habitat.an_hab_indigne_prop
  ADD CONSTRAINT an_hab_indigne_prop_tvoie_fkey FOREIGN KEY (type_voie)
      REFERENCES r_voie.lt_type_voie (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

--##################################################### MEDIA ##################################################

ALTER TABLE m_habitat.an_hab_indigne_media
  ADD CONSTRAINT an_hab_indigne_media_gid_pkey PRIMARY KEY (gid);


-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                         TRIGGER                                                         ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


-- Date de mise à jour

-- Trigger: t_t2_an_hab_indigne_occ_date_maj on m_habitat.an_hab_indigne_occ

-- DROP TRIGGER t_t2_an_hab_indigne_occ_date_maj ON m_habitat.an_hab_indigne_occ;

CREATE TRIGGER t_t2_an_hab_indigne_occ_date_maj
  BEFORE UPDATE
  ON m_habitat.an_hab_indigne_occ
  FOR EACH ROW
  EXECUTE PROCEDURE public.ft_r_timestamp_maj();

-- Trigger: t_t2_an_hab_indigne_prop_date_maj on m_habitat.an_hab_indigne_prop

-- DROP TRIGGER t_t2_an_hab_indigne_prop_date_maj ON m_habitat.an_hab_indigne_prop;

CREATE TRIGGER t_t2_an_hab_indigne_prop_date_maj
  BEFORE UPDATE
  ON m_habitat.an_hab_indigne_prop
  FOR EACH ROW
  EXECUTE PROCEDURE public.ft_r_timestamp_maj();

-- Trigger: t_t2_an_hab_indigne_sign_date_maj on m_habitat.an_hab_indigne_sign

-- DROP TRIGGER t_t2_an_hab_indigne_sign_date_maj ON m_habitat.an_hab_indigne_sign;

CREATE TRIGGER t_t2_an_hab_indigne_sign_date_maj
  BEFORE UPDATE
  ON m_habitat.an_hab_indigne_sign
  FOR EACH ROW
  EXECUTE PROCEDURE public.ft_r_timestamp_maj();


-- Date d'insertion

-- Trigger: t_t1_an_hab_indigne_media_date_sai on m_habitat.an_hab_indigne_media

-- DROP TRIGGER t_t1_an_hab_indigne_media_date_sai ON m_habitat.an_hab_indigne_media;

CREATE TRIGGER t_t1_an_hab_indigne_media_date_sai
  BEFORE INSERT
  ON m_habitat.an_hab_indigne_media
  FOR EACH ROW
  EXECUTE PROCEDURE public.ft_r_timestamp_sai();

-- Trigger: t_t1_an_hab_indigne_occ_date_sai on m_habitat.an_hab_indigne_occ

-- DROP TRIGGER t_t1_an_hab_indigne_occ_date_sai ON m_habitat.an_hab_indigne_occ;

CREATE TRIGGER t_t1_an_hab_indigne_occ_date_sai
  BEFORE INSERT
  ON m_habitat.an_hab_indigne_occ
  FOR EACH ROW
  EXECUTE PROCEDURE public.ft_r_timestamp_sai();

-- Trigger: t_t1_an_hab_indigne_prop_date_sai on m_habitat.an_hab_indigne_prop

-- DROP TRIGGER t_t1_an_hab_indigne_prop_date_sai ON m_habitat.an_hab_indigne_prop;

CREATE TRIGGER t_t1_an_hab_indigne_prop_date_sai
  BEFORE INSERT
  ON m_habitat.an_hab_indigne_prop
  FOR EACH ROW
  EXECUTE PROCEDURE public.ft_r_timestamp_sai();


-- Trigger: t_t1_an_hab_indigne_sign_date_sai on m_habitat.an_hab_indigne_sign

-- DROP TRIGGER t_t1_an_hab_indigne_sign_date_sai ON m_habitat.an_hab_indigne_sign;

CREATE TRIGGER t_t1_an_hab_indigne_sign_date_sai
  BEFORE INSERT
  ON m_habitat.an_hab_indigne_sign
  FOR EACH ROW
  EXECUTE PROCEDURE public.ft_r_timestamp_sai();

-- Function: m_habitat.ft_m_occprop_delete()

-- DROP FUNCTION m_habitat.ft_m_occprop_delete();

CREATE OR REPLACE FUNCTION m_habitat.ft_m_occprop_delete()
  RETURNS trigger AS
$BODY$

DECLARE v_clos boolean;

BEGIN

v_clos := old.cloture;

DELETE FROM m_habitat.an_hab_indigne_occ WHERE id_dos = old.id_dos AND v_clos = false;
DELETE FROM m_habitat.an_hab_indigne_prop WHERE id_dos = old.id_dos AND v_clos = false;
DELETE FROM m_habitat.an_hab_indigne_media WHERE id = old.id_dos AND v_clos = false;

return new;
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

COMMENT ON FUNCTION m_habitat.ft_m_occprop_delete() IS 'Fonction dont l''objet est de supprimer les occupants et les propriétaires liés au dossier de signalement supprimé.';



-- Trigger: t_t5_an_hab_indigne_occprop_delete on m_habitat.an_hab_indigne_sign

-- DROP TRIGGER t_t5_an_hab_indigne_occprop_delete ON m_habitat.an_hab_indigne_sign;

CREATE TRIGGER t_t5_an_hab_indigne_occprop_delete
  AFTER DELETE
  ON m_habitat.an_hab_indigne_sign
  FOR EACH ROW
  EXECUTE PROCEDURE m_habitat.ft_m_occprop_delete();


-- Function: m_habitat.ft_m_avancdos()

-- DROP FUNCTION m_habitat.ft_m_avancdos();

CREATE OR REPLACE FUNCTION m_habitat.ft_m_avancdos()
  RETURNS trigger AS
$BODY$BEGIN

IF (TG_OP = 'INSERT') THEN

	-- par défaut à l'insertion état d'avancement à 0 (signalement) et prochaine étape à 1 (visite) et prochaine délais à + 15 jours

        new.e_dos :='0';
	new.ep_dos := '1';
        new.d_pdelais := new.d_signal + (15 || ' day')::interval;
	IF (new.secpar IS NOT NULL OR new.secpar <> '') AND (new.numpar <> 0 OR new.numpar IS NOT NULL) THEN
        new.secpar := upper(new.secpar);
        new.idu := (SELECT insee FROM x_apps.xapps_geo_vmr_adresse WHERE id_adresse = new.id_adresse) || 
	CASE
		WHEN LENGTH(new.secpar::character varying) = 2 THEN '000'
		WHEN LENGTH(new.secpar::character varying) = 1 THEN '0000'
	END
	|| upper(new.secpar) || 
	CASE
	        WHEN LENGTH(new.numpar::character varying) = 1 THEN '000' 
	        WHEN LENGTH(new.numpar::character varying) = 2 THEN '00'
	        WHEN LENGTH(new.numpar::character varying) = 3 THEN '0'
	        WHEN LENGTH(new.numpar::character varying) = 4 THEN ''
	END
	|| new.numpar;
	END IF;
	
	-- pas de gestion des autres cas pour le moment pour l'insertion (à voir par la suite)

END IF;

-- à la mise à jour, gestion de tous les cas de mise à jour des états sur les prochaines étapes et date de délais
IF (TG_OP = 'UPDATE') THEN

-- un dossier clos ne peut plus être ouverte et modifier
IF old.cloture = true AND new.cloture = false THEN
	DELETE FROM x_apps.xapps_an_v_hab_indigne_erreur WHERE id_dos = old.id_dos;
	INSERT INTO x_apps.xapps_an_v_hab_indigne_erreur VALUES
	(
	nextval('x_apps.xapps_an_v_hab_indigne_erreur_gid_seq'::regclass),
	old.id_adresse,
	old.id_dos,
	'Vous ne pouvez pas réouvrir et modifier un dossier déjà clôturé.',
	now()
	);
		new.cloture=true;
		new.e_dos=old.e_dos;
                new.ep_dos=old.ep_dos;
		new.d_pdelais := old.d_pdelais;
        	new.nm_doc := old.nm_doc;
		new.n_dos := old.n_dos;
		new.compt_ad := old.compt_ad;
		new.o_signal := old.o_signal;
		new.d_signal := old.d_signal;
		new.q_init := old.q_init;
		new.q_det := old.q_det;
		new.d_visit_d := old.d_visit_d;
		new.d_visit_e := old.d_visit_e;
		new.o_visit := old.o_visit;
		new.m_nvisit := old.m_nvisit;
		new.d_rvisit := old.d_rvisit;
		new.q_final := old.q_final;
		new.r_rvisit := old.r_rvisit;
		new.action := old.action;
		new.av_dos := old.av_dos;
		new.d_pvmed := old.d_pvmed;
		new.d_visitconf := old.d_visitconf;
		new.cloture := old.cloture;
		new.m_avise := old.m_avise;
		new.nblog := old.nblog;
		new.occupation := old.occupation;
		new.dos_anah := old.dos_anah;
		new.observ := old.observ;
		new.secpar := old.secpar;
		new.numpar := old.numpar;
		new.d_ftrav := old.d_ftrav;
		new.idu := old.idu;
ELSE


-- si signalement
IF new.e_dos ='0' THEN
           new.ep_dos='1';
	   new.d_pdelais := new.d_signal + (15 || ' day')::interval;
           new.secpar := upper(new.secpar);
	   new.idu := (SELECT insee FROM x_apps.xapps_geo_vmr_adresse WHERE id_adresse = new.id_adresse) || 
		CASE
			WHEN LENGTH(new.secpar::character varying) = 2 THEN '000'
			WHEN LENGTH(new.secpar::character varying) = 1 THEN '0000'
		END
		|| upper(new.secpar) || 
		CASE
			WHEN LENGTH(new.numpar::character varying) = 1 THEN '000' 
			WHEN LENGTH(new.numpar::character varying) = 2 THEN '00'
			WHEN LENGTH(new.numpar::character varying) = 3 THEN '0'
			WHEN LENGTH(new.numpar::character varying) = 4 THEN ''
		END
		|| new.numpar;

END IF;


-- si état du dossier à visite, prochaine étape rapport de visite
	IF new.e_dos ='1' THEN
	   IF new.d_pdelais < old.d_signal THEN
	        DELETE FROM x_apps.xapps_an_v_hab_indigne_erreur WHERE id_dos = old.id_dos;
		INSERT INTO x_apps.xapps_an_v_hab_indigne_erreur VALUES
		(
		nextval('x_apps.xapps_an_v_hab_indigne_erreur_gid_seq'::regclass),
		old.id_adresse,
		old.id_dos,
		'Vous ne pouvez pas saisir un prochain délais avant la date de signalement.',
		now()
		);
                new.e_dos=old.e_dos;
                new.ep_dos=old.ep_dos;
		new.d_pdelais := old.d_pdelais;
		new.nm_doc := old.nm_doc;
		new.n_dos := old.n_dos;
		new.compt_ad := old.compt_ad;
		new.o_signal := old.o_signal;
		new.d_signal := old.d_signal;
		new.q_init := old.q_init;
		new.q_det := old.q_det;
		new.d_visit_d := old.d_visit_d;
		new.d_visit_e := old.d_visit_e;
		new.o_visit := old.o_visit;
		new.m_nvisit := old.m_nvisit;
		new.d_rvisit := old.d_rvisit;
		new.q_final := old.q_final;
		new.r_rvisit := old.r_rvisit;
		new.action := old.action;
		new.av_dos := old.av_dos;
		new.d_pvmed := old.d_pvmed;
		new.d_visitconf := old.d_visitconf;
		new.cloture := old.cloture;
		new.m_avise := old.m_avise;
		new.nblog := old.nblog;
		new.occupation := old.occupation;
		new.dos_anah := old.dos_anah;
		new.observ := old.observ;
		new.secpar := old.secpar;
		new.numpar := old.numpar;
		new.d_ftrav := old.d_ftrav;
		new.idu := old.idu;

		
	   ELSE IF new.d_visit_e is null THEN
	        DELETE FROM x_apps.xapps_an_v_hab_indigne_erreur WHERE id_dos = old.id_dos;
		INSERT INTO x_apps.xapps_an_v_hab_indigne_erreur VALUES
		(
		nextval('x_apps.xapps_an_v_hab_indigne_erreur_gid_seq'::regclass),
		old.id_adresse,
		old.id_dos,
		'Vous n''avez pas saisi la date de la visite.',
		now()
		);
                new.e_dos=old.e_dos;
                new.ep_dos=old.ep_dos;
		new.d_pdelais := old.d_pdelais;
		new.nm_doc := old.nm_doc;
		new.n_dos := old.n_dos;
		new.compt_ad := old.compt_ad;
		new.o_signal := old.o_signal;
		new.d_signal := old.d_signal;
		new.q_init := old.q_init;
		new.q_det := old.q_det;
		new.d_visit_d := old.d_visit_d;
		new.d_visit_e := old.d_visit_e;
		new.o_visit := old.o_visit;
		new.m_nvisit := old.m_nvisit;
		new.d_rvisit := old.d_rvisit;
		new.q_final := old.q_final;
		new.r_rvisit := old.r_rvisit;
		new.action := old.action;
		new.av_dos := old.av_dos;
		new.d_pvmed := old.d_pvmed;
		new.d_visitconf := old.d_visitconf;
		new.cloture := old.cloture;
		new.m_avise := old.m_avise;
		new.nblog := old.nblog;
		new.occupation := old.occupation;
		new.dos_anah := old.dos_anah;
		new.observ := old.observ;
		new.secpar := old.secpar;
		new.numpar := old.numpar;
		new.d_ftrav := old.d_ftrav;
                new.idu := old.idu;

	   ELSE
	   new.ep_dos='2';
	   new.d_pdelais := new.d_visit_e + (15 || ' day')::interval;
           new.secpar := upper(new.secpar);
	   new.idu := (SELECT insee FROM x_apps.xapps_geo_vmr_adresse WHERE id_adresse = new.id_adresse) || 
		CASE
			WHEN LENGTH(new.secpar::character varying) = 2 THEN '000'
			WHEN LENGTH(new.secpar::character varying) = 1 THEN '0000'
		END
		|| upper(new.secpar) || 
		CASE
			WHEN LENGTH(new.numpar::character varying) = 1 THEN '000' 
			WHEN LENGTH(new.numpar::character varying) = 2 THEN '00'
			WHEN LENGTH(new.numpar::character varying) = 3 THEN '0'
			WHEN LENGTH(new.numpar::character varying) = 4 THEN ''
		END
		|| new.numpar;
	
	   END IF;

	   END IF;
	   END IF;

-- si état du dossier à rapport de visite, prochaine étape Courrier initial
	IF new.e_dos ='2' THEN
	   IF new.d_rvisit is null THEN
	        DELETE FROM x_apps.xapps_an_v_hab_indigne_erreur WHERE id_dos = old.id_dos;
		INSERT INTO x_apps.xapps_an_v_hab_indigne_erreur VALUES
		(
		nextval('x_apps.xapps_an_v_hab_indigne_erreur_gid_seq'::regclass),
		old.id_adresse,
		old.id_dos,
		'Vous n''avez pas saisi la date du rapport de visite.',
		now()
		);
                new.e_dos=old.e_dos;
                new.ep_dos=old.ep_dos;
		new.d_pdelais := old.d_pdelais;
		new.nm_doc := old.nm_doc;
		new.n_dos := old.n_dos;
		new.compt_ad := old.compt_ad;
		new.o_signal := old.o_signal;
		new.d_signal := old.d_signal;
		new.q_init := old.q_init;
		new.q_det := old.q_det;
		new.d_visit_d := old.d_visit_d;
		new.d_visit_e := old.d_visit_e;
		new.o_visit := old.o_visit;
		new.m_nvisit := old.m_nvisit;
		new.d_rvisit := old.d_rvisit;
		new.q_final := old.q_final;
		new.r_rvisit := old.r_rvisit;
		new.action := old.action;
		new.av_dos := old.av_dos;
		new.d_pvmed := old.d_pvmed;
		new.d_visitconf := old.d_visitconf;
		new.cloture := old.cloture;
		new.m_avise := old.m_avise;
		new.nblog := old.nblog;
		new.occupation := old.occupation;
		new.dos_anah := old.dos_anah;
		new.observ := old.observ;
		new.secpar := old.secpar;
		new.numpar := old.numpar;
		new.d_ftrav := old.d_ftrav;
		new.idu := old.idu;
	   ELSE IF new.d_rvisit < old.d_visit_e THEN
	        DELETE FROM x_apps.xapps_an_v_hab_indigne_erreur WHERE id_dos = old.id_dos;
		INSERT INTO x_apps.xapps_an_v_hab_indigne_erreur VALUES
		(
		nextval('x_apps.xapps_an_v_hab_indigne_erreur_gid_seq'::regclass),
		old.id_adresse,
		old.id_dos,
		'Vous ne pouvez pas saisir une date du rapport de visite inférieure à la date de la visite',
		now()
		);
                new.e_dos=old.e_dos;
                new.ep_dos=old.ep_dos;
		new.d_pdelais := old.d_pdelais;
                new.d_rvisit := null;
                new.nm_doc := old.nm_doc;
		new.n_dos := old.n_dos;
		new.compt_ad := old.compt_ad;
		new.o_signal := old.o_signal;
		new.d_signal := old.d_signal;
		new.q_init := old.q_init;
		new.q_det := old.q_det;
		new.d_visit_d := old.d_visit_d;
		new.d_visit_e := old.d_visit_e;
		new.o_visit := old.o_visit;
		new.m_nvisit := old.m_nvisit;
		new.d_rvisit := old.d_rvisit;
		new.q_final := old.q_final;
		new.action := old.action;
		new.av_dos := old.av_dos;
		new.d_pvmed := old.d_pvmed;
		new.d_visitconf := old.d_visitconf;
		new.cloture := old.cloture;
		new.m_avise := old.m_avise;
		new.nblog := old.nblog;
		new.occupation := old.occupation;
		new.dos_anah := old.dos_anah;
		new.observ := old.observ;
		new.secpar := old.secpar;
		new.numpar := old.numpar;
		new.d_ftrav := old.d_ftrav;
		new.idu := old.idu;
		
           ELSE
	   new.ep_dos='3';
	   new.d_pdelais := new.d_rvisit + (5 || ' day')::interval;

           new.secpar := upper(new.secpar);
	   new.idu := (SELECT insee FROM x_apps.xapps_geo_vmr_adresse WHERE id_adresse = new.id_adresse) || 
		CASE
			WHEN LENGTH(new.secpar::character varying) = 2 THEN '000'
			WHEN LENGTH(new.secpar::character varying) = 1 THEN '0000'
		END
		|| upper(new.secpar) || 
		CASE
			WHEN LENGTH(new.numpar::character varying) = 1 THEN '000' 
			WHEN LENGTH(new.numpar::character varying) = 2 THEN '00'
			WHEN LENGTH(new.numpar::character varying) = 3 THEN '0'
			WHEN LENGTH(new.numpar::character varying) = 4 THEN ''
		END
		|| new.numpar;

	   END IF;
	   END IF;
        END IF;
-- si état du dossier à Courrier initial, prochaine étape Réponse du propriétaire
	IF new.e_dos ='3' THEN
	   IF new.d_pdelais = old.d_pdelais THEN
	        DELETE FROM x_apps.xapps_an_v_hab_indigne_erreur WHERE id_dos = old.id_dos;
		INSERT INTO x_apps.xapps_an_v_hab_indigne_erreur VALUES
		(
		nextval('x_apps.xapps_an_v_hab_indigne_erreur_gid_seq'::regclass),
		old.id_adresse,
		old.id_dos,
		'Vous devez modifier la date du prochain délais.',
		now()
		);
                new.e_dos=old.e_dos;
                new.ep_dos=old.ep_dos;
		new.d_pdelais := old.d_pdelais;
		new.nm_doc := old.nm_doc;
		new.n_dos := old.n_dos;
		new.compt_ad := old.compt_ad;
		new.o_signal := old.o_signal;
		new.d_signal := old.d_signal;
		new.q_init := old.q_init;
		new.q_det := old.q_det;
		new.d_visit_d := old.d_visit_d;
		new.d_visit_e := old.d_visit_e;
		new.o_visit := old.o_visit;
		new.m_nvisit := old.m_nvisit;
		new.d_rvisit := old.d_rvisit;
		new.q_final := old.q_final;
		new.r_rvisit := old.r_rvisit;
		new.action := old.action;
		new.av_dos := old.av_dos;
		new.d_pvmed := old.d_pvmed;
		new.d_visitconf := old.d_visitconf;
		new.cloture := old.cloture;
		new.m_avise := old.m_avise;
		new.nblog := old.nblog;
		new.occupation := old.occupation;
		new.dos_anah := old.dos_anah;
		new.observ := old.observ;
		new.secpar := old.secpar;
		new.numpar := old.numpar;
		new.d_ftrav := old.d_ftrav;
		new.idu := old.idu;
	    ELSE
	    new.ep_dos='4';

            new.secpar := upper(new.secpar);
	    new.idu := (SELECT insee FROM x_apps.xapps_geo_vmr_adresse WHERE id_adresse = new.id_adresse) || 
		CASE
			WHEN LENGTH(new.secpar::character varying) = 2 THEN '000'
			WHEN LENGTH(new.secpar::character varying) = 1 THEN '0000'
		END
		|| upper(new.secpar) || 
		CASE
			WHEN LENGTH(new.numpar::character varying) = 1 THEN '000' 
			WHEN LENGTH(new.numpar::character varying) = 2 THEN '00'
			WHEN LENGTH(new.numpar::character varying) = 3 THEN '0'
			WHEN LENGTH(new.numpar::character varying) = 4 THEN ''
		END
		|| new.numpar;

            END IF;
        END IF;
-- si état du dossier à Réponse du propriétaire, prochaine étape Relance ou accusé réception
	IF new.e_dos ='4' THEN
	   IF new.d_pdelais = old.d_pdelais THEN
	        DELETE FROM x_apps.xapps_an_v_hab_indigne_erreur WHERE id_dos = old.id_dos;
		INSERT INTO x_apps.xapps_an_v_hab_indigne_erreur VALUES
		(
		nextval('x_apps.xapps_an_v_hab_indigne_erreur_gid_seq'::regclass),
		old.id_adresse,
		old.id_dos,
		'Vous devez modifier la date du prochain délais.',
		now()
		);
                new.e_dos=old.e_dos;
                new.ep_dos=old.ep_dos;
		new.d_pdelais := old.d_pdelais;
		new.nm_doc := old.nm_doc;
		new.n_dos := old.n_dos;
		new.compt_ad := old.compt_ad;
		new.o_signal := old.o_signal;
		new.d_signal := old.d_signal;
		new.q_init := old.q_init;
		new.q_det := old.q_det;
		new.d_visit_d := old.d_visit_d;
		new.d_visit_e := old.d_visit_e;
		new.o_visit := old.o_visit;
		new.m_nvisit := old.m_nvisit;
		new.d_rvisit := old.d_rvisit;
		new.q_final := old.q_final;
		new.r_rvisit := old.r_rvisit;
		new.action := old.action;
		new.av_dos := old.av_dos;
		new.d_pvmed := old.d_pvmed;
		new.d_visitconf := old.d_visitconf;
		new.cloture := old.cloture;
		new.m_avise := old.m_avise;
		new.nblog := old.nblog;
		new.occupation := old.occupation;
		new.dos_anah := old.dos_anah;
		new.observ := old.observ;
		new.secpar := old.secpar;
		new.numpar := old.numpar;
		new.d_ftrav := old.d_ftrav;
                new.idu := old.idu;
	   ELSE
	   new.ep_dos='5';

           new.secpar := upper(new.secpar);
	   new.idu := (SELECT insee FROM x_apps.xapps_geo_vmr_adresse WHERE id_adresse = new.id_adresse) || 
		CASE
			WHEN LENGTH(new.secpar::character varying) = 2 THEN '000'
			WHEN LENGTH(new.secpar::character varying) = 1 THEN '0000'
		END
		|| upper(new.secpar) || 
		CASE
			WHEN LENGTH(new.numpar::character varying) = 1 THEN '000' 
			WHEN LENGTH(new.numpar::character varying) = 2 THEN '00'
			WHEN LENGTH(new.numpar::character varying) = 3 THEN '0'
			WHEN LENGTH(new.numpar::character varying) = 4 THEN ''
		END
		|| new.numpar;

	   END IF;
        END IF;
-- si état du dossier à Relance ou accusé réception, prochaine étape Arrêté de mise en demeure
	IF new.e_dos ='5' THEN
           IF new.d_pdelais = old.d_pdelais THEN
	        DELETE FROM x_apps.xapps_an_v_hab_indigne_erreur WHERE id_dos = old.id_dos;
		INSERT INTO x_apps.xapps_an_v_hab_indigne_erreur VALUES
		(
		nextval('x_apps.xapps_an_v_hab_indigne_erreur_gid_seq'::regclass),
		old.id_adresse,
		old.id_dos,
		'Vous devez modifier la date du prochain délais.',
		now()
		);
                new.e_dos=old.e_dos;
                new.ep_dos=old.ep_dos;
		new.d_pdelais := old.d_pdelais;
		new.nm_doc := old.nm_doc;
		new.n_dos := old.n_dos;
		new.compt_ad := old.compt_ad;
		new.o_signal := old.o_signal;
		new.d_signal := old.d_signal;
		new.q_init := old.q_init;
		new.q_det := old.q_det;
		new.d_visit_d := old.d_visit_d;
		new.d_visit_e := old.d_visit_e;
		new.o_visit := old.o_visit;
		new.m_nvisit := old.m_nvisit;
		new.d_rvisit := old.d_rvisit;
		new.q_final := old.q_final;
		new.r_rvisit := old.r_rvisit;
		new.action := old.action;
		new.av_dos := old.av_dos;
		new.d_pvmed := old.d_pvmed;
		new.d_visitconf := old.d_visitconf;
		new.cloture := old.cloture;
		new.m_avise := old.m_avise;
		new.nblog := old.nblog;
		new.occupation := old.occupation;
		new.dos_anah := old.dos_anah;
		new.observ := old.observ;
		new.secpar := old.secpar;
		new.numpar := old.numpar;
		new.d_ftrav := old.d_ftrav;
                new.idu := old.idu;
            ELSE
	    new.ep_dos='6';

	    new.secpar := upper(new.secpar);
	    new.idu := (SELECT insee FROM x_apps.xapps_geo_vmr_adresse WHERE id_adresse = new.id_adresse) || 
		CASE
			WHEN LENGTH(new.secpar::character varying) = 2 THEN '000'
			WHEN LENGTH(new.secpar::character varying) = 1 THEN '0000'
		END
		|| upper(new.secpar) || 
		CASE
			WHEN LENGTH(new.numpar::character varying) = 1 THEN '000' 
			WHEN LENGTH(new.numpar::character varying) = 2 THEN '00'
			WHEN LENGTH(new.numpar::character varying) = 3 THEN '0'
			WHEN LENGTH(new.numpar::character varying) = 4 THEN ''
		END
		|| new.numpar;

	    END IF;
        END IF;
-- si état du dossier à Arrêté de mise en demeure, prochaine étape Annonce fin de travaux
	IF new.e_dos ='6' THEN
	   IF new.d_pdelais = old.d_pdelais THEN
	        DELETE FROM x_apps.xapps_an_v_hab_indigne_erreur WHERE id_dos = old.id_dos;
		INSERT INTO x_apps.xapps_an_v_hab_indigne_erreur VALUES
		(
		nextval('x_apps.xapps_an_v_hab_indigne_erreur_gid_seq'::regclass),
		old.id_adresse,
		old.id_dos,
		'Vous devez modifier la date du prochain délais.',
		now()
		);
                new.e_dos=old.e_dos;
                new.ep_dos=old.ep_dos;
		new.d_pdelais := old.d_pdelais;
		new.nm_doc := old.nm_doc;
		new.n_dos := old.n_dos;
		new.compt_ad := old.compt_ad;
		new.o_signal := old.o_signal;
		new.d_signal := old.d_signal;
		new.q_init := old.q_init;
		new.q_det := old.q_det;
		new.d_visit_d := old.d_visit_d;
		new.d_visit_e := old.d_visit_e;
		new.o_visit := old.o_visit;
		new.m_nvisit := old.m_nvisit;
		new.d_rvisit := old.d_rvisit;
		new.q_final := old.q_final;
		new.r_rvisit := old.r_rvisit;
		new.action := old.action;
		new.av_dos := old.av_dos;
		new.d_pvmed := old.d_pvmed;
		new.d_visitconf := old.d_visitconf;
		new.cloture := old.cloture;
		new.m_avise := old.m_avise;
		new.nblog := old.nblog;
		new.occupation := old.occupation;
		new.dos_anah := old.dos_anah;
		new.observ := old.observ;
		new.secpar := old.secpar;
		new.numpar := old.numpar;
		new.d_ftrav := old.d_ftrav;
	        new.idu := old.idu;
            ELSE
	    new.ep_dos='7';

           new.secpar := upper(new.secpar);
	   new.idu := (SELECT insee FROM x_apps.xapps_geo_vmr_adresse WHERE id_adresse = new.id_adresse) || 
		CASE
			WHEN LENGTH(new.secpar::character varying) = 2 THEN '000'
			WHEN LENGTH(new.secpar::character varying) = 1 THEN '0000'
		END
		|| upper(new.secpar) || 
		CASE
			WHEN LENGTH(new.numpar::character varying) = 1 THEN '000' 
			WHEN LENGTH(new.numpar::character varying) = 2 THEN '00'
			WHEN LENGTH(new.numpar::character varying) = 3 THEN '0'
			WHEN LENGTH(new.numpar::character varying) = 4 THEN ''
		END
		|| new.numpar;

	    END IF;
        END IF;
-- si état du dossier à Annonce fin de travaux, prochaine étape Visite de fin de travaux
	IF new.e_dos ='7' THEN
	 IF new.d_ftrav is null THEN
	        DELETE FROM x_apps.xapps_an_v_hab_indigne_erreur WHERE id_dos = old.id_dos;
		INSERT INTO x_apps.xapps_an_v_hab_indigne_erreur VALUES
		(
		nextval('x_apps.xapps_an_v_hab_indigne_erreur_gid_seq'::regclass),
		old.id_adresse,
		old.id_dos,
		'Vous devez saisir une date de fin de travaux.',
		now()
		);
                new.e_dos=old.e_dos;
                new.ep_dos=old.ep_dos;
		new.d_pdelais := old.d_pdelais;
		new.nm_doc := old.nm_doc;
		new.n_dos := old.n_dos;
		new.compt_ad := old.compt_ad;
		new.o_signal := old.o_signal;
		new.d_signal := old.d_signal;
		new.q_init := old.q_init;
		new.q_det := old.q_det;
		new.d_visit_d := old.d_visit_d;
		new.d_visit_e := old.d_visit_e;
		new.o_visit := old.o_visit;
		new.m_nvisit := old.m_nvisit;
		new.d_rvisit := old.d_rvisit;
		new.q_final := old.q_final;
		new.r_rvisit := old.r_rvisit;
		new.action := old.action;
		new.av_dos := old.av_dos;
		new.d_pvmed := old.d_pvmed;
		new.d_visitconf := old.d_visitconf;
		new.cloture := old.cloture;
		new.m_avise := old.m_avise;
		new.nblog := old.nblog;
		new.occupation := old.occupation;
		new.dos_anah := old.dos_anah;
		new.observ := old.observ;
		new.secpar := old.secpar;
		new.numpar := old.numpar;
		new.d_ftrav := old.d_ftrav;
                new.idu := old.idu;
            ELSE
	    new.ep_dos='8';
	    new.d_pdelais := new.d_ftrav + (15 || ' day')::interval;

           new.secpar := upper(new.secpar);
	   new.idu := (SELECT insee FROM x_apps.xapps_geo_vmr_adresse WHERE id_adresse = new.id_adresse) || 
		CASE
			WHEN LENGTH(new.secpar::character varying) = 2 THEN '000'
			WHEN LENGTH(new.secpar::character varying) = 1 THEN '0000'
		END
		|| upper(new.secpar) || 
		CASE
			WHEN LENGTH(new.numpar::character varying) = 1 THEN '000' 
			WHEN LENGTH(new.numpar::character varying) = 2 THEN '00'
			WHEN LENGTH(new.numpar::character varying) = 3 THEN '0'
			WHEN LENGTH(new.numpar::character varying) = 4 THEN ''
		END
		|| new.numpar;

            END IF;
        END IF;
-- si état du dossier à Visite de fin de travaux, prochaine étape Clôture fin de travaux
	IF new.e_dos ='8' THEN
	    IF new.d_pdelais = old.d_pdelais THEN
	        DELETE FROM x_apps.xapps_an_v_hab_indigne_erreur WHERE id_dos = old.id_dos;
		INSERT INTO x_apps.xapps_an_v_hab_indigne_erreur VALUES
		(
		nextval('x_apps.xapps_an_v_hab_indigne_erreur_gid_seq'::regclass),
		old.id_adresse,
		old.id_dos,
		'Vous devez modifier la date du prochain délais.',
		now()
		);
                new.e_dos=old.e_dos;
                new.ep_dos=old.ep_dos;
		new.d_pdelais := old.d_pdelais;
		new.nm_doc := old.nm_doc;
		new.n_dos := old.n_dos;
		new.compt_ad := old.compt_ad;
		new.o_signal := old.o_signal;
		new.d_signal := old.d_signal;
		new.q_init := old.q_init;
		new.q_det := old.q_det;
		new.d_visit_d := old.d_visit_d;
		new.d_visit_e := old.d_visit_e;
		new.o_visit := old.o_visit;
		new.m_nvisit := old.m_nvisit;
		new.d_rvisit := old.d_rvisit;
		new.q_final := old.q_final;
		new.r_rvisit := old.r_rvisit;
		new.action := old.action;
		new.av_dos := old.av_dos;
		new.d_pvmed := old.d_pvmed;
		new.d_visitconf := old.d_visitconf;
		new.cloture := old.cloture;
		new.m_avise := old.m_avise;
		new.nblog := old.nblog;
		new.occupation := old.occupation;
		new.dos_anah := old.dos_anah;
		new.observ := old.observ;
		new.secpar := old.secpar;
		new.numpar := old.numpar;
		new.d_ftrav := old.d_ftrav;
		new.idu := old.idu;
            ELSE
	    new.ep_dos='9';

           new.secpar := upper(new.secpar);
	   new.idu := (SELECT insee FROM x_apps.xapps_geo_vmr_adresse WHERE id_adresse = new.id_adresse) || 
		CASE
			WHEN LENGTH(new.secpar::character varying) = 2 THEN '000'
			WHEN LENGTH(new.secpar::character varying) = 1 THEN '0000'
		END
		|| upper(new.secpar) || 
		CASE
			WHEN LENGTH(new.numpar::character varying) = 1 THEN '000' 
			WHEN LENGTH(new.numpar::character varying) = 2 THEN '00'
			WHEN LENGTH(new.numpar::character varying) = 3 THEN '0'
			WHEN LENGTH(new.numpar::character varying) = 4 THEN ''
		END
		|| new.numpar;

	    END IF;

        END IF;
-- si état du dossier à Clôture fin de travaux
	IF new.e_dos ='9' THEN
	   new.ep_dos='10';
           new.d_pdelais := now() + (15 || ' day')::interval;

           new.secpar := upper(new.secpar);
	   new.idu := (SELECT insee FROM x_apps.xapps_geo_vmr_adresse WHERE id_adresse = new.id_adresse) || 
		CASE
			WHEN LENGTH(new.secpar::character varying) = 2 THEN '000'
			WHEN LENGTH(new.secpar::character varying) = 1 THEN '0000'
		END
		|| upper(new.secpar) || 
		CASE
			WHEN LENGTH(new.numpar::character varying) = 1 THEN '000' 
			WHEN LENGTH(new.numpar::character varying) = 2 THEN '00'
			WHEN LENGTH(new.numpar::character varying) = 3 THEN '0'
			WHEN LENGTH(new.numpar::character varying) = 4 THEN ''
		END
		|| new.numpar;

        END IF;
-- si dossier clos
	IF new.cloture = true THEN
	   new.e_dos='10';
	   new.ep_dos='10';
	   new.d_pdelais = null;

           new.secpar := upper(new.secpar);
	   new.idu := (SELECT insee FROM x_apps.xapps_geo_vmr_adresse WHERE id_adresse = new.id_adresse) || 
		CASE
			WHEN LENGTH(new.secpar::character varying) = 2 THEN '000'
			WHEN LENGTH(new.secpar::character varying) = 1 THEN '0000'
		END
		|| upper(new.secpar) || 
		CASE
			WHEN LENGTH(new.numpar::character varying) = 1 THEN '000' 
			WHEN LENGTH(new.numpar::character varying) = 2 THEN '00'
			WHEN LENGTH(new.numpar::character varying) = 3 THEN '0'
			WHEN LENGTH(new.numpar::character varying) = 4 THEN ''
		END
		|| new.numpar;

        END IF;

-- si dossier plus clôturé, alors l'état d'avancement doit être rempli avec une date de délais
IF new.cloture = false AND new.e_dos = '10' THEN
	DELETE FROM x_apps.xapps_an_v_hab_indigne_erreur WHERE id_dos = old.id_dos;
	INSERT INTO x_apps.xapps_an_v_hab_indigne_erreur VALUES
	(
	nextval('x_apps.xapps_an_v_hab_indigne_erreur_gid_seq'::regclass),
	old.id_adresse,
	old.id_dos,
	'Vous devez renseigner un état d''avancement et un délais sinon clore le dossier.',
	now()
	);
		new.cloture=true;
		new.e_dos=old.e_dos;
                new.ep_dos=old.ep_dos;
		new.d_pdelais := old.d_pdelais;
        	new.nm_doc := old.nm_doc;
		new.n_dos := old.n_dos;
		new.compt_ad := old.compt_ad;
		new.o_signal := old.o_signal;
		new.d_signal := old.d_signal;
		new.q_init := old.q_init;
		new.q_det := old.q_det;
		new.d_visit_d := old.d_visit_d;
		new.d_visit_e := old.d_visit_e;
		new.o_visit := old.o_visit;
		new.m_nvisit := old.m_nvisit;
		new.d_rvisit := old.d_rvisit;
		new.q_final := old.q_final;
		new.r_rvisit := old.r_rvisit;
		new.action := old.action;
		new.av_dos := old.av_dos;
		new.d_pvmed := old.d_pvmed;
		new.d_visitconf := old.d_visitconf;
		new.cloture := old.cloture;
		new.m_avise := old.m_avise;
		new.nblog := old.nblog;
		new.occupation := old.occupation;
		new.dos_anah := old.dos_anah;
		new.observ := old.observ;
		new.secpar := old.secpar;
		new.numpar := old.numpar;
		new.d_ftrav := old.d_ftrav;
		new.idu := old.idu;
END IF;
--

END IF;
--
END IF;
--



return new;
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

COMMENT ON FUNCTION m_habitat.ft_m_avancdos() IS 'Fonction dont l''objet est de générer automatiquement la prochaine étape du dossier après saisie de l''état d''avancement.';


-- Trigger: t_t3_an_hab_indigne_avancdos on m_habitat.an_hab_indigne_sign

-- DROP TRIGGER t_t3_an_hab_indigne_avancdos ON m_habitat.an_hab_indigne_sign;

CREATE TRIGGER t_t3_an_hab_indigne_avancdos
  BEFORE INSERT OR UPDATE
  ON m_habitat.an_hab_indigne_sign
  FOR EACH ROW
  EXECUTE PROCEDURE m_habitat.ft_m_avancdos();


-- Function: m_habitat.ft_m_signalclos_delete()

-- DROP FUNCTION m_habitat.ft_m_signalclos_delete();

CREATE OR REPLACE FUNCTION m_habitat.ft_m_signalclos_delete()
  RETURNS trigger AS
$BODY$BEGIN



-- si le dossier est clos on ne peut pas le supprimer
IF old.cloture = false THEN
return old;

END IF;

return new;

END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

COMMENT ON FUNCTION m_habitat.ft_m_signalclos_delete() IS 'Fonction dont l''objet est de gérer la non suppression d''un dossier si cloturé.';

-- Trigger: t_t4_an_hab_indigne_delete on m_habitat.an_hab_indigne_sign

-- DROP TRIGGER t_t4_an_hab_indigne_delete ON m_habitat.an_hab_indigne_sign;

CREATE TRIGGER t_t4_an_hab_indigne_delete
  BEFORE DELETE
  ON m_habitat.an_hab_indigne_sign
  FOR EACH ROW
  EXECUTE PROCEDURE m_habitat.ft_m_signalclos_delete();








