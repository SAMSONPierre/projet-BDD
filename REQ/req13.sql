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
/* les voyages du navire 36 au debut du siecle*/