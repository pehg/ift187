/*
-- =========================================================================== A
Activité : IFT187
Trimestre : 2022-1
Composant : Herbivorie_test1.sql
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

INSERT INTO Etat (etat, description)
  VALUES -- état redondant
  ('O', 'vivante');

INSERT INTO Etat (etat, description)
  VALUES -- état erroné
  ('$', 'vivante');

INSERT INTO Peuplement (peup, description)
  VALUES -- peup trop court
  ('ERH', 'érablière à hêtre');

INSERT INTO Peuplement (peup, description)
  VALUES -- peup trop long
  ('ERHET', 'érablière à hêtre');

INSERT INTO Peuplement (peup, description)
  VALUES -- description trop courte
  ('XXSS', '');

INSERT INTO Peuplement (peup, description)
  VALUES -- description trop longue
  ('XXLL', '123456789012345678901234567890123456789012345678901234567890x');

INSERT INTO Taux (tcat, tmin, tmax)
  VALUES -- intervalle de pourcentage erroné
  ('X', -1, 101);

INSERT INTO Arbre (arbre, description)
  VALUES -- arbre trop long
  ('12345678901234567890x', 'def ABIBAL');

INSERT INTO Placette
  (plac, peup, obs_F1, obs_F2, obs_C1, obs_C2, obs_T1, obs_C2, graminees, mousses, fougeres, arb_P1, arb_P2, arb_P3, date)
  VALUES -- qui était là en 1492 ?
  ('A9', 'ERHE', 'E', 'E', 'F', 'F', 'D', 'E', 'D', 'F', 'C', 'ACESAC', 'FAGGRA', 'BETALL', '1492-01-01');

INSERT INTO obsdimension (id, longueur, largeur, date, note)
  VALUES -- il y a déjà une observation à cette date !
  ('MMA1040', 85, 45, '2017-05-08', 'pousse vite');

INSERT INTO obsdimension (id, longueur, largeur, date, note)
  VALUES -- c'est si long que ça une feuille de trille ?
  ('MMA1040', 20050, 35, '2017-05-09', 'encore plus vite');


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
-- fin de /Herbivorie_test1.sql
-- =========================================================================== Z
*/
