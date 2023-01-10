SELECT CAST(AVG(duree) AS decimal(9,0)) AS temps_moyene, CONCAT(decade, '-',decade+9) AS year
FROM (SELECT FLOOR(EXTRACT(YEAR FROM date_debut)/ 10) *10 AS decade
      FROM voyage) AS decade, voyage
GROUP BY decade
ORDER BY decade;

/*les moyenne de duree des voyage par decennies*/