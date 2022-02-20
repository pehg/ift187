/*
-- =========================================================================== A
Activité : IFT187
Trimestre : 2022-1
Composant : Herbivorie_jeu0.sql
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4-14.1
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.2.0a
Statut : base de développement
-- =========================================================================== A
*/

/*
-- =========================================================================== B
-- Insertion de tuples valides dans les tables initiales.
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

INSERT INTO Arbre VALUES
  ('ABIBAL', 'Abies balsamea'),
  ('ACESAC', 'Acer saccharum'),
  ('BETALL', 'Betula alleghaniensis'),
  ('BETCOR', 'Betula papyrifera var. cordifolia'),
  ('BETPAP', 'Betula papyrifera'),
  ('FAGGRA', 'Fagus grandifolia'),
  ('NA',     'non applicable (sans objet)'),
  ('PICMAR', 'Picea mariana'),
  ('SORSSP', 'Sorbus sp.');

INSERT INTO Taux VALUES
  ('A', 76, 100),
  ('B', 51, 75),
  ('C', 26, 50),
  ('D', 6, 25),
  ('E', 1, 5),
  ('F', 0, 0);

INSERT INTO Placette VALUES
  ('A1', 'ERHE', 'E', 'E', 'F', 'F', 'D', 'E', 'D', 'F', 'C', 'ACESAC', 'FAGGRA', 'BETALL', '2017-07-25'),
  ('A5', 'BEMI', 'C', 'E', 'D', 'D', 'B', 'D', 'E', 'F', 'A', 'BETPAP', 'ACESAC', 'ABIBAL', '2017-07-25'),
  ('A7', 'SAPI', 'D', 'D', 'C', 'C', 'B', 'B', 'E', 'C', 'A', 'ABIBAL', 'BETCOR', 'SORSSP', '2017-08-01'),
  ('B1', 'ERHE', 'D', 'D', 'F', 'E', 'D', 'D', 'F', 'E', 'D', 'ACESAC', 'FAGGRA', 'BETPAP', '2017-07-25'),
  ('B5', 'ERHE', 'E', 'E', 'D', 'D', 'C', 'D', 'E', 'E', 'C', 'ACESAC', 'FAGGRA', 'ABIBAL', '2017-07-26'),
  ('B7', 'SABO', 'E', 'E', 'D', 'D', 'C', 'D', 'D', 'D', 'A', 'ABIBAL', 'BETCOR', 'PICMAR', '2017-08-02'),
  ('C1', 'ERHE', 'D', 'D', 'F', 'F', 'D', 'D', 'E', 'E', 'C', 'ACESAC', 'FAGGRA', 'BETPAP', '2017-07-26'),
  ('C5', 'ERSA', 'E', 'E', 'D', 'D', 'C', 'D', 'E', 'E', 'A', 'ACESAC', 'ABIBAL', 'PICMAR', '2017-07-26'),
  ('C7', 'PEBO', 'F', 'F', 'D', 'D', 'B', 'D', 'E', 'D', 'B', 'PICMAR', 'BETALL', 'ABIBAL', '2017-08-02');


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

Références :
[ddv] http://info.usherbrooke.ca/llavoie/enseignement/Exemples/Herbivorie/Herbivorie_DDV.pdf
[mod] http://info.usherbrooke.ca/llavoie/enseignement/Modules/
-- -----------------------------------------------------------------------------
-- fin de Herbivorie_jeu0.sql
-- =========================================================================== Z
*/
