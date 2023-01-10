SELECT N1.id
FROM navire AS N1
WHERE NOT EXISTS(SELECT V.id
    FROM voyage AS V
    WHERE NOT EXISTS( SELECT N2.id
                      FROM navire AS N2
                      WHERE N2.id=V.id_navire
                        AND N2.id!=N1.id));
/*Tous les navires qui n'ont jamais effectue voyage*/