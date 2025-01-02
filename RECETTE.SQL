-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 02 jan. 2025 à 09:36
-- Version du serveur : 8.0.27
-- Version de PHP : 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `recette`
--

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
  `ID_CATEGORIE` int NOT NULL AUTO_INCREMENT,
  `NOM_CATEGORIE` text NOT NULL,
  PRIMARY KEY (`ID_CATEGORIE`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`ID_CATEGORIE`, `NOM_CATEGORIE`) VALUES
(1, 'Desert');

-- --------------------------------------------------------

--
-- Structure de la table `recette`
--

DROP TABLE IF EXISTS `recette`;
CREATE TABLE IF NOT EXISTS `recette` (
  `ID_RECETTE` int NOT NULL AUTO_INCREMENT,
  `ID_CATEGORIE` int NOT NULL,
  `ID_USER` int NOT NULL,
  `TITRE` text NOT NULL,
  `DESCRIPTION` text,
  `INGREDIENTS` text NOT NULL,
  `INSTRUCTIONS` text NOT NULL,
  `IMAGE` text,
  `DATE_CREATION` date DEFAULT NULL,
  PRIMARY KEY (`ID_RECETTE`),
  KEY `I_FK_RECETTE_CATEGORIE` (`ID_CATEGORIE`),
  KEY `I_FK_RECETTE_UTILISATEUR` (`ID_USER`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `recette`
--

INSERT INTO `recette` (`ID_RECETTE`, `ID_CATEGORIE`, `ID_USER`, `TITRE`, `DESCRIPTION`, `INGREDIENTS`, `INSTRUCTIONS`, `IMAGE`, `DATE_CREATION`) VALUES
(1, 1, 1, 'Glace aux chocolat', 'miam miam miam', 'glace, chocolat', 'froid', 'pexels-ivandesignx-29944220.jpg', '2025-01-02'),
(2, 1, 1, 'Mousse au Chocolat Classique', 'Un dessert intemporel, léger et onctueux, la mousse au chocolat est parfaite pour conclure un repas sur une note gourmande. Facile à préparer avec seulement quelques ingrédients, elle ravira les amateurs de chocolat.', '200 g de chocolat noir (70 % de cacao de préférence)\r\n4 œufs (blancs et jaunes séparés)\r\n30 g de sucre en poudre\r\nUne pincée de sel\r\nFacultatif : copeaux de chocolat ou fruits rouges pour la décoration', 'Faire fondre le chocolat :\r\n\r\nFaites fondre le chocolat au bain-marie ou au micro-ondes (par intervalles de 30 secondes) jusqu\'à obtenir une texture lisse.\r\nLaissez légèrement tiédir.\r\nPréparer les œufs :\r\n\r\nDans un grand bol, battez les jaunes d\'œufs avec le sucre jusqu\'à ce que le mélange blanchisse.\r\nIncorporez délicatement le chocolat fondu au mélange de jaunes d\'œufs.\r\nMonter les blancs en neige :\r\n\r\nDans un autre bol, montez les blancs en neige ferme avec une pincée de sel.\r\nIls doivent former des pics lorsque vous retirez le fouet.\r\nIncorporer les blancs :\r\n\r\nAjoutez délicatement les blancs en neige au mélange chocolaté, en plusieurs fois, avec une spatule.\r\nMélangez en effectuant des mouvements circulaires pour ne pas casser les blancs.\r\nRepos au réfrigérateur :\r\n\r\nVersez la mousse dans des verrines ou un grand bol.\r\nCouvrez et laissez reposer au réfrigérateur pendant au moins 3 heures.\r\nDécoration et service :\r\n\r\nAvant de servir, décorez avec des copeaux de chocolat ou des fruits rouges selon vos goûts.', 'th.jpg', '2025-01-02');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `ID_USER` int NOT NULL AUTO_INCREMENT,
  `USERNAME` text NOT NULL,
  `EMAIL` text,
  `MOT_DE_PASSE` text NOT NULL,
  PRIMARY KEY (`ID_USER`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`ID_USER`, `USERNAME`, `EMAIL`, `MOT_DE_PASSE`) VALUES
(1, 'LaliaAzumi', 'laliaazumii@gmail.com', 'lalia1234');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
