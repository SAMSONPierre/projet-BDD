SELECT nat.id_navire, nat.nation
FROM relation AS rel
LEFT JOIN nationnalite AS nat ON rel.nation1=nat.nation
WHERE rel.relation='guerre'
AND nat.date_debut BETWEEN rel.date_debut AND rel.date_fin;
/* les navire qui ont change de nation / ete capture durant une guerre*/
