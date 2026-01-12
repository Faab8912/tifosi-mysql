-- TIFOSI - SCRIPT D'INSERTION DES DONNEES DE TEST

USE tifosi;

-- 1. INSERTION DES MARQUES

INSERT INTO marque (id_marque, nom) VALUES
(1, 'Coca-cola'),
(2, 'Pepsico'),
(3, 'Monster'),
(4, 'Cristalline');

-- 2. INSERTION DES INGREDIENTS

INSERT INTO ingredient (id_ingredient, nom) VALUES
(1, 'Ail'),
(2, 'Ananas'),
(3, 'Artichaut'),
(4, 'Bacon'),
(5, 'Base Tomate'),
(6, 'Base creme'),
(7, 'Champignon'),
(8, 'Chevre'),
(9, 'Cresson'),
(10, 'Emmental'),
(11, 'Gorgonzola'),
(12, 'Jambon cuit'),
(13, 'Jambon fume'),
(14, 'Oeuf'),
(15, 'Oignon'),
(16, 'Olive noire'),
(17, 'Olive verte'),
(18, 'Parmesan'),
(19, 'Piment'),
(20, 'Poivre'),
(21, 'Pomme de terre'),
(22, 'Raclette'),
(23, 'Salami'),
(24, 'Tomate cerise'),
(25, 'Mozarella');

-- 3. INSERTION DES FOCACCIAS

INSERT INTO focaccia (id_focaccia, nom, prix) VALUES
(1, 'Mozaccia', 9.80),
(2, 'Gorgonzollaccia', 10.80),
(3, 'Raclaccia', 8.90),
(4, 'Emmentalaccia', 9.80),
(5, 'Tradizione', 8.90),
(6, 'Hawaienne', 11.20),
(7, 'Americaine', 10.80),
(8, 'Paysanne', 12.80);

-- 4. INSERTION DES BOISSONS

INSERT INTO boisson (id_boisson, nom, id_marque) VALUES
(1, 'Coca-cola zero', 1),
(2, 'Coca-cola original', 1),
(3, 'Fanta citron', 1),
(4, 'Fanta orange', 1),
(5, 'Capri-sun', 1),
(6, 'Pepsi', 2),
(7, 'Pepsi Max Zero', 2),
(8, 'Lipton zero citron', 2),
(9, 'Lipton Peach', 2),
(10, 'Monster energy ultra gold', 3),
(11, 'Monster energy ultra blue', 3),
(12, 'Eau de source', 4);

-- 5. INSERTION DES MENUS

INSERT INTO menu (id_menu, nom, prix, id_focaccia) VALUES
(1, 'Menu Mozaccia', 9.80, 1),
(2, 'Menu Gorgonzollaccia', 10.80, 2),
(3, 'Menu Raclaccia', 8.90, 3),
(4, 'Menu Emmentalaccia', 9.80, 4),
(5, 'Menu Tradizione', 8.90, 5),
(6, 'Menu Hawaienne', 11.20, 6),
(7, 'Menu Americaine', 10.80, 7),
(8, 'Menu Paysanne', 12.80, 8);

-- 6. INSERTION DES RELATIONS COMPREND

INSERT INTO comprend (id_ingredient, id_focaccia) VALUES
(5, 1),  (25, 1), (9, 1),  (13, 1), (1, 1),  (3, 1),  (7, 1),  (18, 1), (20, 1), (16, 1),
(5, 2),  (11, 2), (9, 2),  (1, 2),  (7, 2),  (18, 2), (20, 2), (16, 2),
(5, 3),  (22, 3), (9, 3),  (1, 3),  (7, 3),  (18, 3), (20, 3),
(6, 4),  (10, 4), (9, 4),  (7, 4),  (18, 4), (20, 4), (15, 4),
(5, 5),  (25, 5), (9, 5),  (12, 5), (7, 5),  (18, 5), (20, 5), (16, 5), (17, 5),
(5, 6),  (25, 6), (9, 6),  (4, 6),  (2, 6),  (19, 6), (18, 6), (20, 6), (16, 6),
(5, 7),  (25, 7), (9, 7),  (4, 7),  (21, 7), (18, 7), (20, 7), (16, 7),
(6, 8),  (8, 8),  (9, 8),  (21, 8), (13, 8), (1, 8),  (3, 8),  (7, 8),  (18, 8), (20, 8), (16, 8), (14, 8);

-- 7. INSERTION DES RELATIONS CONTIENT

INSERT INTO contient (id_menu, id_boisson) VALUES
(1, 1),  (1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9);

-- 8. INSERTION DES CLIENTS

INSERT INTO client (id_client, nom, email, code_postal) VALUES
(1, 'Jean Dupont', 'jean.dupont@email.com', 75001),
(2, 'Marie Martin', 'marie.martin@email.com', 75002),
(3, 'Pierre Bernard', 'pierre.bernard@email.com', 75003),
(4, 'Sophie Moreau', 'sophie.moreau@email.com', 75004),
(5, 'Luc Blanc', 'luc.blanc@email.com', 75005);

-- 9. INSERTION DES RELATIONS ACHETE

INSERT INTO achete (id_client, id_menu, date_achat) VALUES
(1, 1, '2024-01-15 12:30:00'),
(1, 3, '2024-01-16 13:15:00'),
(2, 2, '2024-01-17 12:00:00'),
(2, 4, '2024-01-18 14:45:00'),
(3, 5, '2024-01-19 12:30:00'),
(4, 6, '2024-01-20 13:00:00'),
(5, 7, '2024-01-21 12:15:00'),
(5, 8, '2024-01-22 14:30:00'),
(1, 2, '2024-01-23 12:45:00'),
(3, 8, '2024-01-24 13:30:00');

-- 10. VERIFICATION DES INSERTIONS

SELECT 'VERIFICATION DES MARQUES' AS info;
SELECT COUNT(*) as nombre_marques FROM marque;

SELECT 'VERIFICATION DES INGREDIENTS' AS info;
SELECT COUNT(*) as nombre_ingredients FROM ingredient;

SELECT 'VERIFICATION DES FOCACCIAS' AS info;
SELECT COUNT(*) as nombre_focaccias FROM focaccia;

SELECT 'VERIFICATION DES BOISSONS' AS info;
SELECT COUNT(*) as nombre_boissons FROM boisson;

SELECT 'VERIFICATION DES MENUS' AS info;
SELECT COUNT(*) as nombre_menus FROM menu;

SELECT 'VERIFICATION DES RELATIONS COMPREND' AS info;
SELECT COUNT(*) as nombre_relations FROM comprend;

SELECT 'VERIFICATION DES RELATIONS CONTIENT' AS info;
SELECT COUNT(*) as nombre_relations FROM contient;

SELECT 'VERIFICATION DES CLIENTS' AS info;
SELECT COUNT(*) as nombre_clients FROM client;

SELECT 'VERIFICATION DES ACHATS' AS info;
SELECT COUNT(*) as nombre_achats FROM achete;
