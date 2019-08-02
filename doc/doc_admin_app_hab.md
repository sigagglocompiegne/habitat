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
|affiche_clos    |x|x|null|Formate en HTML le message à afficher dans la fiche d'information en cas d'erreur selon un temps définit (évite un affichage permanent du message)|Fiche d'information PEI|`CASE
WHEN {cloture} = FALSE THEN
'<acronym title="Dossier en cours">'
'<img src="http://geo.compiegnois.fr/documents/metiers/hab/geo_dossier_ouvert.png" width=21 height=30>' 
'</acronym>'
ELSE
'<acronym title="Dossier clos">'
'<img src="http://geo.compiegnois.fr/documents/metiers/hab/geo_dossier_clos.png" width=21 height=30>' 
'</acronym>'
END``|


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

