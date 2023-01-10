SELECT DISTINCT por.nom
FROM port AS por,
     (SELECT * from etape
               WHERE etape.numero<>1) AS nonpro
WHERE por.nom=nonpro.port;
/*les port qui non jamais ete la provenance d un voyage*/