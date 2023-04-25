/* 
Classificar o status de risco de incêncio conforme a temperatura de daída do ar quente:
- temperatura inferior a 40 graus: risco baixo.
- temperatura entre 40 e 70 graus: risco médio.
- temperatura superior a 70 graus: risco alto.
*/

SELECT *,
	CASE WHEN temp_saida_ar_quente <= 40 THEN 'Baixo'
      WHEN temp_saida_ar_quente > 40 AND temp_saida_ar_quente <= 70 THEN 'Médio'
      ELSE 'Alto' END AS status_incendio
FROM leitura_dados;
