SELECT nom, valeur
FROM produit
GROUP BY nom, perissable
HAVING valeur= ALL(SELECT MAX(valeur) FROM produit );
/*le produit le plus cher*/