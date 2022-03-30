-- CREATE DATABASE EQUIPEMENTTYPES;
-- \c EQUIPEMENTTYPES;

CREATE TABLE RECETTE (
  idre TEXT,
  auteur TEXT,
  -- inspiration TEXT,
  PRIMARY KEY (idre)
);

CREATE TABLE CUVEE (
  idcu TEXT,
  responsable TEXT,
  debut TIMESTAMP,
  fin TIMESTAMP,
  idre TEXT,
  PRIMARY KEY (idcu)
);

CREATE TABLE EQUIPEMENT (
  idmodele TEXT,
  noserie TEXT,
  description TEXT,
  PRIMARY KEY (idmodele, noserie)
);

CREATE TABLE EQUIPEMENTTYPE (
  idmodele TEXT,
  description TEXT,
  PRIMARY KEY (idmodele)
);

CREATE TABLE ETAPE (
  idre TEXT,
  noetape SMALLINT, -- Numéro étape
  description TEXT,
  idmodele TEXT, -- id du équipement type
  PRIMARY KEY (idre, noetape)
);

CREATE TABLE ETAPECU (
  idcu TEXT,
  noetcu TEXT,
  debut  TIMESTAMP,
  fin TIMESTAMP,
  idre TEXT,
  noetape SMALLINT,
  PRIMARY KEY (idcu, noetcu)
);

CREATE TABLE PARTIEDEE (
  idmodele TEXT,
  noserie TEXT,
  idmodele_1 TEXT,
  noserie TEXT,
  PRIMARY KEY (idmodele, noserie, idmodele_1, noserie)
);

CREATE TABLE OPTIONDEE (
  idmodele TEXT,
  idmodele_1 TEXT,
  PRIMARY KEY (idmodele, idmodele_1)
);

CREATE TABLE CAPTEUR (
  idmodele TEXT,
  noserie TEXT,
  description TEXT,
  PRIMARY KEY (idmodele, noserie)
);

CREATE TABLE CAPTEURTYPE (
  idmodele TEXT,
  description TEXT,
  PRIMARY KEY (idmodele)
);

CREATE TABLE SOUSETAPE (
  idre TEXT,
  noetape SMALLINT,
  nose SMALLINT,
  description TEXT,
  PRIMARY KEY (idre, noetape, nose)
);

CREATE TABLE SOUSETAPECU (
  idcu TEXT,
  noetcu TEXT,
  nosecu TEXT,
  debut TIMESTAMP,
  fin TIMESTAMP,
  idre TEXT,
  noetape SMALLINT,
  nose SMALLINT,
  PRIMARY KEY (idcu, noetcu, nosecu)
);

CREATE TABLE OPTIONDEC (
  idmodele TEXT,
  idmesure TEXT,
  PRIMARY KEY (idmodele, idmesure)
);

CREATE TABLE MESURETYPE (
  idmesure TEXT,
  unite TEXT,   -- Changer pour des options? (Kg), (L), (C),
  plagetype TEXT,
  description TEXT,
  PRIMARY KEY (idmesure)
);

CREATE TABLE ACTION (
  idre TEXT,
  noetape SMALLINT,
  nose SMALLINT,
  noac TEXT,
  depart TEXT,
  duree TEXT,
  description TEXT,
  idmesure TEXT,
  PRIMARY KEY (idre, noetape, nose, noac)
);

CREATE TABLE ACTIONCU (
  idcu TEXT,
  noetcu TEXT,
  nosecu TEXT,
  noaccu TEXT,
  debut  TIMESTAMP,
  fin TIMESTAMP,
  idre TEXT,
  noetape SMALLINT,
  nose SMALLINT,
  noac TEXT,
  PRIMARY KEY (idcu, noetcu, nosecu, noaccu)
);

CREATE TABLE MESURERE (
  idmesure TEXT,
  frequence TIME,       -- TODO: precision
  seuilscible DOUBLE,   -- TODO: precision
  seuilsalerte DOUBLE,  -- TODO: precision
  PRIMARY KEY (idmesure)
);

/*
CREATE TABLE AUTRERE (
  description TEXT,
  PRIMARY KEY ()
);
*/

CREATE TABLE INTRANTRE (
  quantite TEXT,
  noi TEXT
                       -- RQ: ajouter l'unité?
--   PRIMARY KEY ()
);

CREATE TABLE INTRANTCU (
  statut TEXT,
  nop TEXT
--   PRIMARY KEY ()
);

/*
CREATE TABLE AUTRECU (
  statut TEXT,
  PRIMARY KEY ()
);
*/

/*
CREATE TABLE MESURECU (
  valeur TEXT,
  PRIMARY KEY ()
);
*/

CREATE TABLE INGREDIENT (
  noi TEXT,
  nom TEXT,
  PRIMARY KEY (noi)
);

CREATE TABLE PRODUIT (
  nop TEXT,
  nolot TEXT,
  quantite TEXT,
  reception TEXT,
  peremption TEXT,
  nof TEXT,
  noi TEXT,
  PRIMARY KEY (nop)
);

CREATE TABLE FOURNISSEUR (
  nof TEXT,
  nom TEXT,
  adresse TEXT,
  telephone TEXT,
  courriel TEXT,
  PRIMARY KEY (nof)
);

ALTER TABLE CUVEE ADD FOREIGN KEY (idre) REFERENCES RECETTE (idre);
ALTER TABLE EQUIPEMENT ADD FOREIGN KEY (idmodele) REFERENCES EQUIPEMENTTYPE (idmodele);
ALTER TABLE ETAPE ADD FOREIGN KEY (idmodele) REFERENCES EQUIPEMENTTYPE (idmodele);
ALTER TABLE ETAPE ADD FOREIGN KEY (idre) REFERENCES RECETTE (idre);
ALTER TABLE ETAPECU ADD FOREIGN KEY (idre, noetape) REFERENCES ETAPE (idre, noetape);
ALTER TABLE ETAPECU ADD FOREIGN KEY (idcu) REFERENCES CUVEE (idcu);
ALTER TABLE PARTIEDEE ADD FOREIGN KEY (idmodele_1, noserie) REFERENCES CAPTEUR (idmodele, noserie);
ALTER TABLE PARTIEDEE ADD FOREIGN KEY (idmodele, noserie) REFERENCES EQUIPEMENT (idmodele, noserie);
ALTER TABLE OPTIONDEE ADD FOREIGN KEY (idmodele_1) REFERENCES CAPTEURTYPE (idmodele);
ALTER TABLE OPTIONDEE ADD FOREIGN KEY (idmodele) REFERENCES EQUIPEMENTTYPE (idmodele);
ALTER TABLE CAPTEUR ADD FOREIGN KEY (idmodele) REFERENCES CAPTEURTYPE (idmodele);
ALTER TABLE SOUSETAPE ADD FOREIGN KEY (idre, noetape) REFERENCES ETAPE (idre, noetape);
ALTER TABLE SOUSETAPECU ADD FOREIGN KEY (idre, noetape, nose) REFERENCES SOUSETAPE (idre, noetape, nose);
ALTER TABLE SOUSETAPECU ADD FOREIGN KEY (idcu, noetcu) REFERENCES ETAPECU (idcu, noetcu);
ALTER TABLE OPTIONDEC ADD FOREIGN KEY (idmesure) REFERENCES MESURETYPE (idmesure);
ALTER TABLE OPTIONDEC ADD FOREIGN KEY (idmodele) REFERENCES CAPTEURTYPE (idmodele);
ALTER TABLE ACTION ADD FOREIGN KEY (idmesure) REFERENCES MESURERE (idmesure);
ALTER TABLE ACTION ADD FOREIGN KEY (idre, noetape, nose) REFERENCES SOUSETAPE (idre, noetape, nose);
ALTER TABLE ACTIONCU ADD FOREIGN KEY (idre, noetape, nose, noac) REFERENCES ACTION (idre, noetape, nose, noac);
ALTER TABLE ACTIONCU ADD FOREIGN KEY (idcu, noetcu, nosecu) REFERENCES SOUSETAPECU (idcu, noetcu, nosecu);
ALTER TABLE MESURERE ADD FOREIGN KEY (idmesure) REFERENCES MESURETYPE (idmesure);
ALTER TABLE INTRANTRE ADD FOREIGN KEY (noi) REFERENCES INGREDIENT (noi);
ALTER TABLE INTRANTCU ADD FOREIGN KEY (nop) REFERENCES PRODUIT (nop);
ALTER TABLE PRODUIT ADD FOREIGN KEY (noi) REFERENCES INGREDIENT (noi);
ALTER TABLE PRODUIT ADD FOREIGN KEY (nof) REFERENCES FOURNISSEUR (nof);