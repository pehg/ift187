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
-- Pour chaque journée consignée, donner la température minimale, la température maximale, le taux d’humidité
-- minimal, le taux maximal, le nombre de millimètres de précipitation et la nature de la précipitation. Le cas
-- échéant, choisir les unités appropriées. Forte recommandation : définir plusieurs tables, à raison d’une table par
-- groupe d’attributs provenant d’un même capteur afin de permettre la saisie des mesures provenant des capteurs
-- fonctionnels, même quand d’autres ne le sont pas.

CREATE DOMAIN Temperature_C
    -- Température extérieure en celcius
    FLOAT
    CHECK ( VALUE BETWEEN -50.0 AND 50.0 ); --Afin d'éviter une donnée de température exagérée pour les mois attendus

CREATE DOMAIN TauxHumidite
    --Taux d'humidité en pourcentage
    SMALLINT
    CHECK(VALUE BETWEEN 0 AND 100);

CREATE DOMAIN precipitation_mm
    -- Le nombre de millimètres de précipitation
    FLOAT
    CHECK(VALUE >= 0.0 );

CREATE DOMAIN precipitation_nature
    -- La nature de la précipitation : pluie (P), grêle (G), neige (N), sans précipitation (O)
    TEXT
    CHECK(VALUE IN ('N','G','P', 'O'));


CREATE TABLE Temperature
    -- Répertoire des conditions météorologiques de températures
    --PRÉDICAT: Il a été consigné à la journée "date" que la température minimale est de "temp_max" et la température maximale est de "temp_max".
(
    journee     date            NOT NULL, -- Date de la journée consignée
    temp_min    Temperature_C   NOT NULL, --Température minimale atteinte durant la journée
    temp_max    Temperature_C   NOT NULL, --Température maximale atteinte durant la journée
    CONSTRAINT Temperature_cc0 PRIMARY KEY (journee),
    CONSTRAINT Temp_inter CHECK (temp_min <= temp_max)
);


CREATE TABLE Humidite
-- Répertoire des conditions météorologiques du taux d'humidité quotidiennes.
-- PRÉDICAT: Il a été consigné à la journée "date" que e taux d’humidité minimal est de "hum_min" et le taux maximal est de "hum_max".
(
    journee     date            NOT NULL, -- Date de la journée consignée
    hum_min     TauxHumidite    NOT NULL, --Taux d'humidité minimale atteint durant la journée
    hum_max     TauxHumidite    NOT NULL, --Taux d'humidité maximale atteint durant la journée
    CONSTRAINT Humidite_cc0 PRIMARY KEY (journee),
    CONSTRAINT Humidite_inter CHECK (hum_min <= hum_max)
);


CREATE TABLE Precipitation
    -- Répertoire des conditions météorologiques du nombre de millimètres de précipitation et de la nature de la précipitation.
    -- PRÉDICAT : Il a été consigné à la journée "date" que le nombre de millimètres de précipitation est de "prec_mm"
    -- et la nature de la précipitation est de "prec_nat".
(
    journee     date                   NOT NULL, -- Date de la journée consignée
    prec_mm     precipitation_mm       NOT NULL, -- Nombre de millimètres de précipitation de la journée
    prec_nat    precipitation_nature   NOT NULL, --Nature de la précipitation de la journée
    CONSTRAINT Precipitation_cc0 PRIMARY KEY (journee)
);


-- Y2.
-- Ajouter des données météorologiques vraisemblables et représentatives pour le mois de juin 2016.
-- À partir de la table CarnetMeteo, alimenter les tables créées en Y1 en faisant les vérifications requises.
-- Définir les fonctions requises pour ce faire. N’insérer que les données valides et intègres.
-- Proposer un jeu de données qui illustre l’adéquation de votre alimentation.

CREATE TABLE CarnetMeteo
-- Répertoire des conditions météorologiques notés
--PRÉDICAT: Les données de température minimale de "temp_min" et maximale de "temp_max" ainsi que celles du taux d'humidité
-- minimale de "hum_min" et maximale de " hum_max" et celles du nombre de millimètres de précipitations de "prec_mm" et de
-- la nature de la précipitation de "prec_nat" sont compilées selon la journée "date".
(
    journee     TEXT NOT NULL, -- Date de la journée consignée
    temp_min    TEXT,          --Température minimale atteinte durant la journée
    temp_max    TEXT,          --Température maximale atteinte durant la journée
    hum_min     TEXT,          --Taux d'humidité minimale atteint durant la journée
    hum_max     TEXT,          --Taux d'humidité maximale atteint durant la journée
    prec_mm     TEXT,          -- Nombre de millimètres de précipitation de la journée
    prec_nat    TEXT,          --Nature de la précipitation de la journée
    CONSTRAINT CarnetMeteo_cc0 PRIMARY KEY (journee)
);

-- Le fichier Herbivorie_jeu4.sql doit être ainsi initialisé afin d'insérer des données dans
-- la table CarnetMeteo. Ainsi, la suite du programme peut être effectuée.
-- Dans le cas-ci, il serait avantageux d'inclure cette table dans un fichier différent
-- afin d'éviter une intervention pour insérer les données et permettre l'exécution complète du
-- programme.


--  -----------------------------------------------------------------------------------------
-- Fonctions de vérification du contenu dans la table CarnetMeteo
-- ------------------------------------------------------------------------------------------

--Fonction permettant de s'assurer que la date notée corresponde au format attendu et qu'elle se situe dans un intervalle réaliste
CREATE OR REPLACE FUNCTION test_date (journee Text)
RETURNS BOOLEAN
LANGUAGE SQL AS
$$
     --SELECT journee SIMILAR TO '\d{4}-\d{1,2}-\d{1,2}'
    -- On support des journees et mois comportant un seul chiffre comme 2020-1-1.
    --   Year: from 1900 to 2029
    --   Month: from 1 to 12, accepting single digits or double digits
    --   Day: from 1 to 31, accepting single digits or double digits

    SELECT journee SIMILAR TO '((19\d\d)|(20[0-2]\d))-((1[0-2])|(0[1-9])|[1-9])-([1-9]|(0[1-9])|([1-2]\d)|(3[01]))'
    -- Comment procéder si on veut regarder si le mois contient 28, 29, 30  ou 31 jours?
$$;

--Fonction permettant de s'assurer que le température (minimale et maximale) se situe dans un intervalle raisonnable.
CREATE OR REPLACE FUNCTION test_temp (temp Text)
RETURNS BOOLEAN
LANGUAGE SQL AS
$$
    SELECT temp SIMILAR TO '-?((50(.0)?)|([1-4]?\d(.\d)?))'
    --possibilité d'avoir une mesure de température avec une décimal
$$;

--Fonction permettant de s'assurer que le taux d'humidité (minimal et maximal) se situe dans l'intervalle approprié
CREATE OR REPLACE FUNCTION test_hum (taux_hum TEXT)
    RETURNS BOOLEAN
LANGUAGE SQL AS
$$
    SELECT taux_hum SIMILAR TO '(\d{1,2})|(100)'
$$;

--Fonction permettant de s'assurer que le nombre de millimètres de précipitations se situe dans un intervalle approprié
CREATE OR REPLACE FUNCTION test_prec (prec_mm TEXT)
RETURNS BOOLEAN
LANGUAGE SQL AS
$$
    SELECT prec_mm SIMILAR TO '\d{1,3}(.\d)?'
$$;

--Fonction permettant de s'assurer que la nature de précipitations est bien représentée
CREATE OR REPLACE FUNCTION test_natPrec (prec_nat TEXT)
RETURNS BOOLEAN
LANGUAGE SQL AS
$$
    SELECT prec_nat SIMILAR TO '[NGPO]' --Considère seulement les majuscules
$$;

-- -----------------------------------------------------------------------------------------
-- Fonctions de conversion du type
-- -----------------------------------------------------------------------------------------

--Fonction permettant de convertir le type (chaîne de caractères) de la date
CREATE OR REPLACE FUNCTION conv_date (journee Text)
RETURNS Date
LANGUAGE SQL AS
$$
    SELECT CAST (journee AS Date   )
$$;

--Fonction permettant de convertir le type (chaîne de caractères) de la température
CREATE OR REPLACE FUNCTION conv_temp (temp Text)
RETURNS Temperature_C
LANGUAGE SQL AS
$$
    SELECT CAST (temp AS Temperature_C)
$$;

--Fonction permettant de convertir le type (chaîne de caratères) du taux d'humidité
CREATE OR REPLACE FUNCTION conv_hum (taux_hum TEXT)
RETURNS TauxHumidite
LANGUAGE SQL AS
$$
    SELECT CAST (taux_hum AS TauxHumidite)
$$;

--Fonction permettant de convertir le type (chaîne de caratères) du nombre de millimètres de précipitations.
CREATE OR REPLACE FUNCTION conv_prec (prec_mm TEXT)
RETURNS Precipitation_mm
LANGUAGE SQL AS
$$
    SELECT CAST (prec_mm AS Precipitation_mm)
$$;

--Fonction permettant de convertir le type de la nature de précipitations
CREATE OR REPLACE FUNCTION conv_natPrec (prec_nat TEXT)
RETURNS precipitation_nature
LANGUAGE SQL AS
$$
    SELECT CAST(prec_nat AS precipitation_nature)
$$;

-- ----------------------------------------------------------------------------------------
-- Création de vues contenant les données météorologiques filtrées (bon format et type)
-- ----------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW FiltreTemp AS
    (
    SELECT conv_date(journee) AS journee, conv_temp(temp_min) AS temp_min, conv_temp(temp_max) AS temp_max
    FROM CarnetMeteo
    WHERE test_date(journee) AND test_temp(temp_min) AND test_temp(temp_max)
    );

CREATE OR REPLACE VIEW FiltreHum AS
    (
    SELECT conv_date(journee) AS journee, conv_hum(hum_min) AS hum_min, conv_hum(hum_max) AS hum_max
    FROM CarnetMeteo
    WHERE test_date(journee) AND test_hum(hum_min) AND test_hum(hum_max)
    );

CREATE OR REPLACE VIEW FiltrePrec AS
    (
    SELECT conv_date(journee) AS journee, conv_prec(prec_mm) AS prec_mm, conv_natPrec(prec_nat) AS prec_nat
    FROM CarnetMeteo
    WHERE test_date(journee) AND test_prec(prec_mm) AND test_natPrec(prec_nat)
    );

-- Insertion de données valides et intègres dans les tables créées en Y1

INSERT INTO Temperature
SELECT *
FROM FiltreTemp;

INSERT INTO Humidite
SELECT *
FROM FiltreHum;

INSERT INTO Precipitation
SELECT *
FROM FiltrePrec;


-- Y3.
-- Définir une vue donnant les conditions météorologiques complètes hors précipitation.
-- Maintenir les mêmes identifiants d’attributs qu’en Y1.
--PRÉCISION: On considère que les conditions hors précipitations signifie qu'on ne veut pas de données de précipitation.
--Donc, on ne veut pas les colonnes associées aux précipitations.

CREATE OR REPLACE VIEW HorsPrec AS
    (
    SELECT *
    FROM Temperature NATURAL JOIN Humidite
    )
;

-- Y4.
-- Retirer les données météorologiques du 17 au 19 juin si la température minimale rapportée est en deçà de 4 C
-- (le capteur était défectueux). Utiliser l’instruction DELETE.
-- PRÉCISION: Ainsi, on conserve seulement les données météorologiques de température du 17 au 19 juin qui ont une
-- température minimale rapportée plus grande que 4 C
--RAPPEL: On veut pour les données de l'année 2016

DELETE FROM Temperature
WHERE (journee BETWEEN '2016-06-17' AND '2016-06-19')
  AND (temp_min < 4)
;

-- Y5.
-- Augmenter les températures rapportées de 10 % entre le 20 et 30 juin (le capteur était mal calibré).
-- Utiliser l’instruction UPDATE.
--RAPPEL: On veut pour les données de l'année 2016

UPDATE Temperature
  SET temp_max = temp_max*(1.10),
      temp_min = temp_min*(1.10)
  WHERE journee BETWEEN '2016-06-20' AND '2016-06-30'



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
