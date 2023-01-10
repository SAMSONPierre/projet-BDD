SELECT voyage.id, count(etape.numero) AS nb_etape
FROM voyage , etape
WHERE voyage.id=etape.id_voyage
GROUP BY id
HAVING count(etape.numero)>=ALL(SELECT count(*)
                                FROM etape GROUP BY id_voyage);

/*le voyage qui a le plus d etape*/