/*
-- =========================================================================== A
Activité : IFT187
Trimestre : Hiver 2022
Composant : TS_cre.sql
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4-14.1
Contributeurs : Maciniss Aliouane (alim2101)
                Kim Desroches (desk1001)
                Pedro Edyvan Hernandez Garcia (herp2601)
                Yvan Ndong Ekouaga (ndoy0901)
Version : 0.1.
Statut : base de développement
Référence : Document Herbivorie_cre.sql du cours IFT187 donné par Luc Lavoie
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Création du schéma relationnel correspondant au schéma conceptuel du travail de
session.
-- =========================================================================== B
*/

--Création des domaines

CREATE DOMAIN R_id
    --Code identifiant uniquement une recette
    TEXT
    CHECK(VALUE SIMILAR TO ''); --todo

CREATE DOMAIN M_id
    --Code identifiant uniquement un type de mesure
    --Représente les 4 premières lettres du type de mesure. Par exemple, pour une mesure de température : temp
    TEXT
    CHECK ( VALUE SIMILAR TO '[A-Z]{4}[1-9]{1-6}');

CREATE DOMAIN Unite_mes
    -- Abréviation de l'unité de mesure
    -- Choix discrétionnaire compatible avec les indications reçues.
    TEXT
    CHECK (VALUE SIMILAR TO '[A-Z]{1-4}');

CREATE DOMAIN P_no
    --Code identifiant uniquement un produit
    TEXT
    CHECK(VALUE SIMILAR TO ''); --TODO

CREATE DOMAIN Lot_no
    --Code identifiant le lot du produit
    TEXT
    CHECK(VALUE SIMILAR TO '[0-9]{8}');

CREATE DOMAIN F_no
    --Code identifiant uniquement un fournisseur
    TEXT
    CHECK(VALUE SIMILAR TO '[F][0-9]{4}[A-Z]{4}'); --TODO

CREATE DOMAIN F_ad
    --Format de l'adresse du fournisseur
    TEXT
    CHECK ( VALUE SIMILAR TO ''); --TODO

CREATE DOMAIN F_email
    --Format de l'adresse courriel du fournisseur
    TEXT
    CHECK ( VALUE SIMILAR TO '^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$'); --TODO: vérifier la longueur

CREATE DOMAIN F_phone
    --Format du numéro de téléphone provenant des pays membres de l'ITU.
    --Le numéro de téléphone ne comprend que les chiffres qui les composent.
    TEXT
    CHECK (VALUE SIMILAR TO '[0-9]{8,13}');

CREATE DOMAIN Equip_no
    --Code identifiant un équipement, représente le numéro de série de cet équipement
    TEXT
    CHECK ( VALUE SIMILAR TO ''); --TODO

CREATE DOMAIN TEquip_id
    --Code identifiant uniquement un type d'équipement
    TEXT
    CHECK ( VALUE SIMILAR TO ''); --TODO

CREATE DOMAIN Cap_no
    --Code identifiant un capteur, représente le numéro de série de ce capteur
    TEXT
    CHECK ( VALUE SIMILAR TO ''); --TODO

CREATE DOMAIN TCap_id
    --Code identifiant uniquement un type de capteur
    TEXT
    CHECK ( VALUE SIMILAR TO ''); --TODO

CREATE DOMAIN C_id
    --Code identifiant uniquement une cuvée
    TEXT
    CHECK ( VALUE SIMILAR TO ''); --TODO




--Creation des tables

CREATE TABLE Recette (
  idR R_id,
  auteur TEXT,
  -- inspiration TEXT,
  CONSTRAINT Recette_cc0 PRIMARY KEY (idR)
);

CREATE TABLE Cuvee (
  idC C_id,
  responsable TEXT,
  debut TIMESTAMP,
  fin TIMESTAMP,
  idR R_id,
  CONSTRAINT Cuvee_cc0 PRIMARY KEY (idC),
  CONSTRAINT Cuvee_cr0 FOREIGN KEY (idR) REFERENCES Recette (idR)
);

CREATE TABLE EquipementType (
  idTEquip TEXT,
  description TEXT,
  CONSTRAINT EquipementType_cc0 PRIMARY KEY (idTEquip)
);

CREATE TABLE Equipement (
  idTEquip TEXT,
  noSerie TEXT,
  description TEXT,
  CONSTRAINT Equipement_cc0 PRIMARY KEY (idTEquip, noSerie),
  CONSTRAINT Equipement_cr0 FOREIGN KEY (idTEquip) REFERENCES EquipementType (idTEquip)
);

CREATE TABLE Etape (
  idR TEXT,
  noE SMALLINT, -- Numéro étape
  description TEXT,
  idTEquip TEXT, -- id du équipement type
  CONSTRAINT Etape_cc0 PRIMARY KEY (idR, noE),
  CONSTRAINT Etape_cr0 FOREIGN KEY (idTEquip) REFERENCES EquipementType (idTEquip),
  CONSTRAINT Etape_cr1 FOREIGN KEY (idR) REFERENCES Recette (idR)
);

CREATE TABLE EtapeCu (
  idC C_id,
  noECu TEXT,
  debut  TIMESTAMP,
  fin TIMESTAMP,
  idR R_id,
  noE SMALLINT,
  CONSTRAINT EtapeCu_cc0 PRIMARY KEY (idC, noECu),
  CONSTRAINT EtapeCu_cr0 FOREIGN KEY (idR, noE) REFERENCES Etape (idR, noE),
  CONSTRAINT EtapeCu_cr1 FOREIGN KEY (idC) REFERENCES Cuvee (idC)
);

CREATE TABLE CapteurType (
  idTCap TEXT,
  description TEXT,
  CONSTRAINT CapteurType_cc0 PRIMARY KEY (idTCap)
);

CREATE TABLE Capteur (
  idTCap TEXT,
  noSerie TEXT,
  description TEXT,
  CONSTRAINT Capteur_cc0 PRIMARY KEY (idTCap, noSerie),
  CONSTRAINT Capteur_cr0 FOREIGN KEY (idTCap) REFERENCES CapteurType (idTCap)
);

CREATE TABLE SousEtape (
  idR R_id,
  noE SMALLINT,
  noSE SMALLINT,
  description TEXT,
  CONSTRAINT SousEtape_cc0 PRIMARY KEY (idR, noE, noSE),
  CONSTRAINT SousEtape_cr0 FOREIGN KEY (idR, noE) REFERENCES Etape (idR, noE)
);

CREATE TABLE SousEtapeCu (
  idC C_id,
  noECu TEXT,
  noSEcu TEXT,
  debut TIMESTAMP,
  fin TIMESTAMP,
  idR R_id,
  noE SMALLINT,
  noSE SMALLINT,
  CONSTRAINT SousEtapeCu_cc0 PRIMARY KEY (idC, noECu, noSEcu),
  CONSTRAINT SousEtapeCu_cr0 FOREIGN KEY (idR, noE, noSE) REFERENCES SousEtape (idR, noE, noSE),
  CONSTRAINT SousEtapeCu_cr1 FOREIGN KEY (idC, noECu) REFERENCES EtapeCu (idC, noECu)
);

CREATE TABLE MesureType (
  idM M_id,
  unite Unite_mes,   -- Changer pour des options? (Kg), (L), (C),
  plagetype TEXT,
  description TEXT,
  CONSTRAINT MesureType_cc0 PRIMARY KEY (idM)
);

CREATE TABLE Action (
  idR R_id,
  noE SMALLINT,
  noSE SMALLINT,
  noA TEXT,
  depart TEXT,
  duree TEXT,
  description TEXT,
  idM M_id,
  CONSTRAINT Action_cc0 PRIMARY KEY (idR, noE, noSE, noA),
  CONSTRAINT Action_cr1 FOREIGN KEY (idR, noE, noSE) REFERENCES SousEtape (idR, noE, noSE)
);


CREATE TABLE MesureRe (
    idR R_id,
    noE SMALLINT,
    noSE SMALLINT,
    noA TEXT,
    idM M_id,
    frequence TIME,       -- TODO: precision
    seuilscible TEXT,   -- TODO: precision
    seuilsalerte TEXT,  -- TODO: precision
    CONSTRAINT MesureRe_cc0 PRIMARY KEY (idM),
    CONSTRAINT MesureRe_cr0 FOREIGN KEY (idM) REFERENCES MesureType (idM),
    CONSTRAINT MesureRe_cr1 FOREIGN KEY (idR, noE, noSE, noA) REFERENCES Action (idR, noE, noSE, noA)

);


CREATE TABLE ActionCu (
  idC C_id,
  noECu TEXT,
  noSEcu TEXT,
  noACu TEXT,
  debut  TIMESTAMP,
  fin TIMESTAMP,
  idR R_id,
  noE SMALLINT,
  noSE SMALLINT,
  noA TEXT,
  CONSTRAINT ActionCu_cc0 PRIMARY KEY (idC, noECu, noSEcu, noACu),
  CONSTRAINT ActionCu_cr0 FOREIGN KEY (idR, noE, noSE, noA) REFERENCES Action (idR, noE, noSE, noA),
  CONSTRAINT ActionCu_cr1 FOREIGN KEY (idC, noECu, noSEcu) REFERENCES SousEtapeCu (idC, noECu, noSEcu)
);



CREATE TABLE Ingredient (
  noI TEXT,
  nomI TEXT,
  CONSTRAINT Ingredient_cc0 PRIMARY KEY (noI)
);

CREATE TABLE Fournisseur (
    noF F_no,
    nomF TEXT,
    adresse TEXT,
    telephone TEXT,
    courriel TEXT,
    CONSTRAINT Fournisseur_cc0 PRIMARY KEY (noF)
);

CREATE TABLE Produit (
    noP P_no,
    noLot Lot_no,
    quantite TEXT,
    dateRecu TEXT,
    peremption TEXT,
    noF F_no,
    noI TEXT,
    CONSTRAINT Produit_cc0 PRIMARY KEY (noP),
    CONSTRAINT Produit_cr0 FOREIGN KEY (noI) REFERENCES Ingredient (noI),
    CONSTRAINT Produit_cr1 FOREIGN KEY (noF) REFERENCES Fournisseur (noF)
);

CREATE TABLE IntrantR (
    idR R_id,
    noE SMALLINT,
    noSE SMALLINT,
    noA TEXT,
    noI TEXT,
    quantite TEXT,
                       -- RQ: ajouter l'unité?
    CONSTRAINT IntrantR_cr0 FOREIGN KEY (idR, noE, noSE, noA) REFERENCES Action (idR, noE, noSE, noA),
    CONSTRAINT IntrantR_cr1 FOREIGN KEY (noI) REFERENCES Ingredient (noI)

);

CREATE TABLE IntrantCu (
    idC C_id,
    noECu TEXT,
    noSEcu TEXT,
    noACu TEXT,
    statut TEXT,
    noP P_no,
    CONSTRAINT IntrantCu_cr0 FOREIGN KEY (noP) REFERENCES Produit (noP),
    CONSTRAINT ActionCu_cr1 FOREIGN KEY (idC, noECu, noSEcu, noACu) REFERENCES ActionCu (idC, noECu, noSEcu, noACu)
);


CREATE TABLE AutreR (
    idR R_id,
    noE SMALLINT,
    noSE SMALLINT,
    noA TEXT,
    description TEXT,
    CONSTRAINT AutreR_cr0 FOREIGN KEY (idR, noE, noSE, noA) REFERENCES Action (idR, noE, noSE, noA)
);


CREATE TABLE AutreCu (
    idC C_id,
    noECu TEXT,
    noSEcu TEXT,
    noACu TEXT,
    statut TEXT,
    CONSTRAINT AutreCu_cr0 FOREIGN KEY (idC, noECu, noSEcu, noACu) REFERENCES ActionCu (idC, noECu, noSEcu, noACu)
);


CREATE TABLE MesureCu (
    idC C_id,
    noECu TEXT,
    noSEcu TEXT,
    noACu TEXT,
    valeur TEXT,
    CONSTRAINT MesureCu_cr0 FOREIGN KEY (idC, noECu, noSEcu, noACu) REFERENCES ActionCu (idC, noECu, noSEcu, noACu)
);


CREATE TABLE OptionDeE(
    idTEquip TEXT,
    idTCap TEXT,
    CONSTRAINT OptionDeE_cr0 FOREIGN KEY (idTEquip) REFERENCES EquipementType (idTEquip),
    CONSTRAINT OptionDeE_cr1 FOREIGN KEY (idTCap) REFERENCES CapteurType (idTCap)
);


CREATE TABLE OptionDeC(
    idTCap TEXT,
    idM M_id,
    CONSTRAINT OptionDeE_cr0 FOREIGN KEY (idM) REFERENCES MesureType (idM),
    CONSTRAINT OptionDeE_cr1 FOREIGN KEY (idTCap) REFERENCES CapteurType (idTCap)
);

CREATE TABLE PartieDe(
    idTEquip TEXT,
    noSerieE TEXT,
    idTCap TEXT,
    noSerieC TEXT,
    CONSTRAINT PartieDe_cr0 FOREIGN KEY (idTEquip, noSerieE) REFERENCES Equipement (idTEquip, noSerie),
    CONSTRAINT PartieDe_cr1 FOREIGN KEY (idTCap,noSerieC) REFERENCES Capteur (idTCap,noSerie)
);

ALTER TABLE Action ADD CONSTRAINT Action_cr0 FOREIGN KEY (idM) REFERENCES MesureRe (idM);