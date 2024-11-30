DROP DATABASE IF EXISTS recette;

CREATE DATABASE IF NOT EXISTS recette;
USE recette;
# -----------------------------------------------------------------------------
#       TABLE : RECETTE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS RECETTE
 (
   ID_RECETTE INTEGER NOT NULL AUTO_INCREMENT,
   ID_CATEGORIE INTEGER NOT NULL  ,
   ID_USER INTEGER NOT NULL  ,
   TITRE TEXT NOT NULL  ,
   DESCRIPTION TEXT NULL  ,
   INGREDIENTS TEXT NOT NULL  ,
   INSTRUCTIONS TEXT NOT NULL  ,
   IMAGE TEXT NULL  ,
   DATE_CREATION DATE NULL  
   , PRIMARY KEY (ID_RECETTE) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE RECETTE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_RECETTE_CATEGORIE
     ON RECETTE (ID_CATEGORIE ASC);

CREATE  INDEX I_FK_RECETTE_UTILISATEUR
     ON RECETTE (ID_USER ASC);

# -----------------------------------------------------------------------------
#       TABLE : UTILISATEUR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS UTILISATEUR
 (
   ID_USER INTEGER NOT NULL  AUTO_INCREMENT,
   USERNAME TEXT NOT NULL  ,
   EMAIL TEXT NULL  ,
   MOT_DE_PASSE TEXT NOT NULL  
   , PRIMARY KEY (ID_USER) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : CATEGORIE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CATEGORIE
 (
   ID_CATEGORIE INTEGER NOT NULL  AUTO_INCREMENT,
   NOM_CATEGORIE TEXT NOT NULL  
   , PRIMARY KEY (ID_CATEGORIE) 
 ) 
 comment = "";


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE RECETTE 
  ADD FOREIGN KEY FK_RECETTE_CATEGORIE (ID_CATEGORIE)
      REFERENCES CATEGORIE (ID_CATEGORIE) ;


ALTER TABLE RECETTE 
  ADD FOREIGN KEY FK_RECETTE_UTILISATEUR (ID_USER)
      REFERENCES UTILISATEUR (ID_USER) ;

