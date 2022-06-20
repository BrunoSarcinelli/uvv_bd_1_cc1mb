with recursive produtos as (
    select codigo, nome, codigo_pai from classificacao
    where codigo = 1
union all
    select c.codigo, c.nome, c.codigo_pai from classificacao as c
    inner join produtos p on c.codigo_pai = p.codigo 

)

select * from classificacao
