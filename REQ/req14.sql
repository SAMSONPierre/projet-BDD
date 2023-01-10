SELECT id_navire, count(id) AS nb_voyage
FROM voyage
group by id_navire
ORDER BY id_navire;
/* le nombre de voyage par navire dans l ordre des navires */