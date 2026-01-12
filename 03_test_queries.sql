-- TIFOSI - REQUETES DE TEST

USE tifosi;

-- REQUETE 1: Afficher la liste des noms des focaccias par ordre alphabetique

-- But: Verifier que les focaccias sont bien stockees et peuvent etre listees 
-- par ordre alphabetique croissant

-- Code SQL:
SELECT nom 
FROM focaccia 
ORDER BY nom ASC;

-- Resultat attendu:
-- Americaine
-- Emmentalaccia
-- Gorgonzollaccia
-- Hawaienne
-- Mozaccia
-- Paysanne
-- Raclaccia
-- Tradizione

-- Commentaire: 8 focaccias triees alphabetiquement croissant


-- REQUETE 2: Afficher le nombre total d'ingredients

-- But: Verifier que tous les ingredients ont ete inseres correctement

-- Code SQL:
SELECT COUNT(*) AS nombre_total_ingredients 
FROM ingredient;

-- Resultat attendu: 25

-- Commentaire: Les 25 ingredients sont presents dans la base


-- REQUETE 3: Afficher le prix moyen des focaccias

-- But: Calculer le prix moyen pour connaitre le positionnement commercial

-- Code SQL:
SELECT ROUND(AVG(prix), 2) AS prix_moyen 
FROM focaccia;

-- Resultat attendu: 10.25

-- Commentaire: Calcul correct 
-- (9.80 + 10.80 + 8.90 + 9.80 + 8.90 + 11.20 + 10.80 + 12.80) / 8 = 10.25


-- REQUETE 4: Afficher la liste des boissons avec leur marque

-- But: Afficher toutes les boissons avec leur marque associee, 
-- triees par nom de boisson

-- Code SQL:
SELECT 
  b.nom AS nom_boisson,
  m.nom AS nom_marque
FROM boisson b
LEFT JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom ASC;

-- Resultat attendu:
-- Capri-sun | Coca-cola
-- Coca-cola original | Coca-cola
-- Coca-cola zero | Coca-cola
-- Eau de source | Cristalline
-- Fanta citron | Coca-cola
-- Fanta orange | Coca-cola
-- Lipton Peach | Pepsico
-- Lipton zero citron | Pepsico
-- Monster energy ultra blue | Monster
-- Monster energy ultra gold | Monster
-- Pepsi | Pepsico
-- Pepsi Max Zero | Pepsico

-- Commentaire: 12 boissons avec leurs marques, triees alphabetiquement


-- REQUETE 5: Afficher la liste des ingredients pour une Raclaccia

-- But: Afficher tous les ingredients qui composent la focaccia Raclaccia

-- Code SQL:
SELECT 
  i.nom AS ingredient
FROM ingredient i
INNER JOIN comprend c ON i.id_ingredient = c.id_ingredient
INNER JOIN focaccia f ON c.id_focaccia = f.id_focaccia
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom ASC;

-- Resultat attendu:
-- Ail
-- Champignon
-- Cresson
-- Parmesan
-- Poivre
-- Raclette
-- Base Tomate

-- Commentaire: 7 ingredients listes pour la Raclaccia


-- REQUETE 6: Afficher le nom et le nombre d'ingredients pour chaque focaccia

-- But: Afficher le nombre d'ingredients utilises pour composer chaque focaccia

-- Code SQL:
SELECT 
  f.nom AS nom_focaccia,
  COUNT(c.id_ingredient) AS nombre_ingredients
FROM focaccia f
LEFT JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY f.nom ASC;

-- Resultat attendu:
-- Americaine | 8
-- Emmentalaccia | 7
-- Gorgonzollaccia | 8
-- Hawaienne | 9
-- Mozaccia | 10
-- Paysanne | 12
-- Raclaccia | 7
-- Tradizione | 9

-- Commentaire: Nombre d'ingredients correct pour chaque focaccia


-- REQUETE 7: Afficher le nom de la focaccia qui a le plus d'ingredients

-- But: Identifier la focaccia la plus riche en ingredients

-- Code SQL:
SELECT 
  f.nom AS nom_focaccia,
  COUNT(c.id_ingredient) AS nombre_ingredients
FROM focaccia f
LEFT JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY nombre_ingredients DESC
LIMIT 1;

-- Resultat attendu: Paysanne | 12

-- Commentaire: La Paysanne a le plus d'ingredients (12)


-- REQUETE 8: Afficher la liste des focaccia qui contiennent de l'ail

-- But: Identifier toutes les focaccias contenant l'ingredient 'Ail'

-- Code SQL:
SELECT DISTINCT
  f.nom AS nom_focaccia
FROM focaccia f
INNER JOIN comprend c ON f.id_focaccia = c.id_focaccia
INNER JOIN ingredient i ON c.id_ingredient = i.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom ASC;

-- Resultat attendu:
-- Mozaccia
-- Gorgonzollaccia
-- Raclaccia
-- Paysanne

-- Commentaire: 4 focaccias contiennent de l'ail


-- REQUETE 9: Afficher la liste des ingredients inutilises

-- But: Identifier les ingredients en stock mais non utilises 
-- dans les focaccias

-- Code SQL:
SELECT 
  i.nom AS ingredient
FROM ingredient i
WHERE i.id_ingredient NOT IN (
  SELECT DISTINCT c.id_ingredient 
  FROM comprend c
)
ORDER BY i.nom ASC;

-- Resultat attendu:
-- Salami
-- Tomate cerise

-- Commentaire: 2 ingredients ne sont pas utilises dans les recettes


-- REQUETE 10: Afficher la liste des focaccia qui n'ont pas de champignons

-- But: Identifier les focaccias qui ne contiennent pas de champignon

-- Code SQL:
SELECT 
  f.nom AS nom_focaccia
FROM focaccia f
WHERE f.id_focaccia NOT IN (
  SELECT DISTINCT c.id_focaccia 
  FROM comprend c
  INNER JOIN ingredient i ON c.id_ingredient = i.id_ingredient
  WHERE i.nom = 'Champignon'
)
ORDER BY f.nom ASC;

-- Resultat attendu: (Aucune focaccia - toutes en contiennent)

-- Commentaire: Toutes les 8 focaccias contiennent du champignon
-- Les resultats sont vides, ce qui est correct
