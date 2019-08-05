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

## Table : ` an_hab_indigne_occ`

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
   
   ## Table : `an_hab_indigne_prop`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|ad_contact       |||Adresse||Fiche propiétaire||
|affiche_prop      |x|x|Nom (ou bailleur)|Formate le libellé du propriétaire|Fiche de signalement d'habitat indigne|`CASE WHEN {titre} = '00' THEN {nom}  ' '  {prenom} ELSE CASE WHEN {titre} = '10' THEN 'M' ' '  {nom}  ' ' {prenom} WHEN {titre} = '20' THEN 'Mme'  ' ' {nom}  ' '  {prenom} WHEN {titre} = '30' THEN 'M et Mme'  ' '  {nom}  ' '  {prenom} WHEN {titre} = '40' THEN {titre_aut} ' '  {nom} ' '  {prenom} END END`|
|arefe      |||Nom||Fiche occupant||
|compt_ad        |||Complément d'adresse||Fiche propiétaire||
|contact         |||Complément d'adresse||Fiche propiétaire||
|cp         |||Code postal||Fiche propiétaire||
|e_contact         |||EMail||Fiche propiétaire||
|e_prop         |||Email||Fiche propiétaire||
|nom         |||Nom (ou bailleur)||Fiche propiétaire||
|nom_gest         |||Gestionnaire||Fiche propiétaire||
|nom_voie         |||Voie||Fiche propiétaire||
|numero         |||N°||Fiche propiétaire||
|pays          |||Pays||Fiche propiétaire||
|prenom          |||Prénom||Fiche propiétaire||
|repet           |||Indice de répétition||Fiche propiétaire||
|t_prop           ||x|Type de propriété|`Liste de domaine lt_hab_indigne_tprop`|Fiche propiétaire||
|tela_contact           |||Autre téléphone||Fiche propiétaire||
|tela_prop            |||Autre téléphone||Fiche propiétaire||
|telf_contact            |||Téléphone fixe||Fiche propiétaire||
|telf_occ            |||Téléphone fixe||Fiche propiétaire||
|telp_contact             |||Téléphone portable||Fiche propiétaire||
|titre              |||Titre de l'occupant||Fiche propiétaire||
|titre_aut              |||Autre titre||Fiche propiétaire||
|type_voie            ||x|Type de voie|`Liste de domaine lt_type_voie`|Fiche propiétaire||

   * filtres : aucun
   * relations : aucune
   * particularité(s) : aucune
   
 
 ## Table : `an_hab_indigne_media`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|l_doc        |||Descriptif||Fiche média habitat indigne||
|op_sai         ||x|Opérateur de saisie|`%USER_LOGIN%`|Fiche média habitat indigne||

   * filtres : aucun
   * relations : aucune
   * particularité(s) : aucune

## Table : `xapps_an_v_hab_indigne_erreur`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_message    |x|x|null|Formate en HTML le message à afficher dans la fiche d'information en cas d'erreur selon un temps définit (évite un affichage permanent du message)|Fiche d'information PEI|`CASE WHEN extract(epoch from  now()::timestamp) - extract(epoch from {horodatage}::timestamp) <= 3 then '<table width=100%><td bgcolor="#FF000"> <font size=4 color="#ffffff"><center><b>' {erreur} '</b></center></font></td></table>' ELSE '' END`|


   * filtres : aucun
   * relations : aucune
   * particularité(s) : aucune
   
## Table : `xapps_an_vmr_cadastre_prop_local`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|url_fichelocal     |x|x|Fiche|Formate en HTML le lien pour accéder à la fiche local en PDF de GEO|Fiche d'information des propriétaires|``CASE WHEN {id_local} is not null or {id_local} <> '' THEN
'<a href="http://geo.compiegnois.fr/cadastre/getDescriptifLocal?dbcp=b6b597b9-cb6c-11e7-8f4e-4dc660d3c418&catalogId=default&schema=r_bg_majic&id_local=' || {id_local} || '" target="_blank">' '<img src="http://geo.compiegnois.fr/documents/cms/fi_local_geo.png" alt="">''</a>'ELSE''END`|


   * filtres : aucun
   * relations : aucune
   * particularité(s) : aucune
   

# Les fonctionnalités

Sont présentées ici uniquement les fonctionnalités spécifiques à l'application.

## Recherche globale : `Recherche dans la Base Adresse Locale`

Cette recherche permet à l'utilisateur de faire une recherche libre sur une adresse.

Cette recherche a été créée pour l'application RVA. Le détail de celle-ci est donc à visualiser dans le répertoire GitHub rva au niveau de la documentation applicative.


## Recherche globale : `Recherche dans la Base de Voie Locale`

Cette recherche permet à l'utilisateur de faire une recherche libre sur le libellé d'une voie.

Cette recherche a été créée pour l'application RVA. Le détail de celle-ci est donc à visualiser dans le répertoire GitHub rva au niveau de la documentation applicative.


## Recherche globale : `Localiser une commune de l'ARC`

Cette recherche permet à l'utilisateur de faire une recherche d'une commune.

## Recherche globale : `Localiser un équipement`

Cette recherche permet à l'utilisateur de faire une recherche sur un équipement.

## Recherche (clic sur la carte) : `Signalement d'habitat indigne`

Cette recherche permet à l'utilisateur de cliquer sur la carte au niveau d'une adresse et de remonter les informations de signalement présent à cette adresse.

  * Configuration :

Source : `xapps_geo_v_hab_indigne`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Adresse|x|||||
|affiche_signalement|x|||||


(la détection des doublons n'est pas activée ici)

 * Filtres : aucun

 * Fiches d'information active : Signalement d'habitat indigne à l'adresse


## Recherche (clic sur la carte) : `Bâtiments du parc locatif social`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations d'un bâtiment du parc social.

  * Configuration :

Source : `xapps_geo_vmr_rpls_bati`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Raisonn social du bailleur (rs)|x|||||
|affiche_num_bati|x|||||
|affiche_logement|x|||||

(la détection des doublons n'est pas activée ici)

 * Filtres : aucun

 * Fiches d'information active : Informations sur le bâtiment du parclocatif social
 
 ## Recherche (clic sur la carte) : `Programme de logements sociaux`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations d'un programme du parc social.

  * Configuration :

Source : `xapps_geo_vmr_rpls_programme`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Raisonn social du bailleur (rs)|x|||||
|affiche_num_prog|x|||||
|affiche_logement|x|||||

(la détection des doublons n'est pas activée ici)

 * Filtres : aucun

 * Fiches d'information active : Informations sur le programme de logements sociaux
 
 
  ## Recherche (clic sur la carte) : `Observatoire des copropriétés`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations de la copropriété.

  * Configuration :

Source : `xapps_geo_vmr_rpls_programme`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_nom|x|||||
|affiche_info|x|||||


(la détection des doublons n'est pas activée ici)

 * Filtres : aucun

 * Fiches d'information active : Observatoire des copropriétés
 
   ## Recherche (clic sur la carte) : `Informations au carreau`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations de la copropriété.

  * Configuration :

Source : `geo_carcal_rfl2010_apc`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_result|x|||||
|affiche_variable|x|||||


(la détection des doublons n'est pas activée ici)

 * Filtres : aucun

 * Fiches d'information active : Informations au carreau
 
    ## Recherche (clic sur la carte) : `Parcelle(s) sélectionnée(s)`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations de la parcelle.

Se reporter au dossier docurba.

## Recherche : `Toutes les recherches cadastrales`

L'ensemble des recherches cadastrales ont été formatées et intégrées par l'éditeur via son module GeoCadastre.
Seul le nom des certaines recherches a été modifié par l'ARC pour plus de compréhension des utilisateurs.

Cette recherche est détaillée dans le répertoire GitHub `docurba`.


## Recherche : `Par identifiant du bailleur`

Cette recherche permet à l'utilisateur de faire une recherche guidée sur l'identifiant du bailleur.

  * Configuration :

Source : `an_rpls`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_titre|x|||||
|N° du logement (bailleur) (ident_int)|x|||||
|Commune|x|||||
|Adresse (affiche_adresse)|x|||||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Identifiant bailleur|x|ident_int|est égale à une valeur choisie par l'utilisateur||||||Titre : N° du logement (bailleur)|


(1) si liste de domaine

 * Fiches d'information active : Informations sur le logement


## Recherche : `Par adresse`

Cette recherche permet à l'utilisateur de faire une recherche guidée sur un logement social par adresse.

  * Configuration :

Source : `an_rpls`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_titre|x|||||
|N° du logement (bailleur) (ident_int)|x|||||
|Commune|x|||||
|Adresse (affiche_adresse)|x|||||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Commune|x|depcom_red|est égale à une valeur de liste de choix |commune RPLS|||||Titre : Choisir la commune|
|Adresse|x|ident_int|est égale à une valeur de liste de choix |Liste adresse|||||Titre : Saisir une adresse|



(1) si liste de domaine

 * Fiches d'information active : Informations sur le logement


## Recherche : `Par identifiant bâti du bailleur`

Cette recherche permet à l'utilisateur de faire une recherche guidée sur l'identifiant du bâtiment du bailleur.

  * Configuration :

Source : `xapps_geo_vmr_rpls_bati`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_result|x|||||
|affiche_num_bati|x|||||
|Commune|x|||||


(la détection des doublons n'est pas activée ici)

 * Filtres :

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Code bâtiment bailleur|x|id_rpls_bati|est égale à une valeur suggérée |RPLS - code batiment|||||Titre : N° du bâtiment (bailleur) :|


(1) si liste de domaine

 * Fiches d'information active : Informations sur le bâtiment du parc locatif social
 
 ## Recherche : `Par identifiant du bailleur`

Cette recherche permet à l'utilisateur de faire une recherche guidée d'un programme via l'identifiant du bailleur.

  * Configuration :

Source : `xapps_geo_vmr_rpls_programme`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_titre|x|||||
|affiche_num_prog|x|||||
|Commune|x|||||


(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Commune|x|commune|est égale à une valeur de liste de choix |commune programme|||||Titre : Choisir la commune|
|Identifiant du programme|x|id_rpls_prog|est égale à une valeur de liste de choix |Identifiant du programme|||||Titre : Sélectionnez le programme de logements|



(1) si liste de domaine

 * Fiches d'information active : Informations sur le programme de logements sociaux
 
  ## Recherche : `Par nom du bailleur`

Cette recherche permet à l'utilisateur de faire une recherche guidée d'un programme via le nom du bailleur.

  * Configuration :

Source : `xapps_geo_vmr_rpls_programme`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_titre|x|||||
|affiche_num_prog|x|||||
|Commune|x|||||


(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Commune|x|commune|est égale à une valeur de liste de choix |commune programme|||||Titre : Choisir la commune|
|Raison sociale du bailleur|x|rs_long|est égale à une valeur de liste de choix |Liste bailleurs sociaux|||||Titre : Choisir le nom du bailleur|
|Identifiant du programme||id_rpls_prog|est égale à une valeur de liste de choix |Identifiant du programme|||||Titre : Sélectionnez le programme de logements|



(1) si liste de domaine

 * Fiches d'information active : Informations sur le programme de logements sociaux
 
  
  ## Recherche : `RPLS - statistique communale`

Cette recherche permet à l'utilisateur de faire une recherche guidée sur une commune pour accéder aux statistiques communales en terme de logements sociaux.

  * Configuration :

Source : `an_rpls_com`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_titre|x|||||
|Communne|x|||||
|affiche_recherche|x|||||
|fiche_logement|x|||||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Choix commune|x|insee|est égale à une valeur de liste de choix |RPLS - liste commune|||||Titre : Choix de la commune|




(1) si liste de domaine

 * Fiches d'information active : RPLS - Statistique communale
 
  ## Recherche : `RPLS - statistique ARC`

Cette recherche permet à l'utilisateur d'accéder aux statistiques ARC en terme de logements sociaux.

  * Configuration :

Source : `an_rpls_arc`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_titre|x|||||
|Nom Epci|x|||||
|affiche_recherche|x|||||
|fiche_logement|x|||||

(la détection des doublons n'est pas activée ici)

 * Filtres : aucun


(1) si liste de domaine

 * Fiches d'information active : RPLS - Statistique ARC
 
 ## Recherche : `Copropriété par commune`

Cette recherche permet à l'utilisateur de faire une recherche guidée d'une copropriété.

  * Configuration :

Source : `geo_hab_obscopro`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_nom|x|||||
|affiche_info|x|||||


(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Commune|x|l_commune|Prédéfinis filtre à liste de choix||||||Titre : Commune|



(1) si liste de domaine

 * Fiches d'information active : Observatoire des copropriétés
 
 ## Recherche : `Copropriété par nombre de lots`

Cette recherche permet à l'utilisateur de faire une recherche guidée d'une copropriété selon le nombre de lots.

  * Configuration :

Source : `geo_hab_obscopro`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_nom|x|||||
|affiche_info|x|||||
|affiche_lot|x|||||


(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`||

|Sous-Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Lots (tous usages)|`ET`||

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Nombre de lots en copro||nblott|est égale à une valeur saisie||||||Titre : Nombre de lots|
|Lot inférieur à||nblott|est inférieure ou égale à une valeur saisie||||||Titre : Inférieur à|
|Lot supériieur à||nblott|est supérieure ou égale à une valeur saisie||||||Titre : Supérieur à|

|Sous-Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Lots (usage d'habitation)|`ET`||

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Nombre de lots en copro||nbloth|est égale à une valeur saisie||||||Titre : Nombre de lots|
|Lot inférieur à||nbloth|est inférieure ou égale à une valeur saisie||||||Titre : Inférieur à|
|Lot supériieur à||nbloth|est supérieure ou égale à une valeur saisie||||||Titre : Supérieur à|

(1) si liste de domaine

 * Fiches d'information active : Observatoire des copropriétés
 
 
  ## Recherche : `ANRU - quartier prioritaire`

Cette recherche permet à l'utilisateur de faire une recherche guidée d'un quartier ANRU.

  * Configuration :

Source : `geo_pv_qp`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Libellé (zone)|x|||||


(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`||

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|ANRU - quartier prioritaire|x|zone|est égale à une valeur choisie par l'utilisateur |liste quartier prioritaire|||||Titre : Choisir le quartier|


(1) si liste de domaine

 * Fiches d'information active : Observatoire des copropriétés
 
 ## Recherche : `Recherche par adresse`

Cette recherche permet à l'utilisateur de faire une recherche guidée d'un signalement d'habitat indigne par adresse.

  * Configuration :

Source : `xapps_geo_v_hab_indigne`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Adresse |x|||||
|affiche_signalement |x|||||
|geom (xapps_geo_v_hab_indigne) ||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Commune|x|commune|est égale à une valeur choisie par l'utilisateur |Commune (habitat indigne)|||||Titre : Commune|
|Voie||libvoie_c|est égale à une valeur choisie par l'utilisateur |Voie|||||Titre : Voie|
|Numéro voie||affiche_num_voie|Prédéfinis filtre à liste de choix ||||||Titre : Numéro|

(1) si liste de domaine

 * Fiches d'information active : Signalement d'habitat indigne à l'asresse
 
 ## Recherche : `Recherche d'un dossier`

Cette recherche permet à l'utilisateur de faire une recherche guidée d'un signalement d'habitat indigne par sa référence de dossier.

  * Configuration :

Source : `an_hab_indigne_sign`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_dossier |x|||||
|affiche_dossier_comp |x|||||
|Qualification (affiche_qinit) |x|||||
|Adresse |x|||||
|geom (xapps_geo_v_hab_indigne) ||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Nom du dossier|x|nm_doc|Prédéfinis filtre à suggestion de valeur ||||||Titre : Nom|


(1) si liste de domaine

 * Fiches d'information active : Fiche de signalement d'habitat indigne
 
  ## Recherche : `Recherche d'un occupant`

Cette recherche permet à l'utilisateur de faire une recherche guidée d'un occupant concerné par un signalement d'habitat indigne.

  * Configuration :

Source : `an_hab_indigne_occ`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Nom, prénom (affiche_occupant) |x|||||
|affiche_dossier |x|||||
|Qualification (affiche_qinit) |x|||||
|Adresse |x|||||
|geom (xapps_geo_v_hab_indigne) ||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Occupant||affiche_occupant|Prédéfinis filtre à suggestion de valeur ||||||Titre : Nom|


(1) si liste de domaine

 * Fiches d'information active : Occupant d'un habitat indigne
 
 ## Recherche : `Dossier avec un délais dépassé`

Cette recherche permet à l'utilisateur de faire une recherche sur les signalements avec une date du prochain délais dépassé.

  * Configuration :

Source : `an_hab_indigne_sign`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_dossier |x|||||
|affiche_dossier_comp |x|||||
|Qualification (affiche_qinit) |x|||||
|Adresse |x|||||
|Dossier (nm_doc) ||||||
|Numéro de dossier de l'organisme extérieur ayant fait le signalement (n_doc) ||||||
|Complément d'adresse (compt_ad) ||||||
|Signalé le (d_signal) ||||||
|Par (o_signal) ||||||
|Qualification (q_init) ||||||
|Détail de la qualification initiale (q_det) ||||||
|Date de demande d'une visite (d_visit_d) ||||||
|Date de la visite (d_visit_e) ||||||
|Opérateur de la visite (o_visit) ||||||
|Motif de la non visite (m_nvisit) ||||||
|Date du rapport de la visite (d_rvisit) ||||||
|Qualification finale (q_final) ||||||
|Résumé du rapport de visite (r_rvisit) ||||||
|Action(s) à entreprendre (action) ||||||
|Avancement du dossier (précisions) (av_dos) ||||||
|Date du procés-verbal de mise en demeure (d_pvmed) ||||||
|Prochain délai (d_pdelais) ||||||
|Date de la visite de conformité (d_visitconf) ||||||
|Dossier clos (cloture) ||||||
|Information donnée au maire (m_avise) ||||||
|Nombre de logements (nblog) ||||||
|Le logements ou l'immeuble concerné est-il occupé ? (occupation) ||||||
|Dossier ANAH (dos_anah) ||||||
|Observations (observ) ||||||
|geom (xapps_geo_v_hab_indigne) ||||x||



(la détection des doublons n'est pas activée ici)

 * Filtres :


|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Dossier non clos|x|cloture|est égale à une valeur par défaut |false||||||
|Dossier horsdélais|x|affiche_delais|est égale à une valeur par défaut |true||||||

(1) si liste de domaine

 * Fiches d'information active : Fiche de signalement d'habitat indigne
 
 ## Recherche : `Rechercher tous les dossiers en cours`

Cette recherche permet à l'utilisateur de faire une recherche sur tous les dossiers de signalements.

  * Configuration :

Source : `an_hab_indigne_sign`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_dossier |x|||||
|affiche_dossier_comp |x|||||
|Qualification (affiche_qinit) |x|||||
|Adresse |x|||||


(la détection des doublons n'est pas activée ici)

 * Filtres :


|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`||

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Dossier non clos|x|cloture|est égale à une valeur par défaut |false||||||
|Avancement de dossier||est égale à une valeur de liste de choix |lt_hab_indigne_avancdos|||||Titre : Par état d'avancement du dossier|
|Prochaine étape||est égale à une valeur de liste de choix |lt_hab_indigne_avancdos|||||Titre : Prochaine étape|

(1) si liste de domaine

 * Fiches d'information active : Fiche de signalement d'habitat indigne
 
 
 ## Recherche : `Recherche par qualification (initial)`

Cette recherche permet à l'utilisateur de faire une recherche sur tous les dossiers de signalements par leur qualificationn initiale.

  * Configuration :

Source : `an_hab_indigne_sign`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_dossier |x|||||
|affiche_dossier_comp |x|||||
|Qualification (affiche_qinit) |x|||||
|Adresse |x|||||
|Dossier (nm_doc) ||||||
|Numéro de dossier de l'organisme extérieur ayant fait le signalement (n_doc) ||||||
|Complément d'adresse (compt_ad) ||||||
|Signalé le (d_signal) ||||||
|Par (o_signal) ||||||
|Qualification (q_init) ||||||
|Détail de la qualification initiale (q_det) ||||||
|Date de demande d'une visite (d_visit_d) ||||||
|Date de la visite (d_visit_e) ||||||
|Opérateur de la visite (o_visit) ||||||
|Motif de la non visite (m_nvisit) ||||||
|Date du rapport de la visite (d_rvisit) ||||||
|Qualification finale (q_final) ||||||
|Résumé du rapport de visite (r_rvisit) ||||||
|Action(s) à entreprendre (action) ||||||
|Avancement du dossier (précisions) (av_dos) ||||||
|Date du procés-verbal de mise en demeure (d_pvmed) ||||||
|Prochain délai (d_pdelais) ||||||
|Date de la visite de conformité (d_visitconf) ||||||
|Dossier clos (cloture) ||||||
|Information donnée au maire (m_avise) ||||||
|Nombre de logements (nblog) ||||||
|Le logements ou l'immeuble concerné est-il occupé ? (occupation) ||||||
|Dossier ANAH (dos_anah) ||||||
|Observations (observ) ||||||
|geom (xapps_geo_v_hab_indigne) ||||x||


(la détection des doublons n'est pas activée ici)

 * Filtres :


|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Dossier non clos|x|cloture|est égale à une valeur par défaut |false||||||
|Qualification initiale||est égale à une valeur de liste de choix |lt_hab_indigne_qualif|||||Titre : Type de qualification|


(1) si liste de domaine

 * Fiches d'information active : Fiche de signalement d'habitat indigne
 
 ## Recherche : `Tableau de bord - habitat indigne`

Cette recherche permet à l'utilisateur d'accéder aux tableaux de bord de l'habitat indigne.

  * Configuration :

Source : `xapps_an_v_hab_indigne_tb1`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_result_titre |x|||||
|affiche_result |x|||||


(la détection des doublons n'est pas activée ici)

 * Filtres : aucun



(1) si liste de domaine

 * Fiches d'information active : Tableau de bord - Habitat indigne
 
 
  ## Fiche d'information : `Signalement d'habitat indigne à l'adresse`

Source : ` "xapps_geo_v_hab_indigne" `

* Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|1000x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|titre_html|masqué|Vertical||||

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|titre_liste_html|masqué|Vertical||||

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|affiche_ordre, Dossier (nm_dos), Etat (affiche_dos), Signalé le (d_signal), Par (o_signal), Qualification initiale (affiche qinit), Avancement du dossier (e_dos), Prochaine étape (ep_dos), Délais (affiche_pdelais)|Par défaut|Vertical||Fiche de signalement d'habitat indigne|x|


**IMPORTANT** : L'édition des données jointes est activée. Champ de la relation Adresse activé.

 * Modèle d'impression : aucun
  
  ## Fiche d'information : `Fiche de signalement d'habitat indigne`

Source : ` "an_hab_indigne_sign" `

* Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|1250x800|Onglets|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Signalement initial|affiche_message|masqué|Vertical||||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Dossier (nm_dos),Numéro de dossier de l'organisme extérieur ayant fait le signalement (n_dos)|Par défaut|Vertical||||

|Nom de la sous-sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Adresse (adresse - xapps_geo_v_hab_indigne)|Par défaut|Vertical||||

|Nom de la sous-sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Complément d'adresse (compt_ad),Section cadastrale (secpar),N° parcelle (numpar), Signalé le (d_signal), Par (o_signal), Qualification (q_init), Détail de la qualification initiale (q_det), Nombre de logements (nblog), Le logement ou l'immeuble concerné est-il occupé ? (occupation)|Par défaut|Vertical||||

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Les visites||masqué|Vertical||||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|affiche_message|masqué|Vertical||||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Date de demande d'une visite (d_visit_d), Date de la visite (d_visit_e),Opérateur de la visite (o_visit),Motif de la non visite (m_nvisit), Date du rapport de la visite (d_rvisit), Qualification finale (q_init), Résumé du rapport de visite (r_rvisit)|par défaut|Vertical||||

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Le suivi|affiche_message|masqué|Vertical||||


|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Avancement du dossier (e_dos), Prochaine étape (ep_dos), Prochain délais (d_pdelais), Avancement du dossier (précisions) (av_dos),Action(s) à entreprendre (action), Date du procés-verbal de mise en demeure (d_pvmed), Date de fin de travaux (d_ftrav), Date de la visite de conformité (d_visitconf), Information donnée au maire (m_avise), Dossier ANAH (dos_anah), Dossier clos (cloture)|par défaut|Vertical||||

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Observations||masqué|Vertical||||

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|affiche_message|masqué|Vertical||||

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Observations (observ)|par défaut|Vertical||||


|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Occupant(s)|Nom (nom), Nom,prénom (affiche_occupant), Situation (situation)|par défaut|Vertical||Occupant d'un habitat indigne|x|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Propriétaires(s)|Nom  (ou bailleur) (nom), Nom (ou bailleur) (affiche_prop), Gestionnaire (nom_gest), Type de propriété (t_prop)|par défaut|Vertical||Propriétaire d'un habitat indigne|x|

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Accès aux informations de la parcelle (source : DGFIP)|Parcelle (affiche_par), Adresse fiscale (Bg Full Address), Propriétaire(s) (BG_PROP_RECORDS)|par défaut|Vertical||||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Propriétaire(s) des locaux (source : DGFIP)|Gid,Fiche (url_fichelocal),Lot (lot), Adresse local (adresse_local) ,Type (type), Propriétaire,Voirie propriétaire, Complément propriétaire, Code postal propriétaire|par défaut|Vertical||||

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Document(s)|Champ de miniature de GEO (miniature), Nom du fichier (n_fichier)|par défaut|Vertical||Media Signalement Habitat Indigne||

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Opérateur de saisie de l'information (op_sai)|masqué|Vertical||||

* Saisie :

Sont présent ici uniquement les attributs éditables ou disposant d'un mode de représentation spécifique.

|Attribut|Obligatoire|Valeur par défaut|Liste de domaine|Représentation|
|:---|:---|:---|:---|:---|
|ref_interne (id_dos)|||||
|Dossier (nm_doc)|x||||
|Numéro de dossier de l'organisme extérieur ayant fait le signalement (n_dos)|||||
|Complément d'adresse (compt_ad) ||||  |
|Par |x|||  |
|Signalé le (d_signal) |x|%CURRENT_DATE%|||
|Qualification (q_init) |x|00|lt_hab_indigne_qualif |Liste de choix|
|Détail de la qualification initiale (q_det)||||Champ texte à plusieurs lignes|
|Date de demande d'une visite (d_visit_d)|x|%CURRENT_DATE%|||
|Date de la visite (d_visit_e)|||||
|Motif de la non visite (m_nvisit)||||Champ texte à plusieurs lignes|
|Date du rapport de la visite (d_rvisit) |||||
|Qualification finale (q_final) ||00|lt_hab_indigne_qualif |Liste de choix|
|Résumé du rapport de visite (r_rvisit)  ||| |Champ texte à plusieurs lignes|
|Action(s) à entreprendre (action)   ||| |Champ texte à plusieurs lignes|
|Avancement du dossier (précisions) (av_dos)   ||| |Champ texte à plusieurs lignes|
|Date du procès-verbal de mise en demeure (d_pvmed)   ||| ||
|Prochain délai (d_pdelais)     ||| ||
|Date de la visite de conformité (d_visitconf)      ||| ||
|Dossier clos (cloture)     ||false| |case à cocher|
|Information donnée au maire (m_avise)      ||false| |case à cocher|
|Nombre de logements (nblog)      ||| ||
|Le logement ou l'immeuble concerné est-il occupé ? (occupation)   ||true| |case à cocher|
|Dossier ANAH (dos_anah)   ||false| |case à cocher|
|Observations (observ) ||| |Champ texte à plusieurs lignes|
|Opérateur de saisie de l'information (op_sai)  ||%USER_LOGIN%| ||
|Section cadastrale (secpar)       ||| ||
|N° parcelle (numpar)       ||| ||
|Avancement du dossier (e_dos)        ||0| lt_hab_indigne_avancdos |Liste de choix|
|Date de fin de travaux (d_ftrav)         |||  |  |


**IMPORTANT** : L'édition des données jointes est désactivée.

 * Modèle d'impression : Fiche standard
 
 
 ## Fiche d'information : `Occupant d'un habitat indigne`

Source : ` "an_hab_indigne_occ" `

* Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Onglets|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Occupant (chef de famille)|||||||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Titre de l'occupant (titre)|Par défaut|Vertical||||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Autre titre (titre_aut)|Par défaut|Vertical|titre=='40'|||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Nom, Prénom, Téléphone fixe (telf_occ), Téléphone portable (telp_occ), Autre téléphone (tela_occ), Email (e_occ), Nombre d'occupants (nb_occ), Nb d'enfants et âge (enf_occ)|Par défaut|Vertical||||

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Référent (personne morale)|Nom (refe), Téléphone fixe (telf_refe), Téléphone portable (telp_refe), Autre téléphone (tela_refe), Email (e_refe)|par défaut|vertical||||

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Autre référent (organisme)|Nom (arefe), Téléphone fixe (telf_arefe), Téléphone portable (telp_arefe), Autre téléphone (tela_arefe), Email (e_arefe)|par défaut|vertical||||

* Saisie :

Sont présent ici uniquement les attributs éditables ou disposant d'un mode de représentation spécifique.

|Attribut|Obligatoire|Valeur par défaut|Liste de domaine|Représentation|
|:---|:---|:---|:---|:---|
|Identifiant unique interne ARC du signalement (id_dos) |||||
|Nom (nom)  ||||  |
|Prénom (prenom)   ||||  |
|Téléphone fixe (telf_occ)   ||||  |
|Téléphone portable (telp_occ)    ||||  |
|Autre téléphone (tela_occ)   ||||  |
|EMail (e_occ)   ||||  |
|Titre de l'occupant (titre)    ||00|lt_hab_indigne_pat |Liste de choix|
|Autre titre (titre_aut)   ||||  |
|Situation (situation)    |x|10|lt_hab_indigne_situ  |Liste de choix|
|Nombre d'occupants (nb_occ)    ||||  |
|Nb d'enfants et âge (enf_occ)     ||||  |
|Nom (refe)      ||||  |
|Téléphone fixe (telf_refe)      ||||  |
|Téléphone portable (telp_refe)       ||||  |
|Autre téléphone (tela_refe)      ||||  |
|Email (e_refe)     ||||  |
|Situation sociale (s_social)      ||||  |
|Traitement sociale (t_social)      ||||  |
|Relogé (r_loca)        ||false||  |
|Opérateur de saisie de l'information (op_sai)      ||%USER_LOGIN%||  |
|Nom (arefe)    ||||  |
|Téléphone fixe (telf_arefe)     ||||  |
|Téléphone portable (telp_arefe)     ||||  |
|Autre téléphone (tela_arefe)    ||||  |
|Email (e_arefe)    ||||  |


**IMPORTANT** : L'édition des données jointes est désactivée.

 * Modèle d'impression : aucun
 
 
 ## Fiche d'information : `Propriétaire d'un habitat indigne`

Source : ` "an_hab_indigne_prop" `

* Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Onglets|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Propriétaire|||||||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Titre de l'occupant (titre)|Par défaut|Vertical||||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Autre titre (titre_aut)|Par défaut|Vertical|titre=='40'|||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|Nom (ou bailleur) (nom), Prénom, Gestionnaire (nom_gest)|Par défaut|Vertical||||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Propriété|Type de propriété (t_prop)|par défaut|vertical||||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Coordonnées|Téléphone fixe (telf_occ), Téléphone portable (telp_prop), Autre téléphone (tela_prop), Email (e_contact)|par défaut|vertical||||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Adresse|N° (numero), Indice de répétition (repet), Type (type_voie), Voie (nom_voie), Complément d'adresse (compt_ad), Code postal (cp), Commune, Pays|par défaut|vertical||||

|Nom de la sous-section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Contact|Nom (contact), Téléphone fixe (telf_contact), Téléphone portable (telp_contact), Autre téléphone (tela_contact), Email (e_contact), Adresse (ad_contact)|par défaut|vertical||||

* Saisie :

Sont présent ici uniquement les attributs éditables ou disposant d'un mode de représentation spécifique.

|Attribut|Obligatoire|Valeur par défaut|Liste de domaine|Représentation|
|:---|:---|:---|:---|:---|
|Identifiant unique interne ARC du signalement (id_dos) |||||
|Nom (ou bailleur) (nom)    ||||  |
|Prénom (prenom)   ||||  |
|Téléphone fixe (telf_prop)   ||||  |
|Téléphone portable (telp_prop)    ||||  |
|Autre téléphone (tela_prop)   ||||  |
|EMail (e_occ)   ||||  |
|Titre de l'occupant (titre)    ||00|lt_hab_indigne_pat |Liste de choix|
|Autre titre (titre_aut)   ||||  |
|Situation (situation)    |x|10|lt_hab_indigne_situ  |Liste de choix|
|Nombre d'occupants (nb_occ)    ||||  |
|Nb d'enfants et âge (enf_occ)     ||||  |
|Nom (refe)      ||||  |
|Téléphone fixe (telf_refe)      ||||  |
|Téléphone portable (telp_refe)       ||||  |
|Autre téléphone (tela_refe)      ||||  |
|Email (e_refe)     ||||  |
|Situation sociale (s_social)      ||||  |
|Traitement sociale (t_social)      ||||  |
|Relogé (r_loca)        ||false||  |
|Opérateur de saisie de l'information (op_sai)      ||%USER_LOGIN%||  |
|Nom (arefe)    ||||  |
|Téléphone fixe (telf_arefe)     ||||  |
|Téléphone portable (telp_arefe)     ||||  |
|Autre téléphone (tela_arefe)    ||||  |
|Email (e_arefe)    ||||  |


**IMPORTANT** : L'édition des données jointes est désactivée.

 * Modèle d'impression : aucun
