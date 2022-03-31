/*
-- =========================================================================== A
Activité : IFT187
Trimestre : Hiver 2022
Composant : TS_cre.sql
Encodage : UTF-8, sans BOM; fin de ligne Unix (LF)
Plateforme : PostgreSQL 9.4-14.1
Contributeurs :  Maciniss Aliouane (alim2101)
                Kim Desroches (desk1001)
                Pedro Edyvan Hernandez Garcia (herp2601)
                Yvan Ndong Ekouaga (ndoy0901)
Version : 0.1.
Statut : base de développement
Référence : IFT187 donné par Luc Lavoie
-- =========================================================================== A
*/

/*
-- =========================================================================== B
Retrait des définition de domaines, de types, de tables.
-- =========================================================================== B
*/


DROP TABLE Recette CASCADE;
DROP TABLE Etape CASCADE;
DROP TABLE SousEtape CASCADE;
DROP TABLE Action CASCADE;
DROP TABLE MesureRe CASCADE;
DROP TABLE IntrantR CASCADE;
DROP TABLE AutreR CASCADE ;
DROP TABLE Ingredient CASCADE ;
DROP TABLE Produit CASCADE ;
DROP TABLE Fournisseur CASCADE ;
DROP TABLE MesureType CASCADE ;
DROP TABLE CapteurType CASCADE ;
DROP TABLE EquipementType CASCADE ;
DROP TABLE Equipement CASCADE ;
DROP TABLE Capteur CASCADE ;
DROP TABLE Cuvee CASCADE ;
DROP TABLE EtapeCu CASCADE ;
DROP TABLE SousEtapeCu CASCADE ;
DROP TABLE ActionCu CASCADE ;
DROP TABLE IntrantCu CASCADE ;
DROP TABLE MesureCu CASCADE ;
DROP TABLE AutreCu CASCADE ;
DROP TABLE OptionDeE CASCADE ;
DROP TABLE OptionDeC CASCADE ;
DROP TABLE PartieDe CASCADE ;


DROP DOMAIN F_no CASCADE ;
DROP DOMAIN Lot_no CASCADE ;
DROP DOMAIN M_id CASCADE ;
DROP DOMAIN P_no CASCADE ;
DROP DOMAIN R_id CASCADE ;
DROP DOMAIN Unite_mes CASCADE ;
DROP DOMAIN F_ad CASCADE ;
DROP DOMAIN F_email CASCADE ;
DROP DOMAIN F_phone CASCADE ;
DROP DOMAIN Equip_no CASCADE ;
DROP DOMAIN TEquip_id CASCADE ;
DROP DOMAIN Cap_no CASCADE ;
DROP DOMAIN TCap_id CASCADE ;
DROP DOMAIN C_id CASCADE ;
