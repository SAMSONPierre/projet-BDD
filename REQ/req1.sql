SELECT DISTINCT nav.id,voy.type
FROM navire AS nav, voyage AS voy, nationnalite AS nat
WHERE nav.id=nat.id_navire
AND nat.nation='France';
/* affiche l id des navires francais et le type de leur voyage*/