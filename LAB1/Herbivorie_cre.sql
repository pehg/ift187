/*
-- =========================================================================== A
Activité : IFT187
Trimestre : 2022-1
Composant : Exemples/Herbivorie/Herbivorie_cre.sql
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4-14.1
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.1.1a
Statut : base de développement
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Création du schéma correspondant à la collecte de données du projet Herbivorie.
-- =========================================================================== B
*/

CREATE DOMAIN Etat_id
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{1}');
CREATE DOMAIN Description
  TEXT
  CHECK (CHAR_LENGTH (VALUE) BETWEEN 1 AND 60);
CREATE TABLE Etat
  -- État d'un plant est sa description.
(
  etat        Etat_id     NOT NULL,
  description Description NOT NULL,
  CONSTRAINT Etat_cc0 PRIMARY KEY (etat)
);

CREATE DOMAIN Peuplement_id
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');
CREATE TABLE Peuplement
  -- Type de peuplement d'une parcelle et sa description.
(
  peup        Peuplement_id NOT NULL,
  description Description   NOT NULL,
  CONSTRAINT Peuplement_cc0 PRIMARY KEY (peup)
);

CREATE TABLE Taux
  -- Catégorisation des pourcentages.
  -- NOTE : Il ne doit y avoir aucun recoupement entre les catégories et celles-ci
  --   doivent couvrir la totalité du spectre 0..100. De plus le choix d'une
  --   représentation exacte, discrète de granularité unitaire conduit naturellement
  --   à définir le taux de la catégorie tCat par un intervalle fermé-fermé
  --   [compris entre tMin (inclusivement) et tMax (inclusivement)] alors que,
  --   dans l'énoncé de problème, l'intervalle fermé-ouvert était plutôt utilisé.
(
-- à développer
);

CREATE TABLE Arbre
  -- Variété d'arbre et sa description.
(
-- à développer
);

CREATE TABLE Placette
  -- Description de la placette
(
-- à développer
);

CREATE TABLE Plant
  -- Description d'un plant.
  -- La parcelle est une subdivision de la placette.
(
-- à développer
);

CREATE TABLE ObsDimension
  -- Il a été observé au jour "date" que le plan "id" possédait une feuille
  -- de dimension "longueur" par "largeur".
(
-- à développer
);

CREATE TABLE ObsFloraison
  -- Il a été observé au jour "date" que le plan "id" possédait une fleur (ou non).
(
-- à développer
);

CREATE TABLE ObsEtat
  -- Il a été observé au jour "date" que le plan "id" était dans l'état "etat".
(
-- à développer
);

/*
-- =========================================================================== Z
Contributeurs :
  (DAL) Diane.Auberson-Lavoie@USherbrooke.ca
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
2017-09-19 (LL) : Compléter le schéma
  * Compléter les tables, domaines et contraintes.

Tâches réalisées :
2017-09-17 (LL) : Création
  * Création du schéma de base.
  * Validation minimale avec quelques relevés d'observations.
  * Importation des observations intègres.
-- -----------------------------------------------------------------------------
-- fin de Exemples/Herbivorie/Herbivorie_cre.sql
-- =========================================================================== Z
*/
