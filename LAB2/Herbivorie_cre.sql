/*
-- =========================================================================== A
Activité : IFT187
Trimestre : 2022-1
Composant : Herbivorie_cre.sql
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4-14.1
Responsable : Luc.Lavoie@USherbrooke.ca
Version : 0.1.1a
Statut : base de développement
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Création du schéma correspondant à la collecte de données du projet Herbivorie
(voir [ddv]).
-- =========================================================================== B
*/

CREATE DOMAIN Etat_id
  -- Code identifiant uniquement un état d’un plant.
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{1}');

CREATE DOMAIN Description
  -- Description textuelle d’unn code ou commentaire consigné par l’observateur.
  -- Choix discrétionnaire compatible avec les indications reçues.
  TEXT
  CHECK (CHAR_LENGTH (VALUE) BETWEEN 1 AND 60);

CREATE TABLE Etat
  -- Répertoire des états d’un plant.
  -- PRÉDICAT : L’état d’un plant identifié par "etat" correspondant à la description "description".
(
  etat        Etat_id     NOT NULL,
  description Description NOT NULL,
  CONSTRAINT Etat_cc0 PRIMARY KEY (etat)
);

CREATE DOMAIN Peuplement_id
  -- Code identifiant uniquement un peuplement végétal de parcelle.
  -- Choix discrétionnaire compatible avec les indications reçues.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{4}');

CREATE TABLE Peuplement
  -- Répertoire des types de peuplement végétal d’une parcelle.
  -- PRÉDICAT : Le type de peuplement identifié par "peup" correspondant à la description "description".
(
  peup        Peuplement_id NOT NULL,
  description Description   NOT NULL,
  CONSTRAINT Peuplement_cc0 PRIMARY KEY (peup)
);

CREATE DOMAIN Taux_id
  -- Code identifiant uniquement un intervalle de couverture communément appelé «taux».
  -- Ces codes sont utilisés notamment lors de la mesure de l’obstruction latérale et de la surface au sol.
  -- Choix découlant des exigences.
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z]{1}');

CREATE DOMAIN Taux_val
  -- Valeur de couverture.
  -- Choix découlant des exigences.
  SMALLINT
  CHECK (VALUE BETWEEN 0 AND 100);

CREATE TABLE Taux
  -- Répertoire des codes de couverture communément appelés «taux».
  -- PRÉDICAT : Le code de couverture identifié par "cCat" correspondant à l’intervalle de couverture [tMin..tMax].
  -- NOTE : Il ne doit y avoir aucun recoupement entre les intervalles associés aux codes définis
  --   et l’union des intervalles définis doit couvrir la totalité du spectre 0..100.
  --   De plus le choix d’une représentation exacte, discrète de granularité unitaire
  --   conduit naturellement à définir le taux de la catégorie tCat par un intervalle
  --   fermé-fermé [compris entre tMin (inclusivement) et tMax (inclusivement)].
(
  tCat Taux_id  NOT NULL,
  tMin Taux_val NOT NULL,
  tMax Taux_val NOT NULL,
  CONSTRAINT Taux_cc0 PRIMARY KEY (tCat),
  CONSTRAINT Taux_inter CHECK (tMin <= tMax)
);

CREATE DOMAIN Arbre_id
  -- Code identifiant uniquement une variété d’arbres.
  -- Choix discrétionnaire compatible avec les indications reçues.
  TEXT
  CHECK (CHAR_LENGTH (VALUE) BETWEEN 1 AND 20);

CREATE TABLE Arbre
  -- Répertoire des variétés d’arbres.
  -- PRÉDICAT : La variété d’arbres identifiée par "arbre" correspondant à la description "description".
(
  arbre       Arbre_id    NOT NULL,
  description Description NOT NULL,
  CONSTRAINT Arbre_cc0 PRIMARY KEY (arbre)
);

CREATE DOMAIN Placette_id
  -- Code identifiant uniquement une placette.
  -- Choix discrétionnaire compatible avec les indications reçues
  TEXT
  CHECK (VALUE SIMILAR TO '[A-Z][0-9]');

CREATE DOMAIN Date_eco
  -- Date d’une observation écologique.
  -- La valeur minimale choisie est celle de l’entrée en vigueur du calendrier grégorien en France en Nouvelle-France.
  -- La date du début du projet d’observation aurait pu être choisie.
  DATE
  CHECK (VALUE >= '1582-12-20');

CREATE TABLE Placette
  -- Description de la placette
  -- PRÉDICAT : La placette identifiée par "plac" a été caractérisée grâce aux observations
  --            faites en date du "date" et consignées grâce aux autres attributs décrits ci-après.
(
  plac      Placette_id   NOT NULL, -- désignation de la placette
  peup      Peuplement_id NOT NULL, -- type de peuplement de la placette
  obs_F1    Taux_id       NOT NULL, -- obstruction latérale feuillue moyenne à 1 m de hauteur
  obs_F2    Taux_id       NOT NULL, -- obstruction latérale feuillue moyenne à 2 m de hauteur
  obs_C1    Taux_id       NOT NULL, -- obstruction latérale coniférienne moyenne à 1 m de hauteur
  obs_C2    Taux_id       NOT NULL, -- obstruction latérale coniférienne moyenne à 2 m de hauteur
  obs_T1    Taux_id       NOT NULL, -- obstruction latérale totale moyenne entre à 1 m de hauteur
  obs_T2    Taux_id       NOT NULL, -- obstruction latérale totale moyenne à 2 m de hauteur
  graminees Taux_id       NOT NULL, -- pourcentage d’occupation au sol des graminées dans la placette
  mousses   Taux_id       NOT NULL, -- pourcentage d’occupation au sol des mousses dans la placette
  fougeres  Taux_id       NOT NULL, -- pourcentage d’occupation au sol des fougères dans la placette
  arb_P1    Arbre_id      NOT NULL, -- arbre dominant de la placette (1er rang)
  arb_P2    Arbre_id      NOT NULL, -- arbre dominant de la placette (2e rang)
  arb_P3    Arbre_id      NOT NULL, -- arbre dominant de la placette (3e rang)
  date      Date_eco      NOT NULL, -- date à laquelle la description a été établie
  CONSTRAINT Placette_cc0 PRIMARY KEY (plac),
  CONSTRAINT Placette_cr_pe FOREIGN KEY (peup) REFERENCES Peuplement (peup),
  CONSTRAINT Placette_cr_f1 FOREIGN KEY (obs_F1) REFERENCES Taux (tCat),
  CONSTRAINT Placette_cr_f2 FOREIGN KEY (obs_F2) REFERENCES Taux (tCat),
  CONSTRAINT Placette_cr_c1 FOREIGN KEY (obs_C1) REFERENCES Taux (tCat),
  CONSTRAINT Placette_cr_c2 FOREIGN KEY (obs_C2) REFERENCES Taux (tCat),
  CONSTRAINT Placette_cr_t1 FOREIGN KEY (obs_T1) REFERENCES Taux (tCat),
  CONSTRAINT Placette_cr_t2 FOREIGN KEY (obs_T2) REFERENCES Taux (tCat),
  CONSTRAINT Placette_cr_gr FOREIGN KEY (graminees) REFERENCES Taux (tCat),
  CONSTRAINT Placette_cr_mo FOREIGN KEY (mousses) REFERENCES Taux (tCat),
  CONSTRAINT Placette_cr_fo FOREIGN KEY (fougeres) REFERENCES Taux (tCat),
  CONSTRAINT Placette_cr_p1 FOREIGN KEY (arb_P1) REFERENCES Arbre (arbre),
  CONSTRAINT Placette_cr_p2 FOREIGN KEY (arb_P2) REFERENCES Arbre (arbre),
  CONSTRAINT Placette_cr_p3 FOREIGN KEY (arb_P3) REFERENCES Arbre (arbre)
  -- NOTE : Comment vérifier que obs_T1.tMin >= obs_F1.tMin + obs_C1.tMin ?
  -- NOTE : Comment vérifier que obs_T2.tMin >= obs_F2.tMin + obs_C2.tMin ?
  -- NOTE : Que faudrait-il faire pour les tMax ?
  -- NOTE : Que faudrait-il suggérer aux collègues écologistes ?
);

CREATE DOMAIN Plant_id
  -- Code identifiant uniquement un plant de trille.
  -- Choix discrétionnaire compatible avec les indications reçues
  TEXT
  CHECK (VALUE SIMILAR TO 'MM[A-C][0-9]{4}');

CREATE DOMAIN Parcelle
  -- La parcelle est une subdivision de la placette.
  -- Choix discrétionnaire compatible avec les indications reçues
  SMALLINT
  CHECK (VALUE BETWEEN 1 AND 99);

CREATE TABLE Plant
  -- Répertoire des descriptions de plants de trille.
  -- PRÉDICAT : Le plant identifié par "id" a été caractérisé grâce aux observations
  --            faites en date du "date" et consignées grâce aux autres attributs décrits ci-après.
(
  id       Plant_id    NOT NULL, -- identifiant unique de chaque trille
  placette Placette_id NOT NULL, -- placette dans laquelle est le trille
  parcelle Parcelle    NOT NULL, -- parcelle dans laquelle se trouve le trille
  date     Date_eco    NOT NULL, -- date de la prise de données
  note     TEXT        NOT NULL, -- note supplémentaire à propos du trille
  CONSTRAINT Plant_cc0 PRIMARY KEY (id),
  CONSTRAINT Plant_cr0 FOREIGN KEY (placette) REFERENCES Placette (plac)
);

CREATE DOMAIN Dim_mm
  -- Dimension d’une feuille de trille exprimée en millimètre.
  SMALLINT
  CHECK (VALUE BETWEEN 1 AND 999);

CREATE TABLE ObsDimension
  -- Répertoire des observations de dimension de plants de trille.
  -- PRÉDICAT : Il a été observé en date du "date" que le plan "id" possédait une feuille
  --            de dimension "longueur" par "largeur".
  --            À cette occasion, l’observateur a consigné le commentaire "note".
(
  id       Plant_id NOT NULL, -- identifiant unique de chaque trille
  longueur Dim_mm   NOT NULL, -- longueur d’une des feuilles d’un trille, en mm
  largeur  Dim_mm   NOT NULL, -- largeur d’une des feuilles d’un trille, en mm
  date     Date_eco NOT NULL, -- date de l’observation
  note     TEXT     NOT NULL, -- note supplémentaire à propos du trille
  CONSTRAINT ObsDimension_cc0 PRIMARY KEY (id, date),
  CONSTRAINT ObsDimension_cr0 FOREIGN KEY (id) REFERENCES Plant (id)
);

CREATE TABLE ObsFloraison
  -- Répertoire des observations de floraison de plants de trille.
  -- PRÉDICAT : Il a été observé au jour "date" que le plan "id" possédait une fleur (ou non).
  --            À cette occasion, l’observateur a consigné le commentaire "note".
(
  id       Plant_id NOT NULL, -- identifiant unique de chaque trille
  fleur    BOOLEAN  NOT NULL, -- présence de fleur
  date     Date_eco NOT NULL, -- date de l’observation
  note     TEXT     NOT NULL, -- note supplémentaire à propos du trille
  CONSTRAINT ObsFloraison_cc0 PRIMARY KEY (id, date),
  CONSTRAINT ObsFloraison_cr0 FOREIGN KEY (id) REFERENCES Plant (id)
);

CREATE TABLE ObsEtat
  -- Répertoire des observations d’état de plants de trille.
  -- PRÉDICAT : Il a été observé au jour "date" que le plan "id" était dans l’état "etat".
  --            À cette occasion, l’observateur a consigné le commentaire "note".
(
  id       Plant_id NOT NULL, -- identifiant unique de chaque trille
  etat     Etat_id  NOT NULL, -- état du plant
  date     Date_eco NOT NULL, -- date de l’observation
  note     TEXT     NOT NULL, -- note supplémentaire à propos du trille
  CONSTRAINT ObsEtat_cc0 PRIMARY KEY (id, date),
  CONSTRAINT ObsEtat_cr0 FOREIGN KEY (id) REFERENCES Plant (id),
  CONSTRAINT ObsEtat_cr1 FOREIGN KEY (etat) REFERENCES Etat (etat)
);

/*
-- =========================================================================== Z
== Contributeurs

  (DAL) Diane.Auberson-Lavoie@USherbrooke.ca
  (LL) Luc.Lavoie@USherbrooke.ca

== Adresse, droits d’auteur et copyright

  Groupe Metis
  Département d’informatique
  Faculté des sciences
  Université de Sherbrooke
  Sherbrooke (Québec)  J1K 2R1
  Canada
  http://info.usherbrooke.ca/llavoie/
  [CC-BY-NC-4.0 (http://creativecommons.org/licenses/by-nc/4.0)]

== Tâches projetées

2022-01-23 (LL) : Compléter le schéma
  * Décomposer et temporaliser les observations relatives aux placettes
    (obstruction latérale, couverture au sol, espèces dominantes, etc.).
2017-09-19 (LL) : Compléter le schéma
  * Compléter les contraintes, en particulier :
    - la date d'observation d'un plan ne peut être antérieur à son identification ;
    - la date d'identification d'un plant ne peut être antérieur à celui de sa placette ;
    - les obstructions latérales observées d'une placette doivent être cohérentes ;
    - les couvertures au sol observées d'une placette doivent être cohérentes.
2017-09-18 (LL) : Renommer plus rigoureusement des concept utilisés par le schéma
  * Plusieurs identificateurs sont inappropriés en regards des concepts véhiculées.
  * Certaines abréviations prêtent à confusion.
  * La constitution d'un dictionnaire de données et l'utilisation d'une terminologie
    rigoureuse est fortement recommandes.
  * Entre autres exemples : obs -> obstruction latérale, taux -> pourcentage,
    arb -> variété d'arbres, peup, plac, etc.

== Tâches réalisées

2022-01-23 (LL) : Épurer le schéma.
  * Déplacer les commentaires généraux dans Herbivorie_def.
  * Déplacer le carnet dans Herbi-ELT_def.
  * Remplacer les textes statiques (CHAR) par des textes dynamiques (TEXT).
  * Adapter les contraintes en conséquence.
  * Compléter certains prédicats.
  * Enrichir certains commentaires.
  * Capitaliser les types prédéfinis.
  * Corriger diverses coquilles.
2017-09-20 (LL) : Compléter le schéma.
  * Décomposer Placette afin de permettre l’annulabilité de certaines colonnes.
  * Ne mettre que des attributs TEXT dans Carnet et parfaire les validations.
  * Introduire la table Arbre et les clés référentielles appropriées.
2017-09-17 (LL) : Création
  * Création du schéma de base.
  * Validation minimale du carnet d’observations (voir test0).
  * Importation des observations intègres (voir ini).

== Références

[ddv] http://info.usherbrooke.ca/llavoie/enseignement/Exemples/Herbivorie/Herbivorie_DDV.pdf
[mod] http://info.usherbrooke.ca/llavoie/enseignement/Modules/

-- -----------------------------------------------------------------------------
-- fin de Herbivorie_cre.sql
-- =========================================================================== Z
*/
