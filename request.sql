\! echo requete 1 : affiche l id des navires francais et le type de leur voyage
SELECT DISTINCT nav.id,voy.type
FROM navire AS nav, voyage AS voy, nationnalite AS nat
WHERE nav.id=nat.id_navire
AND nat.nation='France';

\! echo requete 2 : les produits perissable qui partage leur valeur avec un autre produit
SELECT DISTINCT p1.nom, p1.valeur
FROM produit AS p1, produit AS p2
WHERE p1.valeur=p2.valeur
AND p1.nom<>p2.nom
AND p1.perissable

\! echo requete 3 : les voyages en provenance de port europeen
SELECT voy.id, voy.provenance
FROM voyage AS voy
WHERE voy.provenance IN (
    SELECT por.nom FROM port AS por
             WHERE por.localisation = 'Europe'
    );

\! echo requete 4 : les voyages qui ont eut du diamant dans leur cargaison
SELECT DISTINCT id_voyage
FROM etape AS eta
WHERE idC IN (SELECT idC FROM registre AS reg
              WHERE reg.idP='diamant'
    );

\! echo requete 5 : les port qui non jamais ete la provenance d un voyage
SELECT DISTINCT por.nom
FROM port AS por,
     (SELECT * from etape
               WHERE etape.numero<>1) AS nonpro
WHERE por.nom=nonpro.port;

\! echo requete 6 : le produit le plus cher
SELECT nom, valeur
FROM produit
GROUP BY nom, perissable
HAVING valeur= ALL(SELECT MAX(valeur) FROM produit );

\! echo requete 7 : le voyage le plus long
SELECT id,date_debut, date_fin
FROM voyage
GROUP BY id, date_debut, date_fin
HAVING date_fin-voyage.date_debut= ALL(
    SELECT MAX(date_fin-voyage.date_debut) FROM voyage);

\! echo requete 8 :la moyenne et le maximum du nombre de passager par voyage
SELECT DISTINCT id_voyage, AVG(nb_passager), MAX(nb_passager)
FROM etape
GROUP BY id_voyage
ORDER BY id_voyage;

\! echo requete 9 : les moyennes de duree des voyage par decennies
SELECT CAST(AVG(duree) AS decimal(9,0)) AS temps_moyene, CONCAT(decade, '-',decade+9) AS year
FROM (SELECT FLOOR(EXTRACT(YEAR FROM date_debut)/ 10) *10 AS decade
      FROM voyage) AS decade, voyage
GROUP BY decade
ORDER BY decade;

\! echo requete 10 : les navires qui ont change de nation / ete capture durant une guerre
SELECT nat.id_navire, nat.nation
FROM relation AS rel
LEFT JOIN nationnalite AS nat ON rel.nation1=nat.nation
WHERE rel.relation='guerre'
AND nat.date_debut BETWEEN rel.date_debut AND rel.date_fin;

\! echo requete 11 : le produit le plus volumineux
SELECT nom, volume
FROM produit AS pro1
WHERE NOT EXISTS(
    SELECT *
    FROM produit AS pro2
    WHERE pro1.volume<pro2.volume
    );

\! echo requete 12 : le produit le plus volumineux
SELECT nom,volume
FROM produit
WHERE volume=(SELECT MAX(volume) FROM produit);

\! echo requete 13 : les voyages du navire 36 au debut du siecle
WITH RECURSIVE voyage_fait AS (SELECT id, id_navire, type, localisation, provenance, destination
                               FROM voyage
                               WHERE id_navire = 35
                               UNION
                               SELECT voy.id,voy.id_navire, voy.type, voy.localisation, voy.provenance, voy.destination
                               FROM voyage AS voy, voyage_fait
                               WHERE voy.date_fin<'1750-12-31'
                               AND voy.id_navire= voyage_fait.id_navire
                              )
SELECT * FROM voyage_fait;

\! echo requete 14 : le nombre de voyage par navire dans l ordre des navires
SELECT id_navire, count(id) AS nb_voyage
FROM voyage
group by id_navire
ORDER BY id_navire;

\! echo requete 15 : les nations qui n ont pas perdu de navires au cours du siecle
SELECT n1.nom
FROM nation AS n1
WHERE NOT EXISTS (SELECT nation FROM nationnalite AS N2
                    GROUP BY nation
                    HAVING count(id_navire) = (SELECT count(id_navire)
                                               FROM nationnalite as N3
                                               WHERE date_fin = '1800-12-31'
                                               AND n3.nation=n1.nom
                                               GROUP BY n3.id_navire));

\! echo requete 16 : tous les navires qui n ont jamais effectue voyage
SELECT N1.id
FROM navire AS N1
WHERE NOT EXISTS(SELECT V.id
    FROM voyage AS V
    WHERE NOT EXISTS( SELECT N2.id
                      FROM navire AS N2
                      WHERE N2.id=V.id_navire
                        AND N2.id!=N1.id));

\! echo requete 17 : le nombre moyen de passager par annee
SELECT CAST(AVG(nb_passager) AS NUMERIC(7,2)) AS moyenne_passager, EXTRACT(YEAR FROM date_debut) AS year
FROM etape,voyage
WHERE etape.port=voyage.provenance
GROUP BY EXTRACT(YEAR FROM date_debut)
ORDER BY EXTRACT(YEAR FROM date_debut);

\! echo requete 18 : volume moyen des cargaison par annee
SELECT CAST(AVG(c.volume_total) AS NUMERIC(7,2)) AS moyenne_volume, EXTRACT(YEAR FROM date_debut) AS year
FROM etape AS e,voyage AS v, cargaison AS c
WHERE e.port=v.provenance
AND e.idC=c.id
GROUP BY EXTRACT(YEAR FROM date_debut)
ORDER BY EXTRACT(YEAR FROM date_debut);

\! echo requete 19 : nombre de type de voyage par decennie
SELECT COUNT(*) AS nb_voyage, CONCAT(decade, '-',decade+9) AS year
FROM (SELECT FLOOR(EXTRACT(YEAR FROM date_debut)/ 10) *10 AS decade
      FROM voyage) AS decade
GROUP BY decade
ORDER BY decade;

\! echo requete 20 : le voyage qui a le plus d etape

SELECT voyage.id, count(etape.numero) AS nb_etape
FROM voyage , etape
WHERE voyage.id=etape.id_voyage
GROUP BY id
HAVING count(etape.numero)>=ALL(SELECT count(*)
                                FROM etape GROUP BY id_voyage);
