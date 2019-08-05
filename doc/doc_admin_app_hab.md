![picto](img/Logo_web-GeoCompiegnois.png)

# Documentation d'administration de l'application HABITAT #

# Généralité

* Statut
  - [ ] à rédiger
  - [x] en cours de rédaction
  - [ ] relecture
  - [ ] finaliser
  - [ ] révision

* Historique des versions

|Date | Auteur | Description
|:---|:---|:---|
|02/08/2019|Grégory BODET|version initiale|

# Généralité

|Représentation| Nom de l'application |Résumé|
|:---|:---|:---|
|![picto](/doc/img/habitat_bleu.png)|Habitat|Cette application est dédiée à la gestion et la consultation des données liées à l'habitat notament la gestion des signalements d'habitat indigne.|

# Accès

|Public|Métier|Accès restreint|
|:-:|:-:|:---|
||X|Accès réservé à la charge de mission habitat pour le moment.|

# Droit par profil de connexion

* **Prestataires**
Sans objet

* **Personnes du service métier**

|Fonctionnalités|Lecture|Ecriture|Précisions|
|:---|:-:|:-:|:---|
|Toutes|x||L'ensemble des fonctionnalités liés à l'habitat indigne (recherches, cartographie, fiches d'informations, ...) sont accessibles uniquement à la chargée de mission Habitat.|
|Fiche d'information Hbaitat Indigne|x|x|Peut modifier les données de signalement d'habitat indigne.|


* **Autres profils**

Sans objet

# Les données

Sont décrites ici les Géotables et/ou Tables intégrées dans GEO pour les besoins de l'application et en lien avec la gestion de l'habitat indigne pour le moment. Les autres données servant d'habillage (pour la cartographie ou les recherches) sont listées dans les autres parties ci-après. Le tableau ci-dessous présente uniquement les changements (type de champ, formatage du résultat, ...) ou les ajouts (champs calculés, filtre, ...) non présents dans la donnée source. 

## Table : `an_hab_indigne_sign`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_clos    |x|x|Etat|Formate en HTML le message à afficher dans la fiche d'information en cas d'erreur selon un temps définit (évite un affichage permanent du message)|Signalement d'habitat indigne à l'adresse|`CASE WHEN {cloture} = FALSE THEN '<acronym title="Dossier en cours">' '<img src="http://geo.compiegnois.fr/documents/metiers/hab/geo_dossier_ouvert.png" width=21 height=30>' '</acronym>' ELSE '<acronym title="Dossier clos">' '<img src="http://geo.compiegnois.fr/documents/metiers/hab/geo_dossier_clos.png" width=21 height=30>' '</acronym>'END`|
|affiche_delais     |x|x|null|Détermine si la date du prochain délais est dépassé (true ou false)|Filtre: Dossier horsdélais|`{d_pdelais} < now()`|
|affiche_dossier  |x|x|null|Formate l'affichage du nom du dossier|Dans les recherches pour gérer l'affichage du résultat|`Dossier : {nm_doc}`|
|affiche_dossier_comp  |x|x|null|Formate l'affichage de l'état d'avancement du dossier, la prochaine étape et le prochain délais|Dans les recherches pour gérer l'affichage du résultat|`'Avancement du dossier : '  CASE WHEN {e_dos} = '0' THEN 'Signalement' WHEN {e_dos} = '1' THEN 'Visite'WHEN {e_dos} = '2' THEN 'Rapport de visite' WHEN {e_dos} = '3' THEN 'Courrier initiale' WHEN {e_dos} = '4' THEN 'Réponse du propriétaire' WHEN {e_dos} = '5' THEN 'Relance ou accusé réception' WHEN {e_dos} = '6' THEN 'Arrêté de mise en demeure' WHEN {e_dos} = '7' THEN 'Annonce de fin de travaux' WHEN {e_dos} = '8' THEN 'Visite de fin de travaux' WHEN {e_dos} = '9' THEN 'Dossier à cloturer' END  '<br>Prochaine étape : '  CASE WHEN {ep_dos} = '0' THEN 'Signalement' WHEN {ep_dos} = '1' THEN 'Visite' WHEN {ep_dos} = '2' THEN 'Rapport de visite' WHEN {ep_dos} = '3' THEN 'Courrier initiale' WHEN {ep_dos} = '4' THEN 'Réponse du propriétaire' WHEN {ep_dos} = '5' THEN 'Relance ou accusé réception' WHEN {ep_dos} = '6' THEN 'Arrêté de mise en demeure' WHEN {ep_dos} = '7' THEN 'Annonce de fin de travaux' WHEN {ep_dos} = '8' THEN 'Visite de fin de travaux' WHEN {ep_dos} = '9' THEN 'Dossier à cloturer' END  '<br>Prochain délais : ' {affiche_pdelais}`|
|affiche_ordre|x|x|null|Formate un nombre de jour entre la date de signalement et la date du jour pour opérer un tri dans la fiche d'information||`to_char(now() - {d_signal}::timestamp without time zone,'DD')::integer`|
|affiche_par |x|x|Parcelle|Génére l'affichage de la référence cadastrale|Fiche de signalement d'habitat indigne|`{secpar} {numpar}`|
|affiche_pdelais  |x|x|Délais|Génére l'affichage de la référence cadastrale|Signalement d'habitat indigne à l'adresse et Champ calculé: affiche_dossier_comp|`CASE WHEN {d_pdelais} < now() THEN '<table border=0><tr><td bgcolor="#FF0000"><b><font color="#FFFFFF">' to_char({d_pdelais},'DD-MM-YYYY') '</font></b></td></tr></table>' ELSE '<table border=0><tr><td bgcolor="#008000"><b><font color="#000000">' to_char({d_pdelais},'DD-MM-YYYY') '</font></b></td></tr></table>' END`|
|affiche_qfinal   |x|x|Qualification finale|Génére l'affichage des images correspondant à la qualification du signalement|Signalement d'habitat indigne à l'adresse (plus utilisé dans cette fiche pour le moment)|`CASE WHEN {q_final} = '00' THEN 'Non renseignée' WHEN {q_final} = '10' THEN '<img src="http://geo.compiegnois.fr/documents/metiers/hab/habitat_indigne_peril.png" width=125 height=19>' WHEN {q_final} = '20' THEN '<img src="http://geo.compiegnois.fr/documents/metiers/hab/habitat_indigne_insalubrite.png" width=125 height=19>' WHEN {q_final} = '30' THEN '<img src="http://geo.compiegnois.fr/documents/metiers/hab/habitat_indigne_rsd.png" width=125 height=19>' WHEN {q_final} = '40' THEN '<img src="http://geo.compiegnois.fr/documents/metiers/hab/habitat_indigne_incurie.png" width=125 height=19>' WHEN {q_final} = '50' THEN '<img src="http://geo.compiegnois.fr/documents/metiers/hab/habitat_indigne_indecence.png" width=125 height=19>' WHEN {q_final} = '60' THEN '<img src="http://geo.compiegnois.fr/documents/metiers/hab/habitat_indigne_autre.png" width=125 height=19>' END`|
|affiche_qinit    |x|x|Qualification|Génére l'affichage des images correspondant à la qualification du signalement|Signalement d'habitat indigne à l'adresse|`CASE WHEN {q_init} = '00' THEN 'Non renseignée' WHEN {q_init} = '10' THEN '<img src="http://geo.compiegnois.fr/documents/metiers/hab/habitat_indigne_peril.png" width=125 height=19>' WHEN {q_init} = '20' THEN '<img src="http://geo.compiegnois.fr/documents/metiers/hab/habitat_indigne_insalubrite.png" width=125 height=19>' WHEN {q_init} = '30' THEN '<img src="http://geo.compiegnois.fr/documents/metiers/hab/habitat_indigne_rsd.png" width=125 height=19>' WHEN {q_init} = '40' THEN '<img src="http://geo.compiegnois.fr/documents/metiers/hab/habitat_indigne_incurie.png" width=125 height=19>' WHEN {q_init} = '50' THEN '<img src="http://geo.compiegnois.fr/documents/metiers/hab/habitat_indigne_indecence.png" width=125 height=19>' WHEN {q_init} = '60' THEN '<img src="http://geo.compiegnois.fr/documents/metiers/hab/habitat_indigne_autre.png" width=125 height=19>' END`|
|av_dos     |||Avancement du dossier (précisions)||Signalement d'habitat indigne à l'adresse et Fiche de signalement d'habitat indigne ||
|cloture  ||x|Dossier clos|Formaté à oui / non|Fiche de signalement d'habitat indigne ||
|compt_ad  |||Complément d'adresse||Fiche de signalement d'habitat indigne ||
|d_ftrav   ||x|Date de fin de travaux|`dd/mm/yyyy`|Fiche de signalement d'habitat indigne ||
|d_pdelais    ||x|Prochain délai|`dd/mm/yyyy`|Fiche de signalement d'habitat indigne ||
|d_pvmed     ||x|Date du procès-verbal de mise en demeure|`dd/mm/yyyy`|Fiche de signalement d'habitat indigne ||
|d_rvisit      ||x|Date du rapport de la visite|`dd/mm/yyyy`|Fiche de signalement d'habitat indigne ||
|d_signal       ||x|Signalé le|`dd/mm/yyyy`|Fiche de signalement d'habitat indigne ||
|d_visit_d        ||x|Date de demande d'une visite|`dd/mm/yyyy`|Fiche de signalement d'habitat indigne ||
|d_visit_e         ||x|Date de la visite|`dd/mm/yyyy`|Fiche de signalement d'habitat indigne ||
|d_visitconf        ||x|Date de la visite de conformité|`dd/mm/yyyy`|Fiche de signalement d'habitat indigne ||
|dos_anah         ||x|Dossier ANAH|`oui/non`|Fiche de signalement d'habitat indigne ||
|e_dos          ||x|Avancement du dossier|`Liste de domaine lt_hab_indigne_avancdos`|Fiche de signalement d'habitat indigne ||
|ep_dos           ||x|Prochaine étape|`Liste de domaine lt_hab_indigne_avancdos`|Fiche de signalement d'habitat indigne ||
|m_avise          |||Information donnée au maire||Fiche de signalement d'habitat indigne ||
|m_nvisit           |||Motif de la non visite||Fiche de signalement d'habitat indigne ||
|n_dos            |||Numéro de dossier de l'organisme extérieur ayant fait le signalement||Fiche de signalement d'habitat indigne ||
|nblog            |||Nombre de logements||Fiche de signalement d'habitat indigne ||
|nm_doc             |||Dossier||Fiche de signalement d'habitat indigne ||
|numpar             |||N° parcelle||Fiche de signalement d'habitat indigne ||
|o_signal              |||Par||Fiche de signalement d'habitat indigne ||
|observ               |||Observations||Fiche de signalement d'habitat indigne ||
|occupation               ||x|Le logement ou l'immeuble concerné est-il occupé ?|`oui/non`|Fiche de signalement d'habitat indigne ||
|q_det               |||Détail de la qualification initiale||Fiche de signalement d'habitat indigne ||
|q_final            ||x|Qualification finale|`Liste de domaine lt_hab_indigne_qualif`|Fiche de signalement d'habitat indigne ||
|q_init            ||x|Qualification|`Liste de domaine lt_hab_indigne_qualif`|Fiche de signalement d'habitat indigne ||
|r_rvisit             |||Résumé du rapport de visite||Fiche de signalement d'habitat indigne ||
|secpar              |||Section cadastrale||Fiche de signalement d'habitat indigne ||

   * filtres : aucun
   * relations :
   
   |Géotables ou Tables| Champs de jointure | Type |
  |:---|:---|:---|
  | an_hab_indigne_prop |id_dos| 0..n (égal) |
  | xapps_geo_v_hab_indigne |id_adresse| 1 (égal) |
  | xapps_an_v_hab_indigne_erreur |id_dos| 0..1 (égal) |
  | Parcelle (Alpha) V3 |idu| 0..1 (égal) |
  | xapps_an_vmr_cadastre_prop_local |idu| 0..n (égal) |
  | xapps_geo_v_hab_indigne_delais |id_dos| 0..1 (égal) |
  | an_hab_indigne_media |id_dos| 0..n (égal) |
  | an_hab_indigne_occ |id_dos| 0..n (égal) |
   
   * particularité(s) : aucune

## Table : `an_hab_indigne_sign`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_occupant     |x|x|Nom, prénom|Formate du nom et prénom dans un seul attribut d'affichage|Fiche de signalement d'habitat indigne, recherche d'un occupant, filtre occupant|`CASE WHEN {titre} = '00' THEN {nom}  ' '  {prenom} ELSE CASE WHEN {titre} = '10' THEN 'M' ' '  {nom}  ' ' {prenom} WHEN {titre} = '20' THEN 'Mme'  ' ' {nom}  ' '  {prenom} WHEN {titre} = '30' THEN 'M et Mme'  ' '  {nom}  ' '  {prenom} WHEN {titre} = '40' THEN {titre_aut} ' '  {nom} ' '  {prenom} END END`|
|arefe      |||Nom||Fiche occupant||
|e_arefe       |||Email||Fiche occupant||
|e_occ       |||Email||Fiche occupant||
|e_refe       |||Email||Fiche occupant||
|enf_occ       |||Nb d'enfants et âge||Fiche occupant||
|nb_occ      |||Nombre d'occupants||Fiche occupant||
|nom       |||Nom||Fiche occupant||
|prenom       |||Prénom||Fiche occupant||
|r_loca       ||x|Relogé|`oui/non`|Fiche occupant||
|refe        |||Nom||Fiche occupant||
|s_social        |||Situation sociale||Fiche occupant||
|situation        |||Situation|`Liste de domaine lt_hab_indigne_situ`|Fiche occupant||
|t_social        ||x|Traitement sociale||Fiche occupant||
|tela_arefe        |||Autre téléphone||Fiche occupant||
|tela_occ         |||Autre téléphone||Fiche occupant||
|tela_refe         |||Autre téléphone||Fiche occupant||
|telf_arefe         |||Téléphone fixe||Fiche occupant||
|telf_occ         |||Téléphone fixe ||Fiche occupant||
|telf_refe         |||Téléphone fixe||Fiche occupant||
|telp_arefe          |||Téléphone portable||Fiche occupant||
|telp_occ          |||Téléphone portable||Fiche occupant||
|telp_refe          |||Téléphone portable||Fiche occupant||
|titre           |||Titre de l'occupant||Fiche occupant||
|titre_aut           |||Autre titre||Fiche occupant||

   * filtres : aucun
   * relations :
   
   |Géotables ou Tables| Champs de jointure | Type |
  |:---|:---|:---|
  | an_hab_indigne_sign - xapps_geo_v_hab_indigne|id_dos - id_adresse| 1 (égal) - 1 (égal)|

   
   * particularité(s) : aucune
