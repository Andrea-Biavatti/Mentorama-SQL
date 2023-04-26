DELIMITER $$

CREATE PROCEDURE risco_incendio ()
BEGIN

SELECT *,
	CASE WHEN temp_saida_ar_quente <= 40 THEN 'Baixo'
      WHEN temp_saida_ar_quente > 40 AND temp_saida_ar_quente <= 70 THEN 'Médio'
      ELSE 'Alto' END AS status_incendio
FROM leitura_dados;

END $$
DELIMITER ;

