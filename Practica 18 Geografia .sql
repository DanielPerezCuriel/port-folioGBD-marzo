--Practica 18--
-- 1 Mostrar el nombre de cada localidad, su población y el nombre de la provincia en la que está.--
select l.NOMBRE,POBLACION,p.nombre
from LOCALIDADES l
join PROVINCIAS p using (n_provincia);
-- 2  Mostrar el nombre de cada provincia y la capital de la misma--
select p.NOMBRE,l.nombre capital
from PROVINCIAS p
join LOCALIDADES l on (id_capital=id_localidad);
--3Mostrar el nombre de cada localidad, la provincia en la que está y su comunidad--
select l.NOMBRE,p.NOMBRE,c.NOMBRE
from LOCALIDADES l
join PROVINCIAS p using (n_provincia)
join COMUNIDADES c using (id_comunidad);
--4  Añadir la capital de cada provincia --
select l.NOMBRE,p.NOMBRE,c.NOMBRE,l2.nombre capital_provincia
from LOCALIDADES l
join PROVINCIAS p using (n_provincia)
join COMUNIDADES c using (id_comunidad)
join LOCALIDADES l2 on (p.ID_CAPITAL=l2.ID_LOCALIDAD);
--5 Añadir la capital de cada comunidad --
select c2.nombre,c.nombre comunidad ,l.nombre capital_comunidad
from LOCALIDADES l
join COMUNIDADES c on (ID_CAPITAL=ID_LOCALIDAD)
cross join COMUNIDADES c2;
--6 Mostrar el nombre y población de las capitales de provincia de más de 200000 habitantes--
select p.NOMBRE,l.POBLACION,l.nombre capital_provincia
from PROVINCIAS p
join LOCALIDADES l on (ID_LOCALIDAD=ID_CAPITAL)
where l.poblacion>200000;
--7 ] Mostrar el nombre y población de las capitales de comunidad de más de 200000 habitantes--
select c.nombre comunidad ,l.nombre capital_comunidad,POBLACION
from LOCALIDADES l
join COMUNIDADES c on (ID_CAPITAL=ID_LOCALIDAD) where POBLACION>200000;
--8 !! Mostrar el nombre de las localidades con más habitantes que su capital de provincia --
select l.NOMBRE,l.POBLACION,p.NOMBRE,cp.NOMBRE,cp.POBLACION
from LOCALIDADES l
join PROVINCIAS p using (n_provincia)
join LOCALIDADES cp on (cp.ID_LOCALIDAD=p.ID_CAPITAL)
where l.POBLACION>cp.POBLACION
--9 Mostrar el nombre de las localidades que no son capital de provincia --
select l.nombre ,p.nombre
from PROVINCIAS p
right join LOCALIDADES l on (ID_LOCALIDAD=ID_CAPITAL)
where p.nombre is null;
--10  Mostrar las provincias cuyo nombre de capital es distinto del nombre de la provincia --
select l.nombre capital_provincia,p.nombre
from LOCALIDADES l
join PROVINCIAS p on l.ID_LOCALIDAD = P.ID_CAPITAL
where l.nombre!=p.NOMBRE;
--11 Mostrar comunidades autónomas (por pares) que tienen el mismo tamaño de letras en su nombre--

-- 12 Mostrar el numero de provincias que hay en cada Comunidad Autonoma--
select ;
--13 Mostrar el numero de localidades que hay en la provincia de palencia --
select p.nombre,count(*)
from PROVINCIAS p
join LOCALIDADES l using (n_provincia)
where p.NOMBRE like 'Palencia';
--14 !!!!Mostrar el número de localidades que hay en cada Comunidad Autónoma,ordenada desde la que más localidades tiene hasta la que menos--
select c.nombre,l.nombre,l2.nombre,to_number(c.NOMBRE,'?','X')
from COMUNIDADES c
right outer join LOCALIDADES l on (c.ID_CAPITAL = l.ID_LOCALIDAD)
join LOCALIDADES l2 on (c.ID_CAPITAL=l2.ID_LOCALIDAD);
--15 Mostrar el nombre de cada provincia y en otra columna el número de localidades en esa provincia que tienen más de 10000 habitantes. Ordenar por la que menos tiene--
select NOMBRE,regexp_count(N_PROVINCIA,'*')
from LOCALIDADES;
-- 16 Mostrar el número máximo de localidades que tiene una provincia en España. Para ello, calculamos el número de localidades de cada provincia, esta consulta solo obtiene el número más grande de esa lista--
select 'Burgos'||' '||max(count(*))
from LOCALIDADES l
join provincias p using (n_provincia)
group by p.nombre;
-- 17 Mostrar el nombre de cada provincia de Castilla y León seguida de su población total. Ordenar de mayor a menor població--
select c.nombre Comunidad,
       p.nombre
       , sum(l.poblacion)
from PROVINCIAS p
join COMUNIDADES c using (id_comunidad)
right outer join LOCALIDADES l using(n_provincia)
where c.nombre like 'Castilla y León'
group by p.nombre,c.nombre;
--24--
select l.nombre,l.POBLACION,l2.NOMBRE,l2.poblacion
from LOCALIDADES l
cross join LOCALIDADES l2
where l.nombre='Palencia' and l.POBLACION<l2.POBLACION;
--25--
select p.nombre,sum(POBLACION) poblacion
from LOCALIDADES l
join PROVINCIAS p using (n_provincia)
where p.nombre='Guipuzcoa'
group by p.nombre;

select p.nombre provincia, sum(POBLACION)
from LOCALIDADES l
join PROVINCIAS p using (n_provincia)

;

(select t.provincia,t.poblacion,g.provincia,g.poblacion
from
    (select p.nombre provincia , sum(poblacion) poblacion
from LOCALIDADES l
join PROVINCIAS p using (n_provincia)
group by p.nombre) t
cross join
        (select p.nombre provincia, sum(poblacion) poblacion
         from localidades l2
         join provincias p using(n_provincia)
         where p.nombre='Guipuzcoa'
         group by p.nombre) g
where t.poblacion>g.poblacion);
