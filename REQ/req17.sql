SELECT CAST(AVG(nb_passager) AS NUMERIC(7,2)) AS moyenne_passager, EXTRACT(YEAR FROM date_debut) AS year
FROM etape,voyage
WHERE etape.port=voyage.provenance
GROUP BY EXTRACT(YEAR FROM date_debut)
ORDER BY EXTRACT(YEAR FROM date_debut);

/*le nombre moyen de passager par annee*/