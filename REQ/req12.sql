SELECT nom,volume
FROM produit
WHERE volume=(SELECT MAX(volume) FROM produit);
/* le produit le plus volumineux */