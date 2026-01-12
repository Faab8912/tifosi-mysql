TIFOSI - BASE DE DONNEES MYSQL
Documentation et Guide d'Utilisation

1. DESCRIPTION DU PROJET

Tifosi est un restaurant de Street-Food italien qui souhaite gerer sa base de 
donnees pour:

- Les focaccias (produits principaux)
- Les ingredients (composantes des focaccias)
- Les boissons (produits complementaires)
- Les marques (fournisseurs de boissons)
- Les menus (compositions focaccia + boisson)
- Les clients et leurs achats

2. OBJECTIFS DU DEVOIR

Ce projet evalue les competences suivantes:
- Recenser les informations du domaine
- Organiser les donnees (modele relationnel)
- Construire l'organisation physique (schema MySQL)
- Mettre en oeuvre CREATE, ALTER, DROP
- Executer des requetes SQL complexes

3. STRUCTURE DU PROJET

tifosi-mysql/
|-- 01_schema_creation.sql         Creation de la base et des tables
|-- 02_data_insertion.sql          Insertion des donnees de test
|-- 03_test_queries.sql            10 requetes de verification
|-- README.txt                     Documentation
|-- MODELE_ER.txt                  Analyse du modele entite-relation

4. ARCHITECTURE DE LA BASE DE DONNEES

ENTITES PRINCIPALES:

Table: marque
  - id_marque (INT, PK, AUTO_INCREMENT)
  - nom (VARCHAR 100, NOT NULL, UNIQUE)

Table: ingredient
  - id_ingredient (INT, PK, AUTO_INCREMENT)
  - nom (VARCHAR 100, NOT NULL, UNIQUE)

Table: focaccia
  - id_focaccia (INT, PK, AUTO_INCREMENT)
  - nom (VARCHAR 100, NOT NULL, UNIQUE)
  - prix (DECIMAL 5,2, NOT NULL, CHECK > 0)

Table: boisson
  - id_boisson (INT, PK, AUTO_INCREMENT)
  - nom (VARCHAR 100, NOT NULL, UNIQUE)
  - id_marque (INT, FK, NOT NULL)

Table: menu
  - id_menu (INT, PK, AUTO_INCREMENT)
  - nom (VARCHAR 100, NOT NULL, UNIQUE)
  - prix (DECIMAL 5,2, NOT NULL, CHECK > 0)
  - id_focaccia (INT, FK, NOT NULL)

Table: client
  - id_client (INT, PK, AUTO_INCREMENT)
  - nom (VARCHAR 100, NOT NULL)
  - email (VARCHAR 255, NOT NULL, UNIQUE)
  - code_postal (INT, NOT NULL, CHECK 5 digits)

5. TABLES DE JOINTURE (RELATIONS MANY-TO-MANY)

Table: comprend
  - id_ingredient (INT, FK)
  - id_focaccia (INT, FK)
  - Cle primaire composee: (id_ingredient, id_focaccia)
  Relation: Ingredients dans Focaccias

Table: contient
  - id_menu (INT, FK)
  - id_boisson (INT, FK)
  - Cle primaire composee: (id_menu, id_boisson)
  Relation: Boissons dans Menus

Table: achete
  - id_client (INT, FK)
  - id_menu (INT, FK)
  - date_achat (DATETIME)
  - Cle primaire composee: (id_client, id_menu, date_achat)
  Relation: Achats des clients

6. INSTALLATION ET UTILISATION

PREREQUIS:
- MySQL 5.7+ ou MariaDB
- Acces administrateur a MySQL
- Client MySQL (mysql CLI, Workbench, phpMyAdmin, etc.)

ETAPE 1: Executer le script de creation du schema

  mysql -u root -p < 01_schema_creation.sql

  Ou depuis MySQL CLI:
  SOURCE 01_schema_creation.sql;

  Ce script va:
  - Creer la base de donnees tifosi
  - Creer l'utilisateur tifosi avec mot de passe Tifosi123!@#
  - Creer toutes les tables avec contraintes de securite
  - Creer les index pour optimiser les performances

ETAPE 2: Inserer les donnees de test

  mysql -u tifosi -p tifosi < 02_data_insertion.sql

  Ce script va:
  - Inserer 4 marques
  - Inserer 25 ingredients
  - Inserer 8 focaccias
  - Inserer 12 boissons
  - Inserer 8 menus
  - Inserer 73 relations ingredient-focaccia
  - Inserer 9 relations menu-boisson
  - Inserer 5 clients d'exemple
  - Inserer 10 achats d'exemple

ETAPE 3: Executer les requetes de test

  mysql -u tifosi -p tifosi < 03_test_queries.sql

  Ce script va:
  - Executer 10 requetes de verification
  - Afficher les resultats avec commentaires
  - Valider que la base fonctionne correctement

7. SECURITE IMPLEMENTEE

CONTRAINTES INTEGREES:
- Cles Primaires: Unicite des identifiants
- Cles Etrangeres: Integrite referentielle
- UNIQUE Constraints: Pas de doublons (noms, emails)
- NOT NULL: Champs obligatoires
- CHECK Constraints:
  * Prix positif (prix > 0)
  * Code postal valide (5 chiffres)
- CASCADE/RESTRICT: Gestion des suppressions

INDICES (INDEXES):
Crees pour optimiser les requetes sur:
- Noms (recherche frequente)
- Cles etrangeres (jointures)
- Email des clients (authentification)

8. LES 10 REQUETES DE VERIFICATION

No. 1 - Focaccias par ordre alphabetique
  Affichage: 8 focaccias triees de A a Z

No. 2 - Nombre total d'ingredients
  Affichage: 25 ingredients

No. 3 - Prix moyen des focaccias
  Affichage: 10.25 euros

No. 4 - Boissons avec marques
  Affichage: 12 boissons avec leurs marques associees

No. 5 - Ingredients Raclaccia
  Affichage: 7 ingredients dans la Raclaccia

No. 6 - Nombre ingredients par focaccia
  Affichage: De 7 a 12 ingredients par focaccia

No. 7 - Focaccia avec plus ingredients
  Affichage: Paysanne (12 ingredients)

No. 8 - Focaccias avec ail
  Affichage: 4 focaccias contiennent de l'ail

No. 9 - Ingredients inutilises
  Affichage: 2 ingredients (Salami, Tomate cerise)

No. 10 - Focaccias sans champignons
  Affichage: Aucune (toutes en contiennent)

9. DONNEES DE TEST

FOCACCIAS (8):
- Mozaccia (9.80 euros, 10 ingredients)
- Gorgonzollaccia (10.80 euros, 8 ingredients)
- Raclaccia (8.90 euros, 7 ingredients)
- Emmentalaccia (9.80 euros, 7 ingredients)
- Tradizione (8.90 euros, 9 ingredients)
- Hawaienne (11.20 euros, 9 ingredients)
- Americaine (10.80 euros, 8 ingredients)
- Paysanne (12.80 euros, 12 ingredients)

BOISSONS PAR MARQUE:
- Coca-cola: Coca-cola zero, original, Fanta (citron, orange), Capri-sun
- Pepsico: Pepsi, Pepsi Max Zero, Lipton (zero citron, Peach)
- Monster: Monster energy (ultra gold, ultra blue)
- Cristalline: Eau de source

INGREDIENTS (25):
Ail, Ananas, Artichaut, Bacon, Base Tomate, Base creme, Champignon, 
Chevre, Cresson, Emmental, Gorgonzola, Jambon cuit, Jambon fume, 
Oeuf, Oignon, Olive noire, Olive verte, Parmesan, Piment, Poivre, 
Pomme de terre, Raclette, Salami, Tomate cerise, Mozarella

CLIENTS (5):
1. Jean Dupont (jean.dupont@email.com) - 75001
2. Marie Martin (marie.martin@email.com) - 75002
3. Pierre Bernard (pierre.bernard@email.com) - 75003
4. Sophie Moreau (sophie.moreau@email.com) - 75004
5. Luc Blanc (luc.blanc@email.com) - 75005

10. COMMANDES UTILES MYSQL

Se connecter a la base:
  mysql -u tifosi -p -D tifosi

Voir les tables:
  SHOW TABLES;

Voir la structure d'une table:
  DESCRIBE focaccia;

Voir les cles etrangeres:
  SELECT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME
  FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
  WHERE TABLE_SCHEMA = 'tifosi';

Reinitialiser la base:
  DROP DATABASE tifosi;
  SOURCE 01_schema_creation.sql;

11. VERIFICATION FINALE

Pour verifier que tout fonctionne:

  USE tifosi;

Voir le nombre de donnees:
  SELECT COUNT(*) as focaccias FROM focaccia;
  SELECT COUNT(*) as ingredients FROM ingredient;
  SELECT COUNT(*) as boissons FROM boisson;
  SELECT COUNT(*) as marques FROM marque;

Test requete complexe:
  SELECT f.nom, COUNT(c.id_ingredient) as nb_ingredients
  FROM focaccia f
  LEFT JOIN comprend c ON f.id_focaccia = c.id_focaccia
  GROUP BY f.id_focaccia
  ORDER BY nb_ingredients DESC;

12. CONCLUSION

Ce projet de base de donnees TIFOSI comprend:
- Un schema relationnel normalise (3NF)
- Des contraintes de securite completes
- Des donnees de test realistes
- 10 requetes de test de verification
- Une documentation complete

La base est prete pour une utilisation en production.

Derniere mise a jour: Janvier 2026
Statut: Pret pour production
