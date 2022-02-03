/*
-- =========================================================================== A
Activité : IFT187
Trimestre : 2022-1
Composant : Herbivorie_drop.sql
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4-14.1
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.1.0a
Statut : base de développement
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Retrait des définition de domaines, de types, de tables et de procédures à
l'exception des carnets d'observations.
-- =========================================================================== B
*/

DROP TABLE ObsDimension CASCADE ;
DROP TABLE ObsFloraison CASCADE ;
DROP TABLE ObsEtat CASCADE ;
DROP TABLE Plant CASCADE ;
DROP TABLE Placette CASCADE ;
DROP TABLE Etat CASCADE ;
DROP TABLE Taux CASCADE ;
DROP TABLE Peuplement CASCADE ;
DROP TABLE Arbre CASCADE ;

DROP DOMAIN Arbre_id CASCADE;
DROP DOMAIN Date_eco CASCADE;
DROP DOMAIN Description CASCADE;
DROP DOMAIN Dim_mm CASCADE;
DROP DOMAIN Etat_id CASCADE;
DROP DOMAIN Plant_id CASCADE;
DROP DOMAIN Parcelle CASCADE;
DROP DOMAIN Peuplement_id CASCADE;
DROP DOMAIN Placette_id CASCADE;
DROP DOMAIN Taux_id CASCADE;
DROP DOMAIN Taux_val CASCADE;

/*
-- =========================================================================== Z
== Contributeurs

  (DAL) Diane.Auberson-Lavoie@USherbrooke.ca,
  (LL) Luc.Lavoie@USherbrooke.ca

== Adresse, droits d'auteur et copyright

  Groupe Metis
  Département d'informatique
  Faculté des sciences
  Université de Sherbrooke
  Sherbrooke (Québec)  J1K 2R1
  Canada
  http://info.usherbrooke.ca/llavoie/
  [CC-BY-NC-4.0 (http://creativecommons.org/licenses/by-nc/4.0)]

== Tâches projetées

2022-01-30 (LL) : Évolution
  * Maintenir le script au fil de l'évolution de Herbivorie_cre.sql

== Tâches réalisées

2017-09-17 (LL) : Création
  * Version initiale.

== Références

[ddv] http://info.usherbrooke.ca/llavoie/enseignement/Exemples/Herbivorie/Herbivorie_DDV.pdf
[mod] http://info.usherbrooke.ca/llavoie/enseignement/Modules/

-- -----------------------------------------------------------------------------
-- fin de Herbivorie_drop.sql
-- =========================================================================== Z
*/
