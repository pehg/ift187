/*
-- =========================================================================== A
Activité : IFT187
Trimestre : 2022-1
Composant : Exemples/Herbivorie/V01/Herbivorie_test0.sql
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4-14.1
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.1.0a
Statut : en développement
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Test d'insertion de données invalides
-- =========================================================================== B
*/

INSERT INTO Etat VALUES -- état redondant
  ('O', 'vivante');
INSERT INTO Etat VALUES -- état erroné
  ('$', 'vivante');

INSERT INTO Peuplement VALUES -- peup trop court
  ('ERH', 'érablière à hêtre');
INSERT INTO Peuplement VALUES -- peup trop long
  ('ERHET', 'érablière à hêtre');
INSERT INTO Peuplement VALUES -- description trop courte
  ('XXSS', '');
INSERT INTO Peuplement VALUES -- description trop longue
  ('XXLL', '123456789012345678901234567890123456789012345678901234567890x');


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
-- fin de /Exemples/Herbivorie/Herbivorie_test0.sql
-- =========================================================================== Z
*/
