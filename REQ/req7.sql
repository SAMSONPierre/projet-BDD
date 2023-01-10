SELECT id,date_debut, date_fin
FROM voyage
GROUP BY id, date_debut, date_fin
HAVING date_fin-voyage.date_debut= ALL(
    SELECT MAX(date_fin-voyage.date_debut) FROM voyage);
/*le voyage le plus long*/