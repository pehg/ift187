/*
-- =========================================================================== A
Activité : IFT187
Trimestre : 2022-1
Composant : Herbivorie_req3.sql
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4-14.1
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.2.0a
Statut : en cours de développement
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Quelques requêtes de groupement, de quantification et d'ordonnancement.

Notes de mise en oeuvre
(a) aucune.
-- =========================================================================== B
*/

-- Y1.
-- Ajouter les types et les tables requises pour consigner les conditions météorologiques quotidiennes.
-- Pour chaque journée consignée, donner la température minimale, la température maximale, le taux d’humidité minimal,
-- le taux maximal, le nombre de millimètres de précipitation et la nature de la précipitation. Le cas échéant, choisir
-- les unités appropriées. Forte recommandation: définir plusieurs tables, à raison d’une table par groupe d’attributs
-- provenant d’un même capteur afin de permettre la saisie des mesures provenant des capteurs fonctionnels, même quand
-- d’autres ne le sont pas.

-- --------------------------------------------------------
--  Cleanning section
-- --------------------------------------------------------

DROP DOMAIN TempValue CASCADE ;         -- CASCADE also drops castTemp()
DROP DOMAIN TauxHumidite CASCADE ;      -- CASCADE also drops castHumid()
DROP DOMAIN Precipitation_mm CASCADE ;  -- CASCADE also drops castPrecip()
DROP DOMAIN NaturePrecip CASCADE ;      -- CASCADE also drops castNaturePrecip()

DROP TABLE Temperature CASCADE ;
DROP TABLE Humidite CASCADE ;
DROP TABLE Precipitation CASCADE ;
--DROP TABLE filteredDataCopy CASCADE ;   -- Debugging

--DROP VIEW filteredData CASCADE ;      -- dropped by cascaded domains
--DROP VIEW filteredHumid CASCADE ;     -- Debugging
--DROP VIEW filteredTemp CASCADE ;      -- Debugging

DROP FUNCTION verifyTemp(field TEXT) CASCADE ;
DROP FUNCTION verifyDate(field TEXT) CASCADE ;
DROP FUNCTION verifyHumid(field TEXT) CASCADE ;
DROP FUNCTION verifyNaturePrecip(field TEXT) CASCADE ;
DROP FUNCTION verifyPrecip(field TEXT) CASCADE ;
DROP FUNCTION castDate(field Text) CASCADE ;
--DROP FUNCTION castTemp(field Text) CASCADE ;          -- dropped by cascaded TempValue domain
--DROP FUNCTION castHumid(field Text) CASCADE ;         -- dropped by cascaded TauxHumidite domain
--DROP FUNCTION castPrecip(field TEXT) CASCADE ;        -- dropped by cascaded Precipitation_mm domain
--DROP FUNCTION castNaturePrecip(field TEXT) CASCADE ;  -- dropped by cascaded NaturePrecip domain


-- --------------------------------------------------------
--  Domains
-- --------------------------------------------------------

-- Float - Centigrades (-50 <= val <= 50)
CREATE DOMAIN TempValue
  FLOAT
  CHECK(VALUE BETWEEN -50.0 AND 50.0);

-- Pourcentage (0-100)
CREATE DOMAIN TauxHumidite
  SMALLINT
  CHECK(VALUE BETWEEN 0 AND 100);

-- Precipitation mm (0 <= prec <= x)
CREATE DOMAIN Precipitation_mm
  FLOAT
  CHECK ( VALUE >= 0.0 );

-- N: Neige, G: Grêle, P: pluie, O: None
CREATE DOMAIN NaturePrecip
  TEXT
  CHECK (VALUE IN ('N','G','P', 'O'));

-- --------------------------------------------------------
--  Tables
-- --------------------------------------------------------

CREATE TABLE Temperature
(
  journee   date        NOT NULL,
  temp_min  TempValue   NOT NULL,
  temp_max  TempValue   NOT NULL
  CONSTRAINT Temperature_min_max CHECK(temp_max >= temp_min),
  CONSTRAINT Temperature_cc01 PRIMARY KEY (journee)
);

CREATE TABLE Humidite
(
  journee     date          NOT NULL,
  humid_min   TauxHumidite  NOT NULL,
  humid_max   TauxHumidite  NOT NULL,
  CONSTRAINT  Humidite_min_max CHECK(humid_max >= humid_min),
  CONSTRAINT  Humidite_cc01 PRIMARY KEY (journee)
);

CREATE TABLE Precipitation
(
  journee     date              NOT NULL,
  precip_mm   Precipitation_mm  NOT NULL,
  precip_nat  NaturePrecip      NOT NULL,
  CONSTRAINT Precipitation_cc01 PRIMARY KEY (journee)
);

-- Y2.
-- Ajouter des données météorologiques vraisemblables et représentatives pour le mois de juin 2016.
-- À partir de la table CarnetMeteo contenant des données météorologiques brutes (pouvant contenir des erreurs),
-- alimenter les tables créées en Y1 en faisant les vérifications requises. Définir les fonctions requises pour ce faire.
-- N’insérer que les données valides et intègres. Proposer un jeu de données qui illustre l’adéquation de votre
-- alimentation.

-- --------------------------------------------------------
--  Verification functions
-- --------------------------------------------------------

CREATE OR REPLACE FUNCTION verifyDate(field TEXT)
  RETURNS BOOLEAN
LANGUAGE SQL AS
  $$
    --SELECT field SIMILAR TO '\d{4}-\d{1,2}-\d{1,2}'  -- Do we support single digit month and day, like 2020-1-1?
    -- We support single digit month and day, like 2020-1-1. But checking for months that have 28,29, 30 or 31 days
    -- will require a more complicated regex. We only check that we have
    --   Year: from 1900 to 2029
    --   Month: from 1 to 12, accepting single digits or double digits
    --   Day: from 1 to 31, accepting single digits or double digits
    SELECT field SIMILAR TO '((19\d\d)|(20[02]\d))-((1[0-2])|(0[1-9])|[1-9])-([1-9]|(0[1-9])|([1-2]\d)|(3[01]))'
  $$
;

CREATE OR REPLACE FUNCTION verifyTemp(field TEXT)
  RETURNS BOOLEAN
LANGUAGE SQL AS
  $$
    --SELECT field SIMILAR TO '-?[0-5]?\d(?:.\d\d)?'
    SELECT field SIMILAR TO '-?((50(.0)?)|([1-4]?\d(.\d)?))'
  $$
;

CREATE OR REPLACE FUNCTION verifyHumid(field TEXT)
  RETURNS BOOLEAN
LANGUAGE SQL AS
  $$
    --SELECT field SIMILAR TO '\d{1,3}'
  SELECT field SIMILAR TO '(\d{1,2})|(100)'
  $$
;

CREATE OR REPLACE FUNCTION verifyPrecip(field TEXT)
  RETURNS BOOLEAN
LANGUAGE SQL AS
  $$
    --SELECT field SIMILAR TO '\d{1,3}'
    SELECT field SIMILAR TO '\d{1,3}(.\d)?'
  $$
;

CREATE OR REPLACE FUNCTION verifyNaturePrecip(field TEXT)
  RETURNS BOOLEAN
LANGUAGE SQL AS
  $$
    SELECT field SIMILAR TO '[NGPO]'   -- Do we support minuscules? No
  $$
;

-- --------------------------------------------------------
--  Casting functions
-- --------------------------------------------------------
CREATE OR REPLACE FUNCTION castDate(field TEXT)
  RETURNS DATE
LANGUAGE SQL AS
  $$
    SELECT CAST ( field AS DATE)
  $$
;

CREATE OR REPLACE FUNCTION castTemp(field TEXT)
  RETURNS TempValue
LANGUAGE SQL AS
  $$
    SELECT CAST ( field AS TempValue)
  $$
;

CREATE OR REPLACE FUNCTION castHumid(field TEXT)
  RETURNS TauxHumidite
LANGUAGE SQL AS
  $$
    SELECT CAST ( field AS TauxHumidite )
  $$
;

CREATE OR REPLACE FUNCTION castPrecip(field TEXT)
  RETURNS Precipitation_mm
LANGUAGE SQL AS
  $$
    SELECT CAST ( field AS Precipitation_mm )
  $$
;

CREATE OR REPLACE FUNCTION castNaturePrecip(field TEXT)
  RETURNS NaturePrecip
LANGUAGE SQL AS
  $$
    SELECT CAST ( field AS NaturePrecip )
  $$
;

-- --------------------------------------------------------
--  Creation of views with filtered data
-- --------------------------------------------------------

-- filteredData
-- CREATE OR REPLACE VIEW filteredData AS
--   (
--     SELECT
--            castDate(journee) AS journee,
--            castTemp(temp_min) AS temp_min,
--            castTemp(temp_max) AS temp_max,
--            castHumid(humid_min) AS humid_min,
--            castHumid(humid_max) AS humid_max,
--            castPrecip(precip) AS precip,
--            castNaturePrecip(nature_precip) AS nature_precip
--     FROM CarnetMeteo
--     WHERE verifyDate(journee)
--       AND verifyTemp(temp_min)
--       AND verifyTemp(temp_max)
--       AND verifyHumid(humid_min)
--       AND verifyHumid(humid_max)
--       AND verifyPrecip(precip)
--       AND verifyNaturePrecip(nature_precip)
--   )
-- ;

-- --------------------------------------------------------------------------------------------------------------------
--  Separate queries from filteredData (Debugging)
-- --------------------------------------------------------------------------------------------------------------------

-- filteredTemp
CREATE OR REPLACE VIEW filteredTemp AS
  (
    SELECT castDate(journee) AS journee, castTemp(temp_min) AS temp_min, castTemp(temp_max) AS temp_max
--    SELECT (journee) AS journee, (temp_min) AS temp_min, (temp_max) AS temp_max -- DBG
    FROM CarnetMeteo
    WHERE verifyDate(journee) AND verifyTemp(temp_min) AND verifyTemp(temp_max)
  )
;

-- filteredHumid
CREATE OR REPLACE VIEW filtereHumid AS
  (
    SELECT castDate(journee) AS journee, castHumid(humid_min) AS humid_min, castHumid(humid_max) AS humid_max
--    SELECT (journee) AS journee, (humid_min) AS humid_min, (humid_max) AS humid_max -- DBG
    FROM CarnetMeteo
    WHERE verifyDate(journee) AND verifyHumid(humid_min) AND verifyHumid(humid_max)
  )
;

-- filteredPrecip
CREATE OR REPLACE VIEW filteredPrecip AS
  (
    SELECT castDate(journee) AS journee, castPrecip(precip) AS precip, castNaturePrecip(nature_precip) AS nature_precip
--    SELECT (journee) AS journee, (precip) AS precip, (nature_precip) AS nature_precip -- DBG
    FROM CarnetMeteo
    WHERE verifyDate(journee) AND verifyPrecip(precip) AND verifyNaturePrecip(nature_precip)
  )
;


-- ------------------------------------------------------------------------
--  Insertion of filtered data to individual tables
-- ------------------------------------------------------------------------

-- Fill Temperature table
INSERT INTO Temperature
  SELECT journee, temp_min, temp_max
    FROM filteredTemp
;

-- Fill Humidité table
INSERT INTO Humidite
  SELECT journee, humid_min, humid_max
    FROM filtereHumid
;

-- Fill Precipitation table
INSERT INTO Precipitation
  SELECT journee, precip, nature_precip
    FROM filteredPrecip
;


-- Y3.
-- Définir une vue donnant les conditions météorologiques complètes hors précipitation.
-- Maintenir les mêmes identifiants d’attributs qu’en Y1.

CREATE OR REPLACE VIEW conditionsHorsPrecip AS
  (
    SELECT *
      FROM Temperature NATURAL JOIN Humidite
  )
;

-- Y4.
-- Retirer les données météorologiques du 17 au 19 juin si la température minimale rapportée est en deçà de 4 C
-- (le capteur était défectueux). Utiliser l’instruction DELETE.
-- CREATE TABLE filteredDataCopy AS
--     TABLE filteredData
-- ;

DELETE FROM Temperature
  WHERE (journee BETWEEN '2021-06-17' AND '2021-06-19')
    AND (temp_min < 4);

-- Y5.
-- Augmenter les températures rapportées de 10 % entre le 20 et 30 juin (le capteur était mal calibré). Utiliser
-- l’instruction UPDATE.

UPDATE Temperature
  SET temp_max = temp_max*(1.10),
      temp_min = temp_min*(1.10)
  WHERE journee BETWEEN '2021-06-20' AND '2021-06-30'
;


/*
-- =========================================================================== Z
Contributeurs :
  (CK) Christina.Khnaisser@USherbrooke.ca
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
  * ...

Tâches réalisées :
2017-10-02 (LL) : Création
  * Version initiale.

Références :
[ddv] http://info.usherbrooke.ca/llavoie/enseignement/Exemples/Herbivorie/Herbivorie_DDV.pdf
[mod] http://info.usherbrooke.ca/llavoie/enseignement/Modules/
-- -----------------------------------------------------------------------------
-- fin de Herbivorie_req4.sql
-- =========================================================================== Z
*/
