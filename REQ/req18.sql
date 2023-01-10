SELECT CAST(AVG(c.volume_total) AS NUMERIC(7,2)) AS moyenne_volume, EXTRACT(YEAR FROM date_debut) AS year
FROM etape AS e,voyage AS v, cargaison AS c
WHERE e.port=v.provenance
AND e.idC=c.id
GROUP BY EXTRACT(YEAR FROM date_debut)
ORDER BY EXTRACT(YEAR FROM date_debut);

/*volume moyen des cargaison par annee*/