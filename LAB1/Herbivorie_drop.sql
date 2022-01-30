/*
-- =========================================================================== A
Activité : IFT187
Trimestre : 2022-1
Composant : Exemples/Herbivorie/Herbivorie_drop.sql
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4-14.1
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.1.0a
Statut : base de développement
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Retrait des définition de domaines, types, tables, etc.
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

-- à compléter
DROP DOMAIN Arbre_id CASCADE;
DROP DOMAIN Description CASCADE;
DROP DOMAIN Peuplement_id CASCADE;
-- PE_BGN
DROP DOMAIN Etat_id CASCADE;
DROP DOMAIN Taux_val CASCADE;
DROP DOMAIN Taux_id CASCADE;
DROP DOMAIN Plant_id CASCADE;
DROP DOMAIN Placette_id CASCADE;
DROP DOMAIN Date_ISO CASCADE;
DROP DOMAIN Note CASCADE;
DROP DOMAIN Parcelle CASCADE;
DROP DOMAIN Dim_mm CASCADE;
-- PE_END

/*
-- =========================================================================== Z
Contributeurs :
  (DAL) Diane.Auberson-Lavoie@USherbrooke.ca,
  (LL) Luc.Lavoie@USherbrooke.ca

Adresse, droits d'auteur et copyright :
  Groupe Metis
  Département d'informatique
  Faculté des sciences
  Université de Sherbrooke
  Sherbrooke (Québec)  J1K 2R1
  Canada
  http://info.usherbrooke.ca/llavoie/
  [CC-BY-NC-4.0 (http://creativecommons.org/licenses/by-nc/4.0)]

Tâches projetées :
  * Maintenir le script au fil de l'évolution de Herbivorie_cre.sql

Tâches réalisées :
2017-09-17 (LL) : Création
  * Version initiale.
-- -----------------------------------------------------------------------------
-- fin de /Exemples/Herbivorie/Herbivorie_drop.sql
-- =========================================================================== Z
*/
