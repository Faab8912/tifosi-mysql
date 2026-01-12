-- TIFOSI - BASE DE DONNEES MYSQL
-- Script de creation du schema avec securite et contraintes

-- 1. CREATION DE LA BASE DE DONNEES

DROP DATABASE IF EXISTS tifosi;
CREATE DATABASE tifosi 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE tifosi;

-- 2. CREATION DE L'UTILISATEUR TIFOSI

DROP USER IF EXISTS 'tifosi'@'localhost';
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'Tifosi123!@#';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

-- 3. CREATION DES TABLES

-- TABLE MARQUE
CREATE TABLE marque (
    id_marque INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT uk_marque_nom UNIQUE (nom)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- TABLE INGREDIENT
CREATE TABLE ingredient (
    id_ingredient INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT uk_ingredient_nom UNIQUE (nom)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- TABLE FOCACCIA
CREATE TABLE focaccia (
    id_focaccia INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL,
    CONSTRAINT uk_focaccia_nom UNIQUE (nom),
    CONSTRAINT ck_prix_positif CHECK (prix > 0)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- TABLE BOISSON
CREATE TABLE boisson (
    id_boisson INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL UNIQUE,
    id_marque INT NOT NULL,
    CONSTRAINT uk_boisson_nom UNIQUE (nom),
    CONSTRAINT fk_boisson_marque FOREIGN KEY (id_marque) 
        REFERENCES marque(id_marque) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- TABLE MENU
CREATE TABLE menu (
    id_menu INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL,
    id_focaccia INT NOT NULL,
    CONSTRAINT uk_menu_nom UNIQUE (nom),
    CONSTRAINT ck_menu_prix CHECK (prix > 0),
    CONSTRAINT fk_menu_focaccia FOREIGN KEY (id_focaccia) 
        REFERENCES focaccia(id_focaccia) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- TABLE CLIENT
CREATE TABLE client (
    id_client INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    code_postal INT NOT NULL,
    CONSTRAINT uk_client_email UNIQUE (email),
    CONSTRAINT ck_code_postal CHECK (code_postal >= 10000 AND code_postal <= 99999)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. TABLES DE JOINTURE

-- TABLE COMPREND (Relation INGREDIENT - FOCACCIA)
CREATE TABLE comprend (
    id_ingredient INT NOT NULL,
    id_focaccia INT NOT NULL,
    PRIMARY KEY (id_ingredient, id_focaccia),
    CONSTRAINT fk_comprend_ingredient FOREIGN KEY (id_ingredient) 
        REFERENCES ingredient(id_ingredient) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_comprend_focaccia FOREIGN KEY (id_focaccia) 
        REFERENCES focaccia(id_focaccia) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- TABLE CONTIENT (Relation MENU - BOISSON)
CREATE TABLE contient (
    id_menu INT NOT NULL,
    id_boisson INT NOT NULL,
    PRIMARY KEY (id_menu, id_boisson),
    CONSTRAINT fk_contient_menu FOREIGN KEY (id_menu) 
        REFERENCES menu(id_menu) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_contient_boisson FOREIGN KEY (id_boisson) 
        REFERENCES boisson(id_boisson) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- TABLE ACHETE (Relation CLIENT - MENU)
CREATE TABLE achete (
    id_client INT NOT NULL,
    id_menu INT NOT NULL,
    date_achat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_client, id_menu, date_achat),
    CONSTRAINT fk_achete_client FOREIGN KEY (id_client) 
        REFERENCES client(id_client) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_achete_menu FOREIGN KEY (id_menu) 
        REFERENCES menu(id_menu) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. CREATION DES INDEX POUR OPTIMISATION

CREATE INDEX idx_focaccia_nom ON focaccia(nom);
CREATE INDEX idx_ingredient_nom ON ingredient(nom);
CREATE INDEX idx_boisson_nom ON boisson(nom);
CREATE INDEX idx_client_email ON client(email);

CREATE INDEX idx_boisson_marque ON boisson(id_marque);
CREATE INDEX idx_menu_focaccia ON menu(id_focaccia);
CREATE INDEX idx_comprend_ingredient ON comprend(id_ingredient);
CREATE INDEX idx_comprend_focaccia ON comprend(id_focaccia);
CREATE INDEX idx_contient_menu ON contient(id_menu);
CREATE INDEX idx_contient_boisson ON contient(id_boisson);
CREATE INDEX idx_achete_client ON achete(id_client);
CREATE INDEX idx_achete_menu ON achete(id_menu);

-- 6. VERIFICATION DU SCHEMA

SHOW TABLES;
