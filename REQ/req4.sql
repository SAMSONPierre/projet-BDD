SELECT DISTINCT id_voyage
FROM etape AS eta
WHERE idC IN (SELECT idC FROM registre AS reg
              WHERE reg.idP='diamant'
    );
/*les voyages qui ont eut du diamant dans leur cargaison*/