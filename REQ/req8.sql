SELECT DISTINCT id_voyage, AVG(nb_passager), MAX(nb_passager)
FROM etape
GROUP BY id_voyage
ORDER BY id_voyage;

/* la moyenne et le maximum du nombre de passager par voyage*/