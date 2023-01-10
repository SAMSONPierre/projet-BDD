DROP  TYPE IF EXISTS relation_diplomatique CASCADE ;
DROP TYPE IF EXISTS type_navire CASCADE ;
DROP TYPE IF EXISTS type_voyage CASCADE ;
DROP TYPE IF EXISTS localisation CASCADE ;

DROP TABLE IF EXISTS nation CASCADE ;
DROP TABLE IF EXISTS relation CASCADE ;
DROP TABLE IF EXISTS navire CASCADE ;
DROP TABLE IF EXISTS nationnalite CASCADE ;
DROP TABLE IF EXISTS port CASCADE ;
DROP TABLE IF EXISTS voyage CASCADE ;
DROP TABLE IF EXISTS produit CASCADE ;
DROP TABLE IF EXISTS cargaison CASCADE ;
DROP TABLE IF EXISTS registre CASCADE ;
DROP TABLE IF EXISTS etape CASCADE ;


CREATE TYPE relation_diplomatique AS ENUM ('neutre','allies_commerciaux','allies','guerre');

CREATE TYPE type_navire AS ENUM('Flute', 'Jonque','Caraque',
    'Galion', 'Chebec', 'Gabare', 'Clipper');

CREATE TYPE localisation AS ENUM('Afrique','Amerique','Antarctique','Arctique','Asie',
    'Europe','Intercontinental','Oceanie');

CREATE TYPE type_voyage AS ENUM ('court','moyen','long');

CREATE TABLE nation(
    nom VARCHAR PRIMARY KEY
);

CREATE TABLE relation(
    nation1 VARCHAR NOT NULL ,
    nation2 VARCHAR NOT NULL ,
    relation relation_diplomatique DEFAULT 'neutre' ,
    date_debut DATE NOT NULL ,
    date_fin DATE DEFAULT '1800-12-31',
    PRIMARY KEY (nation1,nation2,date_debut),
    FOREIGN KEY (nation1) REFERENCES nation(nom) ON DELETE SET NULL ON UPDATE CASCADE ,
    FOREIGN KEY (nation2) REFERENCES nation(nom) ON DELETE SET NULL ON UPDATE CASCADE ,
    CONSTRAINT ordre CHECK ( nation1 < nation2 ),
    CONSTRAINT temporalite CHECK ( date_debut < date_fin )
);

CREATE TABLE navire(
    id SERIAL,
    type type_navire NOT NULL ,
    categorie INT NOT NULL ,
    volume INT,
    nb_passager INT,
    PRIMARY KEY (id),
    CONSTRAINT categorie CHECK ( categorie BETWEEN 1 AND 5)
);

CREATE TABLE nationnalite(
    id_navire INT,
    nation VARCHAR,
    date_debut DATE,
    date_fin DATE DEFAULT '1800-12-31',
    PRIMARY KEY (id_navire,nation,date_debut),
    FOREIGN KEY(id_navire) REFERENCES navire(id),
    FOREIGN KEY(nation) REFERENCES nation(nom),
    CONSTRAINT temporalite CHECK ( date_debut < date_fin )
);

CREATE TABLE port(
    nom VARCHAR UNIQUE ,
    nation VARCHAR NOT NULL,
    localisation localisation NOT NULL,
    categorie INT NOT NULL,
    PRIMARY KEY (nom,localisation),
    FOREIGN KEY (nation) REFERENCES nation(nom),
    CHECK ( categorie BETWEEN 1 AND 5)
);

CREATE TABLE voyage(
    id  SERIAL UNIQUE ,
    id_navire    INT,
    duree        INT NOT NULL ,
    distance     INT NOT NULL ,
    date_debut   DATE NOT NULL ,
    date_fin     DATE,
    type         type_voyage NOT NULL ,
    localisation localisation NOT NULL ,
    provenance   VARCHAR NOT NULL ,
    destination  VARCHAR NOT NULL ,
    PRIMARY KEY (id,id_navire, date_debut),
    FOREIGN KEY (id_navire) REFERENCES navire (id),
    FOREIGN KEY (provenance) REFERENCES port (nom),
    FOREIGN KEY (destination) REFERENCES port (nom),
    CONSTRAINT temporalite CHECK ( date_debut < date_fin ),
    CONSTRAINT respect_type CHECK ( (type='court' AND distance<1000)
                                        OR (type='moyen' AND (distance BETWEEN 1000 AND 2000))
                                        OR(type='long' AND distance>2000) ),
    CONSTRAINT respect_localisation CHECK ( (localisation='Intercontinental' AND distance >1000) OR localisation!='Intercontinental' )
);

CREATE TABLE produit(
  nom VARCHAR,
  perissable BOOLEAN DEFAULT FALSE,
  duree INT ,
  valeur FLOAT NOT NULL ,
  volume INT ,
  PRIMARY KEY (nom),
  CONSTRAINT peremption CHECK ( (perissable IS TRUE AND duree IS NOT NULL ) OR (perissable IS NOT TRUE AND duree IS NULL ) )

);

CREATE TABLE cargaison(
    id INT,
    volume_total INT,
    PRIMARY KEY (id)
);

CREATE TABLE registre(
    idC INT,
    idP VARCHAR,
    quantite INT,
    FOREIGN KEY (idC) REFERENCES cargaison(id),
    FOREIGN KEY (idP) REFERENCES produit(nom)
);

CREATE TABLE etape(
    id_voyage INT ,
    numero INT NOT NULL ,
    port VARCHAR,
    nb_passager INT,
    idC INT ,
    PRIMARY KEY (id_voyage,port),
    FOREIGN KEY (id_voyage) REFERENCES voyage(id),
    FOREIGN KEY (port) REFERENCES port(nom),
    FOREIGN KEY (idC) REFERENCES cargaison(id)

);

