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
  CHECK (CHAR_LENGTH(VALUE) BETWEEN 1 AND 60);
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

-- Code modified in class as example
-- Modif 3. étant donné qu'on devrait mettre juste pourcentages 0-100, on crée un type
CREATE DOMAIN Taux_val
  INTEGER
  CHECK ( VALUE BETWEEN 0 AND 100);
-- Modif 4. On crée un type pour la catégorie. On peut choisir parmi A-F
CREATE DOMAIN Taux_id
  CHAR
  CHECK ( VALUE SIMILAR TO '[A-F]'); -- The quantifier {1} is not necessary since it's implicit

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
-- Exemple du professuer:
-- tcat    Taux_id,   -- Initially used CHAR
-- tmin    Taux_val,  -- Initially used INTEGER
-- tmax    Taux_val,  -- Initially used INTEGER
-- CONSTRAINT Taux_cc0 primary key (tcat),         -- Initially the CONSTRAINT didn´t have a name
-- CONSTRAINT Taux_min_max CHECK ( tmin < tmax ),  -- Initially this CONSTRAINT didn´t exist: Prevent min bigger than max

/* NOTE:
   Pourcentage: 0 - 100 %. On ne peut pas avoir plus de 100 et moins de 0
   Taux: on peut avoir 110%. Le client a décidé d'appeler la categorie comme Taux, meme s'il peut ëtre engañoso
 */
-- PE_BGN
  tcat Taux_id  NOT NULL,
  tmin Taux_val NOT NULL,
  tmax Taux_val NOT NULL,
  CONSTRAINT Taux_cc0 PRIMARY KEY (tcat),
  CONSTRAINT Taux_min_max CHECK ( tmin < tmax )
-- PE_END
);


CREATE DOMAIN Arbre_id
  TEXT
  CHECK ( VALUE SIMILAR TO '[A-Z]{3}[0-9]{3}');
CREATE TABLE Arbre
  -- Variété d'arbre et sa description.
(
-- à développer
-- PE_BGN
  arbre       Arbre_id    NOT NULL,
  description Description NOT NULL,
  CONSTRAINT Arbre_cc0 PRIMARY KEY (arbre)
-- PE_END
);


-- PE_BGN
CREATE DOMAIN Plant_id
  INTEGER
  CHECK ( VALUE > 0 );
CREATE DOMAIN Placette_id
  TEXT
  CHECK ( VALUE SIMILAR TO '[A-Z]{1}[0-9]{1-2]' );
CREATE DOMAIN Date_ISO
  DATE
  CHECK ( VALUE >= '1900-01-01' );
-- PE_END

CREATE TABLE Placette
  -- Description de la placette
(
-- à développer
-- PE_BGN
  plac      Placette_id   NOT NULL,
  peup      Peuplement_id NOT NULL,
  obs_f1    Taux_id       NOT NULL,
  obs_f2    Taux_id       NOT NULL,
  obs_c1    Taux_id       NOT NULL,
  obs_c2    Taux_id       NOT NULL,
  obs_t1    Taux_id       NOT NULL,
  obs_t2    Taux_id       NOT NULL,
  graminees Taux_id       NOT NULL,
  mousses   Taux_id       NOT NULL,
  fougeres  Taux_id       NOT NULL,
  arb_p1    Arbre_id      NOT NULL,
  arb_p2    Arbre_id      NOT NULL,
  arb_p3    Arbre_id      NOT NULL,
  date      Date_ISO      NOT NULL,
  CONSTRAINT Placette_cc0 PRIMARY KEY (plac),
  CONSTRAINT Placette_cr0 FOREIGN KEY (peup) REFERENCES Peuplement (peup),
  CONSTRAINT Placette_cr1 FOREIGN KEY (obs_f1) REFERENCES Taux (tcat),
  CONSTRAINT Placette_cr2 FOREIGN KEY (obs_f2) REFERENCES Taux (tcat),
  CONSTRAINT Placette_cr3 FOREIGN KEY (obs_c1) REFERENCES Taux (tcat),
  CONSTRAINT Placette_cr4 FOREIGN KEY (obs_c2) REFERENCES Taux (tcat),
  CONSTRAINT Placette_cr5 FOREIGN KEY (obs_t1) REFERENCES Taux (tcat),
  CONSTRAINT Placette_cr6 FOREIGN KEY (obs_t2) REFERENCES Taux (tcat),
  CONSTRAINT Placette_cr7 FOREIGN KEY (graminees) REFERENCES Taux (tcat),
  CONSTRAINT Placette_cr8 FOREIGN KEY (mousses) REFERENCES Taux (tcat),
  CONSTRAINT Placette_cr9 FOREIGN KEY (fougeres) REFERENCES Taux (tcat),
  CONSTRAINT Placette_cr10 FOREIGN KEY (arb_p1) REFERENCES Arbre (arbre),
  CONSTRAINT Placette_cr11 FOREIGN KEY (arb_p2) REFERENCES Arbre (arbre),
  CONSTRAINT Placette_cr12 FOREIGN KEY (arb_p3) REFERENCES Arbre (arbre)
-- PE_END
);

-- PE_BGN
CREATE DOMAIN Note
  TEXT
  CHECK (CHAR_LENGTH(VALUE) < 60);
CREATE DOMAIN Parcelle
  INTEGER
  CHECK ( VALUE > 0);
-- PE_END
CREATE TABLE Plant
  -- Description d'un plant.
  -- La parcelle est une subdivision de la placette.
(
-- à développer
-- PE_BGN
  id       Plant_id    NOT NULL,
  placette Placette_id NOT NULL,
  parcelle Parcelle    NOT NULL, -- TODO: Investigate what it means to be a subdivision
  date     Date_ISO    NOT NULL,
  note     Note,                 -- la note est facultative
  CONSTRAINT Plant_cc00 PRIMARY KEY (id),
  CONSTRAINT Plant_cr00 FOREIGN KEY (placette) REFERENCES Placette (plac)
-- PE_END
);


-- PE_BGN
CREATE DOMAIN Dim_mm
  INTEGER
  CHECK ( VALUE BETWEEN 1 AND 2000 );
-- PE_END
CREATE TABLE ObsDimension
  -- Il a été observé au jour "date" que le plant "id" possédait une feuille
  -- de dimension "longueur" par "largeur".
(
-- à développer
-- PE_BGN
  id       Plant_id NOT NULL,
  date     Date_ISO NOT NULL,
  longueur Dim_mm   NOT NULL,
  largeur  Dim_mm   NOT NULL,
  note     Note, -- Champ facultatif
  CONSTRAINT ObsDimension_cc0 PRIMARY KEY (id, date),
  CONSTRAINT ObsDimension_cr1 FOREIGN KEY (id) REFERENCES Plant (id)
-- PE_END
);

CREATE TABLE ObsFloraison
  -- Il a été observé au jour "date" que le plan "id" possédait une fleur (ou non).
(
-- à développer
-- PE_BGN
  id    Plant_id NOT NULL,
  date  Date_ISO NOT NULL,
  fleur Boolean  NOT NULL,
  note  Note, -- Champ facultatif
  CONSTRAINT ObsFloraison_cc0 PRIMARY KEY (id, date),
  CONSTRAINT ObsFloraison_cr1 FOREIGN KEY (id) REFERENCES Plant (id)
-- PE_END
);

CREATE TABLE ObsEtat
  -- Il a été observé au jour "date" que le plan "id" était dans l'état "etat".
(
-- à développer
-- PE_BGN
  id   Plant_id NOT NULL,
  date Date_ISO NOT NULL,
  etat Etat_id  NOT NULL,
  note Note, -- Champ facultatif
  CONSTRAINT ObsEtat_cc0 PRIMARY KEY (id, date),
  CONSTRAINT ObsEtat_cr1 FOREIGN KEY (id) REFERENCES Plant (id),
  CONSTRAINT ObsEtat_cr2 FOREIGN KEY (etat) REFERENCES Etat (etat)
-- PE_END
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
