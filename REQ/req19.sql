SELECT COUNT(*) AS nb_voyage, CONCAT(decade, '-',decade+9) AS year
FROM (SELECT FLOOR(EXTRACT(YEAR FROM date_debut)/ 10) *10 AS decade
      FROM voyage) AS decade
GROUP BY decade
ORDER BY decade;
/* nombre de type de voyage par decennie*/