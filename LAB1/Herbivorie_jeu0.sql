/*
-- =========================================================================== A
Activité : IFT187
Trimestre : 2022-1
Composant : Exemples/Herbivorie/V01/Herbivorie_jeu0.sql
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4-14.1
Auteur 1 : matricule CIP courriel@UShebrooke.ca
Auteur 2 : matricule CIP courriel@UShebrooke.ca
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.1.0a
Statut : en développement
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Insertion de tuples valides dans les tables initiales.
-- =========================================================================== B
*/

INSERT INTO Etat VALUES
  ('O', 'vivante'),
  ('B', 'broutée'),
  ('X', 'fanée'),
  ('C', 'cassée'),
  ('D', 'disparue'),
  ('N', 'non retrouvée');

INSERT INTO Peuplement VALUES
  ('ERHE', 'érablière à hêtre'),
  ('BEMI', 'bétulai à érable et sapin'),
  ('SABO', 'sapinière à bouleau'),
  ('SAPI', 'sapinière pure'),
  ('ERSA', 'érablière à sapin'),
  ('PEBO', 'pessière à bouleau');

/*
INSERT INTO Arbre VALUES
  ...

INSERT INTO Taux VALUES
  ...

INSERT INTO Placette VALUES
  ...
*/


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
  * Maintenir le script au fil de l'évolution de Herbivorie_cre.sql

Tâches réalisées :
2017-09-17 (LL) : Création
  * Version initiale.

Références :
-- -----------------------------------------------------------------------------
-- fin de /Exemples/Herbivorie/Herbivorie_jeu0.sql
-- =========================================================================== Z
*/
