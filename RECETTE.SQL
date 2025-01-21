-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 21 jan. 2025 à 11:31
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`ID_CATEGORIE`, `NOM_CATEGORIE`) VALUES
(1, 'Désert'),
(2, 'Entrée froide'),
(3, 'Entrée chaude'),
(4, 'Goûter'),
(5, 'Plât principal');

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
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `recette`
--

INSERT INTO `recette` (`ID_RECETTE`, `ID_CATEGORIE`, `ID_USER`, `TITRE`, `DESCRIPTION`, `INGREDIENTS`, `INSTRUCTIONS`, `IMAGE`, `DATE_CREATION`) VALUES
(1, 1, 1, 'Glace aux chocolat', 'miam miam miam', 'glace, chocolat', 'froid', 'pexels-ivandesignx-29944220.jpg', '2025-01-02'),
(2, 1, 1, 'Mousse au Chocolat Classique', 'Un dessert intemporel, léger et onctueux, la mousse au chocolat est parfaite pour conclure un repas sur une note gourmande. Facile à préparer avec seulement quelques ingrédients, elle ravira les amateurs de chocolat.', '200 g de chocolat noir (70 % de cacao de préférence)\r\n4 œufs (blancs et jaunes séparés)\r\n30 g de sucre en poudre\r\nUne pincée de sel\r\nFacultatif : copeaux de chocolat ou fruits rouges pour la décoration', 'Faire fondre le chocolat :\r\nFaites fondre le chocolat au bain-marie ou au micro-ondes (par intervalles de 30 secondes) jusqu\'à obtenir une texture lisse.\r\nLaissez légèrement tiédir.\r\nPréparer les œufs :\r\nDans un grand bol, battez les jaunes d\'œufs avec le sucre jusqu\'à ce que le mélange blanchisse.\r\nIncorporez délicatement le chocolat fondu au mélange de jaunes d\'œufs.\r\nMonter les blancs en neige :\r\nDans un autre bol, montez les blancs en neige ferme avec une pincée de sel.\r\nIls doivent former des pics lorsque vous retirez le fouet.\r\nIncorporer les blancs :\r\nAjoutez délicatement les blancs en neige au mélange chocolaté, en plusieurs fois, avec une spatule.\r\nMélangez en effectuant des mouvements circulaires pour ne pas casser les blancs.\r\nRepos au réfrigérateur :\r\nVersez la mousse dans des verrines ou un grand bol.\r\nCouvrez et laissez reposer au réfrigérateur pendant au moins 3 heures.\r\nDécoration et service :\r\nAvant de servir, décorez avec des copeaux de chocolat ou des fruits rouges selon vos goûts.', 'th.jpg', '2025-01-02'),
(3, 3, 3, 'Feuilletés aux champignons et fromage', 'Une entrée gourmande et croustillante, parfaite pour les amateurs de fromage fondu et de champignons parfumés.', '1 pâte feuilletée\r\n250 g de champignons de Paris\r\n1 échalote\r\n100 g de fromage râpé (emmental, comté ou mozzarella)\r\n20 g de beurre\r\n1 cuillère à soupe de crème fraîche\r\nSel, poivre\r\n1 jaune d\'œuf (pour la dorure)', 'Préchauffez le four à 200°C (th.6-7).\r\nÉmincez les champignons et l’échalote finement.\r\nFaites fondre le beurre dans une poêle et faites revenir les échalotes pendant 2 minutes, puis ajoutez les champignons. Laissez cuire jusqu\'à évaporation complète de l’eau.\r\nAjoutez la crème fraîche, le fromage râpé, le sel et le poivre. Mélangez bien.\r\nDécoupez la pâte feuilletée en carrés de 10 cm. Déposez une cuillerée de farce au centre de chaque carré.\r\nRefermez les feuilletés en pinçant bien les bords. Badigeonnez de jaune d\'œuf.\r\nEnfournez pendant 15-20 minutes jusqu’à ce que les feuilletés soient dorés.\r\nServez chaud.', 'feuillete.jpg', '2025-01-06'),
(4, 2, 3, ' Carpaccio de betteraves au chèvre et noix', 'Une entrée fraîche et colorée qui allie la douceur de la betterave, le crémeux du chèvre et le croquant des noix.', '2 grosses betteraves cuites\r\n100 g de fromage de chèvre frais\r\n30 g de cerneaux de noix\r\nQuelques feuilles de roquette ou de mâche\r\n2 cuillères à soupe d\'huile d\'olive\r\n1 cuillère à soupe de vinaigre balsamique\r\nSel, poivre\r\nFacultatif : quelques brins de ciboulette ou de menthe ciselée', 'Préparer les betteraves : Épluchez les betteraves cuites si ce n\'est pas déjà fait. Coupez-les en fines tranches à l\'aide d\'une mandoline ou d\'un couteau bien aiguisé.\r\nDisposer sur l’assiette : Disposez les tranches de betterave en rosace sur chaque assiette.\r\nPréparer la garniture : Émiettez le fromage de chèvre par-dessus les tranches de betterave. Ajoutez les cerneaux de noix grossièrement concassés.\r\nAssaisonner : Dans un petit bol, mélangez l\'huile d\'olive, le vinaigre balsamique, le sel et le poivre. Versez cette vinaigrette sur le carpaccio.\r\nAjouter la verdure : Garnissez avec quelques feuilles de roquette ou de mâche pour une touche de fraîcheur.\r\nDécorer et servir : Parsemez d\'herbes fraîches ciselées si désiré. Servez immédiatement.', 'Bieten-carpaccio-2-650x433.jpg', '2025-01-06'),
(6, 5, 1, 'Poulet au curry et lait de coco', 'Une recette exotique, rapide et pleine de saveurs, idéale pour un dîner convivial.', '500 g de filets de poulet coupés en morceaux\r\n1 oignon émincé\r\n2 gousses d’ail hachées\r\n1 poivron rouge coupé en lamelles\r\n1 boîte de lait de coco (400 ml)\r\n2 cuillères à soupe de pâte de curry (jaune ou rouge selon vos goûts)\r\n1 cuillère à soupe d’huile végétale\r\nSel et poivre\r\nCoriandre fraîche pour la garniture (optionnel)', 'Chauffez l’huile dans une poêle ou un wok à feu moyen. Faites revenir l’oignon, l’ail et le poivron pendant 5 minutes.\r\nAjoutez les morceaux de poulet et faites-les dorer légèrement.\r\nIncorporez la pâte de curry et mélangez bien pour enrober le poulet.\r\nVersez le lait de coco, salez et poivrez. Laissez mijoter à feu doux pendant 15 minutes jusqu’à ce que le poulet soit tendre.\r\nServez chaud avec du riz basmati. Parsemez de coriandre fraîche avant de déguster si souhaité.', 'curry.jpg', '2025-01-21'),
(7, 4, 3, 'Cookies aux pépites de chocolat', 'Des cookies croustillants à l\'extérieur et moelleux à l\'intérieur, parfaits pour le goûter.', '250 g de farine\r\n125 g de beurre mou\r\n150 g de sucre roux\r\n1 œuf\r\n1 sachet de levure chimique\r\n1 pincée de sel\r\n150 g de pépites de chocolat', 'Préchauffez le four à 180°C (thermostat 6).\r\nMélangez le beurre et le sucre jusqu’à obtention d’une texture crémeuse.\r\nAjoutez l’œuf et mélangez.\r\nIncorporez la farine, la levure, le sel, puis les pépites de chocolat.\r\nFormez des boules de pâte, aplatissez-les légèrement, et disposez-les sur une plaque recouverte de papier cuisson.\r\nEnfournez pendant 10 à 12 minutes. Laissez refroidir avant de déguster.', 'coockie.jpg', '2025-01-21'),
(8, 4, 3, 'Madeleines moelleuses', 'Ces petites douceurs au goût beurré sont parfaites pour accompagner un chocolat chaud.', '120 g de farine\r\n100 g de sucre\r\n100 g de beurre fondu\r\n2 œufs\r\n1 sachet de sucre vanillé\r\n1/2 sachet de levure chimique', 'Préchauffez le four à 200°C.\r\nBattez les œufs avec le sucre et le sucre vanillé jusqu’à blanchiment.\r\nAjoutez la farine et la levure, puis le beurre fondu.\r\nLaissez reposer la pâte 1 heure au réfrigérateur.\r\nVersez dans des moules à madeleines et enfournez 8 à 10 minutes.', 'madeleine.jpg', '2025-01-21'),
(9, 5, 3, 'Risotto aux champignons', 'Un plat crémeux et réconfortant, parfait pour les amateurs de champignons.', '300 g de riz arborio\r\n200 g de champignons frais émincés\r\n1 oignon haché\r\n1 litre de bouillon de légumes chaud\r\n100 ml de vin blanc sec\r\n50 g de parmesan râpé\r\n2 cuillères à soupe d’huile d’olive', 'Chauffez l’huile d’olive dans une poêle, faites revenir l’oignon et les champignons.\r\nAjoutez le riz et mélangez jusqu’à ce qu’il devienne translucide.\r\nVersez le vin blanc et laissez réduire.\r\nAjoutez le bouillon chaud louche par louche, en remuant, jusqu’à absorption complète.\r\nIncorporez le parmesan. Servez chaud.', 'risotto.jpg', '2025-01-21'),
(10, 5, 3, 'Gratin dauphinois', 'Un classique de la cuisine française, simple et délicieux, parfait pour accompagner une viande.', '1 kg de pommes de terre\r\n500 ml de crème fraîche\r\n2 gousses d’ail\r\n50 g de beurre\r\nSel, poivre et muscade', 'Préchauffez le four à 180°C.\r\nÉpluchez et tranchez finement les pommes de terre.\r\nFrottez un plat à gratin avec une gousse d’ail coupée en deux, puis beurrez-le.\r\nDisposez les pommes de terre en couches, salez, poivrez et ajoutez une pincée de muscade entre chaque couche.\r\nVersez la crème et enfournez 1 heure.\r\nServez doré et bien chaud.', 'gratin.jpg', '2025-01-21');

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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`ID_USER`, `USERNAME`, `EMAIL`, `MOT_DE_PASSE`) VALUES
(1, 'LaliaAzumi', 'laliaazumii@gmail.com', 'lalia1234'),
(3, 'Antonella', 'antonella@gmail.com', 'bodo1234');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
