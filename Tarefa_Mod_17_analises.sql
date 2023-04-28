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




/* 
Identificar as ocorrências de risco alto de incêncio em uma tabela que conste:
- Cliente,
- Id do Secador,
- Id do Equipamento,
- Data da ocorrência,
- Horário da ocorrência.
*/

WITH risco_incendio AS (SELECT *,
	CASE WHEN temp_saida_ar_quente <= 40 THEN 'Baixo'
      WHEN temp_saida_ar_quente > 40 AND temp_saida_ar_quente <= 70 THEN 'Médio'
      ELSE 'Alto' END AS status_incendio
FROM leitura_dados)

SELECT  c.razao_social AS Cliente,
		s.id_secador AS Secador,
		r.id_equipam AS Equipamento,
        r.data_leitura AS Dia,
        r.hora_leitura AS Horário
FROM clientes AS c
JOIN secadores AS s
ON c.id_cliente = s.id_cliente
JOIN equipamentos AS e
ON e.id_secador = s.id_secador
JOIN risco_incendio AS r
ON e.id_equipam = r.id_equipam
WHERE r.status_incendio = "Alto"
ORDER BY Cliente;





/* 
Identificar se a temperatura de saída de ar quente aumentou ou diminuiu em comparação com a leitura anterior,
particionado por equipamento e ordenado por data.
*/

WITH risco_incendio AS (SELECT *,
	CASE WHEN temp_saida_ar_quente <= 40 THEN 'Baixo'
      WHEN temp_saida_ar_quente > 40 AND temp_saida_ar_quente <= 70 THEN 'Médio'
      ELSE 'Alto' END AS status_incendio
FROM leitura_dados)

SELECT  *,
		CASE WHEN (lag(temp_saida_ar_quente) OVER (PARTITION BY id_equipam ORDER BY data_leitura)) < temp_saida_ar_quente THEN 'Crescimento'
			WHEN (lag(temp_saida_ar_quente) OVER (PARTITION BY id_equipam ORDER BY data_leitura))  > temp_saida_ar_quente THEN 'Decrescimento'
		ELSE 'N/A' END AS crescimento_ou_descrescimento
FROM risco_incendio