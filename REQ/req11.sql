SELECT nom, volume
FROM produit AS pro1
WHERE NOT EXISTS(
    SELECT *
    FROM produit AS pro2
    WHERE pro1.volume<pro2.volume
    );

/* le produit le plus volumineux*/