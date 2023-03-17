select h.NOMBRE hijo_a , p.nombre padre,m.nombre madre
from personas h
left outer join personas p on (h.n_padre=p.N_PERSONA)
left outer join PERSONAS m on (h.n_madre=m.n_persona)
--EJERCICIO 19 --
--1 Listar aquellas personas cuyo padre y madre son desconocidos--
select nombre from personas where N_PADRE is null and N_MADRE is null;
--2 Nombre de cada persona, nombre de su padre y de su madre --
select h.NOMBRE hijo_a , p.nombre padre,m.nombre madre
from personas h
left outer join personas p on (h.n_padre=p.N_PERSONA)
left outer join PERSONAS m on (h.n_madre=m.n_persona)
where h.N_MADRE is not null and h.N_PADRE is not null;
--3 Añadir a la consulta anterior las personas que no tienen padre o madre en la base de datos--
select h.NOMBRE hijo_a , p.nombre padre,m.nombre madre
from personas h
left outer join personas p on (h.n_padre=p.N_PERSONA)
left outer join PERSONAS m on (h.n_madre=m.n_persona);
--4 Obtener el número de hijos de cada pareja ordenados de más hijos a menos. En caso de que coincidan el número de hijos, se ordenará por el nombre del padre y luego de la madre--
select h.NOMBRE hijo_a , p.nombre padre,m.nombre madre,sum(h.NOMBRE)
from personas h
left outer join personas p on (h.n_padre=p.N_PERSONA)
left outer join PERSONAS m on (h.n_madre=m.n_persona);
-- 5 Nombre de las madres que hayan tenido 2 hijas --
select p.nombre padre,m.nombre madre ,h.NOMBRE hijo_a,h2.nombre
from personas h
left outer join personas p on (h.n_padre=p.N_PERSONA)
left outer join PERSONAS m on (h.n_madre=m.n_persona)
right outer join PERSONAS h2 on (h.nombre=h2.nombre)
where m.NOMBRE is not null and p.nombre is not null;
--6 Mostrar el nombre de los hijos/as y los padres cuya primera letra del nombre es idéntica--
select h.nombre hijos , p.nombre padres
from personas h
left outer join personas p on (h.n_padre=p.N_PERSONA)
left outer join PERSONAS m on (h.n_madre=m.n_persona)
right outer join PERSONAS h2 on (h.nombre=h2.nombre)
where regexp_like(h.nombre,'?',)=regexp_like(h2.nombre,'?');
where extract(initcap(h.NOMBRE))=extract(initcap(p.NOMBRE));
--7 Muestra el nombre de las madres que hayan tenido hijos con padres distintos (conocidos)--
select  distinct  m.nombre madre ,count(distinct p.nombre)
from personas h
left outer join personas p on (h.n_padre=p.N_PERSONA)
left outer join PERSONAS m on (h.n_madre=m.n_persona)
group by m.nombre
having count(distinct p.nombre)>1;
-- 8  Muestra el nombre de todas las abuelas por parte de madre (madres de madres) --

--9--
select p.nombre,h.nombre
from personas h
right outer join  personas p on (p.n_persona=h.n_padre)
where h.nombre is null and p.sexo='H';
