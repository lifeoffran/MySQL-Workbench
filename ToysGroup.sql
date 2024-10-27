CREATE DATABASE ToysGroup;

USE ToysGroup;

DROP TABLE Sales;
DROP TABLE Product;
DROP TABLE Category;
DROP TABLE States;
DROP TABLE Region;

CREATE TABLE Category (
    id_category INT NOT NULL AUTO_INCREMENT,
    categoria VARCHAR(255),
    taglia_prod VARCHAR(5),
    PRIMARY KEY (id_category)
);

insert into Category (categoria, taglia_prod)values ("Toy_story", "S"), ("Cars", "S"), ("Frozen", "S"), ("Lilo&Stitch", "S"),
							("Toy_story", "M"), ("Cars", "M"), ("Frozen", "M"), ("Lilo&Stitch", "M"),
							("Toy_story", "L"), ("Cars", "L"), ("Frozen", "L"), ("Lilo&Stitch", "L");

CREATE TABLE Product (
    id_prod INT NOT NULL AUTO_INCREMENT,
    nome_prod VARCHAR(255) NOT NULL,
    costo_prod INT,
    descrizione_prod VARCHAR(255),
    categoria INT NOT NULL,
    PRIMARY KEY (id_prod),
    FOREIGN KEY (categoria)
        REFERENCES Category (id_category)
);

insert into Product (nome_prod, costo_prod, descrizione_prod, categoria) values ("MTSS", 10, "Maglietta di cotone con grafica di Toy Story", 1),
																				("MCRS", 10, "Maglietta di cotone con grafica di Cars", 2),
                                                                                ("MFZS", 10, "Maglietta di cotone con grafica di Frozen", 3),
                                                                                ("MLSS", 10,"Maglietta di cotone con grafica di Lilo & Stitch", 4),
                                                                                ("MTSM", 10, "Maglietta di cotone con grafica di Toy Story", 5),
																				("MCRM", 10, "Maglietta di cotone con grafica di Cars", 6),
                                                                                ("MFZM", 10, "Maglietta di cotone con grafica di Frozen", 7),
                                                                                ("MLSM", 10, "Maglietta di cotone con grafica di Lilo & Stitch", 8),
                                                                                ("MTSL", 10, "Maglietta di cotone con grafica di Toy Story", 9),
																				("MCRL", 10, "Maglietta di cotone con grafica di Cars", 10),
                                                                                ("MFZL", 10, "Maglietta di cotone con grafica di Frozen", 11),
                                                                                ("MLSL", 10, "Maglietta di cotone con grafica di Lilo & Stitch", 12);

CREATE TABLE Region (
    id_region INT NOT NULL AUTO_INCREMENT,
    nome_regione VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_region)
);

insert into region (nome_regione) values ("West_Europe"), ("North_Europe"), ("Est_Europe"), ("South_Europe");

CREATE TABLE States (
    id_state INT NOT NULL AUTO_INCREMENT,
    states VARCHAR(255) NOT NULL,
    regione INT NOT NULL,
    PRIMARY KEY (id_state),
    FOREIGN KEY (regione)
        REFERENCES Region (id_region)
);

insert into states (states, regione) values ("Italy", 4), ("Spain", 1), ("France", 1), ("Germany", 2), ("Portugal", 1), ("Switzerland", 4), ("Finland", 2), ("Estonia", 3), ("Russia", 3);

CREATE TABLE Sales (
    id_vendita INT NOT NULL AUTO_INCREMENT,
    prodotto INT,
    regione INT,
    data_vendita DATE,
    quantità INT,
    PRIMARY KEY (id_vendita),
    FOREIGN KEY (prodotto)
        REFERENCES Product (id_prod),
    FOREIGN KEY (regione)
        REFERENCES Region (id_region)
);

insert into sales (prodotto, regione, data_vendita, quantità) values (1, 1, "2024-01-01", 3),
																	(2, 2, "2024-01-02", 3),
                                                                    (3, 3, "2024-01-03", 3),
                                                                    (1, 4, "2024-01-08", 3);