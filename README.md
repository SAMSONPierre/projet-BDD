# Projet de base de donnée

### Groupe 95

- MORAND Paul-Emile 21957265
- SAMSON Pierre 21956843

### Exécution

Dans un client psql :

- `createTable.sql` pour effacer si déjà existantes les tables et les types, puis crée les types
et les tables de la base de donnée.
- `fillTable.sql` pour remplir les tables précédemment générées par les fichiers CSV contenu dans le 
répertoire `\CSV`
- `request.sql` pour exécuter toutes les requêtes contenues dans le répertoire `\REG`

### Description fichiers

- `createTable.sql` contient les différentes requêtes qui supprime en cascade les tables et les types
s'ils existent déjà, puis créer les types :
  - `relation_diplomatique`
  - `type_navire`
  - `type_voyage`
  - `localisation`
  
- puis créer les tables et leurs contraintes :
  - `nation`
  - `relation`
  - `navire`
  - `nationnalite`
  - `port`
  - `voyage`
  - `produit`
  - `cargaison`
  - `registre`
  - `etape`


- `fillTable.sql` contient les requêtes pour remplir les tables
à partir des fichiers CSV correspondant.

- `modelisation.pdf` contient les modélisations de la base de donnée avant
et après validation et la liste des contraintes externes. (On retrouve les
modélisations séparées dans les fichiers `avant.png` et `approuve.png`)

- `request.sql` contient toutes les requêtes exécutées à la suite
  (On retrouve les requêtes séparées dans le repertoire `\REQ`)

### Format requête
SELECT ...
la requête en elle-même
;

`/*`la description de la requête`*/`