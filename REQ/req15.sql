SELECT n1.nom
FROM nation AS n1
WHERE NOT EXISTS (SELECT nation FROM nationnalite AS N2
                    GROUP BY nation
                    HAVING count(id_navire) = (SELECT count(id_navire)
                                               FROM nationnalite as N3
                                               WHERE date_fin = '1800-12-31'
                                               AND n3.nation=n1.nom
                                               GROUP BY n3.id_navire));

/*les nations qui n'ont pas perdu de navire au cours du siecle*/