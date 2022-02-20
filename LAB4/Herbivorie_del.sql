/*
-- =========================================================================== A
Activité : IFT187
Trimestre : 2022-1
Composant : Herbivorie_del.sql
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4-14.1
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.1.0a
Statut : base de développement
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Suppression des tables du schéma correspondant.

Notes de mise en oeuvre
(a) aucune.
-- =========================================================================== B
*/

DELETE FROM ObsDimension ;
DELETE FROM ObsFloraison ;
DELETE FROM ObsEtat ;
DELETE FROM Plant ;
DELETE FROM Placette ;
DELETE FROM Etat ;
DELETE FROM Taux ;
DELETE FROM Peuplement ;
DELETE FROM Arbre ;

/*
-- =========================================================================== Z
== Contributeurs

  (CK) Christina.Khnaisser@USherbrooke.ca
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
-- fin de Herbivorie_del.sql
-- =========================================================================== Z
*/
