![picto](/doc/img/Logo_web-GeoCompiegnois.png)

# Documentation d'administration de la base de données sur l'habitat indigne #

## Principes
  * **généralité** :

La base de données développée ici a été conçue pour répondre à une logique de suivi des signalements d'habitat indigne (péril, insalubrité,...). Elle permet au service en charge de cette démarche de mieux suivre les dossiers et d'être plus réactif. 
 
 * **résumé fonctionnel** :

Pour rappel des grands principes :

* Un signalement doit comporter au moins un nom de dossier, une date de signalement, l'origine du signalement, une qualification.
* L'enregistrement de base d'un signalemeent affecte par défaut une date de demande de visite à la date du signalement et génère un délais de visite à 15 jours
* La mise à jour de l'état d'avancement d'un dossier génère automatiquement la prochaine étape et calcul (si nécessaire ou le demande) une date du prochain délais pour le suivi du dossier.
* Le renseignement des références cadastrales permet dans l'onglet Propriétaire d'afficher les informations des locaux et d'accéder à la fiche des locaux de l'application Cadastre-Urbanisme.

## Schéma fonctionnel

![schema_fonctionnel](img/schema_fonctionnel_amt_fon_eco.png)
