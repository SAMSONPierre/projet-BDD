SELECT voy.id, voy.provenance
FROM voyage AS voy
WHERE voy.provenance IN (
    SELECT por.nom FROM port AS por
             WHERE por.localisation='Europe'
    );
/* les voyages en provenance de port europeen*/