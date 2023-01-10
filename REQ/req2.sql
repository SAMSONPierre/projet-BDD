SELECT DISTINCT p1.nom, p1.valeur
FROM produit AS p1, produit AS p2
WHERE p1.valeur=p2.valeur
AND p1.nom<>p2.nom
AND p1.perissable
/* les produits perissable qui partage leur valeur avec un autre produit*/