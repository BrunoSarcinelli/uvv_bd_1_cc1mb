/* QUESTÃO 01 */
SELECT nome_departamento AS Departamento, (SUM(salario)/COUNT(*)) AS media_salarial
FROM departamento dep INNER JOIN funcionario fun
WHERE fun.numero_departamento = dep.numero_departamento
GROUP BY nome_departamento;

/* QUESTÃO 02 */
SELECT sexo AS sexo, (SUM(salario)/COUNT(*)) AS media_salarial 
FROM funcionario GROUP BY sexo

/* QUESTÃO 03 */
SELECT nome_departamento AS departamento, CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS nome_completo, 
data_nascimento AS data_de_nascimento, 
FLOOR(DATEDIFF(CURDATE(), data_nascimento)/365.25) AS idade, 
salario AS salário 
FROM departamento dep INNER JOIN funcionario fun
WHERE dep.numero_departamento = fun.numero_departamento
ORDER BY nome_departamento;

/* QUESTÃO 04 */
SELECT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS nome_completo, FLOOR(DATEDIFF(CURDATE(), data_nascimento)/365.25) AS idade, 
salario AS salário, salario*1.2 AS novo_salário FROM funcionario fun
WHERE salario < '35000'
UNION
SELECT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS nome_completo, FLOOR(DATEDIFF(CURDATE(), data_nascimento)/365.25) AS idade, 
salario AS salário, salario*1.15 AS Novo_salário FROM funcionario fun
WHERE salario >= '35000';

/* QUESTÃO 05 */
SELECT nome_departamento AS departamento, ger.primeiro_nome AS gerente, fun.primeiro_nome AS funcionário, 
salario AS salário
FROM departamento dep INNER JOIN funcionario fun, 
(SELECT primeiro_nome, cpf FROM funcionario fun INNER JOIN departamento dep WHERE fun.cpf = dep.cpf_gerente) AS ger
WHERE fun.numero_departamento = dep.numero_departamento AND ger.cpf = dep.cpf_gerente
ORDER BY dep.nome_departamento ASC, fun.salario DESC;

/* QUESTÃO 06 */
SELECT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS nome_completo, dep.nome_departamento AS departamento,
dpd.nome_dependente AS dependente, FLOOR(DATEDIFF(CURDATE(), dpd.data_nascimento)/365.25) AS idade_dependente,
CASE WHEN dpd.sexo = 'M' THEN 'Masculino' WHEN dpd.sexo = 'F' THEN 'Feminino' END AS sexo_dependente
FROM funcionario fun
INNER JOIN departamento dep ON fun.numero_departamento = dep.numero_departamento
INNER JOIN dependente dpd ON dpd.cpf_funcionario = fun.cpf;

/* QUESTÃO 07 */
SELECT DISTINCT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS nome_completo, dep.nome_departamento AS departamento,
salario AS salário FROM funcionario fun
INNER JOIN departamento dep
INNER JOIN dependente dpd
WHERE dep.numero_departamento = fun.numero_departamento AND
fun.cpf NOT IN (SELECT dpd.cpf_funcionario FROM dependente dpd);

/* QUESTÃO 08 */
SELECT dep.nome_departamento AS departamento, pro.nome_projeto AS projeto,
CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS nome_completo, tbem.horas AS horas
FROM funcionario fun INNER JOIN projeto pro INNER JOIN departamento dep INNER JOIN trabalha_em tbem
WHERE pro.numero_departamento = dep.numero_departamento AND
fun.cpf = tbem.cpf_funcionario AND
pro.numero_projeto = tbem.numero_projeto 
ORDER BY pro.numero_projeto;

/* QUESTÃO 09 */
SELECT dep.nome_departamento AS departamento, pro.nome_projeto AS projeto, SUM(tbem.horas) AS total_horas
FROM departamento dep INNER JOIN projeto pro INNER JOIN trabalha_em tbem
WHERE pro.numero_projeto = tbem.numero_projeto AND dep.numero_departamento = pro.numero_departamento
GROUP BY pro.nome_projeto;

/* QUESTÃO 10 */
SELECT nome_departamento AS departamento, (SUM(salario)/COUNT(*)) AS media_salarial
FROM departamento dep INNER JOIN funcionario fun
WHERE fun.numero_departamento = dep.numero_departamento
GROUP BY dep.nome_departamento;

/* QUESTÃO 11 */
SELECT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS nome_completo, pro.nome_projeto AS projeto,
tbem.horas*50 AS valor_ganho
FROM funcionario fun INNER JOIN trabalha_em tbem INNER JOIN projeto pro
WHERE fun.cpf = tbem.cpf_funcionario AND pro.numero_projeto = tbem.numero_projeto
GROUP BY primeiro_nome;
/* QUESTÃO 12 */
SELECT dep.nome_departamento AS departamento, pro.nome_projeto AS projeto,
CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS nome_completo, tbem.horas AS horas
FROM funcionario fun  INNER JOIN projeto pro INNER JOIN departamento dep INNER JOIN trabalha_em tbem
WHERE fun.cpf = tbem.cpf_funcionario AND pro.numero_projeto = tbem.numero_projeto AND (tbem.horas = NULL OR tbem.horas = 0)
GROUP BY primeiro_nome;

/* QUESTÃO 13 */
SELECT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS nome,
CASE WHEN sexo = 'M' THEN 'Masculino' WHEN sexo = 'F' THEN 'Feminino' END AS sexo,
FLOOR(DATEDIFF(CURDATE(), fun.data_nascimento)/365.25) AS idade
FROM funcionario fun
UNION
SELECT dep.nome_dependente AS nome,
CASE WHEN sexo = 'M' THEN 'Masculino' WHEN sexo = 'F' THEN 'Feminino' END AS sexo,
FLOOR(DATEDIFF(CURDATE(), dep.data_nascimento)/365.25) AS idade
FROM dependente dep
ORDER BY idade;

/* QUESTÃO 14 */
SELECT dep.nome_departamento AS departamento, COUNT(fun.numero_departamento) AS quantidade_funcionarios
FROM funcionario fun INNER JOIN departamento dep
WHERE fun.numero_departamento = dep.numero_departamento
GROUP BY dep.nome_departamento;

/* QUESTÃO 15 */
SELECT DISTINCT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS nome_completo,
dep.nome_departamento AS departamento, 
pro.nome_projeto AS projeto
FROM departamento dep INNER JOIN trabalha_em tbem INNER JOIN projeto pro INNER JOIN funcionario fun
WHERE dep.numero_departamento = fun.numero_departamento AND pro.numero_projeto = tbem.numero_projeto AND
tbem.cpf_funcionario = fun.cpf
UNION
SELECT DISTINCT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS nome_completo,
dep.nome_departamento AS departamento, 
'Sem projeto' AS projeto
FROM departamento dep INNER JOIN trabalha_em tbem INNER JOIN projeto pro INNER JOIN funcionario fun 
WHERE dep.numero_departamento = fun.numero_departamento AND pro.numero_projeto = tbem.numero_projeto AND
(fun.cpf NOT IN (SELECT tbem.cpf_funcionario FROM trabalha_em tbem));


